
set committedSteps 1
set Nsteps [expr int($TmaxAnalysis/$DtAnalysis)]

set strIni {}
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
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
set strIni "/Ini"
*endif
*elseif(strcmp(IntvData(Solution_algorithm),"Modified_Newton-Raphson")==0)
variable algorithmTypeDynamic ModifiedNewton
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
set strIni "/Ini"
*endif
*elseif(strcmp(IntvData(Solution_algorithm),"Newton-Raphson_with_line_search")==0)
variable algorithmTypeDynamic NewtonLineSearch
*elseif(strcmp(IntvData(Solution_algorithm),"Broyden")==0)
variable algorithmTypeDynamic Broyden
*elseif(strcmp(IntvData(Solution_algorithm),"BFGS")==0)
variable algorithmTypeDynamic BFGS
*elseif(strcmp(IntvData(Solution_algorithm),"KrylovNewton")==0)
variable algorithmTypeDynamic KrylovNewton
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
set strIni "/Ini"
*endif
*endif

for {set i 1} { $i <= $Nsteps } {incr i 1} {
    set t [format "%7.5f" [expr [getTime] + $DtAnalysis]]
*if(PrintTime==1)
    puts -nonewline "(*IntvNum) $algorithmTypeDynamic$strIni Time $t "
*endif
    set AnalOk [analyze 1 $DtAnalysis]; # perform analysis - returns 0 if analysis was successful
    if {$AnalOk == 0} {
        set committedSteps [expr $committedSteps+1]
    } else {
        break
    }
}

