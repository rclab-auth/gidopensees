program OpenSeesPost;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.Classes,
  System.SysUtils,
  Windows,
  System.Math;

type
    ArrayStr = array of string;

const
    INDENT       = 7;
    EPS          = 1e-9;

    Black        = 0;
    Blue         = 1;
    Green        = 2;
    Cyan         = 3;
    Red          = 4;
    Magenta      = 5;
    Brown        = 6;
    LightGray    = 7;
    DarkGray     = 8;
    LightBlue    = 9;
    LightGreen   = 10;
    LightCyan    = 11;
    LightRed     = 12;
    LightMagenta = 13;
    Yellow       = 14;
    White        = 15;

var
    i,j,k,n,
    ndm,cnt       : integer;
    s,line,
    GiDPath,
    ModelPath,
    FileName,
    ModelName,
    OutFile,
    ResFileASCII,
    ResFileBin    : string;
    Tag,
    Str           : ArrayStr;
    TCL,
    PER,
    LOC,
    LOG           : TStringList;
    MSH           : TStreamWriter;
    RES           : TextFile;
    Period        : string;
    Vx,Vy,
    Vz,Ang        : array[1..3] of double;
    zxy           : double;
    Int_Type      : ArrayStr;
    Int_Steps,
    Int_StepsInit : array of integer;
    Int_Time      : array of double;
    Str_IntNames,
    Str_Steps     : array of string;
    Step          : integer;

    // console

    BufferInfo    : TConsoleScreenBufferInfo;
    LastMode      : word;
    TextAttr      : byte;
    StdOut,
    StdErr        : THandle;
    CCI           : TConsoleCursorInfo;

// console color text

procedure TextColor(Color: byte);
begin
    LastMode := TextAttr;
    TextAttr := (TextAttr and $F0) or (Color and $0F);
    SetConsoleTextAttribute(StdOut, TextAttr);
end;

// console cursor

procedure ShowCursor(Show : boolean);
begin
   GetConsoleCursorInfo(StdOut,CCI);
   CCI.bVisible := Show;
   SetConsoleCursorInfo(StdOut,CCI);
end;

// execute DOS command and wait

function ExecuteAndWait(const CommandLine : string) : boolean;
var
    StartupInfo     : TStartupInfo;        // start-up info passed to process
    ProcessInfo     : TProcessInformation; // info about the process
    ProcessExitCode : DWord;               // process's exit code

begin
    // Set default error result

    Result := False;

    // Initialise startup info structure to 0, and record length

    FillChar(StartupInfo, SizeOf(StartupInfo), 0);
    StartupInfo.cb := SizeOf(StartupInfo);

    // Execute application commandline

    if Windows.CreateProcess(nil, PChar(CommandLine),nil, nil, False, 0, nil, nil, StartupInfo, ProcessInfo) then
    begin
        try

            // Now wait for application to complete

            if Windows.WaitForSingleObject(ProcessInfo.hProcess, INFINITE) = WAIT_OBJECT_0 then

                // completed - get its exit code

                if Windows.GetExitCodeProcess(ProcessInfo.hProcess,ProcessExitCode) then

                    // check exit code is zero -> successful completion

                    if ProcessExitCode = 0 then
                        Result := True;
        finally

            // tidy up

            Windows.CloseHandle(ProcessInfo.hProcess);
            Windows.CloseHandle(ProcessInfo.hThread);
        end;
    end;
end;

// get file size

function GetFileSize(const s : string) : string;
var
    FD   : TWin32FindData;
    FH   : THandle;
    Size : Int64;

begin
    FH := FindFirstFile(PChar(s), FD);

    if FH = INVALID_HANDLE_VALUE then

        Size := 0

    else

        try
            Size := FD.nFileSizeHigh;
            Size := Size shl 32;
            Size := Size + FD.nFileSizeLow;

        finally
        end;

    if Size > 1024*1024*1024 then
        Result := Format('%0.2f',[Size/1024/1024/1024])+' GB'
    else if Size > 1024*1024 then
        Result := Format('%0.1f',[Size/1024/1024])+' MB'
    else if Size > 1024 then
        Result := Format('%0.1f',[Size/1024])+' KB'
    else
        Result := Format('%0.0f',[Size])+' bytes';
end;

// get full path

function LongPathName (const ShortPathName: string): string;
var
    buff : array [0..MAX_PATH-1] of char;

begin
    GetLongPathName(PChar(ShortPathName), buff, Length(buff));

    Result := buff;
end;

// put tag/result string to an array

procedure StrToArray (s : string; var arr : ArrayStr; n : integer; DeleteFirst : boolean);
var
    i,p,cnt : integer;
    h       : string;

begin
    SetLength(arr,0);

    arr := nil;

    SetLength(arr,n);

    for i := 0 to n-1 do
        arr[i] := '0';  // just in case some results are missing, not to be empty

    if s[Length(s)] <> ' ' then  // tags have already a space in the end !
        s := s+' ';

    if DeleteFirst then
        p := Pos(' ',s)+1  // start after first string (step number or '#')
    else
        p := 1;

    cnt := 0;  // array position

    for i := p to Length(s) do  // get space-separated values FAST
    begin
        if s[i] = ' ' then
        begin
            h := Copy(s,p,i-p);

            arr[cnt] := h;

            if cnt = n-1 then  // to prevent more values found in string
                Break;

            p := i+1;
            cnt := cnt+1;
        end;
    end;
end;

// inverse number

function Inv(s : string) : string;
begin
    if s = '' then
    begin
        Result := '0';
        Exit;
    end;

    if s[1] = '-' then
        Result := Copy(s,2,Length(s)-1)
    else
        Result := '-'+s;
end;

// first string

function FS(s : string) : string;
begin
    Result := Copy(s,1,Pos(' ',s)-1);
end;

// get analysis type from step

function GetIntervalNumber(Step : integer) : integer;
var
    i,Sum : integer;

begin
    Result := 0;
    Sum := 0;

    for i := 0 to Length(Int_Type)-1 do
    begin
        if Step >= Sum then
            Result := i+1;

        Sum := Sum + Int_Steps[i];
    end;
end;

function GetIntervalStep(Step : integer) : integer;
var
    i,Sum : integer;

begin
    Result := 0;
    Sum := 0;

    for i := 0 to Length(Int_Type)-1 do
    begin
        if Step >= Sum then
            Result := Step - Sum;

        Sum := Sum + Int_Steps[i];
    end;
end;

// extract log statistics

procedure GetStatistics(LogFile : string);
var
    STAT      : TStringList;
    Valid,
    Found     : boolean;
    i,j       : integer;
    Mult      : double;
    ElemID,
    ElemCrash : array of integer;
    ElemType  : array of string;
    Elem      : integer;
    s         : string;
    Intv,
    IntPrev,
    Sum       : integer;

