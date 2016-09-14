rem Project name       = %1
rem Project directory  = %2
rem Problem directory  = %3

@echo off

rem delete previous OpenSees folder

cmd /C rmdir /s /q "%2\OpenSees"

rem create new OpenSees folder 

md OpenSees

rem move data file to OpenSees folder

move "%2\%1.dat" "%2\OpenSees\%1.tcl"

cd OpenSees

rem run OpenSees

cmd /C start /w "C:\OpenSees\OpenSees.exe" "%2\OpenSees\%1.tcl"

rem run OpenSeesPost

%3\exe\OpenSeesPost.exe "%1" "%2"