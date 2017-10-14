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
*if(strcmp(IntvData(Convergence_criterion),"Norm_Unbalance")==0)
variable testTypeDynamic NormUnbalance
*elseif(strcmp(IntvData(Convergence_criterion),"Norm_Displacement_Increment")==0)
variable testTypeDynamic NormDispIncr
*elseif(strcmp(IntvData(Convergence_criterion),"Energy_Increment")==0)
variable testTypeDynamic EnergyIncr
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Unbalance")==0)
variable testTypeDynamic RelativeNormUnbalance
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Displacement_Increment")==0)
variable testTypeDynamic RelativeNormDispIncr
*elseif(strcmp(IntvData(Convergence_criterion),"Total_Relative_Norm_Displacement_Increment")==0)
variable testTypeDynamic RelativeTotalNormDispIncr
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Energy_Increment")==0)
variable testTypeDynamic RelativeEnergyIncr
*elseif(strcmp(IntvData(Convergence_criterion),"Fixed_Number_of_Iterations")==0)
variable testTypeDynamic FixedNumIter
*endif
*format "%g"
variable TolDynamic *IntvData(Tolerance,real);
variable maxNumIterDynamic *IntvData(Max_Iterations_per_Step,int);
*if(strcmp(IntvData(Solution_algorithm),"Full_Newton-Raphson")==0)
variable algorithmTypeDynamic Newton
*elseif(strcmp(IntvData(Solution_algorithm),"Modified_Newton-Raphson")==0)
variable algorithmTypeDynamic ModifiedNewton
*elseif(strcmp(IntvData(Solution_algorithm),"Newton-Raphson_with_line_search")==0)
variable algorithmTypeDynamic NewtonLineSearch
*elseif(strcmp(IntvData(Solution_algorithm),"Broyden")==0)
variable algorithmTypeDynamic Broyden
*elseif(strcmp(IntvData(Solution_algorithm),"BFGS")==0)
variable algorithmTypeDynamic BFGS
*elseif(strcmp(IntvData(Solution_algorithm),"KrylovNewton")==0)
variable algorithmTypeDynamic KrylovNewton
*endif
set Nsteps [expr int($TmaxAnalysis/$DtAnalysis)];
set AnalOk [analyze $Nsteps $DtAnalysis]; # perform analysis - returns 0 if analysis was successful

if {$AnalOk != 0} { ; # analysis was not successful.
    # --------------------------------------------------------------------------------------------------
    # change some analysis parameters to achieve convergence
    # performance is slower inside this loop
    # Time-controlled analysis
    set AnalOk 0;
    set controlTime [getTime]; # returns the current time in the domain
    while {$controlTime < $TmaxAnalysis && $AnalOk == 0} {
        set controlTime [getTime]
        set AnalOk [analyze 1 $DtAnalysis]
        if {$AnalOk != 0} {
            puts "\nTrying Newton with Initial Tangent\n"
            test NormDispIncr   $TolDynamic 2000  *LoggingFlag
            algorithm Newton -initial
            set AnalOk [analyze 1 $DtAnalysis]
            test $testTypeDynamic $TolDynamic $maxNumIterDynamic  *LoggingFlag
            algorithm $algorithmTypeDynamic
        }
        if {$AnalOk != 0} {
            puts "\nTrying Broyden\n"
            algorithm Broyden 8
            set AnalOk [analyze 1 $DtAnalysis]
            algorithm $algorithmTypeDynamic
        }
        if {$AnalOk != 0} {
            puts "\nTrying NewtonWithLineSearch\n"
            algorithm NewtonLineSearch .8
            set AnalOk [analyze 1 $DtAnalysis]
            algorithm $algorithmTypeDynamic
        }
    }
}; # end if Analok !0

if {$AnalOk == 0} {
    puts "\nAnalysis completed SUCCESSFULLY\n"
} else {
    puts "\nAnalysis FAILED\n"
}