begin
    if not FileExists(LogFile) then
        Exit;

    LOG := TStringList.Create;
    LOG.LoadFromFile(LogFile);

    Valid := false;
    i := 0;

    while i < LOG.Count do
    begin
        if (Pos('iteration:',LOG.Strings[i]) <> 0) then
            if (Pos('iteration: 1',LOG.Strings[i]) = 0) then
            begin
                Valid := true;
                Break;
            end;

        Inc(i);
    end;

    if Valid then
    begin
        STAT := TStringList.Create;
        STAT.Add('Interval'#9'Interval step'#9'Total step'#9'Step multiplier'#9'LF/Time'#9'Iterations'#9'Algorithm'#9'Criterion'#9'Norm');

        i := 0;
        cnt := 0;
        Mult := 1;
        IntPrev := 0;
        Sum := 0;

        while i < LOG.Count do
        begin
            if LOG.Strings[i] = 'Back to initial step' then
                Mult := 1
            else if LOG.Strings[i] = 'Initial step is divided by 2' then
                Mult := 1/2
            else if LOG.Strings[i] = 'Initial step is divided by 4' then
                Mult := 1/4
            else if LOG.Strings[i] = 'Initial step is divided by 8' then
                Mult := 1/8
            else if LOG.Strings[i] = 'Initial step is divided by 16' then
                Mult := 1/16;

            if (Copy(LOG.Strings[i],1,1) = '(') and (Pos('- iteration:',LOG.Strings[i]) <> 0) then
            begin
                Inc(cnt);
                Inc(Sum);

                Intv := StrToInt(Trim(Copy( LOG.Strings[i],Pos('(',LOG.Strings[i])+1,Pos(')',LOG.Strings[i])-Pos('(',LOG.Strings[i])-1 )));

                if Intv <> IntPrev then
                begin
                    cnt := 1;
                    IntPrev := Intv;
                end;

                s :=     IntToStr(Intv)+#9;
                s := s + IntToStr(cnt)+#9;
                s := s + IntToStr(Sum)+#9;

                s := s + FloatToStr(Mult)+#9;

                if Pos('Time',LOG.Strings[i]) <> 0 then
                    s := s + Trim(Copy( LOG.Strings[i],Pos('Time ',LOG.Strings[i])+5,Pos(' CTest',LOG.Strings[i])-Pos('Time ',LOG.Strings[i])-5 ))+#9;

                if Pos('LF',LOG.Strings[i]) <> 0 then
                    s := s + Trim(Copy( LOG.Strings[i],Pos('LF ',LOG.Strings[i])+3,Pos(' CTest',LOG.Strings[i])-Pos('LF ',LOG.Strings[i])-3 ))+#9;

                s := s + Trim(Copy( LOG.Strings[i],Pos('iteration:',LOG.Strings[i])+10,Pos(' current',LOG.Strings[i])-Pos('iteration:',LOG.Strings[i])-10 ))+#9;

                if Pos('Time',LOG.Strings[i]) <> 0 then
                    s := s + Trim(Copy( LOG.Strings[i],Pos(') ',LOG.Strings[i])+2,Pos(' Time',LOG.Strings[i])-Pos(') ',LOG.Strings[i])-2 ))+#9;

                if Pos('LF',LOG.Strings[i]) <> 0 then
                    s := s + Trim(Copy( LOG.Strings[i],Pos(') ',LOG.Strings[i])+2,Pos(' LF',LOG.Strings[i])-Pos(') ',LOG.Strings[i])-2 ))+#9;

                s := s + Trim(Copy( LOG.Strings[i],Pos('CTest',LOG.Strings[i])+5,Pos('::',LOG.Strings[i])-Pos('CTest',LOG.Strings[i])-5 ))+#9;

                s := s + Trim(Copy( LOG.Strings[i],Pos('Norm:',LOG.Strings[i])+5,Pos(' (max',LOG.Strings[i])-Pos('Norm:',LOG.Strings[i])-5 ));

                STAT.Add(s);
            end;

            Inc(i);
        end;

        STAT.SaveToFile(ExtractFilePath(LogFile)+'Analysis performance.xls');
        STAT.Free;
    end;

    // find issues

    Valid := false;
    i := 0;

    while i < LOG.Count do
    begin
        if (Pos('for element:',LOG.Strings[i]) <> 0) then
        begin
            Valid := true;
            Break;
        end;

        Inc(i);
    end;

    i := 0;

    if Valid then
    begin
        STAT := TStringList.Create;
        STAT.Add('Element'#9'Type'#9'Crashes');

        while i < LOG.Count do
        begin
            if (Pos('for element:',LOG.Strings[i]) <> 0) then
            begin
                Elem := StrToInt(Copy(LOG.Strings[i],Pos('for element:',LOG.Strings[i])+12,Pos('(dW',LOG.Strings[i])-Pos('for element:',LOG.Strings[i])-12));

                Found := false;

                if Length(ElemID) <> 0 then
                begin
                    for j := 0 to Length(ElemID)-1 do
                        if Elem = ElemID[j] then
                        begin
                            Found := true;
                            ElemCrash[j] := ElemCrash[j]+1;

                            Break;
                        end;
                end;

                if not Found then
                begin
                    SetLength(ElemID,Length(ElemID)+1);
                    ElemID[Length(ElemID)-1] := Elem;

                    SetLength(ElemCrash,Length(ElemCrash)+1);
                    ElemCrash[Length(ElemCrash)-1] := 1;

                    SetLength(ElemType,Length(ElemType)+1);
                    ElemType[Length(ElemType)-1] := Copy(LOG.Strings[i],Pos('WARNING -',LOG.Strings[i])+9,Pos('::',LOG.Strings[i])-Pos('WARNING -',LOG.Strings[i])-9);
                end
                else
                begin
                end;
            end;

            Inc(i);
        end;

        for i := 0 to Length(ElemID)-1 do
            STAT.Add(IntToStr(ElemID[i])+#9+ElemType[i]+#9+IntToStr(ElemCrash[i]));

        STAT.SaveToFile(ExtractFilePath(LogFile)+'Analysis problems.xls');
        STAT.Free;
    end;


    LOG.Free;
end;

// procedures for writing results

procedure WriteResults(IsMatrix,Principal : boolean; Caption,Filename,ElemName,ResultName,C1,C2,C3,C4,C5,C6,UnitName : string; GPs, ValuesPerGP : integer; OneFilePerGP : boolean; P1,P2,P3,P4,P5,P6 : integer);

var
    i,j,k,cnt : integer;
    fExists   : boolean;
    OutNames  : array[0..3] of string;
    OutFiles  : array[0..3] of textfile;
    lines     : array[0..3] of string;
    Strs      : array[0..3] of ArrayStr;
    Tags      : ArrayStr;
    f,index   : integer;
    xx,yy,xy,
    TheMax,
    TheMin,
    TheAngle  : double;

begin
    if OneFilePerGP then
    begin
        fExists := true;

        for i := 0 to 3 do
        begin
            OutNames[i] := ModelPath+'\OpenSees\'+Filename+'_GP'+IntToStr(i+1)+'.out';
            fExists := fExists and FileExists(OutNames[i]);
        end;
    end
    else
    begin
        OutNames[0] := ModelPath+'\OpenSees\'+Filename+'.out';
        fExists := FileExists(OutNames[0]);
    end;

    if fExists then
    begin
        write(Caption);

        n := StrToInt(Copy(TCL[TCL.IndexOf('# '+ElemName)+1],3,10));  // number of elements

        StrToArray(TCL[TCL.IndexOf('# '+ElemName)+2],Tags,n,true);  // read all tags

        AssignFile(OutFiles[0],OutNames[0]);
        Reset(OutFiles[0]);

        if OneFilePerGP then
            for i := 1 to 3 do
            begin
                AssignFile(OutFiles[i],OutNames[i]);
                Reset(OutFiles[i]);
            end;

        cnt := 0;

        repeat

            Readln(OutFiles[0],lines[0]);

            if OneFilePerGP then
                for i := 1 to 3 do
                    Readln(OutFiles[i],lines[i]);

            if (cnt = 0) or EOF(OutFiles[0]) or (cnt mod Step = 0) then
            begin

                MSH.Writeline('');

                if (not IsMatrix) or Principal then
                begin
                    MSH.Writeline('Result "Elements//'+ElemName+'//'+ResultName+'" "'+Str_IntNames[cnt]+'" '+Str_Steps[cnt]+' Vector OnGaussPoints "'+ElemName+'_GP"');
                    MSH.Writeline('ComponentNames "'+C1+'" "'+C2+'" "'+C3+'"');
                end
                else
                begin
                    MSH.Writeline('Result "Elements//'+ElemName+'//'+ResultName+'" "'+Str_IntNames[cnt]+'" '+Str_Steps[cnt]+' Matrix OnGaussPoints "'+ElemName+'_GP"');
                    MSH.Writeline('ComponentNames "'+C1+'" "'+C2+'" "'+C3+'" "'+C4+'" "'+C5+'" "'+C6+'"');
                end;

                MSH.Writeline('Unit "'+UnitName+'"');
                MSH.Writeline('Values');

                if OneFilePerGP then
                begin
                    for i := 0 to 3 do
                        StrToArray(lines[i],Strs[i],ValuesPerGP*n,true); // read all values from current step (ValuesPerGP values)
                end
                else
                    StrToArray(lines[0],Strs[0],GPs*ValuesPerGP*n,true);   // read all values from current step (ValuesPerGP values per gauss point)


                for j := 0 to n-1 do  // elements
                begin
                    s := Tags[j] + StringOfChar(' ',INDENT-Length(Tags[j]));

                    for k := 0 to GPs-1 do
                    begin
                         if OneFilePerGP then
                         begin
                             f := k;                        // different file
                             index := ValuesPerGP*j;        // line start index
                         end
                         else
                         begin
                             f := 0;                        // same file
                             index := ValuesPerGP*(GPs*j+k);  // line start index
                         end;

                         if Principal then
                         begin

                             xx := StrToFloat(Strs[f] [index+P1]);
                             yy := StrToFloat(Strs[f] [index+P2]);
                             xy := StrToFloat(Strs[f] [index+P3]);

                             if abs(xx) < 1e-9 then xx := 0;
                             if abs(yy) < 1e-9 then yy := 0;
                             if abs(xy) < 1e-9 then xy := 0;

                             TheMax := (xx+yy)/2 + Sqrt( ((xx-yy)/2) * ((xx-yy)/2) + xy*xy );
                             TheMin := (xx+yy)/2 - Sqrt( ((xx-yy)/2) * ((xx-yy)/2) + xy*xy );
                             TheAngle := 180 / PI * ArcTan2(2*xy,(xx-yy)) / 2;

                             s := s + FloatToStrF(TheMax,ffExponent,6,2)+'  '+FloatToStrF(TheMin,ffExponent,6,2)+' '+FloatToStrF(TheAngle,ffNumber,7,4);
                         end
                         else
                         begin

                             if P1 <> -1 then
                                 s := s + Strs[f] [index+P1] + ' '
                             else
                                 s := s + '0 ';

                             if P2 <> -1 then
                                 s := s + Strs[f] [index+P2] + ' '
                             else
                                 s := s + '0 ';

                             if P3 <> -1 then
                                 s := s + Strs[f] [index+P3]
                             else
                                 s := s + '0';

                             if IsMatrix then
                             begin
                                 s := s + ' ';

                                 if P4 <> -1 then
                                     s := s + Strs[f] [index+P4] + ' '
                                 else
                                     s := s + '0 ';

                                 if P5 <> -1 then
                                     s := s + Strs[f] [index+P5] + ' '
                                 else
                                     s := s + '0 ';

                                 if P6 <> -1 then
                                     s := s + Strs[f] [index+P6]
                                 else
                                     s := s + '0';
                             end;
                         end;

                         MSH.Writeline(s);

                         s := StringOfChar(' ',INDENT);
                    end;
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(cnt+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                if not EOF(OutFiles[0]) then
                    for j := 1 to Length(s) do
                        write(#8);
            end;

            Inc(cnt);

        until EOF(OutFiles[0]);

        writeln;

        CloseFile(OutFiles[0]);

        if OneFilePerGP then
            for i := 1 to 3 do
                CloseFile(OutFiles[i]);
    end;
end;

procedure WriteCracks(Caption,Filename,ElemName,ResultName : string);

var
    i,j,k,cnt : integer;
    fExists   : boolean;
    OutNames  : array[0..3] of string;
    OutFiles  : array[0..3] of textfile;
    lines     : array[0..3] of string;
    Strs      : array[0..3] of ArrayStr;
    Tags      : ArrayStr;

begin
    fExists := true;

    for i := 0 to 3 do
    begin
        OutNames[i] := ModelPath+'\OpenSees\'+Filename+'_GP'+IntToStr(i+1)+'.out';
        fExists := fExists and FileExists(OutNames[i]);
    end;

    if fExists then
    begin
        write(Caption);

        n := StrToInt(Copy(TCL[TCL.IndexOf('# '+ElemName)+1],3,10));  // number of elements

        StrToArray(TCL[TCL.IndexOf('# '+ElemName)+2],Tags,n,true);  // read all tags

        for i := 0 to 3 do
        begin
            AssignFile(OutFiles[i],OutNames[i]);
            Reset(OutFiles[i]);
        end;

        cnt := 0;

        repeat

            for i := 0 to 3 do
                Readln(OutFiles[i],lines[i]);

            if (cnt = 0) or EOF(OutFiles[0]) or (cnt mod Step = 0) then
            begin

                MSH.Writeline('');

                MSH.Writeline('ResultGroup "'+Str_IntNames[cnt]+'" '+Str_Steps[cnt]+' OnGaussPoints "'+ElemName+'_GP"');
                MSH.Writeline('ResultDescription "Elements//'+ElemName+'//'+ResultName+'//Flag" Scalar');
                MSH.Writeline('ResultRangesTable "Cracks"');
                MSH.Writeline('Unit "-"');
                MSH.Writeline('ResultDescription "Elements//'+ElemName+'//'+ResultName+'//Angle" Scalar');
                MSH.Writeline('Unit "deg"');

                MSH.Writeline('Values');

                for i := 0 to 3 do
                    StrToArray(lines[i],Strs[i],3*n,true); // read all values from current step (ValuesPerGP values)

                for j := 0 to n-1 do  // elements
                begin
                    s := Tags[j] + StringOfChar(' ',INDENT-Length(Tags[j]));

                    for k := 0 to 3 do
                    begin
                         s := s + IntToStr ( StrToInt(Strs[k] [3*j]) + 2*StrToInt(Strs[k] [3*j+1]) ) +' '+ Strs[k] [3*j+2];

                         MSH.Writeline(s);

                         s := StringOfChar(' ',INDENT);
                    end;
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(cnt+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                if not EOF(OutFiles[0]) then
                    for j := 1 to Length(s) do
                        write(#8);
            end;

            Inc(cnt);

        until EOF(OutFiles[0]);

        writeln;

        for i := 0 to 3 do
            CloseFile(OutFiles[i]);
    end;
end;

//
// M A I N   P R O G R A M
//

begin

    FormatSettings.DecimalSeparator := '.';  // default in GiD

    // console

    Rewrite(Output);
    StdOut := TTextRec(Output).Handle;
    ShowCursor(false);

    // title

    TextColor(LightCyan);

    writeln('OpenSeesPost - OpenSees to GiD results converter');
    writeln;
    writeln('https://github.com/rclab-auth/gidopensees');
    writeln;

    // check syntax

    TextColor(LightRed);

    if ParamCount < 3 then
    begin
        writeln('Syntax : OpenSeesPost <GiD path> <project path> <step> <option /b for binary>');
        writeln;
        Exit;
    end;

    // load model file

    GiDPath := LongPathName(ParamStr(1));
    ModelPath := LongPathName(ParamStr(2));
    Step := StrToInt(ParamStr(3));

    ModelName := Copy(ModelPath,LastDelimiter('\',ModelPath)+1,Length(ModelPath)-LastDelimiter('\',ModelPath));
    ModelName := Copy(ModelName,1,Length(ModelName)-4);

    // check log file

    FileName := ModelPath+'\OpenSees\'+ModelName+'.log';

    if not FileExists(FileName) then
    begin
        writeln('No results found.');

        Sleep(1000);
        Exit;
    end;

    LOG := TStringList.Create;

    LOG.LoadFromFile(FileName);

    i := 0;

    while i < LOG.Count do
    begin
        if Pos('WARNING invalid nodeId',LOG.Strings[i]) <> 0 then
            LOG.Delete(i)
        else
            Inc(i);
    end;

    LOG.SaveToFile(FileName);

    {
    for i := 0 to LOG.Count-1 do
        if Pos('Analysis FAILED',LOG.Strings[i]) <> 0 then
        begin
            writeln('Analysis failed.');

            Sleep(1000);
            LOG.Free;
            Exit;
        end;
    }

    i := 0;
    cnt := 0;

    while i < LOG.Count do
    begin
        if Pos('Interval',LOG.Strings[i]) <> 0 then
        begin
            SetLength(Int_Type,Length(Int_Type)+1);
            Int_Type[cnt] := Trim(Copy(LOG.Strings[i],Pos(':',LOG.Strings[i])+1,Pos('-',LOG.Strings[i])-Pos(':',LOG.Strings[i])-1 ));

            SetLength(Int_StepsInit,Length(Int_StepsInit)+1);
            Int_StepsInit[cnt] := StrToInt(Trim(Copy(LOG.Strings[i],Pos('-',LOG.Strings[i])+1,Pos('steps',LOG.Strings[i])-Pos('-',LOG.Strings[i])-1 )));

            SetLength(Int_Time,Length(Int_Time)+1);
            if Pos('x',LOG.Strings[i]) <> 0 then
                Int_Time[cnt] := StrToFloat(Trim(Copy(LOG.Strings[i],Pos('x',LOG.Strings[i])+1,Length(LOG.Strings[i])-Pos('x',LOG.Strings[i])-1 )))
            else
                Int_Time[cnt] := 0;

            Inc(cnt);
        end;

        Inc(i);
    end;

    i := 0;
    cnt := 0;

    while i < LOG.Count do
    begin
        if Pos('Committed',LOG.Strings[i]) <> 0 then
        begin
            SetLength(Int_Steps,Length(Int_Steps)+1);
            Int_Steps[cnt] := StrToInt(Trim(Copy(LOG.Strings[i], Pos(':',LOG.Strings[i])+1,10)));
            Inc(cnt);
        end;

        Inc(i);
    end;

    LOG.Free;

    GetStatistics(FileName);

    // check .tcl file

    FileName := ModelPath+'\OpenSees\'+ModelName+'.tcl';

    if FileExists(FileName) then
    begin
        TCL := TStringList.Create;
        TCL.LoadFromFile(FileName);

        TextColor(LightGreen);
        writeln('Model file : '+ExtractFileName(FileName));
        writeln;
    end
    else
    begin
        writeln('Model file '+FileName+' does not exist.');
        writeln;
        Exit;
    end;

    for i := 0 to Length(Int_Type)-1 do
    begin
        if i <= Length(Int_Steps)-1 then
            writeln('Interval '+IntToStr(i+1)+' ('+Int_Type[i]+') : Steps = '+IntToStr(Int_StepsInit[i])+' - Committed = '+IntToStr(Int_Steps[i]))
        else
            writeln('Interval '+IntToStr(i+1)+' ('+Int_Type[i]+') : Steps = '+IntToStr(Int_StepsInit[i])+' - Committed unknown (interrupted)');
    end;

    writeln;

    // get basic model parameters

    ndm := StrToInt(Copy(TCL.Text,Pos('-ndm',TCL.Text)+5,1));

    // initialize files

    ResFileASCII := ModelPath+'\'+ModelName+'.post.res.ascii';
    ResFileBin := ModelPath+'\'+ModelName+'.post.res';

    if FileExists(ResFileASCII) then
        DeleteFile(PWideChar(ResFileASCII));
    if FileExists(ResFileBin) then
        DeleteFile(PWideChar(ResFileBin));

    MSH := TStreamWriter.Create(ResFileASCII,false,TEncoding.ASCII);

    MSH.Writeline('GiD Post Results File 1.0');

    //
    // GAUSS POINT DEFINITIONS
    //

    if FileExists(ModelPath+'\OpenSees\stdBrick_force.out') or
       FileExists(ModelPath+'\OpenSees\stdBrick_stress.out') or
       FileExists(ModelPath+'\OpenSees\stdBrick_strain.out') then
    begin
        MSH.Writeline('');
        MSH.Writeline('GaussPoints "stdBrick_GP" ElemType Hexahedra');
        MSH.Writeline('Number Of Gauss Points: 8');
        MSH.Writeline('Natural Coordinates: Given');
        MSH.Writeline('-0.577350269189626 -0.577350269189626 -0.577350269189626');
        MSH.Writeline('-0.577350269189626 -0.577350269189626  0.577350269189626');
        MSH.Writeline('-0.577350269189626  0.577350269189626 -0.577350269189626');
        MSH.Writeline('-0.577350269189626  0.577350269189626  0.577350269189626');
        MSH.Writeline('+0.577350269189626 -0.577350269189626 -0.577350269189626');
        MSH.Writeline(' 0.577350269189626 -0.577350269189626  0.577350269189626');
        MSH.Writeline(' 0.577350269189626  0.577350269189626 -0.577350269189626');
        MSH.Writeline(' 0.577350269189626  0.577350269189626  0.577350269189626');
        MSH.Writeline('end GaussPoints');

        MSH.Writeline('');
        MSH.Writeline('GaussPoints "stdBrick_Node" ElemType Hexahedra');
        MSH.Writeline('Number Of Gauss Points: 8');
        MSH.Writeline('Natural Coordinates: Given');
        MSH.Writeline('-1 -1 -1');
        MSH.Writeline(' 1 -1 -1');
        MSH.Writeline(' 1  1 -1');
        MSH.Writeline('-1  1 -1');
        MSH.Writeline('-1 -1  1');
        MSH.Writeline(' 1 -1  1');
        MSH.Writeline(' 1  1  1');
        MSH.Writeline('-1  1  1');
        MSH.Writeline('end GaussPoints');
    end;

    if FileExists(ModelPath+'\OpenSees\ShellMITC4_force.out') or
       FileExists(ModelPath+'\OpenSees\ShellMITC4_stress.out') then
    begin
        MSH.Writeline('');
        MSH.Writeline('GaussPoints "ShellMITC4_GP" ElemType Quadrilateral');
        MSH.Writeline('Number Of Gauss Points: 4');
        MSH.Writeline('Natural Coordinates: Given');
        MSH.Writeline('-0.577350269189626 -0.577350269189626');
        MSH.Writeline('-0.577350269189626  0.577350269189626');
        MSH.Writeline(' 0.577350269189626 -0.577350269189626');
        MSH.Writeline(' 0.577350269189626  0.577350269189626');
        MSH.Writeline('end GaussPoints');

        MSH.Writeline('');
        MSH.Writeline('GaussPoints "ShellMITC4_Node" ElemType Quadrilateral');
        MSH.Writeline('Number Of Gauss Points: 4');
        MSH.Writeline('Natural Coordinates: Given');
        MSH.Writeline(' 1 -1');
        MSH.Writeline('-1  1');
        MSH.Writeline('-1 -1');
        MSH.Writeline(' 1  1');
        MSH.Writeline('end GaussPoints');
    end;

    if FileExists(ModelPath+'\OpenSees\ShellDKGQ_force.out') or
       FileExists(ModelPath+'\OpenSees\ShellDKGQ_stress.out') then
    begin
        MSH.Writeline('');
        MSH.Writeline('GaussPoints "ShellDKGQ_GP" ElemType Quadrilateral');
        MSH.Writeline('Number Of Gauss Points: 4');
        MSH.Writeline('Natural Coordinates: Given');
        MSH.Writeline('-0.577350269189626 -0.577350269189626');
        MSH.Writeline('-0.577350269189626  0.577350269189626');
        MSH.Writeline(' 0.577350269189626 -0.577350269189626');
        MSH.Writeline(' 0.577350269189626  0.577350269189626');
        MSH.Writeline('end GaussPoints');

        MSH.Writeline('');
        MSH.Writeline('GaussPoints "ShellDKGQ_Node" ElemType Quadrilateral');
        MSH.Writeline('Number Of Gauss Points: 4');
        MSH.Writeline('Natural Coordinates: Given');
        MSH.Writeline(' 1 -1');
        MSH.Writeline('-1  1');
        MSH.Writeline('-1 -1');
        MSH.Writeline(' 1  1');
        MSH.Writeline('end GaussPoints');
    end;

    if FileExists(ModelPath+'\OpenSees\Quad_force.out') or
       FileExists(ModelPath+'\OpenSees\Quad_stress.out') or
       FileExists(ModelPath+'\OpenSees\Quad_strain.out') then
    begin
        MSH.Writeline('');
        MSH.Writeline('GaussPoints "Quad_GP" ElemType Quadrilateral');
        MSH.Writeline('Number Of Gauss Points: 4');
        MSH.Writeline('Natural Coordinates: Given');
        MSH.Writeline('-0.577350269189626 -0.577350269189626');
        MSH.Writeline('-0.577350269189626  0.577350269189626');
        MSH.Writeline(' 0.577350269189626 -0.577350269189626');
        MSH.Writeline(' 0.577350269189626  0.577350269189626');
        MSH.Writeline('end GaussPoints');

        MSH.Writeline('');
        MSH.Writeline('GaussPoints "Quad_Node" ElemType Quadrilateral');
        MSH.Writeline('Number Of Gauss Points: 4');
        MSH.Writeline('Natural Coordinates: Given');
        MSH.Writeline(' 1 -1');
        MSH.Writeline('-1  1');
        MSH.Writeline('-1 -1');
        MSH.Writeline(' 1  1');
        MSH.Writeline('end GaussPoints');
    end;

    if FileExists(ModelPath+'\OpenSees\Tri31_force.out') or
       FileExists(ModelPath+'\OpenSees\Tri31_stress.out') or
       FileExists(ModelPath+'\OpenSees\Tri31_strain.out') then
    begin
        MSH.Writeline('');
        MSH.Writeline('GaussPoints "Tri31_GP" ElemType Triangle');
        MSH.Writeline('Number Of Gauss Points: 1');
        MSH.Writeline('Natural Coordinates: Given');
        MSH.Writeline(' 0.333333333333333  0.333333333333333');
        MSH.Writeline('end GaussPoints');

        MSH.Writeline('');
        MSH.Writeline('GaussPoints "Tri31_Node" ElemType Triangle');
        MSH.Writeline('Number Of Gauss Points: 3');
        MSH.Writeline('Natural Coordinates: Given');
        MSH.Writeline(' 1  0');
        MSH.Writeline(' 1  1');
        MSH.Writeline(' 0  1');
        MSH.Writeline('end GaussPoints');
    end;

    if FileExists(ModelPath+'\OpenSees\Truss_axialForce.out') or
       FileExists(ModelPath+'\OpenSees\Truss_deformations.out') or
       FileExists(ModelPath+'\OpenSees\CorotTruss_axialForce.out') or
       FileExists(ModelPath+'\OpenSees\CorotTruss_deformations.out') or
       FileExists(ModelPath+'\OpenSees\ElasticBeamColumn_localForce.out')or
       FileExists(ModelPath+'\OpenSees\ElasticTimoshenkoBeamColumn_localForce.out') or
       FileExists(ModelPath+'\OpenSees\ForceBeamColumn_localForce.out') or
       FileExists(ModelPath+'\OpenSees\ForceBeamColumn_basicDeformation.out') or
       FileExists(ModelPath+'\OpenSees\ForceBeamColumn_plasticDeformation') or
       FileExists(ModelPath+'\OpenSees\DispBeamColumn_localForce.out') or
       FileExists(ModelPath+'\OpenSees\DispBeamColumn_basicDeformation.out') or
       FileExists(ModelPath+'\OpenSees\DispBeamColumn_plasticDeformation.out') or
       FileExists(ModelPath+'\OpenSees\DispBeamColumnInt_localForce.out') then

    begin
        MSH.Writeline('');
        MSH.Writeline('GaussPoints "Line_Nodes" ElemType Line');
        MSH.Writeline('Number Of Gauss Points: 2');
        MSH.Writeline('Nodes included');
        MSH.Writeline('Natural Coordinates: Internal');
        MSH.Writeline('end GaussPoints');
    end;

    MSH.Writeline('');
    MSH.Writeline('ResultRangesTable "Cracks"');
    MSH.Writeline('1 - 1: "Crack in dir. 1"');
    MSH.Writeline('2 - 2: "Crack in dir. 2"');
    MSH.Writeline('3 - 3: "Cracks in both dirs."');
    MSH.Writeline('End ResultRangesTable');

    // buffer interval types and steps

    OutFile := ModelPath+'\OpenSees\Node_displacements.out';

    if FileExists(OutFile) then
    begin
        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        SetLength(Str_IntNames,0);
        SetLength(Str_Steps,0);

        repeat

            Readln(RES,line);

            SetLength(Str_IntNames,Length(Str_IntNames)+1);
            SetLength(Str_Steps,Length(Str_Steps)+1);

            Str_IntNames[i] := 'Interval '+IntToStr(GetIntervalNumber(i))+' - '+Int_Type[GetIntervalNumber(i)-1];
            Str_Steps[i] := IntToStr(GetIntervalStep(i));

            Inc(i);

        until EOF(RES);

        CloseFile(RES);
    end;

    //
    //
    // L O C A L   A X E S   F O R   F R A M E   E L E M E N T S
    //
    //

    TextColor(White);

    n := TCL.IndexOf('# F R A M E   L O C A L   A X E S   O R I E N T A T I O N');

    OutFile := ModelPath+'\OpenSees\Node_displacements.out';

    if FileExists(OutFile) and (n <> -1) then
    begin
        MSH.Writeline('');
        MSH.Writeline('GaussPoints "Line_Axes" ElemType Line');
        MSH.Writeline('Number Of Gauss Points: 1');
        MSH.Writeline('Nodes not included');
        MSH.Writeline('Natural Coordinates: Internal');
        MSH.Writeline('end GaussPoints');

        writeln('Reading frame element local axes');

        LOC := TStringList.Create;

        LOC.Add('ComponentNames "Local-x" "Local-y" "Local-z"');
        LOC.Add('Unit " "');
        LOC.Add('Values');

        n := n+6;

        SetLength(Tag,1);

        for i := n to TCL.Count-1 do
        begin
            Tag[0] := Trim(Copy(TCL[i],4,6));

            Vx[1] := StrToFloat(Copy(TCL[i],47,7));
            Vx[2] := StrToFloat(Copy(TCL[i],55,7));
            Vx[3] := StrToFloat(Copy(TCL[i],63,7));
            Vy[1] := StrToFloat(Copy(TCL[i],77,7));
            Vy[2] := StrToFloat(Copy(TCL[i],85,7));
            Vy[3] := StrToFloat(Copy(TCL[i],93,7));
            Vz[1] := StrToFloat(Copy(TCL[i],107,7));
            Vz[2] := StrToFloat(Copy(TCL[i],115,7));
            Vz[3] := StrToFloat(Copy(TCL[i],123,7));

            // calculation of euler angles (http://geom3d.com/data/documents/Calculation=20of=20Euler=20angles.pdf)

            zxy := Sqrt(Vz[1]*Vz[1]+Vz[2]*Vz[2]);

            if zxy > EPS then
            begin
                Ang[1] := ArcTan2(Vy[1]*Vz[2]-Vy[2]*Vz[1],Vx[1]*Vz[2]-Vx[2]*Vz[1]);
                Ang[2] := ArcTan2(zxy,Vz[3]);
                Ang[3] := -ArcTan2(-Vz[1],Vz[2]);
            end
            else
            begin
                Ang[1] := 0;

                if Vz[3] > 0 then
                    Ang[2] := 0
                else
                    Ang[2] := PI;

                Ang[3] := -ArcTan2(Vx[2],Vx[1]);
            end;

            LOC.Add(Tag[0] + StringOfChar(' ',INDENT-Length(Tag[0])) + Format('%7.4f  %7.4f  %7.4f',[Ang[1],Ang[2],Ang[3]]));
        end;

        LOC.Add('End Values');

        // add to all steps

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
                begin


                MSH.Writeline('');
                MSH.Writeline('Result "Local_Axes" "'+Str_IntNames[i]+'" '+Str_Steps[i]+' LocalAxes OnGaussPoints "Line_Axes"');

                for j := 1 to LOC.Count-1 do
                    MSH.Writeline(LOC[j]);
            end;

            Inc(i);

        until EOF(RES);

        CloseFile(RES);

        FreeAndNil(LOC);
    end;

    //
    //
    // M O D E S
    //
    //

    OutFile := ModelPath+'\OpenSees\Periods.out';

    if FileExists(OutFile) then
    begin
        PER := TStringList.Create;
        PER.LoadFromFile(OutFile);

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Number of nodes')+1],3,10));  // number of nodes

        for i := 1 to PER.Count do
        begin
            write('Reading mode ');
            TextColor(Yellow);
            writeln(IntToStr(i));
            TextColor(White);

            OutFile := ModelPath+'\OpenSees\Mode_'+IntToStr(i)+'.out';

            Period := Copy(PER.Strings[i-1],1,LastDelimiter('.',PER.Strings[i-1])+6);

            MSH.Writeline('');
            MSH.Writeline('Result "Mode_'+IntToStr(i)+' (T'+IntToStr(i)+' = '+Period+' s)" "Modal" 0 Vector OnNodes');

            if ndm = 3 then
                s := 'ComponentNames "Ux" "Uy" "Uz"'
            else
                s := 'ComponentNames "Ux" "Uy" "Uz (zero)"';

            MSH.Writeline(s);

            MSH.Writeline('Unit "m"');
            MSH.Writeline('Values');

            AssignFile(RES,OutFile);
            Reset(RES);
            Readln(RES,line);

            StrToArray(line,Str,n*ndm,false);  // read all values from current step

            CloseFile(RES);

            for j := 0 to n-1 do
            begin
                if ndm = 3 then
                    s := IntToStr(j+1) + StringOfChar(' ',INDENT-Length(IntToStr(j+1))) + Str[ndm*j]+' '+Str[ndm*j+1]+' '+Str[ndm*j+2]
                else
                    s := IntToStr(j+1) + StringOfChar(' ',INDENT-Length(IntToStr(j+1))) + Str[ndm*j]+' '+Str[ndm*j+1]+' 0';

                MSH.Writeline(s);
            end;

            MSH.Writeline('End Values');

        end;

        FreeAndNil(PER);
    end;

    //
    //
    // L O A D   F A C T O R   /   T I M E
    //
    //

    OutFile := ModelPath+'\OpenSees\Node_displacements.out';

    if FileExists(OutFile) then
    begin
        write('Reading load factors / time ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Number of nodes')+1],3,10));  // number of nodes

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');

                if Pos('Static',Str_IntNames[i]) <> 0 then
                begin
                    MSH.Writeline('Result "Load Factor" "'+Str_IntNames[i]+'" '+Str_Steps[i]+' Scalar OnNodes');
                    MSH.Writeline('ComponentNames "LF"');
                    MSH.Writeline('Unit " "');
                end;

                if Pos('Transient',Str_IntNames[i]) <> 0 then
                begin
                    MSH.Writeline('Result "Time" "'+Str_IntNames[i]+'" '+Str_Steps[i]+' Scalar OnNodes');
                    MSH.Writeline('ComponentNames "Time"');
                    MSH.Writeline('Unit "s"');
                end;

                MSH.Writeline('Values');

                StrToArray(line,Str,n*ndm,false);  // read all values from current step

                for j := 0 to n-1 do

                    MSH.Writeline(IntToStr(j+1) + StringOfChar(' ',INDENT-Length(IntToStr(j+1))) + Str[0]);

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                if not EOF(RES) then
                    for j := 1 to Length(s) do
                        write(#8);
            end;

            Inc(i);

        until EOF(RES);

        CloseFile(RES);

        writeln;

    end;

    //
    //
    // N O D E S
    //
    //

    // displacements

    OutFile := ModelPath+'\OpenSees\Node_displacements.out';

    if FileExists(OutFile) then
    begin
        write('Reading nodal displacements ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Number of nodes')+1],3,10));  // number of nodes

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Nodes//Displacements" "'+Str_IntNames[i]+'" '+Str_Steps[i]+' Vector OnNodes');

                if ndm = 3 then
                    s := 'ComponentNames "Ux" "Uy" "Uz"'
                else
                    s := 'ComponentNames "Ux" "Uy" "Uz (zero)"';

                MSH.Writeline(s);

                MSH.Writeline('Unit "m"');
                MSH.Writeline('Values');

                StrToArray(line,Str,n*ndm,true);  // read all values from current step

                for j := 0 to n-1 do
                begin

                    if ndm = 3 then
                        s := IntToStr(j+1) + StringOfChar(' ',INDENT-Length(IntToStr(j+1))) + Str[ndm*j]+' '+Str[ndm*j+1]+' '+Str[ndm*j+2]
                    else
                        s := IntToStr(j+1) + StringOfChar(' ',INDENT-Length(IntToStr(j+1))) + Str[ndm*j]+' '+Str[ndm*j+1]+' 0';

                    MSH.Writeline(s);
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                if not EOF(RES) then
                    for j := 1 to Length(s) do
                        write(#8);
            end;

            Inc(i);

        until EOF(RES);

        CloseFile(RES);

        writeln;

    end;

    // rotations

    OutFile := ModelPath+'\OpenSees\Node_rotations.out';

    if FileExists(OutFile) then
    begin
        write('Reading nodal rotations ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Number of nodes')+1],3,10));  // number of nodes

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Nodes//Rotations" "'+Str_IntNames[i]+'" '+Str_Steps[i]+' Vector OnNodes');

                if ndm = 3 then
                    s := 'ComponentNames "Rx" "Ry" "Rz"'
                else
                    s := 'ComponentNames "Rx (zero)" "Ry (zero)" "Rz"';

                MSH.Writeline(s);

                MSH.Writeline('Unit "rad"');
                MSH.Writeline('Values');

                // read all values from current step

                if ndm = 3 then
                    StrToArray(line,Str,3*n,true)
                else
                    StrToArray(line,Str,n,true);

                for j := 0 to n-1 do
                begin

                    if ndm = 3 then
                        s := IntToStr(j+1) + StringOfChar(' ',INDENT-Length(IntToStr(j+1))) + Str[3*j]+' '+Str[3*j+1]+' '+Str[3*j+2]
                    else
                        s := IntToStr(j+1) + StringOfChar(' ',INDENT-Length(IntToStr(j+1))) + ' 0 0 '+Str[j];

                    MSH.Writeline(s);
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                if not EOF(RES) then
                    for j := 1 to Length(s) do
                        write(#8);
            end;

            Inc(i);

        until EOF(RES);

        CloseFile(RES);

        writeln;

    end;

    // force reactions

    OutFile := ModelPath+'\OpenSees\Node_forceReactions.out';

    if FileExists(OutFile) then
    begin
        write('Reading nodal reactions ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Number of nodes')+1],3,10));  // number of nodes

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Nodes//Force reactions" "'+Str_IntNames[i]+'" '+Str_Steps[i]+' Vector OnNodes');

                if ndm = 3  then
                    s := 'ComponentNames "Rx" "Ry" "Rz"'
                else
                    s := 'ComponentNames "Rx" "Ry" "Rz (zero)"';

                MSH.Writeline(s);

                MSH.Writeline('Unit "kN"');
                MSH.Writeline('Values');

                StrToArray(line,Str,n*ndm,true);  // read all values from current step

                for j := 0 to n-1 do
                begin

                    if ndm = 3 then
                        s := IntToStr(j+1) + StringOfChar(' ',INDENT-Length(IntToStr(j+1))) + Str[ndm*j]+' '+Str[ndm*j+1]+' '+Str[ndm*j+2]
                    else
                        s := IntToStr(j+1) + StringOfChar(' ',INDENT-Length(IntToStr(j+1))) + Str[ndm*j]+' '+Str[ndm*j+1]+' 0';

                    MSH.Writeline(s);
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                if not EOF(RES) then
                    for j := 1 to Length(s) do
                        write(#8);
            end;

            Inc(i);

        until EOF(RES);

        CloseFile(RES);

        writeln;

    end;

    // moment reactions

    OutFile := ModelPath+'\OpenSees\Node_momentReactions.out';

    if FileExists(OutFile) then
    begin
        write('Reading nodal moments ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Number of nodes')+1],3,10));  // number of nodes

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Nodes//Moment reactions" "'+Str_IntNames[i]+'" '+Str_Steps[i]+' Vector OnNodes');

                if ndm = 3 then
                    s := 'ComponentNames "RMx" "RMy" "RMz"'
                else
                    s := 'ComponentNames "RMx (zero)" "RMy (zero)" "RMz"';

                MSH.Writeline(s);

                MSH.Writeline('Unit "kNm"');
                MSH.Writeline('Values');

                // read all values from current step

                if ndm = 3 then
                    StrToArray(line,Str,3*n,true)
                else
                    StrToArray(line,Str,n,true);

                for j := 0 to n-1 do
                begin

                    if ndm = 3 then
                        s := IntToStr(j+1) + StringOfChar(' ',INDENT-Length(IntToStr(j+1))) + Str[3*j]+' '+Str[3*j+1]+' '+Str[3*j+2]
                    else
                        s := IntToStr(j+1) + StringOfChar(' ',INDENT-Length(IntToStr(j+1))) + ' 0 0 '+Str[j];

                    MSH.Writeline(s);
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                if not EOF(RES) then
                    for j := 1 to Length(s) do
                        write(#8);
            end;

            Inc(i);

        until EOF(RES);

        CloseFile(RES);

        writeln;

    end;

    // accelerations

    OutFile := ModelPath+'\OpenSees\Node_accelerations.out';

    if FileExists(OutFile) then
    begin
        write('Reading nodal accelerations ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Number of nodes')+1],3,10));  // number of nodes

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Nodes//Accelerations" "'+Str_IntNames[i]+'" '+Str_Steps[i]+' Vector OnNodes');

                if ndm = 3 then
                    s := 'ComponentNames "ax" "ay" "az"'
                else
                    s := 'ComponentNames "ax" "ay" "az (zero)"';

                MSH.Writeline(s);

                MSH.Writeline('Unit "m/s^2"');
                MSH.Writeline('Values');

                StrToArray(line,Str,n*ndm,true);  // read all values from current step

                for j := 0 to n-1 do
                begin

                    if ndm = 3 then
                        s := IntToStr(j+1) + StringOfChar(' ',INDENT-Length(IntToStr(j+1))) + Str[ndm*j]+' '+Str[ndm*j+1]+' '+Str[ndm*j+2]
                    else
                        s := IntToStr(j+1) + StringOfChar(' ',INDENT-Length(IntToStr(j+1))) + Str[ndm*j]+' '+Str[ndm*j+1]+' 0';

                    MSH.Writeline(s);
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                if not EOF(RES) then
                    for j := 1 to Length(s) do
                        write(#8);
            end;

            Inc(i);

        until EOF(RES);

        CloseFile(RES);

        writeln;

    end;

    // rotational accelerations

    OutFile := ModelPath+'\OpenSees\Node_rotAccelerations.out';

    if FileExists(OutFile) then
    begin
        write('Reading nodal rotational accelerations ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Number of nodes')+1],3,10));  // number of nodes

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Nodes//Rot.Accelerations" "'+Str_IntNames[i]+'" '+Str_Steps[i]+' Vector OnNodes');

                if ndm = 3 then
                    s := 'ComponentNames "arx" "ary" "arz"'
                else
                    s := 'ComponentNames "arx (zero)" "ary (zero)" "arz"';

                MSH.Writeline(s);

                MSH.Writeline('Unit "m/s^2"');
                MSH.Writeline('Values');

                StrToArray(line,Str,n*ndm,true);  // read all values from current step

                for j := 0 to n-1 do
                begin

                    if ndm = 3 then
                        s := IntToStr(j+1) + StringOfChar(' ',INDENT-Length(IntToStr(j+1))) + Str[ndm*j]+' '+Str[ndm*j+1]+' '+Str[ndm*j+2]
                    else
                        s := IntToStr(j+1) + StringOfChar(' ',INDENT-Length(IntToStr(j+1))) + ' 0 0 '+Str[j];

                    MSH.Writeline(s);
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                if not EOF(RES) then
                    for j := 1 to Length(s) do
                        write(#8);
            end;

            Inc(i);

        until EOF(RES);

        CloseFile(RES);

        writeln;

    end;

    // velocities

    OutFile := ModelPath+'\OpenSees\Node_velocities.out';

    if FileExists(OutFile) then
    begin
        write('Reading nodal velocities ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Number of nodes')+1],3,10));  // number of nodes

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Nodes//Velocities" "'+Str_IntNames[i]+'" '+Str_Steps[i]+' Vector OnNodes');

                if ndm = 3 then
                    s := 'ComponentNames "vx" "vy" "vz"'
                else
                    s := 'ComponentNames "vx" "vy" "vz (zero)"';

                MSH.Writeline(s);

                MSH.Writeline('Unit "m/s"');
                MSH.Writeline('Values');

                StrToArray(line,Str,n*ndm,true);  // read all values from current step

                for j := 0 to n-1 do
                begin

                    if ndm = 3 then
                        s := IntToStr(j+1) + StringOfChar(' ',INDENT-Length(IntToStr(j+1))) + Str[ndm*j]+' '+Str[ndm*j+1]+' '+Str[ndm*j+2]
                    else
                        s := IntToStr(j+1) + StringOfChar(' ',INDENT-Length(IntToStr(j+1))) + Str[ndm*j]+' '+Str[ndm*j+1]+' 0';

                    MSH.Writeline(s);
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                if not EOF(RES) then
                    for j := 1 to Length(s) do
                        write(#8);
            end;

            Inc(i);

        until EOF(RES);

        CloseFile(RES);

        writeln;

    end;

    // rotational velocities

    OutFile := ModelPath+'\OpenSees\Node_rotVelocities.out';

    if FileExists(OutFile) then
    begin
        write('Reading nodal rotational velocities ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Number of nodes')+1],3,10));  // number of nodes

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Nodes//Rot.Velocities" "'+Str_IntNames[i]+'" '+Str_Steps[i]+' Vector OnNodes');

                if ndm = 3 then
                    s := 'ComponentNames "vrx" "vry" "vrz"'
                else
                    s := 'ComponentNames "vrx (zero)" "vry (zero)" "vrz"';

                MSH.Writeline(s);

                MSH.Writeline('Unit "m/s"');
                MSH.Writeline('Values');

                StrToArray(line,Str,n*ndm,true);  // read all values from current step

                for j := 0 to n-1 do
                begin

                    if ndm = 3 then
                        s := IntToStr(j+1) + StringOfChar(' ',INDENT-Length(IntToStr(j+1))) + Str[ndm*j]+' '+Str[ndm*j+1]+' '+Str[ndm*j+2]
                    else
                        s := IntToStr(j+1) + StringOfChar(' ',INDENT-Length(IntToStr(j+1))) + ' 0 0 '+Str[j];

                    MSH.Writeline(s);
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                if not EOF(RES) then
                    for j := 1 to Length(s) do
                        write(#8);
            end;

            Inc(i);

        until EOF(RES);

        CloseFile(RES);

        writeln;

    end;

    //
    //
    // F R A M E   E L E M E N T S
    //
    //

    //
    // Truss
    //

    OutFile := ModelPath+'\OpenSees\Truss_axialForce.out';

    if FileExists(OutFile) then
    begin
        write('Reading truss forces ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Truss')+1],3,10));  // number of trusses

        StrToArray(TCL[TCL.IndexOf('# Truss')+2],Tag,n,true);  // read all tags

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Elements//Truss//Axial" "'+Str_IntNames[i]+'" '+Str_Steps[i]+' Scalar OnGaussPoints "Line_Nodes"');
                MSH.Writeline('Unit "kN"');
                MSH.Writeline('Values');

                StrToArray(line,Str,n,true);  // read all values from current step (1 value per element)

                for j := 0 to n-1 do
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[j];

                    MSH.Writeline(s);

                    s := StringOfChar(' ',INDENT) + Str[j];

                    MSH.Writeline(s);
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                if not EOF(RES) then
                    for j := 1 to Length(s) do
                        write(#8);
            end;

            Inc(i);

        until EOF(RES);

        CloseFile(RES);

        writeln;

    end;

    OutFile := ModelPath+'\OpenSees\Truss_deformations.out';

    if FileExists(OutFile) then
    begin
        write('Reading truss deformations ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Truss')+1],3,10));  // number of trusses

        StrToArray(TCL[TCL.IndexOf('# Truss')+2],Tag,n,true);  // read all tags

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Elements//Truss//Deformation" "'+Str_IntNames[i]+'" '+Str_Steps[i]+' Scalar OnGaussPoints "Line_Nodes"');
                MSH.Writeline('Unit "m"');
                MSH.Writeline('Values');

                StrToArray(line,Str,n,true);  // read all values from current step (1 value per element)

                for j := 0 to n-1 do
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[j];

                    MSH.Writeline(s);

                    s := StringOfChar(' ',INDENT) + Str[j];

                    MSH.Writeline(s);
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                if not EOF(RES) then
                    for j := 1 to Length(s) do
                        write(#8);
            end;

            Inc(i);

        until EOF(RES);

        CloseFile(RES);

        writeln;

    end;

    //
    // Corotational Truss
    //

    OutFile := ModelPath+'\OpenSees\CorotTruss_axialForce.out';

    if FileExists(OutFile) then
    begin
        write('Reading corotational truss forces ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# CorotTruss')+1],3,10));  // number of corotational trusses

        StrToArray(TCL[TCL.IndexOf('# CorotTruss')+2],Tag,n,true);  // read all tags

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Elements//Corotational_Truss//Axial" "'+Str_IntNames[i]+'" '+Str_Steps[i]+' Scalar OnGaussPoints "Line_Nodes"');
                MSH.Writeline('Unit "kN"');
                MSH.Writeline('Values');

                StrToArray(line,Str,n,true);  // read all values from current step (1 value per element)

                for j := 0 to n-1 do
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[j];

                    MSH.Writeline(s);

                    s := StringOfChar(' ',INDENT) + Str[j];

                    MSH.Writeline(s);
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                if not EOF(RES) then
                    for j := 1 to Length(s) do
                        write(#8);
            end;

            Inc(i);

        until EOF(RES);

        CloseFile(RES);

        writeln;

    end;

    OutFile := ModelPath+'\OpenSees\CorotTruss_deformations.out';

    if FileExists(OutFile) then
    begin
        write('Reading corotational truss deformations ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# CorotTruss')+1],3,10));  // number of corotational trusses

        StrToArray(TCL[TCL.IndexOf('# CorotTruss')+2],Tag,n,true);  // read all tags

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Elements//Corotational_Truss//Deformation" "'+Str_IntNames[i]+'" '+Str_Steps[i]+' Scalar OnGaussPoints "Line_Nodes"');
                MSH.Writeline('Unit "kN"');
                MSH.Writeline('Values');

                StrToArray(line,Str,n,true);  // read all values from current step (1 value per element)

                for j := 0 to n-1 do
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[j];

                    MSH.Writeline(s);

                    s := StringOfChar(' ',INDENT) + Str[j];

                    MSH.Writeline(s);
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                if not EOF(RES) then
                    for j := 1 to Length(s) do
                        write(#8);
            end;

            Inc(i);

        until EOF(RES);

        CloseFile(RES);

        writeln;

    end;

    //
    // Elastic beam-column element
    //

    OutFile := ModelPath+'\OpenSees\ElasticBeamColumn_localForce.out';

    if FileExists(OutFile) then
    begin
        write('Reading elastic beam-column forces ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# ElasticBeamColumn')+1],3,10));  // number of elastic beam-column elements

        StrToArray(TCL[TCL.IndexOf('# ElasticBeamColumn')+2],Tag,n,true);  // read all tags

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');

                if ndm = 2 then
                begin
                    MSH.Writeline('ResultGroup "'+Str_IntNames[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Elastic_Beam-Column//Actions//N" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Elastic_Beam-Column//Actions//V" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Elastic_Beam-Column//Actions//M" Scalar');
                    MSH.Writeline('Unit "kNm"');

                    StrToArray(line,Str,2*3*n,true);  // read all values from current step (3 values per gauss point)
                end;

                if ndm = 3 then
                begin
                    MSH.Writeline('ResultGroup "'+Str_IntNames[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Elastic_Beam-Column//Actions//N" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Elastic_Beam-Column//Actions//Vy" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Elastic_Beam-Column//Actions//Vz" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Elastic_Beam-Column//Actions//T" Scalar');
                    MSH.Writeline('Unit "kNm"');
                    MSH.Writeline('ResultDescription "Elements//Elastic_Beam-Column//Actions//My" Scalar');
                    MSH.Writeline('Unit "kNm"');
                    MSH.Writeline('ResultDescription "Elements//Elastic_Beam-Column//Actions//Mz" Scalar');
                    MSH.Writeline('Unit "kNm"');

                    StrToArray(line,Str,2*6*n,true);  // read all values from current step (6 values per gauss point)
                end;

                MSH.Writeline('Values');

                for j := 0 to n-1 do
                begin
                    if ndm = 2 then // end1                                     N                         V                     M
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Inv(Str[3*(2*j)]) + ' ' + Str[3*(2*j)+1] + ' '+ Str[3*(2*j)+2];

                        MSH.Writeline(s); // end2        N                      V                            M

                        s := StringOfChar(' ',INDENT) +  Str[3*(2*j+1)] + ' ' + Inv(Str[3*(2*j+1)+1]) + ' '+ Inv(Str[3*(2*j+1)+2]);

                        MSH.Writeline(s);
                    end;

                    if ndm = 3 then // end1                                     N                         Vy                     Vz                     T                      My                    Mz
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Inv(Str[6*(2*j)]) + ' ' + Str[6*(2*j)+1] + ' ' + Str[6*(2*j)+2] + ' ' + Str[6*(2*j)+3] + ' ' + Str[6*(2*j)+4] + ' '+ Str[6*(2*j)+5];

                        MSH.Writeline(s); // end2        N                      Vy                            Vz                            T                             My                           Mz

                        s := StringOfChar(' ',INDENT) +  Str[6*(2*j+1)] + ' ' + Inv(Str[6*(2*j+1)+1]) + ' ' + Inv(Str[6*(2*j+1)+2]) + ' ' + Inv(Str[6*(2*j+1)+3]) + ' ' + Inv(Str[6*(2*j+1)+4]) + ' '+ Inv(Str[6*(2*j+1)+5]);

                        MSH.Writeline(s);
                    end;
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                if not EOF(RES) then
                    for j := 1 to Length(s) do
                        write(#8);
            end;

            Inc(i);

        until EOF(RES);

        CloseFile(RES);

        writeln;

    end;

    //
    // Elastic Timoshenko beam-column element
    //

    OutFile := ModelPath+'\OpenSees\ElasticTimoshenkoBeamColumn_localForce.out';

    if FileExists(OutFile) then
    begin
        write('Reading elastic Timoshenko beam-column forces ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# ElasticTimoshenkoBeamColumn')+1],3,10));  // number of elastic beam-column elements

        StrToArray(TCL[TCL.IndexOf('# ElasticTimoshenkoBeamColumn')+2],Tag,n,true);  // read all tags

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');

                if ndm = 2 then
                begin
                    MSH.Writeline('ResultGroup "'+Str_IntNames[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Elastic_Timoshenko_Beam-Column//Actions//N" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Elastic_Timoshenko_Beam-Column//Actions//V" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Elastic_Timoshenko_Beam-Column//Actions//M" Scalar');
                    MSH.Writeline('Unit "kNm"');

                    StrToArray(line,Str,2*3*n,true);  // read all values from current step (3 values per gauss point)
                end;

                if ndm = 3 then
                begin
                    MSH.Writeline('ResultGroup "'+Str_IntNames[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Elastic_Timoshenko_Beam-Column//Actions//N" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Elastic_Timoshenko_Beam-Column//Actions//Vy" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Elastic_Timoshenko_Beam-Column//Actions//Vz" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Elastic_Timoshenko_Beam-Column//Actions//T" Scalar');
                    MSH.Writeline('Unit "kNm"');
                    MSH.Writeline('ResultDescription "Elements//Elastic_Timoshenko_Beam-Column//Actions//My" Scalar');
                    MSH.Writeline('Unit "kNm"');
                    MSH.Writeline('ResultDescription "Elements//Elastic_Timoshenko_Beam-Column//Actions//Mz" Scalar');
                    MSH.Writeline('Unit "kNm"');

                    StrToArray(line,Str,2*6*n,true);  // read all values from current step (6 values per gauss point)
                end;

                MSH.Writeline('Values');

                for j := 0 to n-1 do
                begin
                    if ndm = 2 then // end1                                     N                         V                     M
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Inv(Str[3*(2*j)]) + ' ' + Str[3*(2*j)+1] + ' '+ Str[3*(2*j)+2];

                        MSH.Writeline(s); // end2        N                      V                            M

                        s := StringOfChar(' ',INDENT) +  Str[3*(2*j+1)] + ' ' + Inv(Str[3*(2*j+1)+1]) + ' '+ Inv(Str[3*(2*j+1)+2]);

                        MSH.Writeline(s);
                    end;

                    if ndm = 3 then // end1                                     N                         Vy                     Vz                     T                      My                    Mz
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Inv(Str[6*(2*j)]) + ' ' + Str[6*(2*j)+1] + ' ' + Str[6*(2*j)+2] + ' ' + Str[6*(2*j)+3] + ' ' + Str[6*(2*j)+4] + ' '+ Str[6*(2*j)+5];

                        MSH.Writeline(s); // end2        N                      Vy                            Vz                            T                             My                           Mz

                        s := StringOfChar(' ',INDENT) +  Str[6*(2*j+1)] + ' ' + Inv(Str[6*(2*j+1)+1]) + ' ' + Inv(Str[6*(2*j+1)+2]) + ' ' + Inv(Str[6*(2*j+1)+3]) + ' ' + Inv(Str[6*(2*j+1)+4]) + ' '+ Inv(Str[6*(2*j+1)+5]);

                        MSH.Writeline(s);
                    end;
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                if not EOF(RES) then
                    for j := 1 to Length(s) do
                        write(#8);
            end;

            Inc(i);

        until EOF(RES);

        CloseFile(RES);

        writeln;

    end;

    //
    // Force-based beam-column element
    //

    // force

    OutFile := ModelPath+'\OpenSees\ForceBeamColumn_localForce.out';

    if FileExists(OutFile) then
    begin
        write('Reading force beam-column forces ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# ForceBeamColumn')+1],3,10));  // number of elastic beam-column elements

        StrToArray(TCL[TCL.IndexOf('# ForceBeamColumn')+2],Tag,n,true);  // read all tags

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');

                if ndm = 2 then
                begin
                    MSH.Writeline('ResultGroup "'+Str_IntNames[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Actions//N" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Actions//V" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Actions//M" Scalar');
                    MSH.Writeline('Unit "kNm"');

                    StrToArray(line,Str,2*3*n,true);  // read all values from current step (3 values per gauss point)
                end;

                if ndm = 3 then
                begin
                    MSH.Writeline('ResultGroup "'+Str_IntNames[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Actions//N" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Actions//Vy" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Actions//Vz" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Actions//T" Scalar');
                    MSH.Writeline('Unit "kNm"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Actions//My" Scalar');
                    MSH.Writeline('Unit "kNm"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Actions//Mz" Scalar');
                    MSH.Writeline('Unit "kNm"');

                    StrToArray(line,Str,2*6*n,true);  // read all values from current step (6 values per gauss point)
                end;

                MSH.Writeline('Values');

                for j := 0 to n-1 do
                begin
                    if ndm = 2 then // end1                                     N                         V                     M
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Inv(Str[3*(2*j)]) + ' ' + Str[3*(2*j)+1] + ' '+ Str[3*(2*j)+2];

                        MSH.Writeline(s); // end2        N                      V                            M

                        s := StringOfChar(' ',INDENT) +  Str[3*(2*j+1)] + ' ' + Inv(Str[3*(2*j+1)+1]) + ' '+ Inv(Str[3*(2*j+1)+2]);

                        MSH.Writeline(s);
                    end;

                    if ndm = 3 then // end1                                     N                         Vy                     Vz                     T                      My                    Mz
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Inv(Str[6*(2*j)]) + ' ' + Str[6*(2*j)+1] + ' ' + Str[6*(2*j)+2] + ' ' + Str[6*(2*j)+3] + ' ' + Str[6*(2*j)+4] + ' '+ Str[6*(2*j)+5];

                        MSH.Writeline(s); // end2        Í                      Vy                            Vz                            T                             My                           Mz

                        s := StringOfChar(' ',INDENT) +  Str[6*(2*j+1)] + ' ' + Inv(Str[6*(2*j+1)+1]) + ' ' + Inv(Str[6*(2*j+1)+2]) + ' ' + Inv(Str[6*(2*j+1)+3]) + ' ' + Inv(Str[6*(2*j+1)+4]) + ' '+ Inv(Str[6*(2*j+1)+5]);

                        MSH.Writeline(s);
                    end;
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                if not EOF(RES) then
                    for j := 1 to Length(s) do
                        write(#8);
            end;

            Inc(i);

        until EOF(RES);

        CloseFile(RES);

        writeln;

    end;

    // total deformation

    OutFile := ModelPath+'\OpenSees\ForceBeamColumn_basicDeformation.out';

    if FileExists(OutFile) then
    begin
        write('Reading force beam-column total deformations ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# ForceBeamColumn')+1],3,10));  // number of elastic beam-column elements

        StrToArray(TCL[TCL.IndexOf('# ForceBeamColumn')+2],Tag,n,true);  // read all tags

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');

                if ndm = 2 then
                begin
                    MSH.Writeline('ResultGroup "'+Str_IntNames[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Deformations_Total//Axial" Scalar');
                    MSH.Writeline('Unit "m"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Deformations_Total//Rotation" Scalar');
                    MSH.Writeline('Unit "rad"');

                    StrToArray(line,Str,3*n,true);  // read all values from current step (3 values per gauss point)
                end;

                if ndm = 3 then
                begin
                    MSH.Writeline('ResultGroup "'+Str_IntNames[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Deformations_Total//Axial" Scalar');
                    MSH.Writeline('Unit "m"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Deformations_Total//Rotation_z" Scalar');
                    MSH.Writeline('Unit "rad"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Deformations_Total//Rotation_y" Scalar');
                    MSH.Writeline('Unit "rad"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Deformations_Total//Torsional" Scalar');
                    MSH.Writeline('Unit "rad"');

                    StrToArray(line,Str,6*n,true);  // read all values from current step (6 values per element)
                end;

                MSH.Writeline('Values');

                for j := 0 to n-1 do
                begin
                    if ndm = 2 then // end1                                     Axial            Rotation
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[3*j] + ' ' + Str[3*j+1];

                        MSH.Writeline(s); // end2       Axial            Rotation

                        s := StringOfChar(' ',INDENT) + Str[3*j] + ' ' + Inv(Str[3*j+2]);

                        MSH.Writeline(s);
                    end;

                    if ndm = 3 then // end1                                     Axial            Rotation z              Rotation y              Torsional
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[6*j] + ' ' + Inv(Str[6*j+1]) + ' ' + Inv(Str[6*j+3]) + ' ' + Str[6*j+5];

                        MSH.Writeline(s); // end2        Axial            Rotation z         Rotation y         Torsional

                        s := StringOfChar(' ',INDENT) +  Str[6*j] + ' ' + Str[6*j+2] + ' ' + Str[6*j+4] + ' ' + Str[6*j+5];

                        MSH.Writeline(s);
                    end;
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                if not EOF(RES) then
                    for j := 1 to Length(s) do
                        write(#8);
            end;

            Inc(i);

        until EOF(RES);

        CloseFile(RES);

        writeln;

    end;

    // plastic deformation

    OutFile := ModelPath+'\OpenSees\ForceBeamColumn_plasticDeformation.out';

    if FileExists(OutFile) then
    begin
        write('Reading force beam-column plastic deformations ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# ForceBeamColumn')+1],3,10));  // number of elastic beam-column elements

        StrToArray(TCL[TCL.IndexOf('# ForceBeamColumn')+2],Tag,n,true);  // read all tags

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');

                if ndm = 2 then
                begin
                    MSH.Writeline('ResultGroup "'+Str_IntNames[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Deformations_Plastic//Axial" Scalar');
                    MSH.Writeline('Unit "m"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Deformations_Plastic//Rotation" Scalar');
                    MSH.Writeline('Unit "rad"');

                    StrToArray(line,Str,3*n,true);  // read all values from current step (3 values per gauss point)
                end;

                if ndm = 3 then
                begin
                    MSH.Writeline('ResultGroup "'+Str_IntNames[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Deformations_Plastic//Axial" Scalar');
                    MSH.Writeline('Unit "m"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Deformations_Plastic//Rotation_z" Scalar');
                    MSH.Writeline('Unit "rad"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Deformations_Plastic//Rotation_y" Scalar');
                    MSH.Writeline('Unit "rad"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Deformations_Plastic//Torsional" Scalar');
                    MSH.Writeline('Unit "rad"');

                    StrToArray(line,Str,6*n,true);  // read all values from current step (6 values per element)
                end;

                MSH.Writeline('Values');

                for j := 0 to n-1 do
                begin
                    if ndm = 2 then // end 1                                    Axial            Rotation
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[3*j] + ' ' + Str[3*j+1];

                        MSH.Writeline(s); // end 2      Axial            Rotation

                        s := StringOfChar(' ',INDENT) + Str[3*j] + ' ' + Inv(Str[3*j+2]);

                        MSH.Writeline(s);
                    end;

                    if ndm = 3 then // end1                                     Axial            Rotation z              Rotation y              Torsional
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[6*j] + ' ' + Inv(Str[6*j+1]) + ' ' + Inv(Str[6*j+3]) + ' ' + Str[6*j+5];

                        MSH.Writeline(s); // end2        Axial            Rotation z         Rotation y         Torsional

                        s := StringOfChar(' ',INDENT) +  Str[6*j] + ' ' + Str[6*j+2] + ' ' + Str[6*j+4] + ' ' + Str[6*j+5];

                        MSH.Writeline(s);
                    end;
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                if not EOF(RES) then
                    for j := 1 to Length(s) do
                        write(#8);
            end;

            Inc(i);

        until EOF(RES);

        CloseFile(RES);

        writeln;

    end;

    //
    // Displacement-based beam-column element
    //

    // force

    OutFile := ModelPath+'\OpenSees\DispBeamColumn_localForce.out';

    if FileExists(OutFile) then
    begin
        write('Reading displacement beam-column forces ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# DispBeamColumn')+1],3,10));  // number of elastic beam-column elements

        StrToArray(TCL[TCL.IndexOf('# DispBeamColumn')+2],Tag,n,true);  // read all tags

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');

                if ndm = 2 then
                begin
                    MSH.Writeline('ResultGroup "'+Str_IntNames[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Actions//N" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Actions//V" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Actions//M" Scalar');
                    MSH.Writeline('Unit "kNm"');

                    StrToArray(line,Str,2*3*n,true);  // read all values from current step (3 values per gauss point)
                end;

                if ndm = 3 then
                begin
                    MSH.Writeline('ResultGroup "'+Str_IntNames[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Actions//N" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Actions//Vy" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Actions//Vz" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Actions//T" Scalar');
                    MSH.Writeline('Unit "kNm"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Actions//My" Scalar');
                    MSH.Writeline('Unit "kNm"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Actions//Mz" Scalar');
                    MSH.Writeline('Unit "kNm"');

                    StrToArray(line,Str,2*6*n,true);  // read all values from current step (6 values per gauss point)
                end;

                MSH.Writeline('Values');

                for j := 0 to n-1 do
                begin
                    if ndm = 2 then // end1                                     N                         V                     M
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Inv(Str[3*(2*j)]) + ' ' + Str[3*(2*j)+1] + ' '+ Str[3*(2*j)+2];

                        MSH.Writeline(s); // end2        N                      V                            M

                        s := StringOfChar(' ',INDENT) +  Str[3*(2*j+1)] + ' ' + Inv(Str[3*(2*j+1)+1]) + ' '+ Inv(Str[3*(2*j+1)+2]);

                        MSH.Writeline(s);
                    end;

                    if ndm = 3 then // end1                                     N                         Vy                     Vz                     T                      My                    Mz
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Inv(Str[6*(2*j)]) + ' ' + Str[6*(2*j)+1] + ' ' + Str[6*(2*j)+2] + ' ' + Str[6*(2*j)+3] + ' ' + Str[6*(2*j)+4] + ' '+ Str[6*(2*j)+5];

                        MSH.Writeline(s); // end2        Í                      Vy                            Vz                            T                             My                           Mz

                        s := StringOfChar(' ',INDENT) +  Str[6*(2*j+1)] + ' ' + Inv(Str[6*(2*j+1)+1]) + ' ' + Inv(Str[6*(2*j+1)+2]) + ' ' + Inv(Str[6*(2*j+1)+3]) + ' ' + Inv(Str[6*(2*j+1)+4]) + ' '+ Inv(Str[6*(2*j+1)+5]);

                        MSH.Writeline(s);
                    end;
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                if not EOF(RES) then
                    for j := 1 to Length(s) do
                        write(#8);
            end;

            Inc(i);

        until EOF(RES);

        CloseFile(RES);

        writeln;

    end;

    // total deformation

    OutFile := ModelPath+'\OpenSees\DispBeamColumn_basicDeformation.out';

    if FileExists(OutFile) then
    begin
        write('Reading displacement beam-column total deformations ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# DispBeamColumn')+1],3,10));  // number of elastic beam-column elements

        StrToArray(TCL[TCL.IndexOf('# DIspBeamColumn')+2],Tag,n,true);  // read all tags

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');

                if ndm = 2 then
                begin
                    MSH.Writeline('ResultGroup "'+Str_IntNames[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Deformations_Total//Axial" Scalar');
                    MSH.Writeline('Unit "m"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Deformations_Total//Rotation" Scalar');
                    MSH.Writeline('Unit "rad"');

                    StrToArray(line,Str,3*n,true);  // read all values from current step (3 values per gauss point)
                end;

                if ndm = 3 then
                begin
                    MSH.Writeline('ResultGroup "'+Str_IntNames[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Deformations_Total//Axial" Scalar');
                    MSH.Writeline('Unit "m"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Deformations_Total//Rotation_z" Scalar');
                    MSH.Writeline('Unit "rad"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Deformations_Total//Rotation_y" Scalar');
                    MSH.Writeline('Unit "rad"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Deformations_Total//Torsional" Scalar');
                    MSH.Writeline('Unit "rad"');

                    StrToArray(line,Str,6*n,true);  // read all values from current step (6 values per gauss point)
                end;

                MSH.Writeline('Values');

                for j := 0 to n-1 do
                begin
                    if ndm = 2 then // end1                                     Axial            Rotation
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[3*j] + ' ' + Str[3*j+1];

                        MSH.Writeline(s); // end2       Axial            Rotation

                        s := StringOfChar(' ',INDENT) + Str[3*j] + ' ' + Inv(Str[3*j+2]);

                        MSH.Writeline(s);
                    end;

                    if ndm = 3 then // end1                                     Axial            Rotation z              Rotation y              Torsional
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[6*j] + ' ' + Inv(Str[6*j+1]) + ' ' + Inv(Str[6*j+3]) + ' ' + Str[6*j+5];

                        MSH.Writeline(s); // end2        Axial            Rotation z         Rotation y         Torsional

                        s := StringOfChar(' ',INDENT) +  Str[6*j] + ' ' + Str[6*j+2] + ' ' + Str[6*j+4] + ' ' + Str[6*j+5];

                        MSH.Writeline(s);
                    end;
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                if not EOF(RES) then
                    for j := 1 to Length(s) do
                        write(#8);
            end;

            Inc(i);

        until EOF(RES);

        CloseFile(RES);

        writeln;

    end;

    // plastic deformation

    OutFile := ModelPath+'\OpenSees\DispBeamColumn_plasticDeformation.out';

    if FileExists(OutFile) then
    begin
        write('Reading displacement beam-column plastic deformations ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# DispBeamColumn')+1],3,10));  // number of elastic beam-column elements

        StrToArray(TCL[TCL.IndexOf('# DispBeamColumn')+2],Tag,n,true);  // read all tags

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');

                if ndm = 2 then
                begin
                    MSH.Writeline('ResultGroup "'+Str_IntNames[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Deformations_Plastic//Axial" Scalar');
                    MSH.Writeline('Unit "m"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Deformations_Plastic//Rotation" Scalar');
                    MSH.Writeline('Unit "rad"');

                    StrToArray(line,Str,3*n,true);  // read all values from current step (3 values per gauss point)
                end;

                if ndm = 3 then
                begin
                    MSH.Writeline('ResultGroup "'+Str_IntNames[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Deformations_Plastic//Axial" Scalar');
                    MSH.Writeline('Unit "m"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Deformations_Plastic//Rotation_z" Scalar');
                    MSH.Writeline('Unit "rad"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Deformations_Plastic//Rotation_y" Scalar');
                    MSH.Writeline('Unit "rad"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Deformations_Plastic//Torsional" Scalar');
                    MSH.Writeline('Unit "rad"');

                    StrToArray(line,Str,6*n,true);  // read all values from current step (6 values per gauss point)
                end;

                MSH.Writeline('Values');

                for j := 0 to n-1 do
                begin
                    if ndm = 2 then // end 1                                    Axial            Rotation
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[3*j] + ' ' + Str[3*j+1];

                        MSH.Writeline(s); // end 2      Axial            Rotation

                        s := StringOfChar(' ',INDENT) + Str[3*j] + ' ' + Inv(Str[3*j+2]);

                        MSH.Writeline(s);
                    end;

                    if ndm = 3
                     then // end1                                               Axial            Rotation z              Rotation y              Torsional
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[6*j] + ' ' + Inv(Str[6*j+1]) + ' ' + Inv(Str[6*j+3]) + ' ' + Str[6*j+5];

                        MSH.Writeline(s); // end2        Axial            Rotation z         Rotation y         Torsional

                        s := StringOfChar(' ',INDENT) +  Str[6*j] + ' ' + Str[6*j+2] + ' ' + Str[6*j+4] + ' ' + Str[6*j+5];

                        MSH.Writeline(s);
                    end;
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                if not EOF(RES) then
                    for j := 1 to Length(s) do
                        write(#8);
            end;

            Inc(i);

        until EOF(RES);

        CloseFile(RES);

        writeln;

    end;

    //
    // Flexure-shear interaction displacement-based beam-column element
    //

    // force

    OutFile := ModelPath+'\OpenSees\DispBeamColumnInt_localForce.out';

    if FileExists(OutFile) then
    begin
        write('Reading flexure-shear interaction displacement beam-column forces ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# DispBeamColumnInt')+1],3,10));  // number of elastic beam-column elements

        StrToArray(TCL[TCL.IndexOf('# DispBeamColumnInt')+2],Tag,n,true);  // read all tags

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');

                if ndm = 2 then
                begin
                    MSH.Writeline('ResultGroup "'+Str_IntNames[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Flexure_Shear_Interaction_Displacement_Beam-Column//Actions//N" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Flexure_Shear_Interaction_Displacement_Beam-Column//Actions//V" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Flexure_Shear_Interaction_Displacement_Beam-Column//Actions//M" Scalar');
                    MSH.Writeline('Unit "kNm"');

                    StrToArray(line,Str,2*3*n,true);  // read all values from current step (3 values per gauss point)
                end;

                MSH.Writeline('Values');

                for j := 0 to n-1 do
                begin
                    if ndm = 2 then // end1                                     N                    V                     M
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[3*(2*j)] + ' ' + Str[3*(2*j)+1] + ' '+ Str[3*(2*j)+2];

                        MSH.Writeline(s); // end2        N                      V                       M

                        s := StringOfChar(' ',INDENT) +  Str[3*(2*j+1)] + ' ' + Str[3*(2*j+1)+1] + ' '+ Inv(Str[3*(2*j+1)+2]);

                        MSH.Writeline(s);
                    end;
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                if not EOF(RES) then
                    for j := 1 to Length(s) do
                        write(#8);
            end;

            Inc(i);

        until EOF(RES);

        CloseFile(RES);

        writeln;

    end;

    //
    //
    // S O L I D   E L E M E N T S
    //
    //

    //
    // stdBrick
    //

    WriteResults(false,
                 false,'Reading stdBrick forces ',
                       'stdBrick_force','stdBrick','Forces',
                       'Fx','Fy','Fz','','','','kN',8,3,false,0,1,2,-1,-1,-1);

    WriteResults(true,
                 false,'Reading stdBrick stresses ',
                       'stdBrick_stress','stdBrick','Stresses',
                       's11','s22','s33','s12','s23','s13','kPa',8,6,false,0,1,2,3,4,5);

    WriteResults(true,
                 false,'Reading stdBrick strains ',
                       'stdBrick_strain','stdBrick','Strains',
                       'e11','e22','e33','e12','e23','e13','-',8,6,false,0,1,2,3,4,5);


    //
    //
    // P L A N E   E L E M E N T S
    //
    //

    //
    // Tri31
    //

    WriteResults(false,
                 false,'Reading Tri31 forces ',
                       'Tri31_force','Tri31','Forces',
                       'Fx','Fy','N/A','','','','kN',4,2,false,0,1,-1,-1,-1,-1);

    WriteResults(true,
                 false,'Reading Tri31 stresses ',
                       'Tri31_stress','Tri31','Stresses',
                       's11','s22','s12','','','','kPa',4,3,false,0,1,2,-1,-1,-1);

    WriteResults(true,
                 false,'Reading Tri31 strains ',
                       'Tri31_strain','Tri31','Strains',
                       'e11','e22','e12','','','','-',4,3,false,0,1,2,-1,-1,-1);

    WriteResults(false,
                  true,'Reading Tri31 principal stresses ',
                       'Tri31_stress','Tri31','Stresses-Principal',
                       's1','s2','angle','','','','kPa',4,3,false,0,1,2,-1,-1,-1);

    WriteResults(false,
                  true,'Reading Tri31 principal strains ',
                       'Tri31_strain','Tri31','Strains-Principal',
                       'e1','e2','angle','','','','-',4,3,false,0,1,2,-1,-1,-1);

    //
    // Quad
    //

    WriteResults(false,
                 false,'Reading Quad forces ',
                       'Quad_force','Quad','Forces',
                       'Fx','Fy','N/A','','','','kN',4,2,false,0,1,-1,-1,-1,-1);

    WriteResults(true,
                 false, 'Reading Quad stresses ',
                       'Quad_stress','Quad','Stresses',
                       's11','s22','s12','','','','kPa',4,3,false,0,1,2,-1,-1,-1);

    WriteResults(true,
                 false,'Reading Quad strains ',
                       'Quad_strain','Quad','Strains',
                       'e11','e22','e12','','','','-',4,3,false,0,1,2,-1,-1,-1);

    WriteResults(false,
                  true,'Reading Quad principal stresses ',
                       'Quad_stress','Quad','Stresses-Principal',
                       's1','s2','angle','','','','kPa',4,3,false,0,1,2,-1,-1,-1);

    WriteResults(false,
                  true,'Reading Quad principal strains ',
                       'Quad_strain','Quad','Strains-Principal',
                       'e1','e2','angle','','','','-',4,3,false,0,1,2,-1,-1,-1);

    //
    // shellMITC4
    //

    WriteResults(false,
                 false,'Reading ShellMITC4 forces ',
                       'ShellMITC4_force','ShellMITC4','Forces',
                       'Fx','Fy','N/A','','','','kN',4,6,false,0,1,2,-1,-1,-1);

    WriteResults(false,
                 false,'Reading ShellMITC4 moments ',
                       'ShellMITC4_force','ShellMITC4','Moments',
                       'Mx','My','N/A','','','','kNm',4,6,false,3,4,5,-1,-1,-1);

    WriteResults(false,
                 false,'Reading ShellMITC4 stresses (membrane) ',
                       'ShellMITC4_stress','ShellMITC4','Stresses-Membrane',
                       's11','s22','s12','','','','kPa',4,8,false,0,1,2,-1,-1,-1);

    WriteResults(false,
                 false,'Reading ShellMITC4 stresses (bending) ',
                       'ShellMITC4_stress','ShellMITC4','Stresses-Bending',
                       'm11','m22','m12','','','','kPa',4,8,false,3,4,5,-1,-1,-1);

    WriteResults(false,
                 false,'Reading ShellMITC4 stresses (shear) ',
                       'ShellMITC4_stress','ShellMITC4','Stresses-Shear',
                       't1','t2','N/A','','','','kPa',4,8,false,6,7,-1,-1,-1,-1);

    WriteResults(false,
                 false,'Reading ShellMITC4 strains (membrane) ',
                       'ShellMITC4_strain','ShellMITC4','Strains-Membrane',
                       'e11','e22','e12','','','','-',4,8,false,0,1,2,-1,-1,-1);

    WriteResults(false,
                 false,'Reading ShellMITC4 strains (bending) ',
                       'ShellMITC4_strain','ShellMITC4','Strains-Bending',
                       'k11','k22','k12','','','','-',4,8,false,3,4,5,-1,-1,-1);

    WriteResults(false,
                 false,'Reading ShellMITC4 strains (shear) ',
                       'ShellMITC4_strain','ShellMITC4','Strains-Shear',
                       'g1','g2','N/A','','','','-',4,8,false,6,7,-1,-1,-1,-1);

    WriteResults(false,
                  true,'Reading ShellMITC4 principal stresses (membrane) ',
                       'ShellMITC4_stress','ShellMITC4','Stresses-Membrane-Principal',
                       's1','s2','angle','','','','kPa',4,8,false,0,1,2,-1,-1,-1);

    WriteResults(false,
                  true,'Reading ShellMITC4 principal strains (membrane) ',
                       'ShellMITC4_strain','ShellMITC4','Strains-Membrane-Principal',
                       'e1','e2','angle','','','','-',4,8,false,0,1,2,-1,-1,-1);


    //
    // shellDKGQ
    //

    WriteResults(false,
                 false,'Reading ShellDKGQ forces ',
                       'ShellDKGQ_force','ShellDKGQ','Forces',
                       'Fx','Fy','N/A','','','','kN',4,6,false,0,1,2,-1,-1,-1);

    WriteResults(false,
                 false,'Reading ShellDKGQ moments ',
                       'ShellDKGQ_force','ShellDKGQ','Moments',
                       'Mx','My','N/A','','','','kNm',4,6,false,3,4,5,-1,-1,-1);

    WriteResults(false,
                 false,'Reading ShellDKGQ stresses (membrane) ',
                       'ShellDKGQ_stress','ShellDKGQ','Stresses-Membrane',
                       's11','s22','s12','','','','kPa',4,8,false,0,1,2,-1,-1,-1);

    WriteResults(false,
                 false,'Reading ShellDKGQ stresses (bending) ',
                       'ShellDKGQ_stress','ShellDKGQ','Stresses-Bending',
                       'm11','m22','m12','','','','kPa',4,8,false,3,4,5,-1,-1,-1);

    WriteResults(false,
                 false,'Reading ShellDKGQ stresses (shear) ',
                       'ShellDKGQ_stress','ShellDKGQ','Stresses-Shear',
                       't1','t2','N/A','','','','kPa',4,8,false,6,7,-1,-1,-1,-1);

    WriteResults(false,
                 false,'Reading ShellDKGQ strains (membrane) ',
                       'ShellDKGQ_strain','ShellDKGQ','Strains-Membrane',
                       'e11','e22','e12','','','','-',4,8,false,0,1,2,-1,-1,-1);

    WriteResults(false,
                 false,'Reading ShellDKGQ strains (bending) ',
                       'ShellDKGQ_strain','ShellDKGQ','Strains-Bending',
                       'k11','k22','k12','','','','-',4,8,false,3,4,5,-1,-1,-1);

    WriteResults(false,
                 false,'Reading ShellDKGQ strains (shear) ',
                       'ShellDKGQ_strain','ShellDKGQ','Strains-Shear',
                       'g1','g2','N/A','','','','-',4,8,false,6,7,-1,-1,-1,-1);

    WriteResults(false,
                  true,'Reading ShellDKGQ principal stresses (membrane) ',
                       'ShellDKGQ_stress','ShellDKGQ','Stresses-Membrane-Principal',
                       's1','s2','angle','','','','kPa',4,8,false,0,1,2,-1,-1,-1);

    WriteResults(false,
                  true,'Reading ShellDKGQ principal strains (membrane) ',
                       'ShellDKGQ_strain','ShellDKGQ','Strains-Membrane-Principal',
                       'e1','e2','angle','','','','-',4,8,false,0,1,2,-1,-1,-1);

    //
    // shellMITC4 per layer
    //

    for i := 1 to 20 do  // dirty way but 20 layers are enough
    begin

        WriteResults(false,
                     false,'Reading ShellMITC4 stresses (membrane) for layer '+IntToStr(i)+' ',
                           'ShellMITC4_stress_Layer'+IntToStr(i),'ShellMITC4','Stresses-Membrane (L'+IntToStr(i)+')',
                           's11','s22','s12','','','','kPa',4,5,true,0,1,2,-1,-1,-1);

        WriteResults(false,
                     false,'Reading ShellMITC4 stresses (shear) for layer '+IntToStr(i)+' ',
                           'ShellMITC4_stress_Layer'+IntToStr(i),'ShellMITC4','Stresses-Shear (L'+IntToStr(i)+')',
                           't1','t2','N/A','','','','kPa',4,5,true,3,4,-1,-1,-1,-1);

        WriteResults(false,
                     false,'Reading ShellMITC4 strains (membrane) for layer '+IntToStr(i)+' ',
                           'ShellMITC4_strain_Layer'+IntToStr(i),'ShellMITC4','Strains-Membrane (L'+IntToStr(i)+')',
                           'e11','e22','e12','','','','-',4,5,true,0,1,2,-1,-1,-1);

        WriteResults(false,
                     false,'Reading ShellMITC4 strains (shear) for layer '+IntToStr(i)+' ',
                           'ShellMITC4_strain_Layer'+IntToStr(i),'ShellMITC4','Strains-Shear (L'+IntToStr(i)+')',
                           'g1','g2','N/A','','','','-',4,5,true,3,4,-1,-1,-1,-1);

        WriteResults(false,
                      true,'Reading ShellMITC4 principal stresses (membrane) for layer '+IntToStr(i)+' ',
                           'ShellMITC4_stress_Layer'+IntToStr(i),'ShellMITC4','Stresses-Membrane-Principal (L'+IntToStr(i)+')',
                           's1','s2','angle','','','','kPa',4,5,true,0,1,2,-1,-1,-1);

        WriteResults(false,
                      true,'Reading ShellMITC4 principal strains (membrane) for layer '+IntToStr(i)+' ',
                           'ShellMITC4_strain_Layer'+IntToStr(i),'ShellMITC4','Strains-Membrane-Principal (L'+IntToStr(i)+')',
                           'e1','e2','angle','','','','-',4,5,true,0,1,2,-1,-1,-1);

        WriteCracks(       'Reading ShellMITC4 cracks for layer '+IntToStr(i)+' ',
                           'ShellMITC4_crack_Layer'+IntToStr(i),'ShellMITC4','Cracks (L'+IntToStr(i)+')');
    end;

    //
    // shellDKGQ per layer
    //

    for i := 1 to 20 do  // dirty way but 20 layers are enough
    begin

        WriteResults(false,
                     false,'Reading ShellDKGQ stresses (membrane) for layer '+IntToStr(i)+' ',
                           'ShellDKGQ_stress_Layer'+IntToStr(i),'ShellDKGQ','Stresses-Membrane (L'+IntToStr(i)+')',
                           's11','s22','s12','','','','kPa',4,5,true,0,1,2,-1,-1,-1);

        WriteResults(false,
                     false,'Reading ShellDKGQ stresses (shear) for layer '+IntToStr(i)+' ',
                           'ShellDKGQ_stress_Layer'+IntToStr(i),'ShellDKGQ','Stresses-Shear (L'+IntToStr(i)+')',
                           't1','t2','N/A','','','','kPa',4,5,true,3,4,-1,-1,-1,-1);

        WriteResults(false,
                     false,'Reading ShellDKGQ strains (membrane) for layer '+IntToStr(i)+' ',
                           'ShellDKGQ_strain_Layer'+IntToStr(i),'ShellDKGQ','Strains-Membrane (L'+IntToStr(i)+')',
                           'e11','e22','e12','','','','-',4,5,true,0,1,2,-1,-1,-1);

        WriteResults(false,
                     false,'Reading ShellDKGQ strains (shear) for layer '+IntToStr(i)+' ',
                           'ShellDKGQ_strain_Layer'+IntToStr(i),'ShellDKGQ','Strains-Shear (L'+IntToStr(i)+')',
                           'g1','g2','N/A','','','','-',4,5,true,3,4,-1,-1,-1,-1);

        WriteResults(false,
                      true,'Reading ShellDKGQ principal stresses (membrane) for layer '+IntToStr(i)+' ',
                           'ShellDKGQ_stress_Layer'+IntToStr(i),'ShellDKGQ','Stresses-Membrane-Principal (L'+IntToStr(i)+')',
                           's1','s2','angle','','','','kPa',4,5,true,0,1,2,-1,-1,-1);

        WriteResults(false,
                      true,'Reading ShellDKGQ principal strains (membrane) for layer '+IntToStr(i)+' ',
                           'ShellDKGQ_strain_Layer'+IntToStr(i),'ShellDKGQ','Strains-Membrane-Principal (L'+IntToStr(i)+')',
                           'e1','e2','angle','','','','-',4,5,true,0,1,2,-1,-1,-1);

        WriteCracks(       'Reading ShellDKGQ cracks for layer '+IntToStr(i)+' ',
                           'ShellDKGQ_crack_Layer'+IntToStr(i),'ShellDKGQ','Cracks (L'+IntToStr(i)+')');
    end;

//
// ------------------------------------------------------------------------------------------------------------------------------------------------------------------
//

    FreeAndNil(TCL);

    MSH.Close;
    MSH.Free;

    writeln;

    if ParamStr(4) = '/b' then
    begin
        TextColor(LightGreen);

        write('Creating HDF5 binary results file...');

        // convert to binary

        ExecuteAndWait('"'+GiDPath+'\gid.exe" -PostResultsToBinary "'+ResFileASCII+'" "'+ResFileBin+'"');

        if FileExists(ResFileASCII) then
            DeleteFile(PWideChar(ResFileASCII));
    end
    else
    begin
        write('Text results file...');

        RenameFile(ResFileASCII,ResFileBin);  // ASCII just becomes post.res
    end;

    writeln(#8#8#8' : '+GetFileSize(ResFileBin));
    writeln;

    TextColor(LightCyan);
    writeln('Conversion completed');

    writeln;
    TextColor(Yellow);
    writeln('Press any key to close ...');
    readln;
end.
