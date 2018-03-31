
*# LoadIncr must be floating!
*format "%f"
set Lincr *LoadIncr
*format "%d"
set Nsteps *steps
set committedSteps 1

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
*format "%g"
variable TolStatic *IntvData(Tolerance,real)
variable maxNumIterStatic *IntvData(Max_Iterations_per_Step,int)
*if(strcmp(IntvData(Solution_algorithm),"Full_Newton-Raphson")==0)
variable algorithmTypeStatic Newton
*elseif(strcmp(IntvData(Solution_algorithm),"Modified_Newton-Raphson")==0)
variable algorithmTypeStatic ModifiedNewton
*elseif(strcmp(IntvData(Solution_algorithm),"Newton-Raphson_with_line_search")==0)
variable algorithmTypeStatic NewtonLineSearch
*elseif(strcmp(IntvData(Solution_algorithm),"Broyden")==0)
variable algorithmTypeStatic Broyden
*elseif(strcmp(IntvData(Solution_algorithm),"BFGS")==0)
variable algorithmTypeStatic BFGS
*elseif(strcmp(IntvData(Solution_algorithm),"KrylovNewton")==0)
variable algorithmTypeStatic KrylovNewton
*endif
set LoadCounter 0
for {set i 1} { $i <= $Nsteps } {incr i 1} {
    set t [format "%7.5f" [expr [getTime] + $Lincr]]
*if(PrintTime==1)
    puts -nonewline "LF (*IntvNum)$t "
*endif
    set AnalOk [analyze 1]
    if {$AnalOk !=0} {
        break
    } else {
        set LoadCounter [expr $LoadCounter+1.0]
        set committedSteps [expr $committedSteps+1]
    }
}

