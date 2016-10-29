program OpenSeesPost;

{$APPTYPE CONSOLE}

{$R *.res}

uses
    System.Classes,
    System.SysUtils,
    Windows;

type
    ArrayStr = array of string;

const
    INDENT = 7;

var
    i,j,k,n,
    ndm,ndf    : integer;
    s,Path,
    FileName,
    ModelName,
    OutFile,
    AnalType   : string;
    Tag,
    Str        : ArrayStr;
    TCL,
    MSH,
    RES,
    PER        : TStringList;
    Period     : string;

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

//
// main program
//

begin

    // title

    writeln('OpenSeesPost - OpenSees to GiD results converter');
    writeln;
    writeln('https://github.com/rclab-auth/gidopensees');
    writeln;

    // check syntax

    if ParamCount <> 1 then
    begin
        writeln('Syntax : OpenSeesPost <project path>');
        writeln;
        Exit;
    end;

    // load model file

    Path := LongPathName(ParamStr(1));

    ModelName := Copy(Path,LastDelimiter('\',Path)+1,Length(Path)-LastDelimiter('\',Path));
    ModelName := Copy(ModelName,1,Length(ModelName)-4);

    FileName := Path+'\OpenSees\'+ModelName+'.log';

    if not FileExists(FileName) then
    begin
        writeln('No results found. Exiting.');

        Sleep(1000);
        Exit;
    end;

    FileName := Path+'\OpenSees\'+ModelName+'.tcl';

    if FileExists(FileName) then
    begin
        TCL := TStringList.Create;
        TCL.LoadFromFile(FileName);

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

    if Pos('analysis Static',TCL.Text) <> 0 then
        AnalType := 'Static'
    else if Pos('analysis Transient',TCL.Text) <> 0 then
        AnalType := 'Transient';

    ndm := StrToInt(Copy(TCL.Text,Pos('-ndm',TCL.Text)+5,1));
    ndf := StrToInt(Copy(TCL.Text,Pos('-ndf',TCL.Text)+5,1));

    // initialize files

    MSH := TStringList.Create;

    MSH.Add('GiD Post Results File 1.0');

    //
    // GAUSS POINT DEFINITIONS
    //

    if FileExists(Path+'\OpenSees\stdBrick_stress.out') then
    begin
        MSH.Add('');
        MSH.Add('GaussPoints "stdbrick_GP" ElemType Hexahedra');
        MSH.Add('Number Of Gauss Points: 8');
        MSH.Add('Natural Coordinates: Given');
        MSH.Add('-0.577350269189626 -0.577350269189626 -0.577350269189626');
        MSH.Add('-0.577350269189626 -0.577350269189626  0.577350269189626');
        MSH.Add('-0.577350269189626  0.577350269189626 -0.577350269189626');
        MSH.Add('-0.577350269189626  0.577350269189626  0.577350269189626');
        MSH.Add('+0.577350269189626 -0.577350269189626 -0.577350269189626');
        MSH.Add(' 0.577350269189626 -0.577350269189626  0.577350269189626');
        MSH.Add(' 0.577350269189626  0.577350269189626 -0.577350269189626');
        MSH.Add(' 0.577350269189626  0.577350269189626  0.577350269189626');
        MSH.Add('end GaussPoints');

        MSH.Add('');
        MSH.Add('GaussPoints "stdbrick_Node" ElemType Hexahedra');
        MSH.Add('Number Of Gauss Points: 8');
        MSH.Add('Natural Coordinates: Given');
        MSH.Add('-1 -1 -1');
        MSH.Add(' 1 -1 -1');
        MSH.Add(' 1  1 -1');
        MSH.Add('-1  1 -1');
        MSH.Add('-1 -1  1');
        MSH.Add(' 1 -1  1');
        MSH.Add(' 1  1  1');
        MSH.Add('-1  1  1');
        MSH.Add('end GaussPoints');
    end;

    if FileExists(Path+'\OpenSees\ShellMITC4_stress.out') then
    begin
        MSH.Add('');
        MSH.Add('GaussPoints "ShellMITC4_GP" ElemType Quadrilateral');
        MSH.Add('Number Of Gauss Points: 4');
        MSH.Add('Natural Coordinates: Given');
        MSH.Add('-0.577350269189626 -0.577350269189626');
        MSH.Add('-0.577350269189626  0.577350269189626');
        MSH.Add(' 0.577350269189626 -0.577350269189626');
        MSH.Add(' 0.577350269189626  0.577350269189626');
        MSH.Add('end GaussPoints');

        MSH.Add('');
        MSH.Add('GaussPoints "ShellMITC4_Node" ElemType Quadrilateral');
        MSH.Add('Number Of Gauss Points: 4');
        MSH.Add('Natural Coordinates: Given');
        MSH.Add(' 1 -1');
        MSH.Add('-1  1');
        MSH.Add('-1 -1');
        MSH.Add(' 1  1');
        MSH.Add('end GaussPoints');
    end;

    if FileExists(Path+'\OpenSees\Quad_stress.out') then
    begin
        MSH.Add('');
        MSH.Add('GaussPoints "Quad_GP" ElemType Quadrilateral');
        MSH.Add('Number Of Gauss Points: 4');
        MSH.Add('Natural Coordinates: Given');
        MSH.Add('-0.577350269189626 -0.577350269189626');
        MSH.Add('-0.577350269189626  0.577350269189626');
        MSH.Add(' 0.577350269189626 -0.577350269189626');
        MSH.Add(' 0.577350269189626  0.577350269189626');
        MSH.Add('end GaussPoints');

        MSH.Add('');
        MSH.Add('GaussPoints "Quad_Node" ElemType Quadrilateral');
        MSH.Add('Number Of Gauss Points: 4');
        MSH.Add('Natural Coordinates: Given');
        MSH.Add(' 1 -1');
        MSH.Add('-1  1');
        MSH.Add('-1 -1');
        MSH.Add(' 1  1');
        MSH.Add('end GaussPoints');
    end;

    if FileExists(Path+'\OpenSees\Tri31_stress.out') then
    begin
        MSH.Add('');
        MSH.Add('GaussPoints "Tri31_GP" ElemType Triangle');
        MSH.Add('Number Of Gauss Points: 1');
        MSH.Add('Natural Coordinates: Given');
        MSH.Add(' 0.333333333333333  0.333333333333333');
        MSH.Add('end GaussPoints');

        MSH.Add('');
        MSH.Add('GaussPoints "Tri31_Node" ElemType Triangle');
        MSH.Add('Number Of Gauss Points: 3');
        MSH.Add('Natural Coordinates: Given');
        MSH.Add(' 1  0');
        MSH.Add(' 1  1');
        MSH.Add(' 0  1');
        MSH.Add('end GaussPoints');
    end;

    if FileExists(Path+'\OpenSees\Truss_axialForce.out') or FileExists(Path+'\OpenSees\CorotTruss_axialForce.out') or
       FileExists(Path+'\OpenSees\ElasticBeamColumn_localForce.out') or FileExists(Path+'\OpenSees\ElasticTimoshenkoBeamColumn_localForce.out') or
       FileExists(Path+'\OpenSees\ForceBeamColumn_localForce.out')then

    begin
        MSH.Add('');
        MSH.Add('GaussPoints "Line_Nodes" ElemType Line');
        MSH.Add('Number Of Gauss Points: 2');
        MSH.Add('Nodes included');
        MSH.Add('Natural Coordinates: Internal');
        MSH.Add('end GaussPoints');
    end;

    //
    //
    // M O D E S
    //
    //

    OutFile := Path+'\OpenSees\Periods.out';

    if FileExists(OutFile) then
    begin
        PER := TStringList.Create;
        PER.LoadFromFile(OutFile);

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Number of nodes')+1],3,10));  // number of nodes

        for i := 1 to PER.Count do
        begin
            writeln('Reading mode shape '+IntToStr(i));

            OutFile := Path+'\OpenSees\Mode_'+IntToStr(i)+'.out';

            RES := TStringList.Create;
            RES.LoadFromFile(OutFile);

            Period := Copy(PER.Strings[i-1],1,LastDelimiter('.',PER.Strings[i-1])+6);

            // ndm=2, ndf=2 -> Ux,Uy
            // ndm=2, ndf=3 -> Ux,Uy,(Rz)
            // ndm=3, ndf=3 -> Ux,Uy,Uz
            // ndm=3, ndf=6 -> Ux,Uy,Uz,(Rx),(Ry),(Rz)

            MSH.Add('');
            MSH.Add('Result "Mode_'+IntToStr(i)+' (T'+IntToStr(i)+' = '+Period+' s)" "Modal" 1 Vector OnNodes');

            s := 'ComponentNames "Ux" "Uy"';

            if ndm <> 2 then
                s := s+' "Uz"'
            else
                s := s+' "Uz (zero)"';

            MSH.Add(s);

            MSH.Add('Unit "m"');
            MSH.Add('Values');

            StrToArray(RES[0],Str,n*ndf,false);  // read all values from current step (ndf values per node)

            for j := 0 to n-1 do
            begin
                s := IntToStr(j+1) + StringOfChar(' ',INDENT-Length(IntToStr(j+1))) + Str[ndf*j]+' '+Str[ndf*j+1];

                if ndm <> 2 then
                    s := s + ' '+Str[ndf*j+2];

                MSH.Add(s);
            end;

            MSH.Add('End Values');

            Sleep(200);

            FreeAndNil(RES);
        end;

        FreeAndNil(PER);
    end;

    //
    //
    // N O D E S
    //
    //

    // displacements

    OutFile := Path+'\OpenSees\Node_displacements.out';

    if FileExists(OutFile) then
    begin
        write('Reading nodal displacements ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Number of nodes')+1],3,10));  // number of nodes

        RES := TStringList.Create;
        RES.LoadFromFile(OutFile);

        // ndm=2, ndf=2 -> Ux,Uy
        // ndm=2, ndf=3 -> Ux,Uy,(Rz)
        // ndm=3, ndf=3 -> Ux,Uy,Uz
        // ndm=3, ndf=6 -> Ux,Uy,Uz,(Rx),(Ry),(Rz)

        for i := 0 to RES.Count-1 do  // for all steps
        begin
            MSH.Add('');
            MSH.Add('Result "Nodes//Displacements" "'+AnalType+'" '+IntToStr(i+1)+' Vector OnNodes');

            s := 'ComponentNames "Ux" "Uy"';

            if ndm <> 2 then
                s := s+' "Uz"'
            else
                s := s+' "Uz (zero)"';

            MSH.Add(s);

            MSH.Add('Unit "m"');
            MSH.Add('Values');

            StrToArray(RES[i],Str,n*ndf,true);  // read all values from current step (ndf values per node)

            for j := 0 to n-1 do
            begin
                s := IntToStr(j+1) + StringOfChar(' ',INDENT-Length(IntToStr(j+1))) + Str[ndf*j]+' '+Str[ndf*j+1];

                if ndm <> 2 then
                    s := s + ' '+Str[ndf*j+2];

                MSH.Add(s);
            end;

            MSH.Add('End Values');

            write('.');
        end;

        writeln;

        Sleep(200);

        FreeAndNil(RES);
    end;

    // reactions

    OutFile := Path+'\OpenSees\Node_reactions.out';

    if FileExists(OutFile) then
    begin
        write('Reading nodal reactions ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Number of nodes')+1],3,10));  // number of nodes

        RES := TStringList.Create;
        RES.LoadFromFile(OutFile);

        // ndm=2, ndf=2 -> Ux,Uy
        // ndm=2, ndf=3 -> Ux,Uy,(Rz)
        // ndm=3, ndf=3 -> Ux,Uy,Uz
        // ndm=3, ndf=6 -> Ux,Uy,Uz,(Rx),(Ry),(Rz)

        for i := 0 to RES.Count-1 do  // for all steps
        begin
            MSH.Add('');
            MSH.Add('Result "Nodes//Reactions" "'+AnalType+'" '+IntToStr(i+1)+' Vector OnNodes');

            s := 'ComponentNames "Rx" "Ry"';

            if ndm <> 2 then
                s := s+' "Rz"'
            else
                s := s+' "Rz (zero)"';

            MSH.Add(s);

            MSH.Add('Unit "kN"');
            MSH.Add('Values');

            StrToArray(RES[i],Str,n*ndf,true);  // read all values from current step (ndf values per node)

            for j := 0 to n-1 do
            begin
                s := IntToStr(j+1) + StringOfChar(' ',INDENT-Length(IntToStr(j+1))) + Str[ndf*j]+' '+Str[ndf*j+1];

                if ndm <> 2 then
                    s := s + ' '+Str[ndf*j+2];

                MSH.Add(s);
            end;

            MSH.Add('End Values');

            write('.');
        end;

        writeln;

        Sleep(200);

        FreeAndNil(RES);
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

    OutFile := Path+'\OpenSees\stdBrick_force.out';

    if FileExists(OutFile) then
    begin
        write('Reading brick forces ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# stdBrick')+1],3,10));  // number of bricks

        StrToArray(TCL[TCL.IndexOf('# stdBrick')+2],Tag,n,true);  // read all tags

        RES := TStringList.Create;
        RES.LoadFromFile(OutFile);

        for i := 0 to RES.Count-1 do  // for all steps
        begin
            MSH.Add('');
            MSH.Add('Result "Elements//stdBrick//Forces" "'+AnalType+'" '+IntToStr(i+1)+' Vector OnGaussPoints "stdbrick_Node"');
            MSH.Add('ComponentNames "Fx" "Fy" "Fz"');
            MSH.Add('Unit "kN"');
            MSH.Add('Values');

            StrToArray(RES[i],Str,8*3*n,true);  // read all values from current step (3 values per node)

            for j := 0 to n-1 do
            begin
                s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                for k := 0 to 7 do  // 8 nodes
                begin
                    s := s + Str[3*(8*j+k)] + ' ' + Str[3*(8*j+k)+1] + ' ' + Str[3*(8*j+k)+2];  // positions 0,1,2

                    MSH.Add(s);

                    s := StringOfChar(' ',INDENT);
                end;
            end;

            MSH.Add('End Values');

            write('.');
        end;

        writeln;

        Sleep(200);

        FreeAndNil(RES);
    end;

    // stresses

    OutFile := Path+'\OpenSees\stdBrick_stress.out';

    if FileExists(OutFile) then
    begin
        write('Reading brick stresses ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# stdBrick')+1],3,10));  // number of bricks

        StrToArray(TCL[TCL.IndexOf('# stdBrick')+2],Tag,n,true);  // read all tags

        RES := TStringList.Create;
        RES.LoadFromFile(OutFile);

        for i := 0 to RES.Count-1 do  // for all steps
        begin
            MSH.Add('');
            MSH.Add('Result "Elements//stdBrick//Stresses" "'+AnalType+'" '+IntToStr(i+1)+' Matrix OnGaussPoints "stdbrick_GP"');
            MSH.Add('ComponentNames "s11" "s22" "s33" "s12" "s23" "s13"');
            MSH.Add('Unit "kPa"');
            MSH.Add('Values');

            StrToArray(RES[i],Str,8*6*n,true);  // read all values from current step (6 values per gauss point)

            for j := 0 to n-1 do
            begin
                s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                for k := 0 to 7 do  // 8 gauss points
                begin
                    s := s + Str[6*(8*j+k)] + ' ' + Str[6*(8*j+k)+1] + ' ' + Str[6*(8*j+k)+2] + ' ' + Str[6*(8*j+k)+3] + ' ' + Str[6*(8*j+k)+4] + ' ' + Str[6*(8*j+k)+5];  // positions 0,1,2,3,4,5

                    MSH.Add(s);

                    s := StringOfChar(' ',INDENT);
                end;
            end;

            MSH.Add('End Values');

            write('.');
        end;

        writeln;

        Sleep(200);

        FreeAndNil(RES);
    end;

    // strains

    OutFile := Path+'\OpenSees\stdBrick_strain.out';

    if FileExists(OutFile) then
    begin
        write('Reading brick strains ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# stdBrick')+1],3,10));  // number of bricks

        StrToArray(TCL[TCL.IndexOf('# stdBrick')+2],Tag,n,true);  // read all tags

        RES := TStringList.Create;
        RES.LoadFromFile(OutFile);

        for i := 0 to RES.Count-1 do  // for all steps
        begin
            MSH.Add('');
            MSH.Add('Result "Elements//stdBrick//Strains" "'+AnalType+'" '+IntToStr(i+1)+' Matrix OnGaussPoints "stdbrick_GP"');
            MSH.Add('ComponentNames "e11" "e22" "e33" "e12" "e23" "e13"');
            MSH.Add('Unit "m-1"');
            MSH.Add('Values');

            StrToArray(RES[i],Str,8*6*n,true);  // read all values from current step (6 values per gauss point)

            for j := 0 to n-1 do
            begin
                s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                for k := 0 to 7 do  // 8 gauss points
                begin
                    s := s + Str[6*(8*j+k)] + ' ' + Str[6*(8*j+k)+1] + ' ' + Str[6*(8*j+k)+2] + ' ' + Str[6*(8*j+k)+3] + ' ' + Str[6*(8*j+k)+4] + ' ' + Str[6*(8*j+k)+5];  // positions 0,1,2,3,4,5

                    MSH.Add(s);

                    s := StringOfChar(' ',INDENT);
                end;
            end;

            MSH.Add('End Values');

            write('.');
        end;

        writeln;

        Sleep(200);

        FreeAndNil(RES);
    end;

    //
    // shellMITC4
    //

    OutFile := Path+'\OpenSees\ShellMITC4_force.out';

    if FileExists(OutFile) then
    begin
        write('Reading shell forces/moments ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# ShellMITC4')+1],3,10));  // number of shells

        StrToArray(TCL[TCL.IndexOf('# ShellMITC4')+2],Tag,n,true);  // read all tags

        RES := TStringList.Create;
        RES.LoadFromFile(OutFile);

        // forces

        for i := 0 to RES.Count-1 do  // for all steps
        begin
            MSH.Add('');
            MSH.Add('Result "Elements//ShellMITC4//Forces" "'+AnalType+'" '+IntToStr(i+1)+' Vector OnGaussPoints "ShellMITC4_Node"');
            MSH.Add('ComponentNames "Fx" "Fy" "Fz"');
            MSH.Add('Unit "kN"');
            MSH.Add('Values');

            StrToArray(RES[i],Str,4*6*n,true);  // read all values from current step (6 values per node)

            for j := 0 to n-1 do
            begin
                s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                for k := 0 to 3 do  // 4 nodes
                begin
                    s := s + Str[6*(4*j+k)] + ' ' + Str[6*(4*j+k)+1] + ' ' + Str[6*(4*j+k)+2];  // positions 0,1,2

                    MSH.Add(s);

                    s := StringOfChar(' ',INDENT);
                end;
            end;

            MSH.Add('End Values');

            write('.');
        end;

        for i := 0 to RES.Count-1 do
            write(#8);

        // moments

        for i := 0 to RES.Count-1 do  // for all steps
        begin
            MSH.Add('');
            MSH.Add('Result "Elements//ShellMITC4//Moments" "'+AnalType+'" '+IntToStr(i+1)+' Vector OnGaussPoints "ShellMITC4_Node"');
            MSH.Add('ComponentNames "Mx" "My" "Mz"');
            MSH.Add('Unit "kNm"');
            MSH.Add('Values');

            StrToArray(RES[i],Str,4*6*n,true);  // read all values from current step (6 values per node)

            for j := 0 to n-1 do
            begin
                s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                for k := 0 to 3 do  // 4 nodes
                begin
                    s := s + Str[6*(4*j+k)+3] + ' ' + Str[6*(4*j+k)+4] + ' ' + Str[6*(4*j+k)+5];  // positions 3,4,5

                    MSH.Add(s);

                    s := StringOfChar(' ',INDENT);
                end;
            end;

            MSH.Add('End Values');

            write('.');
        end;

        writeln;

        Sleep(200);

        FreeAndNil(RES);
    end;

    OutFile := Path+'\OpenSees\ShellMITC4_stress.out';

    if FileExists(OutFile) then
    begin
        write('Reading shell stresses ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# ShellMITC4')+1],3,10));  // number of shells

        StrToArray(TCL[TCL.IndexOf('# ShellMITC4')+2],Tag,n,true);  // read all tags

        RES := TStringList.Create;
        RES.LoadFromFile(OutFile);

        // membrane stresses

        for i := 0 to RES.Count-1 do  // for all steps
        begin
            MSH.Add('');
            MSH.Add('Result "Elements//ShellMITC4//Stresses-Membrane" "'+AnalType+'" '+IntToStr(i+1)+' Matrix OnGaussPoints "ShellMITC4_GP"');
            MSH.Add('ComponentNames "s11" "s22" "s33 (zero)" "s12" "s23 (zero)" "s13 (zero)"');
            MSH.Add('Unit "kPa"');
            MSH.Add('Values');

            StrToArray(RES[i],Str,4*8*n,true);  // read all values from current step (8 values per gauss point)

            for j := 0 to n-1 do
            begin
                s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                for k := 0 to 3 do  // 4 gauss points
                begin
                    s := s + Str[8*(4*j+k)] + ' ' + Str[8*(4*j+k)+1] + ' 0 ' + Str[8*(4*j+k)+2] + ' 0 0';  // positions 0,1,2

                    MSH.Add(s);

                    s := StringOfChar(' ',INDENT);
                end;
            end;

            MSH.Add('End Values');

            write('.');
        end;

        for i := 0 to RES.Count-1 do
            write(#8);

        // bending stress

        for i := 0 to RES.Count-1 do  // for all steps
        begin
            MSH.Add('');
            MSH.Add('Result "Elements//ShellMITC4//Stresses-Bending" "'+AnalType+'" '+IntToStr(i+1)+' Matrix OnGaussPoints "ShellMITC4_GP"');
            MSH.Add('ComponentNames "m11" "m22" "m33 (zero)" "m12" "m23 (zero)" "m13 (zero)"');
            MSH.Add('Unit "kPa"');
            MSH.Add('Values');

            StrToArray(RES[i],Str,4*8*n,true);  // read all values from current step (8 values per gauss point)

            for j := 0 to n-1 do
            begin
                s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                for k := 0 to 3 do  // 4 gauss points
                begin
                    s := s + Str[8*(4*j+k)+3] + ' ' + Str[8*(4*j+k)+4] + ' 0 ' + Str[8*(4*j+k)+5] + ' 0 0';  // positions 3,4,5

                    MSH.Add(s);

                    s := StringOfChar(' ',INDENT);
                end;
            end;

            MSH.Add('End Values');

            write('.');
        end;

        for i := 0 to RES.Count-1 do
            write(#8);

        // shear stresses

        for i := 0 to RES.Count-1 do  // for all steps
        begin
            MSH.Add('');
            MSH.Add('Result "Elements//ShellMITC4//Stresses-Shear" "'+AnalType+'" '+IntToStr(i+1)+' Vector OnGaussPoints "ShellMITC4_GP"');
            MSH.Add('ComponentNames "q1" "q2" "q3 (zero)"');
            MSH.Add('Unit "kPa"');
            MSH.Add('Values');

            StrToArray(RES[i],Str,4*8*n,true);  // read all values from current step (8 values per gauss point)

            for j := 0 to n-1 do
            begin
                s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                for k := 0 to 3 do  // 4 gauss points
                begin
                    s := s + Str[8*(4*j+k)+6] + ' ' + Str[8*(4*j+k)+7] + ' 0';  // positions 6,7

                    MSH.Add(s);

                    s := StringOfChar(' ',INDENT);
                end;
            end;

            MSH.Add('End Values');

            write('.');
        end;

        writeln;

        Sleep(200);

        FreeAndNil(RES);
    end;

    //
    // Quad
    //

    // forces

    OutFile := Path+'\OpenSees\Quad_force.out';

    if FileExists(OutFile) then
    begin
        write('Reading quad forces ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Quad')+1],3,10));  // number of quads

        StrToArray(TCL[TCL.IndexOf('# Quad')+2],Tag,n,true);  // read all tags

        RES := TStringList.Create;
        RES.LoadFromFile(OutFile);

        for i := 0 to RES.Count-1 do  // for all steps
        begin
            MSH.Add('');
            MSH.Add('Result "Elements//Quad//Forces" "'+AnalType+'" '+IntToStr(i+1)+' Vector OnGaussPoints "Quad_Node"');
            MSH.Add('ComponentNames "Fx" "Fy" "Fz (zero)"');
            MSH.Add('Unit "kN"');
            MSH.Add('Values');

            StrToArray(RES[i],Str,4*2*n,true);  // read all values from current step (2 values per node)

            for j := 0 to n-1 do
            begin
                s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                for k := 0 to 3 do  // 4 nodes
                begin
                    s := s + Str[2*(4*j+k)] + ' ' + Str[2*(4*j+k)+1] + ' 0';  // positions 0,1,2

                    MSH.Add(s);

                    s := StringOfChar(' ',INDENT);
                end;
            end;

            MSH.Add('End Values');

            write('.');
        end;

        writeln;

        Sleep(200);

        FreeAndNil(RES);
    end;

    // stresses

    OutFile := Path+'\OpenSees\Quad_stress.out';

    if FileExists(OutFile) then
    begin
        write('Reading quad stresses ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Quad')+1],3,10));  // number of quads

        StrToArray(TCL[TCL.IndexOf('# Quad')+2],Tag,n,true);  // read all tags

        RES := TStringList.Create;
        RES.LoadFromFile(OutFile);

        for i := 0 to RES.Count-1 do  // for all steps
        begin
            MSH.Add('');
            MSH.Add('Result "Elements//Quad//Stresses" "'+AnalType+'" '+IntToStr(i+1)+' Matrix OnGaussPoints "Quad_GP"');
            MSH.Add('ComponentNames "s11" "s22" "s33 (zero)" "s12" "s23 (zero)" "s13 (zero)"');
            MSH.Add('Unit "kPa"');
            MSH.Add('Values');

            StrToArray(RES[i],Str,4*3*n,true);  // read all values from current step (3 values per gauss point)

            for j := 0 to n-1 do
            begin
                s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                for k := 0 to 3 do  // 4 gauss points
                begin
                    s := s + Str[3*(4*j+k)] + ' ' + Str[3*(4*j+k)+1] + ' 0 ' + Str[3*(4*j+k)+2] + ' 0 0';  // positions 0,1,2

                    MSH.Add(s);

                    s := StringOfChar(' ',INDENT);
                end;
            end;

            MSH.Add('End Values');

            write('.');
        end;

        writeln;

        Sleep(200);

        FreeAndNil(RES);
    end;

    // strains

    OutFile := Path+'\OpenSees\Quad_strain.out';

    if FileExists(OutFile) then
    begin
        write('Reading quad strains ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Quad')+1],3,10));  // number of quads

        StrToArray(TCL[TCL.IndexOf('# Quad')+2],Tag,n,true);  // read all tags

        RES := TStringList.Create;
        RES.LoadFromFile(OutFile);

        for i := 0 to RES.Count-1 do  // for all steps
        begin
            MSH.Add('');
            MSH.Add('Result "Elements//Quad//Strains" "'+AnalType+'" '+IntToStr(i+1)+' Matrix OnGaussPoints "Quad_GP"');
            MSH.Add('ComponentNames "e11" "e22" "e33 (zero)" "e12" "e23 (zero)" "e13 (zero)"');
            MSH.Add('Unit "m-1"');
            MSH.Add('Values');

            StrToArray(RES[i],Str,4*3*n,true);  // read all values from current step (3 values per gauss point)

            for j := 0 to n-1 do
            begin
                s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                for k := 0 to 3 do  // 4 gauss points
                begin
                    s := s + Str[3*(4*j+k)] + ' ' + Str[3*(4*j+k)+1] + ' 0 ' + Str[3*(4*j+k)+2] + ' 0 0';  // positions 0,1,2

                    MSH.Add(s);

                    s := StringOfChar(' ',INDENT);
                end;
            end;

            MSH.Add('End Values');

            write('.')
        end;

        writeln;

        Sleep(200);

        FreeAndNil(RES);
    end;

    //
    // Triangular
    //

    // forces

    OutFile := Path+'\OpenSees\Tri31_force.out';

    if FileExists(OutFile) then
    begin
        write('Reading triangular forces ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Tri31')+1],3,10));  // number of quads

        StrToArray(TCL[TCL.IndexOf('# Tri31')+2],Tag,n,true);  // read all tags

        RES := TStringList.Create;
        RES.LoadFromFile(OutFile);

        for i := 0 to RES.Count-1 do  // for all steps
        begin
            MSH.Add('');
            MSH.Add('Result "Elements//Triangular//Forces" "'+AnalType+'" '+IntToStr(i+1)+' Vector OnGaussPoints "Tri31_Node"');
            MSH.Add('ComponentNames "Fx" "Fy" "Fz (zero)"');
            MSH.Add('Unit "kN"');
            MSH.Add('Values');

            StrToArray(RES[i],Str,3*2*n,true);  // read all values from current step (2 values per node)

            for j := 0 to n-1 do
            begin
                s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j]));

                for k := 0 to 2 do  // 3 nodes
                begin
                    s := s + Str[2*(3*j+k)] + ' ' + Str[2*(3*j+k)+1] + ' 0';  // positions 0,1,2

                    MSH.Add(s);

                    s := StringOfChar(' ',INDENT);
                end;
            end;

            MSH.Add('End Values');

            write('.');
        end;

        writeln;

        Sleep(200);

        FreeAndNil(RES);
    end;

    // stresses

    OutFile := Path+'\OpenSees\Tri31_stress.out';

    if FileExists(OutFile) then
    begin
        write('Reading triangular stresses ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Tri31')+1],3,10));  // number of quads

        StrToArray(TCL[TCL.IndexOf('# Tri31')+2],Tag,n,true);  // read all tags

        RES := TStringList.Create;
        RES.LoadFromFile(OutFile);

        for i := 0 to RES.Count-1 do  // for all steps
        begin
            MSH.Add('');
            MSH.Add('Result "Elements//Triangular//Stresses" "'+AnalType+'" '+IntToStr(i+1)+' Matrix OnGaussPoints "Tri31_GP"');
            MSH.Add('ComponentNames "s11" "s22" "s33 (zero)" "s12" "s23 (zero)" "s13 (zero)"');
            MSH.Add('Unit "kPa"');
            MSH.Add('Values');

            StrToArray(RES[i],Str,3*n,true);  // read all values from current step (3 values per gauss point)

            for j := 0 to n-1 do
            begin
                s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[3*j] + ' ' + Str[3*j+1] + ' 0 ' + Str[3*j+2] + ' 0 0';  // positions 0,1,2

                MSH.Add(s);
            end;

            MSH.Add('End Values');

            write('.');
        end;

        writeln;

        Sleep(200);

        FreeAndNil(RES);
    end;

    //
    // Truss
    //

    OutFile := Path+'\OpenSees\Truss_axialForce.out';

    if FileExists(OutFile) then
    begin
        write('Reading truss forces ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# Truss')+1],3,10));  // number of trusses

        StrToArray(TCL[TCL.IndexOf('# Truss')+2],Tag,n,true);  // read all tags

        RES := TStringList.Create;
        RES.LoadFromFile(OutFile);

        for i := 0 to RES.Count-1 do  // for all steps
        begin
            MSH.Add('');
            MSH.Add('Result "Elements//Truss//Axial" "'+AnalType+'" '+IntToStr(i+1)+' Scalar OnGaussPoints "Line_Nodes"');
            MSH.Add('Unit "kN"');
            MSH.Add('Values');

            StrToArray(RES[i],Str,n,true);  // read all values from current step (1 value per element)

            for j := 0 to n-1 do
            begin
                s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[j];

                MSH.Add(s);

                s := StringOfChar(' ',INDENT) + Str[j];

                MSH.Add(s);
            end;

            MSH.Add('End Values');

            write('.');
        end;

        writeln;

        Sleep(200);

        FreeAndNil(RES);
    end;

    //
    // Corotational Truss
    //

    OutFile := Path+'\OpenSees\CorotTruss_axialForce.out';

    if FileExists(OutFile) then
    begin
        write('Reading corotational truss forces ');

        n := StrToInt(Copy(TCL[TCL.IndexOf('# CorotTruss')+1],3,10));  // number of corotational trusses

        StrToArray(TCL[TCL.IndexOf('# CorotTruss')+2],Tag,n,true);  // read all tags

        RES := TStringList.Create;
        RES.LoadFromFile(OutFile);

        // axial force

        for i := 0 to RES.Count-1 do  // for all steps
        begin
            MSH.Add('');
            MSH.Add('Result "Elements//Corotational_Truss//Axial" "'+AnalType+'" '+IntToStr(i+1)+' Scalar OnGaussPoints "Line_Nodes"');
            MSH.Add('Unit "kN"');
            MSH.Add('Values');

            StrToArray(RES[i],Str,n,true);  // read all values from current step (1 value per element)

            for j := 0 to n-1 do
            begin
                s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[j];

                MSH.Add(s);

                s := StringOfChar(' ',INDENT) + Str[j];

                MSH.Add(s);
            end;

            MSH.Add('End Values');

            write('.');
        end;

        writeln;

        Sleep(200);

        FreeAndNil(RES);
    end;

    //
    // Elastic beam-column element
    //

    OutFile := Path+'\OpenSees\ElasticBeamColumn_localForce.out';

    if FileExists(OutFile) then
    begin
        write('Reading elastic beam-column forces ');

        s := Copy(TCL[TCL.IndexOf('# ElasticBeamColumn')+1],3,10);

        n := StrToInt(Copy(TCL[TCL.IndexOf('# ElasticBeamColumn')+1],3,10));  // number of elastic beam-column elements

        StrToArray(TCL[TCL.IndexOf('# ElasticBeamColumn')+2],Tag,n,true);  // read all tags

        RES := TStringList.Create;
        RES.LoadFromFile(OutFile);

        for i := 0 to RES.Count-1 do  // for all steps
        begin
            MSH.Add('');

            if ndf = 3 then
            begin
                MSH.Add('ResultGroup "'+AnalType+'" '+IntToStr(i+1)+' OnGaussPoints "Line_Nodes"');
                MSH.Add('ResultDescription "Elements//Elastic_Beam-Column//Actions//N" Scalar');
                MSH.Add('ResultDescription "Elements//Elastic_Beam-Column//Actions//V" Scalar');
                MSH.Add('ResultDescription "Elements//Elastic_Beam-Column//Actions//M" Scalar');

                StrToArray(RES[i],Str,2*3*n,true);  // read all values from current step (3 values per node)
            end;

            if ndf = 6 then
            begin
                MSH.Add('ResultGroup "'+AnalType+'" '+IntToStr(i+1)+' OnGaussPoints "Line_Nodes"');
                MSH.Add('ResultDescription "Elements//Elastic_Beam-Column//Actions//N" Scalar');
                MSH.Add('ResultDescription "Elements//Elastic_Beam-Column//Actions//Vy" Scalar');
                MSH.Add('ResultDescription "Elements//Elastic_Beam-Column//Actions//Vz" Scalar');
                MSH.Add('ResultDescription "Elements//Elastic_Beam-Column//Actions//T" Scalar');
                MSH.Add('ResultDescription "Elements//Elastic_Beam-Column//Actions//My" Scalar');
                MSH.Add('ResultDescription "Elements//Elastic_Beam-Column//Actions//Mz" Scalar');

                StrToArray(RES[i],Str,2*6*n,true);  // read all values from current step (6 values per node)
            end;

            MSH.Add('Unit "kN/kNm"');
            MSH.Add('Values');

            for j := 0 to n-1 do
            begin
                if ndf = 3 then // end1                                     N                         V                     M
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Inv(Str[3*(2*j)]) + ' ' + Str[3*(2*j)+1] + ' '+ Str[3*(2*j)+2];

                    MSH.Add(s); // end2              N                      V                            M

                    s := StringOfChar(' ',INDENT) +  Str[3*(2*j+1)] + ' ' + Inv(Str[3*(2*j+1)+1]) + ' '+ Inv(Str[3*(2*j+1)+2]);

                    MSH.Add(s);
                end;

                if ndf = 6 then // end1                                     Í                         Vy                     Vz                     T                      My                    Mz
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Inv(Str[6*(2*j)]) + ' ' + Str[6*(2*j)+1] + ' ' + Str[6*(2*j)+2] + ' ' + Str[6*(2*j)+3] + ' ' + Str[6*(2*j)+4] + ' '+ Str[6*(2*j)+5];

                    MSH.Add(s); // end2              Í                      Vy                            Vz                            T                             My                           Mz

                    s := StringOfChar(' ',INDENT) +  Str[6*(2*j+1)] + ' ' + Inv(Str[6*(2*j+1)+1]) + ' ' + Inv(Str[6*(2*j+1)+2]) + ' ' + Inv(Str[6*(2*j+1)+3]) + ' ' + Inv(Str[6*(2*j+1)+4]) + ' '+ Inv(Str[6*(2*j+1)+5]);

                    MSH.Add(s);
                end;
            end;

            MSH.Add('End Values');

            write('.');
        end;

        writeln;

        Sleep(200);

        FreeAndNil(RES);
    end;

    //
    // Elastic Timoshenko beam-column element
    //

    OutFile := Path+'\OpenSees\ElasticTimoshenkoBeamColumn_localForce.out';

    if FileExists(OutFile) then
    begin
        write('Reading elastic Timoshenko beam-column forces ');

        s := Copy(TCL[TCL.IndexOf('# ElasticTimoshenkoBeamColumn')+1],3,10);

        n := StrToInt(Copy(TCL[TCL.IndexOf('# ElasticTimoshenkoBeamColumn')+1],3,10));  // number of elastic beam-column elements

        StrToArray(TCL[TCL.IndexOf('# ElasticTimoshenkoBeamColumn')+2],Tag,n,true);  // read all tags

        RES := TStringList.Create;
        RES.LoadFromFile(OutFile);

        for i := 0 to RES.Count-1 do  // for all steps
        begin
            MSH.Add('');

            if ndf = 3 then
            begin
                MSH.Add('ResultGroup "'+AnalType+'" '+IntToStr(i+1)+' OnGaussPoints "Line_Nodes"');
                MSH.Add('ResultDescription "Elements//Elastic_Timoshenko_Beam-Column//Actions//N" Scalar');
                MSH.Add('ResultDescription "Elements//Elastic_Timoshenko_Beam-Column//Actions//V" Scalar');
                MSH.Add('ResultDescription "Elements//Elastic_Timoshenko_Beam-Column//Actions//M" Scalar');

                StrToArray(RES[i],Str,2*3*n,true);  // read all values from current step (3 values per node)
            end;

            if ndf = 6 then
            begin
                MSH.Add('ResultGroup "'+AnalType+'" '+IntToStr(i+1)+' OnGaussPoints "Line_Nodes"');
                MSH.Add('ResultDescription "Elements//Elastic_Timoshenko_Beam-Column//Actions//N" Scalar');
                MSH.Add('ResultDescription "Elements//Elastic_Timoshenko_Beam-Column//Actions//Vy" Scalar');
                MSH.Add('ResultDescription "Elements//Elastic_Timoshenko_Beam-Column//Actions//Vz" Scalar');
                MSH.Add('ResultDescription "Elements//Elastic_Timoshenko_Beam-Column//Actions//T" Scalar');
                MSH.Add('ResultDescription "Elements//Elastic_Timoshenko_Beam-Column//Actions//My" Scalar');
                MSH.Add('ResultDescription "Elements//Elastic_Timoshenko_Beam-Column//Actions//Mz" Scalar');

                StrToArray(RES[i],Str,2*6*n,true);  // read all values from current step (6 values per node)
            end;

            MSH.Add('Unit "kN/kNm"');
            MSH.Add('Values');

            for j := 0 to n-1 do
            begin
                if ndf = 3 then // end1                                     N                         V                     M
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Inv(Str[3*(2*j)]) + ' ' + Str[3*(2*j)+1] + ' '+ Str[3*(2*j)+2];

                    MSH.Add(s); // end2              N                      V                            M

                    s := StringOfChar(' ',INDENT) +  Str[3*(2*j+1)] + ' ' + Inv(Str[3*(2*j+1)+1]) + ' '+ Inv(Str[3*(2*j+1)+2]);

                    MSH.Add(s);
                end;

                if ndf = 6 then // end1                                     Í                         Vy                     Vz                     T                      My                    Mz
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Inv(Str[6*(2*j)]) + ' ' + Str[6*(2*j)+1] + ' ' + Str[6*(2*j)+2] + ' ' + Str[6*(2*j)+3] + ' ' + Str[6*(2*j)+4] + ' '+ Str[6*(2*j)+5];

                    MSH.Add(s); // end2              Í                      Vy                            Vz                            T                             My                           Mz

                    s := StringOfChar(' ',INDENT) +  Str[6*(2*j+1)] + ' ' + Inv(Str[6*(2*j+1)+1]) + ' ' + Inv(Str[6*(2*j+1)+2]) + ' ' + Inv(Str[6*(2*j+1)+3]) + ' ' + Inv(Str[6*(2*j+1)+4]) + ' '+ Inv(Str[6*(2*j+1)+5]);

                    MSH.Add(s);
                end;
            end;

            MSH.Add('End Values');

            write('.');
        end;

        writeln;

        Sleep(200);

        FreeAndNil(RES);
    end;

    //
    // Force-based beam-column element
    //

    // force

    OutFile := Path+'\OpenSees\ForceBeamColumn_localForce.out';

    if FileExists(OutFile) then
    begin
        write('Reading force beam-column forces ');

        s := Copy(TCL[TCL.IndexOf('# ForceBeamColumn')+1],3,10);

        n := StrToInt(Copy(TCL[TCL.IndexOf('# ForceBeamColumn')+1],3,10));  // number of elastic beam-column elements

        StrToArray(TCL[TCL.IndexOf('# ForceBeamColumn')+2],Tag,n,true);  // read all tags

        RES := TStringList.Create;
        RES.LoadFromFile(OutFile);

        for i := 0 to RES.Count-1 do  // for all steps
        begin
            MSH.Add('');

            if ndf = 3 then
            begin
                MSH.Add('ResultGroup "'+AnalType+'" '+IntToStr(i+1)+' OnGaussPoints "Line_Nodes"');
                MSH.Add('ResultDescription "Elements//Force_Beam-Column//Actions//N" Scalar');
                MSH.Add('ResultDescription "Elements//Force_Beam-Column//Actions//V" Scalar');
                MSH.Add('ResultDescription "Elements//Force_Beam-Column//Actions//M" Scalar');

                StrToArray(RES[i],Str,2*3*n,true);  // read all values from current step (3 values per node)
            end;

            if ndf = 6 then
            begin
                MSH.Add('ResultGroup "'+AnalType+'" '+IntToStr(i+1)+' OnGaussPoints "Line_Nodes"');
                MSH.Add('ResultDescription "Elements//Force_Beam-Column//Actions//N" Scalar');
                MSH.Add('ResultDescription "Elements//Force_Beam-Column//Actions//Vy" Scalar');
                MSH.Add('ResultDescription "Elements//Force_Beam-Column//Actions//Vz" Scalar');
                MSH.Add('ResultDescription "Elements//Force_Beam-Column//Actions//T" Scalar');
                MSH.Add('ResultDescription "Elements//Force_Beam-Column//Actions//My" Scalar');
                MSH.Add('ResultDescription "Elements//Force_Beam-Column//Actions//Mz" Scalar');

                StrToArray(RES[i],Str,2*6*n,true);  // read all values from current step (6 values per node)
            end;

            MSH.Add('Unit "m & rad"');
            MSH.Add('Values');

            for j := 0 to n-1 do
            begin
                if ndf = 3 then // end1                                     N                         V                     M
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Inv(Str[3*(2*j)]) + ' ' + Str[3*(2*j)+1] + ' '+ Str[3*(2*j)+2];

                    MSH.Add(s); // end2              N                      V                            M

                    s := StringOfChar(' ',INDENT) +  Str[3*(2*j+1)] + ' ' + Inv(Str[3*(2*j+1)+1]) + ' '+ Inv(Str[3*(2*j+1)+2]);

                    MSH.Add(s);
                end;

                if ndf = 6 then // end1                                     Í                         Vy                     Vz                     T                      My                    Mz
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Inv(Str[6*(2*j)]) + ' ' + Str[6*(2*j)+1] + ' ' + Str[6*(2*j)+2] + ' ' + Str[6*(2*j)+3] + ' ' + Str[6*(2*j)+4] + ' '+ Str[6*(2*j)+5];

                    MSH.Add(s); // end2              Í                      Vy                            Vz                            T                             My                           Mz

                    s := StringOfChar(' ',INDENT) +  Str[6*(2*j+1)] + ' ' + Inv(Str[6*(2*j+1)+1]) + ' ' + Inv(Str[6*(2*j+1)+2]) + ' ' + Inv(Str[6*(2*j+1)+3]) + ' ' + Inv(Str[6*(2*j+1)+4]) + ' '+ Inv(Str[6*(2*j+1)+5]);

                    MSH.Add(s);
                end;
            end;

            MSH.Add('End Values');

            write('.');
        end;

        writeln;

        Sleep(200);

        FreeAndNil(RES);
    end;

    // total deformation

    OutFile := Path+'\OpenSees\ForceBeamColumn_basicDeformation.out';

    if FileExists(OutFile) then
    begin
        write('Reading force beam-column total deformation ');

        s := Copy(TCL[TCL.IndexOf('# ForceBeamColumn')+1],3,10);

        n := StrToInt(Copy(TCL[TCL.IndexOf('# ForceBeamColumn')+1],3,10));  // number of elastic beam-column elements

        StrToArray(TCL[TCL.IndexOf('# ForceBeamColumn')+2],Tag,n,true);  // read all tags

        RES := TStringList.Create;
        RES.LoadFromFile(OutFile);

        for i := 0 to RES.Count-1 do  // for all steps
        begin
            MSH.Add('');

            if ndf = 3 then
            begin
                MSH.Add('ResultGroup "'+AnalType+'" '+IntToStr(i+1)+' OnGaussPoints "Line_Nodes"');
                MSH.Add('ResultDescription "Elements//Force_Beam-Column//Deformations_Total//Axial" Scalar');
                MSH.Add('ResultDescription "Elements//Force_Beam-Column//Deformations_Total//Rotation" Scalar');

                StrToArray(RES[i],Str,3*n,true);  // read all values from current step (3 values per element)
            end;

            if ndf = 6 then
            begin
                MSH.Add('ResultGroup "'+AnalType+'" '+IntToStr(i+1)+' OnGaussPoints "Line_Nodes"');
                MSH.Add('ResultDescription "Elements//Force_Beam-Column//Deformations_Total//Axial" Scalar');
                MSH.Add('ResultDescription "Elements//Force_Beam-Column//Deformations_Total//Rotation_z" Scalar');
                MSH.Add('ResultDescription "Elements//Force_Beam-Column//Deformations_Total//Rotation_y" Scalar');
                MSH.Add('ResultDescription "Elements//Force_Beam-Column//Deformations_Total//Torsional" Scalar');

                StrToArray(RES[i],Str,6*n,true);  // read all values from current step (6 values per element)
            end;

            MSH.Add('Unit "m & rad"');
            MSH.Add('Values');

            for j := 0 to n-1 do
            begin
                if ndf = 3 then // end1                                     Axial            Rotation
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[3*j] + ' ' + Str[3*j+1];

                    MSH.Add(s); // end2             Axial            Rotation

                    s := StringOfChar(' ',INDENT) + Str[3*j] + ' ' + Inv(Str[3*j+2]);

                    MSH.Add(s);
                end;

                if ndf = 6 then // end1                                     Axial            Rotation z              Rotation y              Torsional
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[6*j] + ' ' + Inv(Str[6*j+1]) + ' ' + Inv(Str[6*j+3]) + ' ' + Str[6*j+5];

                    MSH.Add(s); // end2              Axial            Rotation z         Rotation y         Torsional

                    s := StringOfChar(' ',INDENT) +  Str[6*j] + ' ' + Str[6*j+2] + ' ' + Str[6*j+4] + ' ' + Str[6*j+5];

                    MSH.Add(s);
                end;
            end;

            MSH.Add('End Values');

            write('.');
        end;

        writeln;

        Sleep(200);

        FreeAndNil(RES);
    end;

    // plastic deformation

    OutFile := Path+'\OpenSees\ForceBeamColumn_plasticDeformation.out';

    if FileExists(OutFile) then
    begin
        write('Reading force beam-column plastic deformation ');

        s := Copy(TCL[TCL.IndexOf('# ForceBeamColumn')+1],3,10);

        n := StrToInt(Copy(TCL[TCL.IndexOf('# ForceBeamColumn')+1],3,10));  // number of elastic beam-column elements

        StrToArray(TCL[TCL.IndexOf('# ForceBeamColumn')+2],Tag,n,true);  // read all tags

        RES := TStringList.Create;
        RES.LoadFromFile(OutFile);

        for i := 0 to RES.Count-1 do  // for all steps
        begin
            MSH.Add('');

            if ndf = 3 then
            begin
                MSH.Add('ResultGroup "'+AnalType+'" '+IntToStr(i+1)+' OnGaussPoints "Line_Nodes"');
                MSH.Add('ResultDescription "Elements//Force_Beam-Column//Deformations_Plastic//Axial" Scalar');
                MSH.Add('ResultDescription "Elements//Force_Beam-Column//Deformations_Plastic//Rotation" Scalar');

                StrToArray(RES[i],Str,3*n,true);  // read all values from current step (3 values per element)
            end;

            if ndf = 6 then
            begin
                MSH.Add('ResultGroup "'+AnalType+'" '+IntToStr(i+1)+' OnGaussPoints "Line_Nodes"');
                MSH.Add('ResultDescription "Elements//Force_Beam-Column//Deformations_Plastic//Axial" Scalar');
                MSH.Add('ResultDescription "Elements//Force_Beam-Column//Deformations_Plastic//Rotation_z" Scalar');
                MSH.Add('ResultDescription "Elements//Force_Beam-Column//Deformations_Plastic//Rotation_y" Scalar');
                MSH.Add('ResultDescription "Elements//Force_Beam-Column//Deformations_Plastic//Torsional" Scalar');

                StrToArray(RES[i],Str,6*n,true);  // read all values from current step (4 values per element)
            end;

            MSH.Add('Unit "m & rad"');
            MSH.Add('Values');

            for j := 0 to n-1 do
            begin
                if ndf = 3 then // end 1                                    Axial            Rotation
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[3*j] + ' ' + Str[3*j+1];

                    MSH.Add(s); // end 2            Axial            Rotation

                    s := StringOfChar(' ',INDENT) + Str[3*j] + ' ' + Inv(Str[3*j+2]);

                    MSH.Add(s);
                end;

                if ndf = 6 then // end1                                     Axial            Rotation z              Rotation y              Torsional
                begin
                    s := Tag[j] + StringOfChar(' ',INDENT-Length(Tag[j])) + Str[6*j] + ' ' + Inv(Str[6*j+1]) + ' ' + Inv(Str[6*j+3]) + ' ' + Str[6*j+5];

                    MSH.Add(s); // end2              Axial            Rotation z         Rotation y         Torsional

                    s := StringOfChar(' ',INDENT) +  Str[6*j] + ' ' + Str[6*j+2] + ' ' + Str[6*j+4] + ' ' + Str[6*j+5];

                    MSH.Add(s);
                end;
            end;

            MSH.Add('End Values');

            write('.');
        end;

        writeln;

        Sleep(200);

        FreeAndNil(RES);
    end;

    //
    // write results and finish
    //

    MSH.SaveToFile(Path+'\'+ModelName+'.post.res');

    FreeAndNil(TCL);
    FreeAndNil(MSH);

    writeln;
    writeln('Conversion complete');

    Sleep(1000);
end.
