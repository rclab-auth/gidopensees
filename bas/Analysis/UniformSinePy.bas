*if(strcmp(IntvData(Ground_motion_direction),"Ux")==0)
GMdirection = 1
*elseif(strcmp(IntvData(Ground_motion_direction),"Uy")==0)
GMdirection = 2
*elseif(strcmp(IntvData(Ground_motion_direction),"Uz")==0)
GMdirection = 3
*elseif(strcmp(IntvData(Ground_motion_direction),"Rx")==0)
GMdirection = 4
*elseif(strcmp(IntvData(Ground_motion_direction),"Ry")==0)
GMdirection = 5
*elseif(strcmp(IntvData(Ground_motion_direction),"Rz")==0)
GMdirection = 6
*endif
*format "%g"
GMSineAmpl = *IntvData(Acceleration_Amplitude,real)
*format "%g"
TPeriodSine = *IntvData(Period,real)
*format "%g"
DurationSine = *IntvData(Duration,real)
*format "%g"
DtAnalysis = *IntvData(Analysis_time_step,real)
*format "%g"
TmaxAnalysis = *IntvData(Analysis_duration,real)
*format "%g"
Shift = *IntvData(Shift,real)
*set var IDGMLoadPatternTag=operation(100*IntvNum+50)
ops.timeSeries("Trig", 0, DurationSine, TPeriodSine, "-factor", GMSineAmpl, "-shift", Shift)
*format "%d%g"
ops.pattern("UniformExcitation", *IDGMLoadPatternTag, GMdirection, "-accel", 0, "-vel0", *IntvData(Initial_velocity,real))
*include SolutionAlgorithmsDynamicPy.bas