
set iDmax [list]
set iNSteps [list]
set Nsteps *steps
set committedSteps 1
set IDctrlNode *IntvData(Control_node,int)
set IDctrlDOF *NodeCtrlDOF
*set var NMatrix=IntvData(Displacement_peaks-cycles,int)

*for(i=1;i<=Nmatrix;i=i+2)
*set var tempratio=IntvData(Displacement_peaks-cycles,*i,real)
*format "%g"
*if(strcmp(IntvData(Control_node_direction),"UX")==0 || strcmp(IntvData(Control_node_direction),"UY")==0 || strcmp(IntvData(Control_node_direction),"UZ")==0)
lappend iDmax *operation(tempratio*(IntvData(Total_displacement,real)))
*# Rotational control direction
*else
lappend iDmax *operation(tempratio*(IntvData(Total_rotation,real)))
*endif
lappend iNcycles *IntvData(Displacement_peaks-cycles,*operation(i+1),int)
*format "%g"
*if(IntvData(Adjust_number_of_steps_according_to_displacement_ratio,int)==1)
lappend iNSteps [expr int(*tempratio**$Nsteps)]
*else
lappend iNSteps $Nsteps
*endif
*endfor

set strIni {}
*if(strcmp(IntvData(Convergence_criterion),"Norm_Unbalance")==0)
variable testTypeStatic NormUnbalance
*elseif(strcmp(IntvData(Convergence_criterion),"Norm_Displacement_Increment")==0)
variable testTypeStatic NormDispIncr
*elseif(strcmp(IntvData(Convergence_criterion),"Energy_Increment")==0)
variable testTypeStatic EnergyIncr
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Unbalance")==0)
variable testTypeStatic RelativeNormUnbalance
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Displacement_Increment")==0)
variable testTypeStatic RelativeNormDispIncr
*elseif(strcmp(IntvData(Convergence_criterion),"Total_Relative_Norm_Displacement_Increment")==0)
variable testTypeStatic RelativeTotalNormDispIncr
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Energy_Increment")==0)
variable testTypeStatic RelativeEnergyIncr
*elseif(strcmp(IntvData(Convergence_criterion),"Fixed_Number_of_Iterations")==0)
variable testTypeStatic FixedNumIter
*endif
variable TolStatic *IntvData(Tolerance,real)
variable maxNumIterStatic *IntvData(Max_Iterations_per_Step,int)
*if(strcmp(IntvData(Solution_algorithm),"Full_Newton-Raphson")==0)
variable algorithmTypeStatic Newton
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
set strIni "/Ini"
*endif
*elseif(strcmp(IntvData(Solution_algorithm),"Modified_Newton-Raphson")==0)
variable algorithmTypeStatic ModifiedNewton
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
set strIni "/Ini"
*endif
*elseif(strcmp(IntvData(Solution_algorithm),"Newton-Raphson_with_line_search")==0)
variable algorithmTypeStatic NewtonLineSearch
*elseif(strcmp(IntvData(Solution_algorithm),"Broyden")==0)
variable algorithmTypeStatic Broyden
*elseif(strcmp(IntvData(Solution_algorithm),"BFGS")==0)
variable algorithmTypeStatic BFGS
*elseif(strcmp(IntvData(Solution_algorithm),"KrylovNewton")==0)
variable algorithmTypeStatic KrylovNewton
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
set strIni "/Ini"
*endif
*endif

