*if(strcmp(IntvData(Ground_motion_direction),"Ux")==0)
set GMdirection 1
*elseif(strcmp(IntvData(Ground_motion_direction),"Uy")==0)
set GMdirection 2
*elseif(strcmp(IntvData(Ground_motion_direction),"Uz")==0)
set GMdirection 3
*elseif(strcmp(IntvData(Ground_motion_direction),"Rx")==0)
set GMdirection 4
*elseif(strcmp(IntvData(Ground_motion_direction),"Ry")==0)
set GMdirection 5
*elseif(strcmp(IntvData(Ground_motion_direction),"Rz")==0)
set GMdirection 6
*endif
*format "%g"
set GMSineAmpl *IntvData(Acceleration_Amplitude,real)
*format "%g"
set TPeriodSine *IntvData(Period,real)
*format "%g"
set DurationSine *IntvData(Duration,real)
*format "%g"
set DtAnalysis *IntvData(Analysis_time_step,real)
*format "%g"
set TmaxAnalysis *IntvData(Analysis_duration,real)
*format "%g"
set Shift *IntvData(Shift,real)
*set var IDGMLoadPatternTag=operation(100*IntvNum+50)
set AccelSeries "Trig 0. $DurationSine  $TPeriodSine -factor $GMSineAmpl -shift $Shift"
*format "%d%g"
pattern UniformExcitation  *IDGMLoadPatternTag  $GMdirection  -accel $AccelSeries -vel0 *IntvData(Initial_velocity,real)
*include SolutionAlgorithmsDynamic.bas