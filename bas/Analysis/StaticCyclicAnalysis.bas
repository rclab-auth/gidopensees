set iDmax [list]
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
*endfor

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
variable TolStatic *IntvData(Tolerance,real);
variable maxNumIterStatic *IntvData(Max_Iterations_per_Step,int);
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

foreach Dmax $iDmax Ncycles $iNcycles {
    set Dstepvector ""
    set DispIncr [expr $Dmax/$Nsteps]
    set Disp 0

    if {$Dmax<0} {; # avoid the divide by zero
        set dx [expr -$DispIncr]
    } else {
        set dx $DispIncr
    }
    for {set i 1} {$i <= $Nsteps} {incr i 1} {; # zero to one
        set Disp [expr $Disp + $dx]
        lappend Dstepvector $Disp
    }
    for {set i 1} {$i <= $Nsteps} {incr i 1} {; # one to zero
        set Disp [expr $Disp - $dx]
        lappend Dstepvector $Disp
    }
    for {set i 1} {$i <= $Nsteps} {incr i 1} {; # zero to minus one
        set Disp [expr $Disp - $dx]
        lappend Dstepvector $Disp
    }
    for {set i 1} {$i <= $Nsteps} {incr i 1} {; # minus one to zero
            set Disp [expr $Disp + $dx]
            lappend Dstepvector $Disp
    }

    for {set i 1} {$i <= $Ncycles} {incr i 1} {
        set D0 0.0
        foreach Dstep $Dstepvector {
            set D1 $Dstep
            set Dincr [expr $D1 - $D0]
            integrator DisplacementControl  $IDctrlNode $IDctrlDOF $Dincr
            set t [getTime]
*if(PrintTime==1)
            puts -nonewline "LF (*IntvNum)$t "
*endif
            set AnalOk [analyze 1]; # first analyze command
            if {$AnalOk != 0} { ; # if fails
*if(IntvData(Use_initial_stiffness_iterations,int)==0)
                if {$AnalOk != 0} {
                    puts "\nTrying Newton-Raphson with Initial Stiffness\n"
                    test NormDispIncr   $TolStatic 1000 *LoggingFlag
                    algorithm Newton -initial
                    set t [getTime]
*if(PrintTime==1)
                    puts -nonewline "LF (*IntvNum)$t "
*endif
                    set AnalOk [analyze 1]
                    test $testTypeStatic $TolStatic $maxNumIterStatic *LoggingFlag
                    algorithm $algorithmTypeStatic
                }
                if {$AnalOk !=0} {
                    puts "\nTrying Modified Newton-Raphson with Initial Stiffness\n"
                    test NormDispIncr $TolStatic 1000 0
                    algorithm ModifiedNewton -initial
                    set t [getTime]
*if(PrintTime==1)
                    puts -nonewline "LF (*IntvNum)$t "
*endif
                    set AnalOk [analyze 1]
                    test $testTypeStatic $TolStatic $maxNumIterStatic *LoggingFlag
                    algorithm $algorithmTypeStatic
                }
*else
                if {$AnalOk != 0} {
                    puts "\nTrying Newton\n"
                    test NormDispIncr   $TolStatic 1000 *LoggingFlag
                    algorithm Newton
                    set t [getTime]
*if(PrintTime==1)
                    puts -nonewline "LF (*IntvNum)$t "
*endif
                    set AnalOk [analyze 1]
                    test $testTypeStatic $TolStatic $maxNumIterStatic *LoggingFlag
                    algorithm $algorithmTypeStatic
                }
                if {$AnalOk !=0} {
                    puts "\nTrying Modified Newton\n"
                    test NormDispIncr $TolStatic 1000 0
                    algorithm ModifiedNewton
                    set t [getTime]
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
                    set t [getTime]
*if(PrintTime==1)
                    puts -nonewline "LF (*IntvNum)$t "
*endif
                    set AnalOk [analyze 1]
                    algorithm $algorithmTypeStatic
                }
                if {$AnalOk != 0} {
                    puts "\nTrying NewtonWithLineSearch\n"
                    algorithm NewtonLineSearch 0.8
                    set t [getTime]
*if(PrintTime==1)
                    puts -nonewline "LF (*IntvNum)$t "
*endif
                    set AnalOk [analyze 1]
                    algorithm $algorithmTypeStatic
                }
                if {$AnalOk != 0} {
                    puts "\nAnalysis FAILED\n"
                    return -1
                }; # end if
                if {$AnalOk == 0} {
                    set committedSteps [expr $committedSteps+1]
                }
            }; # end if
            if {$AnalOk == 0} {
                set committedSteps [expr $committedSteps+1]
            }
            set D0 $D1; # move to next step
        }; # end Dstep
    }; # end i
}; # end of iDmax

if {$AnalOk == 0} {
    puts "\nAnalysis completed SUCCESSFULLY"
    puts "Committed steps : $committedSteps\n"
} else {
    puts "\nAnalysis FAILED\n"
}