foreach Dmax $iDmax Ncycles $iNcycles NumSteps $iNSteps {
    set DispIncr [expr $Dmax/$NumSteps]; # the displacement increment for each step
    set Dstepvector ""
    set Disp 0
    if {$Dmax<0} {; # avoid the divide by zero
        set dx [expr -$DispIncr]
    } else {
        set dx $DispIncr
    }
    for {set i 1} {$i <= $NumSteps} {incr i 1} {; # zero to one
        set Disp [expr $Disp + $dx]
        lappend Dstepvector $Disp
    }
    for {set i 1} {$i <= $NumSteps} {incr i 1} {; # one to zero
        set Disp [expr $Disp - $dx]
        lappend Dstepvector $Disp
    }
    for {set i 1} {$i <= $NumSteps} {incr i 1} {; # zero to minus one
        set Disp [expr $Disp - $dx]
        lappend Dstepvector $Disp
    }
    for {set i 1} {$i <= $NumSteps} {incr i 1} {; # minus one to zero
            set Disp [expr $Disp + $dx]
            lappend Dstepvector $Disp
    }
    for {set i 1} {$i <= $Ncycles} {incr i 1} {
        set currentPath 1
        set D0 0.0
        foreach Dispstep $Dstepvector {
            set D1 $Dispstep
            set Dincr [expr $D1 - $D0]
            integrator DisplacementControl $IDctrlNode $IDctrlDOF $Dincr
            set t [getTime]
*if(PrintTime==1)
            puts -nonewline "(*IntvNum) $algorithmTypeStatic$strIni LF $t "
*endif
            set AnalOk [analyze 1];
            set D0 $D1; # move to next step
            set tempexpr1 [expr abs($D0-$Dmax)]
            set tempexpr2 [expr abs($D0+$Dmax)]
            set tempexpr3 [expr abs($D0)]
            if {($tempexpr1 < 0.0000001) || ($tempexpr2 < 0.0000001) || ($tempexpr3 < 0.0000001)} {
                set currentPath [expr $currentPath+1]
            }
            if {$AnalOk != 0 } {
                break
            } else {
                set committedSteps [expr $committedSteps+1]
            }
        }
        if {$AnalOk != 0} {; # if analysis fails, alternative algorithms and substepping is applied
            set firstFail 1
            set Dstep 0.0
            set AnalOk 0
            set Nk 1
            set returnToInitStepFlag 0
*if(IntvData(Tolerance_relaxation,int)==1)
            set InitialTolFlag 1
            set returnToInitTolFlag 0
            set ChangeToleranceFlag 0
            set SkipFirstLoopForTolRelaxFlag 1
*endif
            set tempexpr [expr abs($Dstep)]
            while {($AnalOk == 0 && $currentPath<=3) || ($tempexpr > 0.000001 && $AnalOk == 0 && $currentPath==4)} {
                set controlDisp [nodeDisp $IDctrlNode $IDctrlDOF]
                set Dstep [expr $controlDisp/$Dmax]
                if {($Nk==2 && $AnalOk==0) || ($Nk==1 && $AnalOk==0)} {
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
                            set TolStatic [expr $TolStatic/*IntvData(Relaxation_factor,real)]
                            set InitialTolFlag 1
*if(strcmp(IntvData(Convergence_criterion),"Norm_Unbalance")==0)
*format "%d"
                            test NormUnbalance $TolStatic *IntvData(Max_Iterations_per_Step,int) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Norm_Displacement_Increment")==0)
*format "%d"
                            test NormDispIncr $TolStatic *IntvData(Max_Iterations_per_Step,int) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Energy_Increment")==0)
*format "%d"
                            test EnergyIncr $TolStatic *IntvData(Max_Iterations_per_Step,int) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Unbalance")==0)
*format "%d"
                            test RelativeNormUnbalance $TolStatic *IntvData(Max_Iterations_per_Step,int) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Displacement_Increment")==0)
*format "%d"
                            test RelativeNormDispIncr $TolStatic *IntvData(Max_Iterations_per_Step,int) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Total_Relative_Norm_Displacement_Increment")==0)
*format "%d"
                            test RelativeTotalNormDispIncr $TolStatic *IntvData(Max_Iterations_per_Step,int) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Energy_Increment")==0)
*format "%d"
                            test RelativeEnergyIncr $TolStatic *IntvData(Max_Iterations_per_Step,int) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Fixed_Number_of_Iterations")==0)
*format "%d"
                            test FixedNumIter *IntvData(Max_Iterations_per_Step,int) *LoggingFlag
*endif
                        }
                    } else {
                        if {$InitialTolFlag && $ChangeToleranceFlag && !$SkipFirstLoopForTolRelaxFlag} {
*format "%g"
                        puts "Tolerance is multiplied by *IntvData(Relaxation_factor,real)\n"
*format "%g"
                        set TolStatic [expr $TolStatic***IntvData(Relaxation_factor,real)]
                        set InitialTolFlag 0
*if(strcmp(IntvData(Convergence_criterion),"Norm_Unbalance")==0)
*format "%d"
                        test NormUnbalance $TolStatic *IntvData(Max_Iterations_per_Step,int) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Norm_Displacement_Increment")==0)
*format "%d"
                        test NormDispIncr $TolStatic *IntvData(Max_Iterations_per_Step,int) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Energy_Increment")==0)
*format "%d"
                        test EnergyIncr $TolStatic *IntvData(Max_Iterations_per_Step,int) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Unbalance")==0)
*format "%d"
                        test RelativeNormUnbalance $TolStatic *IntvData(Max_Iterations_per_Step,int) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Displacement_Increment")==0)
*format "%d"
                        test RelativeNormDispIncr $TolStatic *IntvData(Max_Iterations_per_Step,int) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Total_Relative_Norm_Displacement_Increment")==0)
*format "%d"
                        test RelativeTotalNormDispIncr $TolStatic *IntvData(Max_Iterations_per_Step,int) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Energy_Increment")==0)
*format "%d"
                        test RelativeEnergyIncr $TolStatic *IntvData(Max_Iterations_per_Step,int) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Fixed_Number_of_Iterations")==0)
*format "%d"
                        test FixedNumIter *IntvData(Max_Iterations_per_Step,int) *LoggingFlag
*endif
                        }
                    }
                    set SkipFirstLoopForTolRelaxFlag 0
*endif
                    if {$firstFail == 0} {; # for the first time only, do not repeat previous failed step
                        if {$Dmax > 0} {
                            if {$currentPath == 1 || $currentPath == 4 } {
                                integrator DisplacementControl $IDctrlNode $IDctrlDOF $DispIncr; # bring back to original increment
                            } else {
                                integrator DisplacementControl $IDctrlNode $IDctrlDOF -$DispIncr
                            }
                        } else {
                            if {$currentPath == 1 || $currentPath == 4 } {
                                integrator DisplacementControl $IDctrlNode $IDctrlDOF -$DispIncr; # bring back to original increment
                            } else {
                                integrator DisplacementControl $IDctrlNode $IDctrlDOF $DispIncr
                            }
                        }
                        set t [getTime]
*if(PrintTime==1)
                        puts -nonewline "(*IntvNum) $algorithmTypeStatic$strIni LF $t "
*endif
                        set AnalOk [analyze 1]; # zero for convergence
                    } else {
                        set AnalOk 1
                        set firstFail 0
                    }
                    if {$AnalOk == 0} {
                        set committedSteps [expr $committedSteps+1]
                    }
                }; # end if Nk=1
                # substepping /2
                if {($AnalOk !=0 && $Nk==1) || ($AnalOk==0 && $Nk==4)} {
                    set Nk 2; # reduce step size
                    set continueFlag 1
                    puts "\nInitial step is divided by 2\n"
                    set DincrReduced [expr $DispIncr/$Nk]
                    if {$Dmax > 0} {
                        if {$currentPath == 1 || $currentPath == 4 } {
                            integrator DisplacementControl $IDctrlNode $IDctrlDOF $DincrReduced; # bring back to original increment
                        } else {
                            integrator DisplacementControl $IDctrlNode $IDctrlDOF -$DincrReduced
                        }
                    } else {
                        if {$currentPath == 1 || $currentPath == 4 } {
                            integrator DisplacementControl $IDctrlNode $IDctrlDOF -$DincrReduced; # bring back to original increment
                        } else {
                            integrator DisplacementControl $IDctrlNode $IDctrlDOF $DincrReduced
                        }
                    }
                    for {set ik 1} {$ik <=$Nk} {incr ik 1} {
                        if {$continueFlag==0} {
                            break
                        }
                        set t [getTime]
*if(PrintTime==1)
                        puts -nonewline "(*IntvNum) $algorithmTypeStatic$strIni LF $t "
*endif
                        set AnalOk [analyze 1]; # zero for convergence
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
                if {($AnalOk !=0 && $Nk==2) || ($AnalOk==0 && $Nk==8)} {
                    set Nk 4; # reduce step size
                    set continueFlag 1
                    puts "\nInitial step is divided by 4\n"
                    set DincrReduced [expr $DispIncr/$Nk]
                    if {$Dmax > 0} {
                        if {$currentPath == 1 || $currentPath == 4 } {
                            integrator DisplacementControl $IDctrlNode $IDctrlDOF $DincrReduced; # bring back to original increment
                        } else {
                            integrator DisplacementControl $IDctrlNode $IDctrlDOF -$DincrReduced
                        }
                    } else {
                        if {$currentPath == 1 || $currentPath == 4 } {
                            integrator DisplacementControl $IDctrlNode $IDctrlDOF -$DincrReduced; # bring back to original increment
                        } else {
                            integrator DisplacementControl $IDctrlNode $IDctrlDOF $DincrReduced
                        }
                    }
                    for {set ik 1} {$ik <=$Nk} {incr ik 1} {
                        if {$continueFlag==0} {
                            break
                        }
                        set t [getTime]
*if(PrintTime==1)
                        puts -nonewline "(*IntvNum) $algorithmTypeStatic$strIni LF $t "
*endif
                        set AnalOk [analyze 1]; # zero for convergence
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
                if {$AnalOk !=0 && $Nk==4 || ($Nk == 16 && $AnalOk == 0)} {
                    set Nk 8; # reduce step size
                    set continueFlag 1
                    puts "\nInitial step is divided by 8\n"
                    set DincrReduced [expr $DispIncr/$Nk]
                    if {$Dmax > 0} {
                        if {$currentPath == 1 || $currentPath == 4 } {
                            integrator DisplacementControl $IDctrlNode $IDctrlDOF $DincrReduced; # bring back to original increment
                        } else {
                            integrator DisplacementControl $IDctrlNode $IDctrlDOF -$DincrReduced
                        }
                    } else {
                        if {$currentPath == 1 || $currentPath == 4 } {
                            integrator DisplacementControl $IDctrlNode $IDctrlDOF -$DincrReduced; # bring back to original increment
                        } else {
                            integrator DisplacementControl $IDctrlNode $IDctrlDOF $DincrReduced
                        }
                    }
                    for {set ik 1} {$ik <=$Nk} {incr ik 1} {
                        if {$continueFlag==0} {
                            break
                        }
                        set t [getTime]
*if(PrintTime==1)
                        puts -nonewline "(*IntvNum) $algorithmTypeStatic$strIni LF $t "
*endif
                        set AnalOk [analyze 1]; # zero for convergence
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
                    set Nk 16; # reduce step size
                    set continueFlag 1
                    puts "\nInitial step is divided by 16\n"
                    set DincrReduced [expr $DispIncr/$Nk]
                    if {$Dmax > 0} {
                        if {$currentPath == 1 || $currentPath == 4 } {
                            integrator DisplacementControl $IDctrlNode $IDctrlDOF $DincrReduced; # bring back to original increment
                        } else {
                            integrator DisplacementControl $IDctrlNode $IDctrlDOF -$DincrReduced
                        }
                    } else {
                        if {$currentPath == 1 || $currentPath == 4 } {
                            integrator DisplacementControl $IDctrlNode $IDctrlDOF -$DincrReduced; # bring back to original increment
                        } else {
                            integrator DisplacementControl $IDctrlNode $IDctrlDOF $DincrReduced
                        }
                    }
                    for {set ik 1} {$ik <=$Nk} {incr ik 1} {
                        if {$continueFlag==0} {
                            break
                        }
                        set t [getTime]
*if(PrintTime==1)
                        puts -nonewline "(*IntvNum) $algorithmTypeStatic$strIni LF $t "
*endif
                        set AnalOk [analyze 1]; # zero for convergence
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
                set controlDisp [nodeDisp $IDctrlNode $IDctrlDOF]
                set Dstep [expr $controlDisp/$Dmax]
                set tempexpr1 [expr abs($Dstep-1)]
                set tempexpr2 [expr abs($Dstep+1)]
                set tempexpr3 [expr abs($Dstep)]
                if {$tempexpr1 < 0.0000001 || $tempexpr2 < 0.0000001 || $tempexpr3 < 0.0000001} {
                    set currentPath [expr $currentPath+1]
                }
                set tempexpr [expr abs($Dstep)]
            }; # end while loop
        }; # end if $AnalOk !=0
        if {$AnalOk != 0 } {
            break
        }
    }; # end i
}; # end of iDmax

if {$AnalOk == 0} {
    puts "\nAnalysis completed SUCCESSFULLY"
    puts "Committed steps : $committedSteps\n"
} else {
    puts "\nAnalysis FAILED"
    puts "Committed steps : $committedSteps\n"
}