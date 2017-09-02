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
    EPS          = 1e-2;

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
    ndm          : integer;
    s,line,
    GiDPath,
    ModelPath,
    FileName,
    ModelName,
    OutFile,
    ResFileASCII,
    ResFileBin   : string;
    Tag,
    Str          : ArrayStr;
    TCL,
    PER,
    LOC,
    LOG          : TStringList;
    MSH          : TStreamWriter;
    RES          : TextFile;
    Period       : string;
    Vx,Vy,
    Vz,Ang       : array[1..3] of double;
    senb         : double;
    Int_Type     : ArrayStr;
    Int_Steps    : array of integer;
    Str_Titles,
    Str_Steps    : array of string;
    Step         : integer;

    // console

    BufferInfo   : TConsoleScreenBufferInfo;
    LastMode     : word;
    TextAttr     : byte;
    StdOut,
    StdErr       : THandle;
    CCI          : TConsoleCursorInfo;

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
    i,j,
    p,cnt : integer;
    h     : string;

begin
    SetLength(arr,0);

    arr := nil;

    SetLength(arr,n);

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

            // fast clean very small numbers

            for j := 10 to 20 do
                if (Copy(h,Length(h)-4,4) = 'e-01') or (Copy(h,Length(h)-3,3) = 'E-1') or
                   (Copy(h,Length(h)-4,4) = 'e-02') or (Copy(h,Length(h)-3,3) = 'E-2') or
                   (Copy(h,Length(h)-4,4) = 'e-03') or (Copy(h,Length(h)-3,3) = 'E-3')then
                begin
                    h := '0';
                    Break;
                end;

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

function GetIntervalTitle(Step : integer) : string;
var
    i,Sum : integer;

begin
    Result := '';
    Sum := 0;

    for i := 0 to Length(Int_Type)-1 do
    begin
        if Step >= Sum then
            Result := 'Interval '+IntToStr(i+1)+' - '+Int_Type[i];

        Sum := Sum + Int_Steps[i]+1;
    end;
end;

function GetIntervalStep(Step : integer) : string;
var
    i,Sum : integer;

begin
    Result := '';
    Sum := 0;

    for i := 0 to Length(Int_Type)-1 do
    begin
        if Step >= Sum then
            Result := IntToStr(Step - Sum);

        Sum := Sum + Int_Steps[i]+1;
    end;
end;