if {$AnalOk != 0} {
    # if analysis fails, different stepping and algorithms are applied
    set AnalOk 0
    set Nk 1
    while {$LoadCounter < $Nsteps && $AnalOk == 0} {

        if {($Nk==2 && $AnalOk==0) || ($Nk==1 && $AnalOk==0)} {
            set Nk 1
            puts "\nApplying initial step\n"
            integrator LoadControl $Lincr; # bring back to original increment
            set t [format "%7.5f" [expr [getTime] + $Lincr]]
*if(PrintTime==1)
            puts -nonewline "LF (*IntvNum)$t "
*endif
            set AnalOk [analyze 1]; # this will return zero if no convergence problems were encountered
            if {$AnalOk == 0} {
                set LoadCounter [expr $LoadCounter+1.0/$Nk]
                set committedSteps [expr $committedSteps+1]
            }
        }

        if {($AnalOk !=0 && $Nk==1) || ($AnalOk==0 && $Nk==4)} {; # reduce step size if still fails to converge
            set Nk 2;  # reduce step size
            puts "\nApplying substepping / 2\n"
            set LincrReduced [expr $Lincr/$Nk]
            integrator LoadControl $LincrReduced
            for {set ik 1} {$ik <=$Nk} {incr ik 1} {
                set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
*if(PrintTime==1)
                puts -nonewline "LF (*IntvNum)$t "
*endif
                set AnalOk [analyze 1]; # this will return zero if no convergence problems were encountered
*if(IntvData(Use_initial_stiffness_iterations,int)==0)
                if {$AnalOk != 0} {
                    puts "\nTrying Newton-Raphson with Initial Stiffness\n"
                    test NormDispIncr $TolStatic 2000 0
                    algorithm Newton -initial
                    set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
*if(PrintTime==1)
                    puts -nonewline "LF (*IntvNum)$t "
*endif
                    set AnalOk [analyze 1]
                    test $testTypeStatic $TolStatic $maxNumIterStatic *LoggingFlag
                    algorithm $algorithmTypeStatic
                }
                if {$AnalOk !=0} {
                    puts "\nTrying Modified Newton-Raphson with Initial Stiffness\n"
                    test NormDispIncr $TolStatic 2000 0
                    algorithm ModifiedNewton -initial
                    set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
*if(PrintTime==1)
                    puts -nonewline "LF (*IntvNum)$t "
*endif
                    set AnalOk [analyze 1]
                    test $testTypeStatic $TolStatic $maxNumIterStatic *LoggingFlag
                    algorithm $algorithmTypeStatic
                }
*else
                if {$AnalOk != 0} {
                    puts "\nTrying Newton-Raphson\n"
                    test NormDispIncr $TolStatic 2000 0
                    algorithm Newton
                    set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
*if(PrintTime==1)
                    puts -nonewline "LF (*IntvNum)$t "
*endif
                    set AnalOk [analyze 1]
                    test $testTypeStatic $TolStatic $maxNumIterStatic *LoggingFlag
                    algorithm $algorithmTypeStatic
                }
                if {$AnalOk !=0} {
                    puts "\nTrying Modified Newton-Raphson\n"
                    test NormDispIncr $TolStatic 2000 0
                    algorithm ModifiedNewton
                    set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
*if(PrintTime==1)
                    puts -nonewline "LF (*IntvNum)$t "
*endif
                    set AnalOk [analyze 1]
                    test $testTypeStatic $TolStatic $maxNumIterStatic *LoggingFlag
                    algorithm $algorithmTypeStatic
                }
*endif
                if {$AnalOk != 0} {
                    puts "\nTrying Broyden\n"
                    algorithm Broyden 8
                    set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
*if(PrintTime==1)
                    puts -nonewline "LF (*IntvNum)$t "
*endif
                    set AnalOk [analyze 1]
                    algorithm $algorithmTypeStatic
                }
                if {$AnalOk != 0} {
                    puts "\nTrying Newton-Raphson with Line Search\n"
                    algorithm NewtonLineSearch
                    set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
*if(PrintTime==1)
                    puts -nonewline "LF (*IntvNum)$t "
*endif
                    set AnalOk [analyze 1]
                    algorithm $algorithmTypeStatic
                }
                if {$AnalOk !=0} {
                    puts "\nTrying BFGS\n"
                    algorithm BFGS
                    set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
*if(PrintTime==1)
                    puts -nonewline "LF (*IntvNum)$t "
*endif
                    set AnalOk [analyze 1]
                    algorithm $algorithmTypeStatic
                }

                if {$AnalOk == 0} {
                    set LoadCounter [expr $LoadCounter+1.0/$Nk]
                    set committedSteps [expr $committedSteps+1]
                }
            }
        }

        # if step size bisection is not enough, it is bisected again
        if {($AnalOk !=0 && $Nk==2) || ($AnalOk==0 && $Nk==8)} {
            set Nk 4; # reduce step size
            puts "\nApplying substepping / 4\n"
            set LincrReduced [expr $Lincr/$Nk]
            integrator LoadControl $LincrReduced
            for {set ik 1} {$ik <=$Nk} {incr ik 1} {
                set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
*if(PrintTime==1)
                puts -nonewline "LF (*IntvNum)$t "
*endif
                set AnalOk [analyze 1]; # this will return zero if no convergence problems were encountered
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
                if {$AnalOk != 0} {
                    puts "\nTrying Newton-Raphson with Initial Stiffness\n"
                    test NormDispIncr $TolStatic 2000 0
                    algorithm Newton -initial
                    set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
*if(PrintTime==1)
                    puts -nonewline "LF (*IntvNum)$t "
*endif
                    set AnalOk [analyze 1]
                    test $testTypeStatic $TolStatic $maxNumIterStatic *LoggingFlag
                    algorithm $algorithmTypeStatic
                }
                if {$AnalOk !=0} {
                    puts "\nTrying Modified Newton-Raphson with Initial Stiffness\n"
                    test NormDispIncr $TolStatic 2000 0
                    algorithm ModifiedNewton -initial
                    set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
*if(PrintTime==1)
                    puts -nonewline "LF (*IntvNum)$t "
*endif
                    set AnalOk [analyze 1]
                    test $testTypeStatic $TolStatic $maxNumIterStatic *LoggingFlag
                    algorithm $algorithmTypeStatic
                }
*else
                if {$AnalOk != 0} {
                    puts "\nTrying Newton-Raphson\n"
                    test NormDispIncr $TolStatic 2000 0
                    algorithm Newton
                    set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
*if(PrintTime==1)
                    puts -nonewline "LF (*IntvNum)$t "
*endif
                    set AnalOk [analyze 1]
                    test $testTypeStatic $TolStatic $maxNumIterStatic *LoggingFlag
                    algorithm $algorithmTypeStatic
                }
                if {$AnalOk !=0} {
                puts "\nTrying Modified Newton-Raphson\n"
                    test NormDispIncr $TolStatic 2000 0
                    algorithm ModifiedNewton
                    set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
*if(PrintTime==1)
                    puts -nonewline "LF (*IntvNum)$t "
*endif
                    set AnalOk [analyze 1]
                    test $testTypeStatic $TolStatic $maxNumIterStatic *LoggingFlag
                    algorithm $algorithmTypeStatic
                }
*endif
                if {$AnalOk != 0} {
                    puts "\nTrying Broyden\n"
                    algorithm Broyden 8
                    set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
*if(PrintTime==1)
                    puts -nonewline "LF (*IntvNum)$t "
*endif
                    set AnalOk [analyze 1]
                    algorithm $algorithmTypeStatic
                }
                if {$AnalOk != 0} {
                    puts "\nTrying Newton-Raphson with Line Search\n"
                    algorithm NewtonLineSearch
                    set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
*if(PrintTime==1)
                    puts -nonewline "LF (*IntvNum)$t "
*endif
                    set AnalOk [analyze 1]
                    algorithm $algorithmTypeStatic
                }
                if {$AnalOk !=0} {
                    puts "\nTrying BFGS\n"
                    algorithm BFGS
                    set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
*if(PrintTime==1)
                    puts -nonewline "LF (*IntvNum)$t "
*endif
                    set AnalOk [analyze 1]
                    algorithm $algorithmTypeStatic
                }
                if {$AnalOk == 0} {
                    set LoadCounter [expr $LoadCounter+1.0/$Nk]
                    set committedSteps [expr $committedSteps+1]
                }
            }
        }

        # if step size double bisection is not enough, it is bisected again
        if {$AnalOk !=0 && $Nk==4} {
            set Nk 8; # reduce step size
            puts "\nApplying substepping / 8\n"
            set LincrReduced [expr $Lincr/$Nk]
            integrator LoadControl $LincrReduced
            for {set ik 1} {$ik <=$Nk} {incr ik 1} {
                set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
*if(PrintTime==1)
                puts -nonewline "LF (*IntvNum)$t "
*endif
                set AnalOk [analyze 1]; # this will return zero if no convergence problems were encountered
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
                if {$AnalOk != 0} {
                    puts "\nTrying Newton-Raphson with Initial Stiffness\n"
                    test NormDispIncr $TolStatic 2000 0
                    algorithm Newton -initial
                    set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
*if(PrintTime==1)
                    puts -nonewline "LF (*IntvNum)$t "
*endif
                    set AnalOk [analyze 1]
                    test $testTypeStatic $TolStatic $maxNumIterStatic *LoggingFlag
                    algorithm $algorithmTypeStatic
                }
                if {$AnalOk !=0} {
                    puts "\nTrying Modified Newton-Raphson with Initial Stiffness\n"
                    test NormDispIncr $TolStatic 2000 0
                    algorithm ModifiedNewton -initial
                    set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
*if(PrintTime==1)
                    puts -nonewline "LF (*IntvNum)$t "
*endif
                    set AnalOk [analyze 1]
                    test $testTypeStatic $TolStatic $maxNumIterStatic *LoggingFlag
                    algorithm $algorithmTypeStatic
                }
*else
                if {$AnalOk != 0} {
                    puts "\nTrying Newton-Raphson\n"
                    test NormDispIncr $TolStatic 2000 0
                    algorithm Newton
                    set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
*if(PrintTime==1)
                    puts -nonewline "LF (*IntvNum)$t "
*endif
                    set AnalOk [analyze 1]
                    test $testTypeStatic $TolStatic $maxNumIterStatic *LoggingFlag
                    algorithm $algorithmTypeStatic
                }
                if {$AnalOk !=0} {
                    puts "\nTrying Modified Newton-Raphson\n"
                    test NormDispIncr $TolStatic 2000 0
                    algorithm ModifiedNewton
                    set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
*if(PrintTime==1)
                    puts -nonewline "LF (*IntvNum)$t "
*endif
                    set AnalOk [analyze 1]
                    test $testTypeStatic $TolStatic $maxNumIterStatic *LoggingFlag
                    algorithm $algorithmTypeStatic
                }
*endif
                if {$AnalOk != 0} {
                    puts "\nTrying Broyden\n"
                    algorithm Broyden 8
                    set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
*if(PrintTime==1)
                    puts -nonewline "LF (*IntvNum)$t "
*endif
                    set AnalOk [analyze 1 ]
                    algorithm $algorithmTypeStatic
                }
                if {$AnalOk != 0} {
                    puts "\nTrying Newton-Raphson with LineSearch\n"
                    algorithm NewtonLineSearch
                    set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
*if(PrintTime==1)
                    puts -nonewline "LF (*IntvNum)$t "
*endif
                    set AnalOk [analyze 1]
                    algorithm $algorithmTypeStatic
                }
                if {$AnalOk !=0} {
                    puts "\nTrying BFGS\n"
                    algorithm BFGS
                    set t [format "%7.5f" [expr [getTime] + $LincrReduced]]
*if(PrintTime==1)
                    puts -nonewline "LF (*IntvNum)$t "
*endif
                    set AnalOk [analyze 1]
                    algorithm $algorithmTypeStatic
                }
                if {$AnalOk == 0} {
                    set LoadCounter [expr $LoadCounter+1.0/$Nk]
                    set committedSteps [expr $committedSteps+1]
                }
            }
        }; # end if Nk=8
    }; # end while loop
}; # end if AnalOk

if {$AnalOk != 0 } {
    puts "\nAnalysis FAILED\n"
} else {
    puts "\nAnalysis completed SUCCESSFULLY"
    puts "Committed steps : $committedSteps\n"
}