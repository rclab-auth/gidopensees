*format "%g%g"
set DtAnalysis *IntvData(Analysis_time_step,real)
*format "%g%g"
set TmaxAnalysis *IntvData(Analysis_duration,real)
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

if {$AnalOk != 0} { ; # analysis was not successful
    # --------------------------------------------------------------------------------------------------
    # change some analysis parameters to achieve convergence
    # performance is slower inside this loop
    # Time-controlled analysis
    set AnalOk 0;
    set controlTime [getTime];
	set Nk 1; # dt = dt/Nk
    while {$controlTime < $TmaxAnalysis && $AnalOk == 0} {
        set controlTime [getTime]
        if { ($Nk == 1 && $AnalOk == 0) || ($Nk == 2 && $AnalOk == 0) } {
		set Nk 1
        set AnalOk [analyze 1 $DtAnalysis]
            if {$AnalOk != 0} {
                puts "\nTrying Newton with Initial Tangent\n"
                test NormDispIncr $TolDynamic 1000  *LoggingFlag
                algorithm Newton -initial
                set AnalOk [analyze 1 $DtAnalysis]
                test $testTypeDynamic $TolDynamic $maxNumIterDynamic *LoggingFlag
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

		if {($Nk == 1 && $AnalOk!=0) || ($Nk == 4 && $AnalOk==0)} {
			set Nk 2.0
            set curTime [getTime]
            set curStep [expr int($curTime/$DtAnalysis)]
            set remStep [expr int(($Nsteps-$curStep)**2.0)]
            set ReducedDtAnalysis [expr $DtAnalysis/2.0]
            for {set ik 1} {$ik <= $Nk} {incr ik 1} {
            set AnalOk [analyze 1 $ReducedDtAnalysis]
                if {$AnalOk != 0} {
                    puts "\nTrying Newton with Initial Tangent\n"
                    test NormDispIncr $TolDynamic 1000  *LoggingFlag
                    algorithm Newton -initial
                    set AnalOk [analyze 1 $ReducedDtAnalysis]
                    test $testTypeDynamic $TolDynamic $maxNumIterDynamic *LoggingFlag
                    algorithm $algorithmTypeDynamic
                }
                if {$AnalOk != 0} {
                    puts "\nTrying Broyden\n"
                    algorithm Broyden 8
                    set AnalOk [analyze 1 $ReducedDtAnalysis]
                    algorithm $algorithmTypeDynamic
                }
                if {$AnalOk != 0} {
                    puts "\nTrying NewtonWithLineSearch\n"
                    algorithm NewtonLineSearch .8
                    set AnalOk [analyze 1 $ReducedDtAnalysis]
                    algorithm $algorithmTypeDynamic
                }
            }
        }

        if {($Nk == 2 && $AnalOk!=0)} {
            set Nk 4.0
            set currTime [getTime]
            set curStep [expr ($currTime-$curTime)/$ReducedDtAnalysis]
            set remainStep [expr int(($remStep-$curStep)**2.0)]
            set ReducedDtAnalysis [expr $ReducedDtAnalysis/2.0]
            for {set ik 1} {$ik <= $Nk} {incr ik 1} {
                set AnalOk [analyze 1 $ReducedDtAnalysis]
                if {$AnalOk != 0} {
                    puts "\nTrying Newton with Initial Tangent\n"
                    test NormDispIncr $TolDynamic 1000  *LoggingFlag
                    algorithm Newton -initial
                    set AnalOk [analyze 1 $ReducedDtAnalysis]
                    test $testTypeDynamic $TolDynamic $maxNumIterDynamic *LoggingFlag
                    algorithm $algorithmTypeDynamic
				}
                if {$AnalOk != 0} {
                    puts "\nTrying Broyden\n"
                    algorithm Broyden 8
                    set AnalOk [analyze 1 $ReducedDtAnalysis]
                    algorithm $algorithmTypeDynamic
				}
                if {$AnalOk != 0} {
                    puts "\nTrying NewtonWithLineSearch\n"
                    algorithm NewtonLineSearch .8
                    set AnalOk [analyze 1 $ReducedDtAnalysis]
                    algorithm $algorithmTypeDynamic
                }
            }
        }
    }
}; # end if ok !

if {$AnalOk == 0} {
    puts "\nAnalysis completed SUCCESSFULLY\n"
} else {
    puts "\nAnalysis FAILED\n"
}