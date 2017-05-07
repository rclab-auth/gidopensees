*#set var DispIncr=operation(IntvData(Total_displacement,real)/steps)
set iDmax [list]
set Nsteps *steps
set IDctrlNode *IntvData(Control_node,int)
set IDctrlDOF *NodeCtrlDOF
*set var NMatrix=IntvData(Displacement_peaks-cycles,int)

*for(i=1;i<=Nmatrix;i=i+2)
*set var tempratio=IntvData(Displacement_peaks-cycles,*i,real)
*format "%g"
lappend iDmax *operation(tempratio*(IntvData(Total_displacement,real)))
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
variable algorithmTypeStatic
*elseif(strcmp(IntvData(Solution_algorithm),"BFGS")==0)
variable algorithmTypeStatic BFGS
*endif

foreach Dmax $iDmax Ncycles $iNcycles {
    set Dstepvector ""
    set DispIncr [expr $Dmax/$Nsteps]
    set Disp 0

    if {$Dmax<0} {; # avoid the divide by zero
        set dx [expr -$DispIncr]
    } else {
        set dx $DispIncr;
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
            set AnalOk [analyze 1]; # first analyze command
            if {$AnalOk != 0} { ; # if fails
*if(IntvData(Use_initial_stiffness_iterations,int)==0)
                if {$AnalOk != 0} {
                    puts "\nTrying Newton with Initial Tangent\n"
                    test NormDispIncr   $TolStatic 2000 *LoggingFlag
                    algorithm Newton -initial
                    set AnalOk [analyze 1]
                    test $testTypeStatic $TolStatic $maxNumIterStatic *LoggingFlag
                    algorithm $algorithmTypeStatic
                }
                if {$AnalOk !=0} {
                    puts "\nTrying Modified Newton with Initial Tangent\n"
                    test NormDispIncr $TolStatic 2000 0
                    algorithm ModifiedNewton -initial
                    set AnalOk [analyze 1]
                    test $testTypeStatic $TolStatic $maxNumIterStatic *LoggingFlag
                    algorithm $algorithmTypeStatic
                }
*else
                if {$AnalOk != 0} {
                    puts "\nTrying Newton\n"
                    test NormDispIncr   $TolStatic 2000 *LoggingFlag
                    algorithm Newton
                    set AnalOk [analyze 1]
                    test $testTypeStatic $TolStatic $maxNumIterStatic *LoggingFlag
                    algorithm $algorithmTypeStatic
                }
                if {$AnalOk !=0} {
                    puts "\nTrying Modified Newton\n"
                    test NormDispIncr $TolStatic 2000 0
                    algorithm ModifiedNewton
                    set AnalOk [analyze 1]
                    test $testTypeStatic $TolStatic $maxNumIterStatic *LoggingFlag
                    algorithm $algorithmTypeStatic
                }
*endif
                if {$AnalOk != 0} {
                    puts "\nTrying Broyden\n"
                    algorithm Broyden 8
                    set AnalOk [analyze 1]
                    algorithm $algorithmTypeStatic
                }
                if {$AnalOk != 0} {
                    puts "\nTrying NewtonWithLineSearch\n"
                    algorithm NewtonLineSearch 0.8
                    set AnalOk [analyze 1]
                    algorithm $algorithmTypeStatic
                }
                if {$AnalOk != 0} {
                    puts "\nAnalysis FAILED\n"
                    return -1
                }; # end if
            }; # end if
            set D0 $D1; # move to next step
        }; # end Dstep
    }; # end i
}; # end of iDmax

if {$AnalOk == 0} {
    puts "\nAnalysis completed SUCCESSFULLY\n"
} else {
    puts "\nAnalysis FAILED\n"
}