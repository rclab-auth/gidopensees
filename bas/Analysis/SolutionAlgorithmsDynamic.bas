
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
variable TolDynamic *IntvData(Tolerance,real)
variable maxNumIterDynamic *IntvData(Max_Iterations_per_Step,int)
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
set committedSteps 1
set Nsteps [expr int($TmaxAnalysis/$DtAnalysis)]
for {set i 1} { $i <= $Nsteps } {incr i 1} {
    set t [format "%7.5f" [expr [getTime] + $DtAnalysis]]
    puts -nonewline "Time (*IntvNum)$t "
    set AnalOk [analyze 1 $DtAnalysis]; # perform analysis - returns 0 if analysis was successful
    if {$AnalOk == 0} {
        set committedSteps [expr $committedSteps+1]
    } else {
        break
    }
}

if {$AnalOk != 0} { ; # analysis was not successful
    # --------------------------------------------------------------------------------------------------
    # change some analysis parameters to achieve convergence
    # performance is slower inside this loop
    # Time-controlled analysis
    set AnalOk 0
    set controlTime [getTime]
    set Nk 1; # dt = dt/Nk
    set returnToInitStepFlag 0
*if(IntvData(Tolerance_relaxation,int)==1)
    set InitialTolFlag 1
    set returnToInitTolFlag 0
    set ChangeToleranceFlag 0
    set SkipFirstLoopForToleranceRelaxFlag 1
*endif
    while {$controlTime < $TmaxAnalysis && $AnalOk == 0} {
        if { ($Nk == 1 && $AnalOk == 0) || ($Nk == 2 && $AnalOk == 0) } {
        set Nk 1
            if {$returnToInitStepFlag} {
                puts "\nBack to initial time step ..\n"
                set returnToInitStepFlag 0
            }
*if(IntvData(Tolerance_relaxation,int)==1)
            if {$returnToInitTolFlag} {
            if {!$InitialTolFlag} {
            puts "\nBack to initial error tolerance ..\n"
*format "%g"
                set TolDynamic [expr $TolDynamic/*IntvData(Relaxation_factor,real)]
                set InitialTolFlag 1
*if(strcmp(IntvData(Convergence_criterion),"Norm_Unbalance")==0)
*format "%d"
test NormUnbalance $TolDynamic *IntvData(Max_Iterations_per_Step,int) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Norm_Displacement_Increment")==0)
*format "%d"
test NormDispIncr $TolDynamic *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Energy_Increment")==0)
*format "%d"
test EnergyIncr $TolDynamic *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Unbalance")==0)
*format "%d"
test RelativeNormUnbalance $TolDynamic *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Displacement_Increment")==0)
*format "%d"
test RelativeNormDispIncr $TolDynamic *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Total_Relative_Norm_Displacement_Increment")==0)
*format "%d"
test RelativeTotalNormDispIncr $TolDynamic *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Energy_Increment")==0)
*format "%d"
test RelativeEnergyIncr $TolDynamic *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Fixed_Number_of_Iterations")==0)
*format "%d"
test FixedNumIter *IntvData(Max_Iterations_per_Step) *LoggingFlag
*endif
            }
            } else {
                if {$InitialTolFlag && $ChangeToleranceFlag && !$SkipFirstLoopForToleranceRelaxFlag} {
*format "%g"
                puts "\nTolerance is multiplied by *IntvData(Relaxation_factor,real) \n"
*format "%g"
                set TolDynamic [expr $TolDynamic***IntvData(Relaxation_factor,real)]
                set InitialTolFlag 0
*if(strcmp(IntvData(Convergence_criterion),"Norm_Unbalance")==0)
*format "%d"
test NormUnbalance $TolDynamic *IntvData(Max_Iterations_per_Step,int) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Norm_Displacement_Increment")==0)
*format "%d"
test NormDispIncr $TolDynamic *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Energy_Increment")==0)
*format "%d"
test EnergyIncr $TolDynamic *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Unbalance")==0)
*format "%d"
test RelativeNormUnbalance $TolDynamic *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Displacement_Increment")==0)
*format "%d"
test RelativeNormDispIncr $TolDynamic *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Total_Relative_Norm_Displacement_Increment")==0)
*format "%d"
test RelativeTotalNormDispIncr $TolDynamic *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Energy_Increment")==0)
*format "%d"
test RelativeEnergyIncr $TolDynamic *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Fixed_Number_of_Iterations")==0)
*format "%d"
test FixedNumIter *IntvData(Max_Iterations_per_Step) *LoggingFlag
*endif
                }
            }
set SkipFirstLoopForToleranceRelaxFlag 0
*endif
        set t [format "%7.5f" [expr [getTime] + $DtAnalysis]]
        puts -nonewline "Time (*IntvNum)$t "
        set AnalOk [analyze 1 $DtAnalysis]
*if((strcmp(IntvData(Solution_algorithm),"Full_Newton-Raphson")==0 && IntvData(Use_initial_stiffness_iterations,int)==0 ) || strcmp(IntvData(Solution_algorithm),"Newton-Raphson_with_line_search")==0 || strcmp(IntvData(Solution_algorithm),"BFGS")==0 || strcmp(IntvData(Solution_algorithm),"Broyden")==0 || strcmp(IntvData(Solution_algorithm),"KrylovNewton")==0)
            if {$AnalOk != 0} {
                puts "\nTrying Newton-Raphson with Initial Stiffness \n"
                test NormDispIncr $TolDynamic $maxNumIterDynamic  *LoggingFlag
                algorithm Newton -initial
                set t [format "%7.5f" [expr [getTime] + $DtAnalysis]]
                puts -nonewline "Time (*IntvNum)$t "
                set AnalOk [analyze 1 $DtAnalysis]
                test $testTypeDynamic $TolDynamic $maxNumIterDynamic *LoggingFlag
                algorithm $algorithmTypeDynamic
            }
*endif
*if(strcmp(IntvData(Solution_algorithm),"Modified_Newton-Raphson")==0 && IntvData(Use_initial_stiffness_iterations,int)==0)
            if {$AnalOk != 0} {
                puts "\nTrying Modified Newton-Raphson with Initial Stiffness \n"
                test NormDispIncr $TolDynamic $maxNumIterDynamic  *LoggingFlag
                algorithm ModifiedNewton -initial
                set t [format "%7.5f" [expr [getTime] + $DtAnalysis]]
                puts -nonewline "Time (*IntvNum)$t "
                set AnalOk [analyze 1 $DtAnalysis]
                test $testTypeDynamic $TolDynamic $maxNumIterDynamic *LoggingFlag
                algorithm $algorithmTypeDynamic
            }
*endif
            if {$AnalOk == 0} {
                set committedSteps [expr $committedSteps+1]
            }
        }
        if {($Nk == 1 && $AnalOk!=0) || ($Nk == 4 && $AnalOk==0)} {
            set Nk 2.0
            set continueFlag 1
puts "\nInitial time step is divided by 2 ..\n"
            set currTime1 [getTime]
            set curStep [expr int($currTime1/$DtAnalysis)]
            set remStep1 [expr int(($Nsteps-$curStep)**2.0)]
            set ReducedDtAnalysis [expr $DtAnalysis/2.0]
            for {set ik 1} {$ik <= $Nk} {incr ik 1} {
                if {$continueFlag==0} {
                    break
                }
            set t [format "%7.5f" [expr [getTime] + $ReducedDtAnalysis]]
            puts -nonewline "Time (*IntvNum)$t "
            set AnalOk [analyze 1 $ReducedDtAnalysis]
*if((strcmp(IntvData(Solution_algorithm),"Full_Newton-Raphson")==0 && IntvData(Use_initial_stiffness_iterations,int)==0 ) || strcmp(IntvData(Solution_algorithm),"Newton-Raphson_with_line_search")==0 || strcmp(IntvData(Solution_algorithm),"BFGS")==0 || strcmp(IntvData(Solution_algorithm),"Broyden")==0 || strcmp(IntvData(Solution_algorithm),"KrylovNewton")==0)
            if {$AnalOk != 0} {
                puts "\nTrying Newton-Raphson with Initial Stiffness \n"
                test NormDispIncr $TolDynamic $maxNumIterDynamic  *LoggingFlag
                algorithm Newton -initial
                set t [format "%7.5f" [expr [getTime] + $ReducedDtAnalysis]]
                puts -nonewline "Time (*IntvNum)$t "
                set AnalOk [analyze 1 $ReducedDtAnalysis]
                test $testTypeDynamic $TolDynamic $maxNumIterDynamic *LoggingFlag
                algorithm $algorithmTypeDynamic
            }
*endif
*if(strcmp(IntvData(Solution_algorithm),"Modified_Newton-Raphson")==0 && IntvData(Use_initial_stiffness_iterations,int)==0)
            if {$AnalOk != 0} {
                puts "\nTrying Modified Newton-Raphson with Initial Stiffness \n"
                test NormDispIncr $TolDynamic $maxNumIterDynamic  *LoggingFlag
                algorithm ModifiedNewton -initial
                set t [format "%7.5f" [expr [getTime] + $ReducedDtAnalysis]]
                puts -nonewline "Time (*IntvNum)$t "
                set AnalOk [analyze 1 $ReducedDtAnalysis]
                test $testTypeDynamic $TolDynamic $maxNumIterDynamic *LoggingFlag
                algorithm $algorithmTypeDynamic
            }
*endif
                if {$AnalOk == 0} {
                    set committedSteps [expr $committedSteps+1]
                } else {
                    set continueFlag 0
                }
            }
        if {$AnalOk == 0} {
            set returnToInitStepFlag 1
        }
        }
*if(IntvData(Tolerance_relaxation,int)==1)
*if(strcmp(IntvData(Tolerance_relaxation_after_failed_substepping_of),"/2")==0)
if {$AnalOk != 0 } {
        if {$InitialTolFlag} {

            set Nk 1; # go back to initial step and there tolerance is updated
            set AnalOk 0
            set returnToInitStepFlag 1
            set ChangeToleranceFlag 1
            set returnToInitTolFlag 0
        }
} else {
    if {!$InitialTolFlag} {

        set Nk 1
        set returnToInitTolFlag 1

    }
}
*endif
*endif
        if {($Nk == 2 && $AnalOk!=0) || ($Nk == 8 && $AnalOk == 0)} {
            set Nk 4.0
            set continueFlag 1
puts "\nInitial time step is divided by 4 ..\n"
            set currTime2 [getTime]
            set curStep [expr ($currTime2-$currTime1)/$ReducedDtAnalysis]
            set remStep2 [expr int(($remStep1-$curStep)**2.0)]
            set ReducedDtAnalysis [expr $ReducedDtAnalysis/2.0]
            for {set ik 1} {$ik <= $Nk} {incr ik 1} {
                if {$continueFlag==0} {
                    break
                }
                set t [format "%7.5f" [expr [getTime] + $ReducedDtAnalysis]]
                puts -nonewline "Time (*IntvNum)$t "
                set AnalOk [analyze 1 $ReducedDtAnalysis]
*if((strcmp(IntvData(Solution_algorithm),"Full_Newton-Raphson")==0 && IntvData(Use_initial_stiffness_iterations,int)==0 ) || strcmp(IntvData(Solution_algorithm),"Newton-Raphson_with_line_search")==0 || strcmp(IntvData(Solution_algorithm),"BFGS")==0 || strcmp(IntvData(Solution_algorithm),"Broyden")==0 || strcmp(IntvData(Solution_algorithm),"KrylovNewton")==0)
            if {$AnalOk != 0} {
                puts "\nTrying Newton-Raphson with Initial Stiffness \n"
                test NormDispIncr $TolDynamic $maxNumIterDynamic  *LoggingFlag
                algorithm Newton -initial
                set t [format "%7.5f" [expr [getTime] + $ReducedDtAnalysis]]
                puts -nonewline "Time (*IntvNum)$t "
                set AnalOk [analyze 1 $ReducedDtAnalysis]
                test $testTypeDynamic $TolDynamic $maxNumIterDynamic *LoggingFlag
                algorithm $algorithmTypeDynamic
            }
*endif
*if(strcmp(IntvData(Solution_algorithm),"Modified_Newton-Raphson")==0 && IntvData(Use_initial_stiffness_iterations,int)==0)
            if {$AnalOk != 0} {
                puts "\nTrying Modified Newton-Raphson with Initial Stiffness \n"
                test NormDispIncr $TolDynamic $maxNumIterDynamic  *LoggingFlag
                algorithm ModifiedNewton -initial
                set t [format "%7.5f" [expr [getTime] + $ReducedDtAnalysis]]
                puts -nonewline "Time (*IntvNum)$t "
                set AnalOk [analyze 1 $ReducedDtAnalysis]
                test $testTypeDynamic $TolDynamic $maxNumIterDynamic *LoggingFlag
                algorithm $algorithmTypeDynamic
            }
*endif
                if {$AnalOk == 0} {
                    set committedSteps [expr $committedSteps+1]
                } else {
                    set continueFlag 0
                }
            }
        if {$AnalOk == 0} {
            set returnToInitStepFlag 1
        }
        }
*if(IntvData(Tolerance_relaxation,int)==1)
*if(strcmp(IntvData(Tolerance_relaxation_after_failed_substepping_of),"/4")==0)
if {$AnalOk != 0 } {
        if {$InitialTolFlag} {

            set Nk 1; # go back to initial step and there tolerance is updated
            set AnalOk 0
            set returnToInitStepFlag 1
            set ChangeToleranceFlag 1
            set returnToInitTolFlag 0
        }
} else {
    if {!$InitialTolFlag} {

        set Nk 1
        set returnToInitTolFlag 1

    }
}
*endif
*endif
        if {($Nk == 4 && $AnalOk!=0) || ($Nk == 16 && $AnalOk == 0)} {
            set Nk 8.0
            set continueFlag 1
puts "\nInitial time step is divided by 8 ..\n"
            set currTime3 [getTime]
            set curStep [expr ($currTime3-$currTime2)/$ReducedDtAnalysis]
            set remStep3 [expr int(($remStep2-$curStep)**2.0)]
            set ReducedDtAnalysis [expr $ReducedDtAnalysis/2.0]
            for {set ik 1} {$ik <= $Nk} {incr ik 1} {
                if {$continueFlag==0} {
                    break
                }
                set t [format "%7.5f" [expr [getTime] + $ReducedDtAnalysis]]
                puts -nonewline "Time (*IntvNum)$t "
                set AnalOk [analyze 1 $ReducedDtAnalysis]
*if((strcmp(IntvData(Solution_algorithm),"Full_Newton-Raphson")==0 && IntvData(Use_initial_stiffness_iterations,int)==0 ) || strcmp(IntvData(Solution_algorithm),"Newton-Raphson_with_line_search")==0 || strcmp(IntvData(Solution_algorithm),"BFGS")==0 || strcmp(IntvData(Solution_algorithm),"Broyden")==0 || strcmp(IntvData(Solution_algorithm),"KrylovNewton")==0)
            if {$AnalOk != 0} {
                puts "\nTrying Newton-Raphson with Initial Stiffness \n"
                test NormDispIncr $TolDynamic $maxNumIterDynamic  *LoggingFlag
                algorithm Newton -initial
                set t [format "%7.5f" [expr [getTime] + $ReducedDtAnalysis]]
                puts -nonewline "Time (*IntvNum)$t "
                set AnalOk [analyze 1 $ReducedDtAnalysis]
                test $testTypeDynamic $TolDynamic $maxNumIterDynamic *LoggingFlag
                algorithm $algorithmTypeDynamic
            }
*endif
*if(strcmp(IntvData(Solution_algorithm),"Modified_Newton-Raphson")==0 && IntvData(Use_initial_stiffness_iterations,int)==0)
            if {$AnalOk != 0} {
                puts "\nTrying Modified Newton-Raphson with Initial Stiffness \n"
                test NormDispIncr $TolDynamic $maxNumIterDynamic  *LoggingFlag
                algorithm ModifiedNewton -initial
                set t [format "%7.5f" [expr [getTime] + $ReducedDtAnalysis]]
                puts -nonewline "Time (*IntvNum)$t "
                set AnalOk [analyze 1 $ReducedDtAnalysis]
                test $testTypeDynamic $TolDynamic $maxNumIterDynamic *LoggingFlag
                algorithm $algorithmTypeDynamic
            }
*endif
                if {$AnalOk == 0} {
                    set committedSteps [expr $committedSteps+1]
                } else {
                    set continueFlag 0
                }
            }
        if {$AnalOk == 0} {
            set returnToInitStepFlag 1
        }
        }
*if(IntvData(Tolerance_relaxation,int)==1)
*if(strcmp(IntvData(Tolerance_relaxation_after_failed_substepping_of),"/8")==0)
if {$AnalOk != 0 } {
        if {$InitialTolFlag} {

            set Nk 1; # go back to initial step and there tolerance is updated
            set AnalOk 0
            set returnToInitStepFlag 1
            set ChangeToleranceFlag 1
            set returnToInitTolFlag 0
        }
} else {
    if {!$InitialTolFlag} {

        set Nk 1
        set returnToInitTolFlag 1

    }
}
*endif
*endif
        if {($Nk == 8 && $AnalOk!=0)} {
            set Nk 16.0
            set continueFlag 1
puts "\nInitial time step is divided by 16 ..\n"
            set currTime4 [getTime]
            set curStep [expr ($currTime4-$currTime3)/$ReducedDtAnalysis]
            set remStep4 [expr int(($remStep3-$curStep)**2.0)]
            set ReducedDtAnalysis [expr $ReducedDtAnalysis/2.0]
            for {set ik 1} {$ik <= $Nk} {incr ik 1} {
                if {$continueFlag==0} {
                    break
                }
                set t [format "%7.5f" [expr [getTime] + $ReducedDtAnalysis]]
                puts -nonewline "Time (*IntvNum)$t "
                set AnalOk [analyze 1 $ReducedDtAnalysis]
*if((strcmp(IntvData(Solution_algorithm),"Full_Newton-Raphson")==0 && IntvData(Use_initial_stiffness_iterations,int)==0 ) || strcmp(IntvData(Solution_algorithm),"Newton-Raphson_with_line_search")==0 || strcmp(IntvData(Solution_algorithm),"BFGS")==0 || strcmp(IntvData(Solution_algorithm),"Broyden")==0 || strcmp(IntvData(Solution_algorithm),"KrylovNewton")==0)
            if {$AnalOk != 0} {
                puts "\nTrying Newton-Raphson with Initial Stiffness \n"
                test NormDispIncr $TolDynamic $maxNumIterDynamic  *LoggingFlag
                algorithm Newton -initial
                set t [format "%7.5f" [expr [getTime] + $ReducedDtAnalysis]]
                puts -nonewline "Time (*IntvNum)$t "
                set AnalOk [analyze 1 $ReducedDtAnalysis]
                test $testTypeDynamic $TolDynamic $maxNumIterDynamic *LoggingFlag
                algorithm $algorithmTypeDynamic
            }
*endif
*if(strcmp(IntvData(Solution_algorithm),"Modified_Newton-Raphson")==0 && IntvData(Use_initial_stiffness_iterations,int)==0)
            if {$AnalOk != 0} {
                puts "\nTrying Modified Newton-Raphson with Initial Stiffness \n"
                test NormDispIncr $TolDynamic $maxNumIterDynamic  *LoggingFlag
                algorithm ModifiedNewton -initial
                set t [format "%7.5f" [expr [getTime] + $ReducedDtAnalysis]]
                puts -nonewline "Time (*IntvNum)$t "
                set AnalOk [analyze 1 $ReducedDtAnalysis]
                test $testTypeDynamic $TolDynamic $maxNumIterDynamic *LoggingFlag
                algorithm $algorithmTypeDynamic
            }
*endif
                if {$AnalOk == 0} {
                    set committedSteps [expr $committedSteps+1]
                } else {
                    set continueFlag 0
                }
            }
        if {$AnalOk == 0} {
            set returnToInitStepFlag 1
        }
        }
*if(IntvData(Tolerance_relaxation,int)==1)
*if(strcmp(IntvData(Tolerance_relaxation_after_failed_substepping_of),"/16")==0)
if {$AnalOk != 0 } {
        if {$InitialTolFlag} {

            set Nk 1; # go back to initial step and there tolerance is updated
            set AnalOk 0
            set returnToInitStepFlag 1
            set ChangeToleranceFlag 1
            set returnToInitTolFlag 0
        }
} else {
    if {!$InitialTolFlag} {

        set Nk 1
        set returnToInitTolFlag 1

    }
}
*endif
*endif
*# if tolerance relaxation is not enough, break the while loop
*if(IntvData(Tolerance_relaxation,int)==1)
if {$AnalOk != 0 } {

        if {!$InitialTolFlag} {

            break;

        }
}
*endif
    set controlTime [getTime]
    }
}

if {$AnalOk == 0} {
    puts "\nAnalysis completed SUCCESSFULLY"
    puts "Committed steps : $committedSteps\n"
} else {
    puts "\nAnalysis FAILED\n"
    puts "Committed steps : $committedSteps\n"
}