//
// main program
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

    for i := 0 to LOG.Count-1 do
        if Pos('Analysis FAILED',LOG.Strings[i]) <> 0 then
        begin
            writeln('Analysis failed.');

            Sleep(1000);
            LOG.Free;
            Exit;
        end;

    i := 1;  // after analysis summary

    while LOG.Strings[i] <> '' do
    begin
        SetLength(Int_Type,Length(Int_Type)+1);
        SetLength(Int_Steps,Length(Int_Steps)+1);

        Int_Type[i-1] := Copy(LOG.Strings[i],Pos('-',LOG.Strings[i])+2,Pos(':',LOG.Strings[i])-Pos('-',LOG.Strings[i])-3);

        Int_Steps[i-1] := StrToInt(Copy(LOG.Strings[i],Pos(':',LOG.Strings[i])+8,100));

        Inc(i);
    end;

    LOG.Free;

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
        MSH.Writeline('GaussPoints "stdbrick_GP" ElemType Hexahedra');
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
        MSH.Writeline('GaussPoints "stdbrick_Node" ElemType Hexahedra');
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
       FileExists(ModelPath+'\OpenSees\CorotTruss_axialForce.out') or
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

    // buffer interval types and steps

    OutFile := ModelPath+'\OpenSees\Node_displacements.out';

    if FileExists(OutFile) then
    begin
        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        SetLength(Str_Titles,0);
        SetLength(Str_Steps,0);

        repeat

            Readln(RES,line);

            SetLength(Str_Titles,Length(Str_Titles)+1);
            SetLength(Str_Steps,Length(Str_Steps)+1);

            Str_Titles[i] := GetIntervalTitle(i);
            Str_Steps[i] := GetIntervalStep(i);

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

            Vx[1] := StrToFloat(Copy(TCL[i],47,6));
            Vx[2] := StrToFloat(Copy(TCL[i],54,6));
            Vx[3] := StrToFloat(Copy(TCL[i],61,6));
            Vy[1] := StrToFloat(Copy(TCL[i],74,6));
            Vy[2] := StrToFloat(Copy(TCL[i],81,6));
            Vy[3] := StrToFloat(Copy(TCL[i],88,6));
            Vz[1] := StrToFloat(Copy(TCL[i],101,6));
            Vz[2] := StrToFloat(Copy(TCL[i],108,6));
            Vz[3] := StrToFloat(Copy(TCL[i],115,6));

            if (Vz[3] < 1.0-EPS) and (Vz[3] > -1.0+EPS) then
            begin
                senb := Sqrt(1.0-Vz[3]*Vz[3]);

                Ang[2] := ArcCos(Vz[3]);
                Ang[3] := ArcCos(Vz[2]/senb);

                if Vz[1]/senb < 0 then
                    Ang[3] := 2*PI-Ang[3];

                Ang[1] := ArcCos(Vy[3]/senb);

                if Vx[3]/senb < 0 then
                    Ang[1] := 2*PI-Ang[1];
            end
            else
            begin
                Ang[2] := ArcCos(Vz[3]);
                Ang[1] := 0.0;
                Ang[3] := ArcCos(Vx[1]);

                if -Vx[2] < 0 then
                    Ang[3] := 2*PI-Ang[3];
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
                MSH.Writeline('Result "Local_Axes" "'+Str_Titles[i]+'" '+Str_Steps[i]+' LocalAxes OnGaussPoints "Line_Axes"');

                for j := 1 to LOC.Count-1 do
                    MSH.Writeline(LOC[j]);
            end;

            Inc(i);

        until EOF(RES);

        CloseFile(RES);

        Sleep(200);

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

            Sleep(200);
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

                if Pos('Static',GetIntervalTitle(i)) <> 0 then
                begin
                    MSH.Writeline('Result "Load Factor" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Scalar OnNodes');
                    MSH.Writeline('ComponentNames "LF"');
                    MSH.Writeline('Unit " "');
                end;

                if Pos('Transient',GetIntervalTitle(i)) <> 0 then
                begin
                    MSH.Writeline('Result "Time" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Scalar OnNodes');
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

        Sleep(200);
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
                MSH.Writeline('Result "Nodes//Displacements" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Vector OnNodes');

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

        Sleep(200);
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
                MSH.Writeline('Result "Nodes//Rotations" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Vector OnNodes');

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

        Sleep(200);
    end;

    // force reactions

    OutFile := ModelPath+'\OpenSees\Node_forceReactions.out';

    if FileExists(OutFile) then
    begin
        write('Reading force reactions ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Number of nodes')+1],3,10));  // number of nodes

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Nodes//Force reactions" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Vector OnNodes');

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

        Sleep(200);
    end;

    // moment reactions

    OutFile := ModelPath+'\OpenSees\Node_momentReactions.out';

    if FileExists(OutFile) then
    begin
        write('Reading moment reactions ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Number of nodes')+1],3,10));  // number of nodes

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Nodes//Moment reactions" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Vector OnNodes');

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

        Sleep(200);
    end;

    // relative accelerations

    OutFile := ModelPath+'\OpenSees\Node_relativeAccelerations.out';

    if FileExists(OutFile) then
    begin
        write('Reading relative accelerations ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Number of nodes')+1],3,10));  // number of nodes

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Nodes//Rel. Accelerations" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Vector OnNodes');

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

        Sleep(200);
    end;

    // relative velocities

    OutFile := ModelPath+'\OpenSees\Node_relativeVelocities.out';

    if FileExists(OutFile) then
    begin
        write('Reading relative velocities ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Number of nodes')+1],3,10));  // number of nodes

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Nodes//Rel. Velocities" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Vector OnNodes');

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

        Sleep(200);
    end;

    //
    //
    // E L E M E N T S
    //
    //

    //
    // stdBrick
    //

    // forces

    OutFile := ModelPath+'\OpenSees\stdBrick_force.out';

    if FileExists(OutFile) then
    begin
        write('Reading brick forces ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# stdBrick')+1],3,10));  // number of bricks

        StrToArray(TCL[TCL.IndexOf('# stdBrick')+2],Tag,n,true);  // read all tags

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Elements//stdBrick//Forces" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Vector OnGaussPoints "stdbrick_Node"');
                MSH.Writeline('ComponentNames "Fx" "Fy" "Fz"');
                MSH.Writeline('Unit "kN"');
                MSH.Writeline('Values');

                StrToArray(line,Str,8*3*n,true);  // read all values from current step (3 values per node)

                for j := 0 to n-1 do
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                    for k := 0 to 7 do  // 8 nodes
                    begin
                        s := s + Str[3*(8*j+k)] + ' ' + Str[3*(8*j+k)+1] + ' ' + Str[3*(8*j+k)+2];  // positions 0,1,2

                        MSH.Writeline(s);

                        s := StringOfChar(' ',INDENT);
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

        Sleep(200);
    end;

    // stresses

    OutFile := ModelPath+'\OpenSees\stdBrick_stress.out';

    if FileExists(OutFile) then
    begin
        write('Reading brick stresses ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# stdBrick')+1],3,10));  // number of bricks

        StrToArray(TCL[TCL.IndexOf('# stdBrick')+2],Tag,n,true);  // read all tags

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Elements//stdBrick//Stresses" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Matrix OnGaussPoints "stdbrick_GP"');
                MSH.Writeline('ComponentNames "s11" "s22" "s33" "s12" "s23" "s13"');
                MSH.Writeline('Unit "kPa"');
                MSH.Writeline('Values');

                StrToArray(line,Str,8*6*n,true);  // read all values from current step (6 values per gauss point)

                for j := 0 to n-1 do
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                    for k := 0 to 7 do  // 8 gauss points
                    begin
                        s := s + Str[6*(8*j+k)] + ' ' + Str[6*(8*j+k)+1] + ' ' + Str[6*(8*j+k)+2] + ' ' + Str[6*(8*j+k)+3] + ' ' + Str[6*(8*j+k)+4] + ' ' + Str[6*(8*j+k)+5];  // positions 0,1,2,3,4,5

                        MSH.Writeline(s);

                        s := StringOfChar(' ',INDENT);
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

        Sleep(200);
    end;

    // strains

    OutFile := ModelPath+'\OpenSees\stdBrick_strain.out';

    if FileExists(OutFile) then
    begin
        write('Reading brick strains ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# stdBrick')+1],3,10));  // number of bricks

        StrToArray(TCL[TCL.IndexOf('# stdBrick')+2],Tag,n,true);  // read all tags

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Elements//stdBrick//Strains" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Matrix OnGaussPoints "stdbrick_GP"');
                MSH.Writeline('ComponentNames "e11" "e22" "e33" "e12" "e23" "e13"');
                MSH.Writeline('Unit "m-1"');
                MSH.Writeline('Values');

                StrToArray(line,Str,8*6*n,true);  // read all values from current step (6 values per gauss point)

                for j := 0 to n-1 do
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                    for k := 0 to 7 do  // 8 gauss points
                    begin
                        s := s + Str[6*(8*j+k)] + ' ' + Str[6*(8*j+k)+1] + ' ' + Str[6*(8*j+k)+2] + ' ' + Str[6*(8*j+k)+3] + ' ' + Str[6*(8*j+k)+4] + ' ' + Str[6*(8*j+k)+5];  // positions 0,1,2,3,4,5

                        MSH.Writeline(s);

                        s := StringOfChar(' ',INDENT);
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

        Sleep(200);
    end;

    //
    // shellMITC4
    //

    OutFile := ModelPath+'\OpenSees\ShellMITC4_force.out';

    if FileExists(OutFile) then
    begin
        write('Reading shell forces/moments ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# ShellMITC4')+1],3,10));  // number of shells

        StrToArray(TCL[TCL.IndexOf('# ShellMITC4')+2],Tag,n,true);  // read all tags

        AssignFile(RES,OutFile);

        // forces

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Elements//ShellMITC4//Forces" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Vector OnGaussPoints "ShellMITC4_Node"');
                MSH.Writeline('ComponentNames "Fx" "Fy" "Fz"');
                MSH.Writeline('Unit "kN"');
                MSH.Writeline('Values');

                StrToArray(line,Str,4*6*n,true);  // read all values from current step (6 values per node)

                for j := 0 to n-1 do
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                    for k := 0 to 3 do  // 4 nodes
                    begin
                        s := s + Str[6*(4*j+k)] + ' ' + Str[6*(4*j+k)+1] + ' ' + Str[6*(4*j+k)+2];  // positions 0,1,2

                        MSH.Writeline(s);

                        s := StringOfChar(' ',INDENT);
                    end;
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                for j := 1 to Length(s) do
                    write(#8);
            end;

            Inc(i);

        until EOF(RES);

        // moments

        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Elements//ShellMITC4//Moments" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Vector OnGaussPoints "ShellMITC4_Node"');
                MSH.Writeline('ComponentNames "Mx" "My" "Mz"');
                MSH.Writeline('Unit "kNm"');
                MSH.Writeline('Values');

                StrToArray(line,Str,4*6*n,true);  // read all values from current step (6 values per node)

                for j := 0 to n-1 do
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                    for k := 0 to 3 do  // 4 nodes
                    begin
                        s := s + Str[6*(4*j+k)+3] + ' ' + Str[6*(4*j+k)+4] + ' ' + Str[6*(4*j+k)+5];  // positions 3,4,5

                        MSH.Writeline(s);

                        s := StringOfChar(' ',INDENT);
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

        Sleep(200);
    end;

    OutFile := ModelPath+'\OpenSees\ShellMITC4_stress.out';

    if FileExists(OutFile) then
    begin
        write('Reading shell stresses ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# ShellMITC4')+1],3,10));  // number of shells

        StrToArray(TCL[TCL.IndexOf('# ShellMITC4')+2],Tag,n,true);  // read all tags

        AssignFile(RES,OutFile);

        // membrane stresses

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Elements//ShellMITC4//Stresses-Membrane" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Matrix OnGaussPoints "ShellMITC4_GP"');
                MSH.Writeline('ComponentNames "s11" "s22" "s33 (zero)" "s12" "s23 (zero)" "s13 (zero)"');
                MSH.Writeline('Unit "kPa"');
                MSH.Writeline('Values');

                StrToArray(line,Str,4*8*n,true);  // read all values from current step (8 values per gauss point)

                for j := 0 to n-1 do
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                    for k := 0 to 3 do  // 4 gauss points
                    begin
                        s := s + Str[8*(4*j+k)] + ' ' + Str[8*(4*j+k)+1] + ' 0 ' + Str[8*(4*j+k)+2] + ' 0 0';  // positions 0,1,2

                        MSH.Writeline(s);

                        s := StringOfChar(' ',INDENT);
                    end;
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                for j := 1 to Length(s) do
                    write(#8);
            end;

            Inc(i);

        until EOF(RES);

        // bending stress

        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Elements//ShellMITC4//Stresses-Bending" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Matrix OnGaussPoints "ShellMITC4_GP"');
                MSH.Writeline('ComponentNames "m11" "m22" "m33 (zero)" "m12" "m23 (zero)" "m13 (zero)"');
                MSH.Writeline('Unit "kPa"');
                MSH.Writeline('Values');

                StrToArray(line,Str,4*8*n,true);  // read all values from current step (8 values per gauss point)

                for j := 0 to n-1 do
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                    for k := 0 to 3 do  // 4 gauss points
                    begin
                        s := s + Str[8*(4*j+k)+3] + ' ' + Str[8*(4*j+k)+4] + ' 0 ' + Str[8*(4*j+k)+5] + ' 0 0';  // positions 3,4,5

                        MSH.Writeline(s);

                        s := StringOfChar(' ',INDENT);
                    end;
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                for j := 1 to Length(s) do
                    write(#8);
            end;

            Inc(i);

        until EOF(RES);

        // shear stresses

        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Elements//ShellMITC4//Stresses-Shear" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Vector OnGaussPoints "ShellMITC4_GP"');
                MSH.Writeline('ComponentNames "q1" "q2" "q3 (zero)"');
                MSH.Writeline('Unit "kPa"');
                MSH.Writeline('Values');

                StrToArray(line,Str,4*8*n,true);  // read all values from current step (8 values per gauss point)

                for j := 0 to n-1 do
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                    for k := 0 to 3 do  // 4 gauss points
                    begin
                        s := s + Str[8*(4*j+k)+6] + ' ' + Str[8*(4*j+k)+7] + ' 0';  // positions 6,7

                        MSH.Writeline(s);

                        s := StringOfChar(' ',INDENT);
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

        Sleep(200);
    end;

    //
    // shellDKGQ
    //

    OutFile := ModelPath+'\OpenSees\ShellDKGQ_force.out';

    if FileExists(OutFile) then
    begin
        write('Reading shellDKGQ forces/moments ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# ShellDKGQ')+1],3,10));  // number of shells

        StrToArray(TCL[TCL.IndexOf('# ShellDKGQ')+2],Tag,n,true);  // read all tags

        AssignFile(RES,OutFile);

        // forces

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Elements//ShellDKGQ//Forces" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Vector OnGaussPoints "ShellDKGQ_Node"');
                MSH.Writeline('ComponentNames "Fx" "Fy" "Fz"');
                MSH.Writeline('Unit "kN"');
                MSH.Writeline('Values');

                StrToArray(line,Str,4*6*n,true);  // read all values from current step (6 values per node)

                for j := 0 to n-1 do
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                    for k := 0 to 3 do  // 4 nodes
                    begin
                        s := s + Str[6*(4*j+k)] + ' ' + Str[6*(4*j+k)+1] + ' ' + Str[6*(4*j+k)+2];  // positions 0,1,2

                        MSH.Writeline(s);

                        s := StringOfChar(' ',INDENT);
                    end;
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                for j := 1 to Length(s) do
                    write(#8);
            end;

            Inc(i);

        until EOF(RES);

        // moments

        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Elements//ShellDKGQ//Moments" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Vector OnGaussPoints "ShellDKGQ_Node"');
                MSH.Writeline('ComponentNames "Mx" "My" "Mz"');
                MSH.Writeline('Unit "kNm"');
                MSH.Writeline('Values');

                StrToArray(line,Str,4*6*n,true);  // read all values from current step (6 values per node)

                for j := 0 to n-1 do
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                    for k := 0 to 3 do  // 4 nodes
                    begin
                        s := s + Str[6*(4*j+k)+3] + ' ' + Str[6*(4*j+k)+4] + ' ' + Str[6*(4*j+k)+5];  // positions 3,4,5

                        MSH.Writeline(s);

                        s := StringOfChar(' ',INDENT);
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

        Sleep(200);
    end;

    OutFile := ModelPath+'\OpenSees\ShellDKGQ_stress.out';

    if FileExists(OutFile) then
    begin
        write('Reading shellDKGQ stresses ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# ShellDKGQ')+1],3,10));  // number of shells

        StrToArray(TCL[TCL.IndexOf('# ShellDKGQ')+2],Tag,n,true);  // read all tags

        AssignFile(RES,OutFile);

        // membrane stresses

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Elements//ShellDKGQ//Stresses-Membrane" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Matrix OnGaussPoints "ShellDKGQ_GP"');
                MSH.Writeline('ComponentNames "s11" "s22" "s33 (zero)" "s12" "s23 (zero)" "s13 (zero)"');
                MSH.Writeline('Unit "kPa"');
                MSH.Writeline('Values');

                StrToArray(line,Str,4*8*n,true);  // read all values from current step (8 values per gauss point)

                for j := 0 to n-1 do
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                    for k := 0 to 3 do  // 4 gauss points
                    begin
                        s := s + Str[8*(4*j+k)] + ' ' + Str[8*(4*j+k)+1] + ' 0 ' + Str[8*(4*j+k)+2] + ' 0 0';  // positions 0,1,2

                        MSH.Writeline(s);

                        s := StringOfChar(' ',INDENT);
                    end;
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                for j := 1 to Length(s) do
                    write(#8);
            end;

            Inc(i);

        until EOF(RES);

        // bending stress

        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Elements//ShellDKGQ//Stresses-Bending" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Matrix OnGaussPoints "ShellDKGQ_GP"');
                MSH.Writeline('ComponentNames "m11" "m22" "m33 (zero)" "m12" "m23 (zero)" "m13 (zero)"');
                MSH.Writeline('Unit "kPa"');
                MSH.Writeline('Values');

                StrToArray(line,Str,4*8*n,true);  // read all values from current step (8 values per gauss point)

                for j := 0 to n-1 do
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                    for k := 0 to 3 do  // 4 gauss points
                    begin
                        s := s + Str[8*(4*j+k)+3] + ' ' + Str[8*(4*j+k)+4] + ' 0 ' + Str[8*(4*j+k)+5] + ' 0 0';  // positions 3,4,5

                        MSH.Writeline(s);

                        s := StringOfChar(' ',INDENT);
                    end;
                end;

                MSH.Writeline('End Values');

                s := '('+IntToStr(i+1)+')';
                TextColor(Yellow);
                write(s);
                TextColor(White);

                for j := 1 to Length(s) do
                    write(#8);
            end;

            Inc(i);

        until EOF(RES);

        // shear stresses

        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Elements//ShellDKGQ//Stresses-Shear" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Vector OnGaussPoints "ShellDKGQ_GP"');
                MSH.Writeline('ComponentNames "q1" "q2" "q3 (zero)"');
                MSH.Writeline('Unit "kPa"');
                MSH.Writeline('Values');

                StrToArray(line,Str,4*8*n,true);  // read all values from current step (8 values per gauss point)

                for j := 0 to n-1 do
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                    for k := 0 to 3 do  // 4 gauss points
                    begin
                        s := s + Str[8*(4*j+k)+6] + ' ' + Str[8*(4*j+k)+7] + ' 0';  // positions 6,7

                        MSH.Writeline(s);

                        s := StringOfChar(' ',INDENT);
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

        Sleep(200);
    end;

    //
    // Quad
    //

    // forces

    OutFile := ModelPath+'\OpenSees\Quad_force.out';

    if FileExists(OutFile) then
    begin
        write('Reading quad forces ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Quad')+1],3,10));  // number of quads

        StrToArray(TCL[TCL.IndexOf('# Quad')+2],Tag,n,true);  // read all tags

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Elements//Quad//Forces" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Vector OnGaussPoints "Quad_Node"');
                MSH.Writeline('ComponentNames "Fx" "Fy" "Fz (zero)"');
                MSH.Writeline('Unit "kN"');
                MSH.Writeline('Values');

                StrToArray(line,Str,4*2*n,true);  // read all values from current step (2 values per node)

                for j := 0 to n-1 do
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                    for k := 0 to 3 do  // 4 nodes
                    begin
                        s := s + Str[2*(4*j+k)] + ' ' + Str[2*(4*j+k)+1] + ' 0';  // positions 0,1,2

                        MSH.Writeline(s);

                        s := StringOfChar(' ',INDENT);
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

        Sleep(200);
    end;

    // stresses

    OutFile := ModelPath+'\OpenSees\Quad_stress.out';

    if FileExists(OutFile) then
    begin
        write('Reading quad stresses ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Quad')+1],3,10));  // number of quads

        StrToArray(TCL[TCL.IndexOf('# Quad')+2],Tag,n,true);  // read all tags

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Elements//Quad//Stresses" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Matrix OnGaussPoints "Quad_GP"');
                MSH.Writeline('ComponentNames "s11" "s22" "s33 (zero)" "s12" "s23 (zero)" "s13 (zero)"');
                MSH.Writeline('Unit "kPa"');
                MSH.Writeline('Values');

                StrToArray(line,Str,4*3*n,true);  // read all values from current step (3 values per gauss point)

                for j := 0 to n-1 do
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                    for k := 0 to 3 do  // 4 gauss points
                    begin
                        s := s + Str[3*(4*j+k)] + ' ' + Str[3*(4*j+k)+1] + ' 0 ' + Str[3*(4*j+k)+2] + ' 0 0';  // positions 0,1,2

                        MSH.Writeline(s);

                        s := StringOfChar(' ',INDENT);
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

        Sleep(200);
    end;

    // strains

    OutFile := ModelPath+'\OpenSees\Quad_strain.out';

    if FileExists(OutFile) then
    begin
        write('Reading quad strains ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Quad')+1],3,10));  // number of quads

        StrToArray(TCL[TCL.IndexOf('# Quad')+2],Tag,n,true);  // read all tags

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Elements//Quad//Strains" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Matrix OnGaussPoints "Quad_GP"');
                MSH.Writeline('ComponentNames "e11" "e22" "e33 (zero)" "e12" "e23 (zero)" "e13 (zero)"');
                MSH.Writeline('Unit "m-1"');
                MSH.Writeline('Values');

                StrToArray(line,Str,4*3*n,true);  // read all values from current step (3 values per gauss point)

                for j := 0 to n-1 do
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                    for k := 0 to 3 do  // 4 gauss points
                    begin
                        s := s + Str[3*(4*j+k)] + ' ' + Str[3*(4*j+k)+1] + ' 0 ' + Str[3*(4*j+k)+2] + ' 0 0';  // positions 0,1,2

                        MSH.Writeline(s);

                        s := StringOfChar(' ',INDENT);
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

        Sleep(200);
    end;

    //
    // Triangular
    //

    // forces

    OutFile := ModelPath+'\OpenSees\Tri31_force.out';

    if FileExists(OutFile) then
    begin
        write('Reading triangular forces ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Tri31')+1],3,10));  // number of quads

        StrToArray(TCL[TCL.IndexOf('# Tri31')+2],Tag,n,true);  // read all tags

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Elements//Triangular//Forces" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Vector OnGaussPoints "Tri31_Node"');
                MSH.Writeline('ComponentNames "Fx" "Fy" "Fz (zero)"');
                MSH.Writeline('Unit "kN"');
                MSH.Writeline('Values');

                StrToArray(line,Str,3*2*n,true);  // read all values from current step (2 values per node)

                for j := 0 to n-1 do
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                    for k := 0 to 2 do  // 3 nodes
                    begin
                        s := s + Str[2*(3*j+k)] + ' ' + Str[2*(3*j+k)+1] + ' 0';  // positions 0,1,2

                        MSH.Writeline(s);

                        s := StringOfChar(' ',INDENT);
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

        Sleep(200);
    end;

    // stresses

    OutFile := ModelPath+'\OpenSees\Tri31_stress.out';

    if FileExists(OutFile) then
    begin
        write('Reading triangular stresses ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Tri31')+1],3,10));  // number of quads

        StrToArray(TCL[TCL.IndexOf('# Tri31')+2],Tag,n,true);  // read all tags

        AssignFile(RES,OutFile);
        Reset(RES);

        i := 0;

        repeat

            Readln(RES,line);

            if (i = 0) or EOF(RES) or (i mod Step = 0) then
            begin

                MSH.Writeline('');
                MSH.Writeline('Result "Elements//Triangular//Stresses" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Matrix OnGaussPoints "Tri31_GP"');
                MSH.Writeline('ComponentNames "s11" "s22" "s33 (zero)" "s12" "s23 (zero)" "s13 (zero)"');
                MSH.Writeline('Unit "kPa"');
                MSH.Writeline('Values');

                StrToArray(line,Str,3*n,true);  // read all values from current step (3 values per gauss point)

                for j := 0 to n-1 do
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[3*j] + ' ' + Str[3*j+1] + ' 0 ' + Str[3*j+2] + ' 0 0';  // positions 0,1,2

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

        Sleep(200);
    end;

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
                MSH.Writeline('Result "Elements//Truss//Axial" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Scalar OnGaussPoints "Line_Nodes"');
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

        Sleep(200);
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
                MSH.Writeline('Result "Elements//Corotational_Truss//Axial" "'+Str_Titles[i]+'" '+Str_Steps[i]+' Scalar OnGaussPoints "Line_Nodes"');
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

        Sleep(200);
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
                    MSH.Writeline('ResultGroup "'+Str_Titles[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Elastic_Beam-Column//Actions//N" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Elastic_Beam-Column//Actions//V" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Elastic_Beam-Column//Actions//M" Scalar');
                    MSH.Writeline('Unit "kNm"');

                    StrToArray(line,Str,2*3*n,true);  // read all values from current step (3 values per node)
                end;

                if ndm = 3 then
                begin
                    MSH.Writeline('ResultGroup "'+Str_Titles[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
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

                    StrToArray(line,Str,2*6*n,true);  // read all values from current step (6 values per node)
                end;

                MSH.Writeline('Values');

                for j := 0 to n-1 do
                begin
                    if ndm = 2 then // end1                                     N                         V                     M
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Inv(Str[3*(2*j)]) + ' ' + Str[3*(2*j)+1] + ' '+ Str[3*(2*j)+2];

                        MSH.Writeline(s); // end2              N                      V                            M

                        s := StringOfChar(' ',INDENT) +  Str[3*(2*j+1)] + ' ' + Inv(Str[3*(2*j+1)+1]) + ' '+ Inv(Str[3*(2*j+1)+2]);

                        MSH.Writeline(s);
                    end;

                    if ndm = 3 then // end1                                     N                         Vy                     Vz                     T                      My                    Mz
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Inv(Str[6*(2*j)]) + ' ' + Str[6*(2*j)+1] + ' ' + Str[6*(2*j)+2] + ' ' + Str[6*(2*j)+3] + ' ' + Str[6*(2*j)+4] + ' '+ Str[6*(2*j)+5];

                        MSH.Writeline(s); // end2              N                      Vy                            Vz                            T                             My                           Mz

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

        Sleep(200);
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
                    MSH.Writeline('ResultGroup "'+Str_Titles[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Elastic_Timoshenko_Beam-Column//Actions//N" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Elastic_Timoshenko_Beam-Column//Actions//V" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Elastic_Timoshenko_Beam-Column//Actions//M" Scalar');
                    MSH.Writeline('Unit "kNm"');

                    StrToArray(line,Str,2*3*n,true);  // read all values from current step (3 values per node)
                end;

                if ndm = 3 then
                begin
                    MSH.Writeline('ResultGroup "'+Str_Titles[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
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

                    StrToArray(line,Str,2*6*n,true);  // read all values from current step (6 values per node)
                end;

                MSH.Writeline('Values');

                for j := 0 to n-1 do
                begin
                    if ndm = 2 then // end1                                     N                         V                     M
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Inv(Str[3*(2*j)]) + ' ' + Str[3*(2*j)+1] + ' '+ Str[3*(2*j)+2];

                        MSH.Writeline(s); // end2              N                      V                            M

                        s := StringOfChar(' ',INDENT) +  Str[3*(2*j+1)] + ' ' + Inv(Str[3*(2*j+1)+1]) + ' '+ Inv(Str[3*(2*j+1)+2]);

                        MSH.Writeline(s);
                    end;

                    if ndm = 3 then // end1                                     N                         Vy                     Vz                     T                      My                    Mz
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Inv(Str[6*(2*j)]) + ' ' + Str[6*(2*j)+1] + ' ' + Str[6*(2*j)+2] + ' ' + Str[6*(2*j)+3] + ' ' + Str[6*(2*j)+4] + ' '+ Str[6*(2*j)+5];

                        MSH.Writeline(s); // end2              N                      Vy                            Vz                            T                             My                           Mz

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

        Sleep(200);
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
                    MSH.Writeline('ResultGroup "'+Str_Titles[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Actions//N" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Actions//V" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Actions//M" Scalar');
                    MSH.Writeline('Unit "kNm"');

                    StrToArray(line,Str,2*3*n,true);  // read all values from current step (3 values per node)
                end;

                if ndm = 3 then
                begin
                    MSH.Writeline('ResultGroup "'+Str_Titles[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
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

                    StrToArray(line,Str,2*6*n,true);  // read all values from current step (6 values per node)
                end;

                MSH.Writeline('Values');

                for j := 0 to n-1 do
                begin
                    if ndm = 2 then // end1                                     N                         V                     M
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Inv(Str[3*(2*j)]) + ' ' + Str[3*(2*j)+1] + ' '+ Str[3*(2*j)+2];

                        MSH.Writeline(s); // end2              N                      V                            M

                        s := StringOfChar(' ',INDENT) +  Str[3*(2*j+1)] + ' ' + Inv(Str[3*(2*j+1)+1]) + ' '+ Inv(Str[3*(2*j+1)+2]);

                        MSH.Writeline(s);
                    end;

                    if ndm = 3 then // end1                                     N                         Vy                     Vz                     T                      My                    Mz
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Inv(Str[6*(2*j)]) + ' ' + Str[6*(2*j)+1] + ' ' + Str[6*(2*j)+2] + ' ' + Str[6*(2*j)+3] + ' ' + Str[6*(2*j)+4] + ' '+ Str[6*(2*j)+5];

                        MSH.Writeline(s); // end2                                    Vy                            Vz                            T                             My                           Mz

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

        Sleep(200);
    end;

    // total deformation

    OutFile := ModelPath+'\OpenSees\ForceBeamColumn_basicDeformation.out';

    if FileExists(OutFile) then
    begin
        write('Reading force beam-column total deformation ');

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
                    MSH.Writeline('ResultGroup "'+Str_Titles[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Deformations_Total//Axial" Scalar');
                    MSH.Writeline('Unit "m"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Deformations_Total//Rotation" Scalar');
                    MSH.Writeline('Unit "rad"');

                    StrToArray(line,Str,3*n,true);  // read all values from current step (3 values per element)
                end;

                if ndm = 3 then
                begin
                    MSH.Writeline('ResultGroup "'+Str_Titles[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
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

                        MSH.Writeline(s); // end2             Axial            Rotation

                        s := StringOfChar(' ',INDENT) + Str[3*j] + ' ' + Inv(Str[3*j+2]);

                        MSH.Writeline(s);
                    end;

                    if ndm = 3 then // end1                                     Axial            Rotation z              Rotation y              Torsional
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[6*j] + ' ' + Inv(Str[6*j+1]) + ' ' + Inv(Str[6*j+3]) + ' ' + Str[6*j+5];

                        MSH.Writeline(s); // end2              Axial            Rotation z         Rotation y         Torsional

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

        Sleep(200);
    end;

    // plastic deformation

    OutFile := ModelPath+'\OpenSees\ForceBeamColumn_plasticDeformation.out';

    if FileExists(OutFile) then
    begin
        write('Reading force beam-column plastic deformation ');

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
                    MSH.Writeline('ResultGroup "'+Str_Titles[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Deformations_Plastic//Axial" Scalar');
                    MSH.Writeline('Unit "m"');
                    MSH.Writeline('ResultDescription "Elements//Force_Beam-Column//Deformations_Plastic//Rotation" Scalar');
                    MSH.Writeline('Unit "rad"');

                    StrToArray(line,Str,3*n,true);  // read all values from current step (3 values per element)
                end;

                if ndm = 3 then
                begin
                    MSH.Writeline('ResultGroup "'+Str_Titles[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
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

                        MSH.Writeline(s); // end 2            Axial            Rotation

                        s := StringOfChar(' ',INDENT) + Str[3*j] + ' ' + Inv(Str[3*j+2]);

                        MSH.Writeline(s);
                    end;

                    if ndm = 3 then // end1                                     Axial            Rotation z              Rotation y              Torsional
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[6*j] + ' ' + Inv(Str[6*j+1]) + ' ' + Inv(Str[6*j+3]) + ' ' + Str[6*j+5];

                        MSH.Writeline(s); // end2              Axial            Rotation z         Rotation y         Torsional

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

        Sleep(200);
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
                    MSH.Writeline('ResultGroup "'+Str_Titles[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Actions//N" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Actions//V" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Actions//M" Scalar');
                    MSH.Writeline('Unit "kNm"');

                    StrToArray(line,Str,2*3*n,true);  // read all values from current step (3 values per node)
                end;

                if ndm = 3 then
                begin
                    MSH.Writeline('ResultGroup "'+Str_Titles[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
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

                    StrToArray(line,Str,2*6*n,true);  // read all values from current step (6 values per node)
                end;

                MSH.Writeline('Values');

                for j := 0 to n-1 do
                begin
                    if ndm = 2 then // end1                                     N                         V                     M
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Inv(Str[3*(2*j)]) + ' ' + Str[3*(2*j)+1] + ' '+ Str[3*(2*j)+2];

                        MSH.Writeline(s); // end2              N                      V                            M

                        s := StringOfChar(' ',INDENT) +  Str[3*(2*j+1)] + ' ' + Inv(Str[3*(2*j+1)+1]) + ' '+ Inv(Str[3*(2*j+1)+2]);

                        MSH.Writeline(s);
                    end;

                    if ndm = 3 then // end1                                     N                         Vy                     Vz                     T                      My                    Mz
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Inv(Str[6*(2*j)]) + ' ' + Str[6*(2*j)+1] + ' ' + Str[6*(2*j)+2] + ' ' + Str[6*(2*j)+3] + ' ' + Str[6*(2*j)+4] + ' '+ Str[6*(2*j)+5];

                        MSH.Writeline(s); // end2                                    Vy                            Vz                            T                             My                           Mz

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

        Sleep(200);
    end;

    // total deformation

    OutFile := ModelPath+'\OpenSees\DispBeamColumn_basicDeformation.out';

    if FileExists(OutFile) then
    begin
        write('Reading displacement beam-column total deformation ');

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
                    MSH.Writeline('ResultGroup "'+Str_Titles[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Deformations_Total//Axial" Scalar');
                    MSH.Writeline('Unit "m"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Deformations_Total//Rotation" Scalar');
                    MSH.Writeline('Unit "rad"');

                    StrToArray(line,Str,3*n,true);  // read all values from current step (3 values per element)
                end;

                if ndm = 3 then
                begin
                    MSH.Writeline('ResultGroup "'+Str_Titles[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Deformations_Total//Axial" Scalar');
                    MSH.Writeline('Unit "m"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Deformations_Total//Rotation_z" Scalar');
                    MSH.Writeline('Unit "rad"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Deformations_Total//Rotation_y" Scalar');
                    MSH.Writeline('Unit "rad"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Deformations_Total//Torsional" Scalar');
                    MSH.Writeline('Unit "rad"');

                    StrToArray(line,Str,6*n,true);  // read all values from current step (6 values per element)
                end;

                MSH.Writeline('Values');

                for j := 0 to n-1 do
                begin
                    if ndm = 2 then // end1                                     Axial            Rotation
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[3*j] + ' ' + Str[3*j+1];

                        MSH.Writeline(s); // end2             Axial            Rotation

                        s := StringOfChar(' ',INDENT) + Str[3*j] + ' ' + Inv(Str[3*j+2]);

                        MSH.Writeline(s);
                    end;

                    if ndm = 3 then // end1                                     Axial            Rotation z              Rotation y              Torsional
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[6*j] + ' ' + Inv(Str[6*j+1]) + ' ' + Inv(Str[6*j+3]) + ' ' + Str[6*j+5];

                        MSH.Writeline(s); // end2              Axial            Rotation z         Rotation y         Torsional

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

        Sleep(200);
    end;

    // plastic deformation

    OutFile := ModelPath+'\OpenSees\DispBeamColumn_plasticDeformation.out';

    if FileExists(OutFile) then
    begin
        write('Reading displacement beam-column plastic deformation ');

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
                    MSH.Writeline('ResultGroup "'+Str_Titles[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Deformations_Plastic//Axial" Scalar');
                    MSH.Writeline('Unit "m"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Deformations_Plastic//Rotation" Scalar');
                    MSH.Writeline('Unit "rad"');

                    StrToArray(line,Str,3*n,true);  // read all values from current step (3 values per element)
                end;

                if ndm = 3 then
                begin
                    MSH.Writeline('ResultGroup "'+Str_Titles[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Deformations_Plastic//Axial" Scalar');
                    MSH.Writeline('Unit "m"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Deformations_Plastic//Rotation_z" Scalar');
                    MSH.Writeline('Unit "rad"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Deformations_Plastic//Rotation_y" Scalar');
                    MSH.Writeline('Unit "rad"');
                    MSH.Writeline('ResultDescription "Elements//Displacement_Beam-Column//Deformations_Plastic//Torsional" Scalar');
                    MSH.Writeline('Unit "rad"');

                    StrToArray(line,Str,6*n,true);  // read all values from current step (6 values per element)
                end;

                MSH.Writeline('Values');

                for j := 0 to n-1 do
                begin
                    if ndm = 2 then // end 1                                    Axial            Rotation
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[3*j] + ' ' + Str[3*j+1];

                        MSH.Writeline(s); // end 2            Axial            Rotation

                        s := StringOfChar(' ',INDENT) + Str[3*j] + ' ' + Inv(Str[3*j+2]);

                        MSH.Writeline(s);
                    end;

                    if ndm = 3
                     then // end1                                     Axial            Rotation z              Rotation y              Torsional
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[6*j] + ' ' + Inv(Str[6*j+1]) + ' ' + Inv(Str[6*j+3]) + ' ' + Str[6*j+5];

                        MSH.Writeline(s); // end2              Axial            Rotation z         Rotation y         Torsional

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

        Sleep(200);
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
                    MSH.Writeline('ResultGroup "'+Str_Titles[i]+'" '+Str_Steps[i]+' OnGaussPoints "Line_Nodes"');
                    MSH.Writeline('ResultDescription "Elements//Flexure_Shear_Interaction_Displacement_Beam-Column//Actions//N" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Flexure_Shear_Interaction_Displacement_Beam-Column//Actions//V" Scalar');
                    MSH.Writeline('Unit "kN"');
                    MSH.Writeline('ResultDescription "Elements//Flexure_Shear_Interaction_Displacement_Beam-Column//Actions//M" Scalar');
                    MSH.Writeline('Unit "kNm"');

                    StrToArray(line,Str,2*3*n,true);  // read all values from current step (3 values per node)
                end;

                MSH.Writeline('Values');

                for j := 0 to n-1 do
                begin
                    if ndm = 2 then // end1                                     N                         V                     M
                    begin
                        s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[3*(2*j)] + ' ' + Str[3*(2*j)+1] + ' '+ Str[3*(2*j)+2];

                        MSH.Writeline(s); // end2              N                      V                            M

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

        Sleep(200);
    end;

	//
	//
	//

    FreeAndNil(TCL);

    MSH.Close;
    MSH.Free;

    writeln;

    if ParamStr(3) = '/b' then
    begin
        TextColor(LightGreen);

        write('Creating binary results file...');

        // convert to binary

        ExecuteAndWait('"'+GiDPath+'\gid.exe" -PostResultsToBinary "'+ResFileASCII+'" "'+ResFileBin+'"');

        if FileExists(ResFileASCII) then
            DeleteFile(PWideChar(ResFileASCII));
    end
    else
    begin
        write('Text results file...');

        RenameFile(ResFileASCII,ResFileBin);
    end;

    writeln(#8#8#8' : '+GetFileSize(ResFileBin));
    writeln;

    TextColor(LightCyan);
    writeln('Conversion completed');

    Sleep(2000);
end.