if {$AnalOk != 0} {; # if analysis fails, alternative algorithms and substepping is applied
    set firstFail 1
    set AnalOk 0
    set controlTime [getTime]
    set Nk 1; # dt = dt/Nk
    set returnToInitStepFlag 0
*if(IntvData(Tolerance_relaxation,int)==1)
    set InitialTolFlag 1
    set returnToInitTolFlag 0
    set ChangeToleranceFlag 0
    set SkipFirstLoopForTolRelaxFlag 1
*endif
    while {$controlTime < $TmaxAnalysis && $AnalOk == 0} {
        if { ($Nk == 1 && $AnalOk == 0) || ($Nk == 2 && $AnalOk == 0) } {
            set Nk 1
            if {$returnToInitStepFlag} {
                puts "\nBack to initial step\n"
                set returnToInitStepFlag 0
            }
*if(IntvData(Tolerance_relaxation,int)==1)
            if {$returnToInitTolFlag} {
                if {!$InitialTolFlag} {
                    puts "\nBack to initial error tolerance\n"
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
                if {$InitialTolFlag && $ChangeToleranceFlag && !$SkipFirstLoopForTolRelaxFlag} {
*format "%g"
                    puts "Tolerance is multiplied by *IntvData(Relaxation_factor,real)\n"
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
            set SkipFirstLoopForTolRelaxFlag 0
*endif
            if {$firstFail == 0} {; # for the first time only, do not repeat previous failed step
                set t [format "%7.5f" [expr [getTime] + $DtAnalysis]]
*if(PrintTime==1)
                puts -nonewline "(*IntvNum) $algorithmTypeDynamic$strIni Time $t "
*endif
                set AnalOk [analyze 1 $DtAnalysis]
            } else {
                set AnalOk 1
                set firstFail 0
            }
            if {$AnalOk == 0} {
                set committedSteps [expr $committedSteps+1]
            }
        }; # end if Nk=1
        # substepping /2
        if {($Nk == 1 && $AnalOk!=0) || ($Nk == 4 && $AnalOk==0)} {
            set Nk 2.0
            set continueFlag 1
            puts "\nInitial step is divided by 2\n"
            set currTime1 [getTime]
            set curStep [expr int($currTime1/$DtAnalysis)]
            set remStep1 [expr int(($Nsteps-$curStep)**2.0)]
            set ReducedDtAnalysis [expr $DtAnalysis/2.0]
            for {set ik 1} {$ik <= $Nk} {incr ik 1} {
                if {$continueFlag==0} {
                    break
                }
                set t [format "%7.5f" [expr [getTime] + $ReducedDtAnalysis]]
*if(PrintTime==1)
                puts -nonewline "(*IntvNum) $algorithmTypeDynamic$strIni Time $t "
*endif
                set AnalOk [analyze 1 $ReducedDtAnalysis]
                if {$AnalOk == 0} {
                    set committedSteps [expr $committedSteps+1]
                } else {
                    set continueFlag 0
                }
            }
            if {$AnalOk == 0} {
                set returnToInitStepFlag 1
            }
        }; # end if Nk=2
*if(IntvData(Tolerance_relaxation,int)==1)
*if(strcmp(IntvData(Tolerance_relaxation_after_failed_substepping_of),"/2")==0)
        if {$AnalOk != 0 } {
            if {$InitialTolFlag} {
                set Nk 1; # back to initial step - tolerance relaxation
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
        # substepping /4
        if {($Nk == 2 && $AnalOk!=0) || ($Nk == 8 && $AnalOk == 0)} {
            set Nk 4.0
            set continueFlag 1
            puts "\nInitial step is divided by 4\n"
            set currTime2 [getTime]
            set curStep [expr ($currTime2-$currTime1)/$ReducedDtAnalysis]
            set remStep2 [expr int(($remStep1-$curStep)**2.0)]
            set ReducedDtAnalysis [expr $ReducedDtAnalysis/2.0]
            for {set ik 1} {$ik <= $Nk} {incr ik 1} {
                if {$continueFlag==0} {
                    break
                }
                set t [format "%7.5f" [expr [getTime] + $ReducedDtAnalysis]]
*if(PrintTime==1)
                puts -nonewline "(*IntvNum) $algorithmTypeDynamic$strIni Time $t "
*endif
                set AnalOk [analyze 1 $ReducedDtAnalysis]
                if {$AnalOk == 0} {
                    set committedSteps [expr $committedSteps+1]
                } else {
                    set continueFlag 0
                }
            }
            if {$AnalOk == 0} {
                set returnToInitStepFlag 1
            }
        }; # end if Nk=4
*if(IntvData(Tolerance_relaxation,int)==1)
*if(strcmp(IntvData(Tolerance_relaxation_after_failed_substepping_of),"/4")==0)
        if {$AnalOk != 0 } {
            if {$InitialTolFlag} {
                set Nk 1; # back to initial step - tolerance relaxation
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
        # substepping /8
        if {($Nk == 4 && $AnalOk!=0) || ($Nk == 16 && $AnalOk == 0)} {
            set Nk 8.0
            set continueFlag 1
            puts "\nInitial step is divided by 8\n"
            set currTime3 [getTime]
            set curStep [expr ($currTime3-$currTime2)/$ReducedDtAnalysis]
            set remStep3 [expr int(($remStep2-$curStep)**2.0)]
            set ReducedDtAnalysis [expr $ReducedDtAnalysis/2.0]
            for {set ik 1} {$ik <= $Nk} {incr ik 1} {
                if {$continueFlag==0} {
                    break
                }
                set t [format "%7.5f" [expr [getTime] + $ReducedDtAnalysis]]
*if(PrintTime==1)
                puts -nonewline "(*IntvNum) $algorithmTypeDynamic$strIni Time $t "
*endif
                set AnalOk [analyze 1 $ReducedDtAnalysis]
                if {$AnalOk == 0} {
                    set committedSteps [expr $committedSteps+1]
                } else {
                    set continueFlag 0
                }
            }
            if {$AnalOk == 0} {
                set returnToInitStepFlag 1
            }
        }; # end if Nk=8
*if(IntvData(Tolerance_relaxation,int)==1)
*if(strcmp(IntvData(Tolerance_relaxation_after_failed_substepping_of),"/8")==0)
        if {$AnalOk != 0 } {
            if {$InitialTolFlag} {
                set Nk 1; # back to initial step - tolerance relaxation
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
        # substepping /16
        if {($Nk == 8 && $AnalOk!=0)} {
            set Nk 16.0
            set continueFlag 1
            puts "\nInitial step is divided by 16\n"
            set currTime4 [getTime]
            set curStep [expr ($currTime4-$currTime3)/$ReducedDtAnalysis]
            set remStep4 [expr int(($remStep3-$curStep)**2.0)]
            set ReducedDtAnalysis [expr $ReducedDtAnalysis/2.0]
            for {set ik 1} {$ik <= $Nk} {incr ik 1} {
                if {$continueFlag==0} {
                    break
                }
                set t [format "%7.5f" [expr [getTime] + $ReducedDtAnalysis]]
*if(PrintTime==1)
                puts -nonewline "(*IntvNum) $algorithmTypeDynamic$strIni Time $t "
*endif
                set AnalOk [analyze 1 $ReducedDtAnalysis]
                if {$AnalOk == 0} {
                    set committedSteps [expr $committedSteps+1]
                } else {
                    set continueFlag 0
                }
            }
            if {$AnalOk == 0} {
                set returnToInitStepFlag 1
            }
        }; # end if Nk=16
*if(IntvData(Tolerance_relaxation,int)==1)
*if(strcmp(IntvData(Tolerance_relaxation_after_failed_substepping_of),"/16")==0)
        if {$AnalOk != 0 } {
            if {$InitialTolFlag} {
                set Nk 1; # back to initial step - tolerance relaxation
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
*if(IntvData(Tolerance_relaxation,int)==1)
        if {$AnalOk != 0 } {
            if {!$InitialTolFlag} {
                break
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
    puts "\nAnalysis FAILED"
    puts "Committed steps : $committedSteps\n"
}