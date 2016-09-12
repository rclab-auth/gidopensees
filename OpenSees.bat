rem project name       = %1
rem Project directory  = %2
rem Problem directory  = %3

@echo off

rem Delete files 
cmd /C rmdir /s /q "%2\OpenSees" 

md OpenSees

move "%2\%1.dat" "%2\OpenSees\%1.tcl"

cmd /C start /w "%3\exe\OpenSees.exe" "%2\OpenSees\%1.tcl"

rem Moving files to the OpenSees folder
move "%2\log.txt" "%2\OpenSees\%1.log"
move "%2\NodesDisp3D.out" "%2\OpenSees\NodesDisp3D.out"
move "%2\NodesDisp2D.out" "%2\OpenSees\NodesDisp2D.out"
move "%2\ElemForces.out" "%2\OpenSees\ElemForces.out"
move "%2\ElemForces2d.out" "%2\OpenSees\ElemForces2d.out"
move "%2\ElemStresses.out" "%2\OpenSees\ElemStresses.out"
move "%2\HexahedraBrickElemStresses.out" "%2\OpenSees\HexahedraBrickElemStresses.out"
move "%2\HexahedraBrickElemStrains.out" "%2\OpenSees\HexahedraBrickElemStrains.out"
move "%2\HexahedraBrickElemForces.out" "%2\OpenSees\HexahedraBrickElemForces.out"
move "%2\modes" "%2\OpenSees"
move "%2\NumOfEigenValues.out" "%2\OpenSees\NumOfEigenValues.out"
move "%2\QuadStresses.out" "%2\OpenSees\QuadStresses.out"
move "%2\QuadForces.out" "%2\OpenSees\QuadForces.out"
move "%2\ShellForces.out" "%2\OpenSees\ShellForces.out"
move "%2\ShellStresses.out" "%2\OpenSees\ShellStresses.out"

copy "%3\exe\OpenSeesPost.exe" "%2\OpenSees\OpenSeesPost.exe"

cd %2\OpenSees

cmd /C start /w "%2\OpenSees\OpenSeesPost.exe"

move "%2\OpenSees\OpenSees.post.res" "%2\%1.post.res"

if exist OpenSeesPost.exe del OpenSeesPost.exe