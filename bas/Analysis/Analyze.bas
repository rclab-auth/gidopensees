*#
*# Eigenvalue analysis
*#
*if(IntvNum==1 && GenData(Activate_eigenvalue_analysis,int)==1)
# Perform eigenvalue analysis

puts "Running eigenvalue analysis\n"

set numModes *GenData(Number_of_eigenvalues,int)

# Record eigenvectors

for { set k 1 } { $k <= $numModes } { incr k } {
*if(ndime==2)
    recorder Node -file [format "Mode_%i.out" $k] -nodeRange 1 *cntNodes -dof 1 2 "eigen $k"
*else
    recorder Node -file [format "Mode_%i.out" $k] -nodeRange 1 *cntNodes -dof 1 2 3 "eigen $k"
*endif
}

set lambda [eigen *\
*if(strcmp(GenData(Solver),"genBandArpack")==0)
-genBandArpack $numModes]
*elseif(strcmp(GenData(Solver),"fullGenLapack")==0)
-fullGenLapack $numModes]
*elseif(strcmp(GenData(Solver),"symmBandLapack")==0)
-symmBandLapack $numModes]
*endif

# Calculate periods

set T {}
foreach lam $lambda {
    lappend T [expr 6.283185/sqrt($lam)]
}

# Write periods file

set period "Periods.out"
set Periods [open $period "w"]
foreach t $T {
    puts $Periods "$t"
}
close $Periods

*endif
*if(IntvNum==1)
*if(GenData(Activate_Global_Rayleigh_damping,int)==1)
# Rayleigh damping

*format "%g%g%g%g"
rayleigh *GenData(alphaM,real) *GenData(betaK,real) *GenData(betaKinit,real) *GenData(betaKcomm,real)

*else
*include Regions.bas
*endif
*endif
*set var PrintTime=1
*if(strcmp(IntvData(Logging_level),"Low")==0)
*set var LoggingFlag=0
*set var PrintTime=0
*elseif(strcmp(IntvData(Logging_level),"Medium")==0)
*set var LoggingFlag=2
*elseif(strcmp(IntvData(Logging_level),"High")==0)
*set var LoggingFlag=1
*endif
*#
*# Analysis Options
*#
# Analysis options

*#
*# STATIC ANALYSIS
*#
*if(strcmp(IntvData(Analysis_type),"Static")==0)
system *IntvData(System_of_equations)
numberer *IntvData(DOF_numberer)
*if(strcmp(IntvData(Constraint_handler),"Penalty")==0)
*format "%g%g"
constraints Penalty *IntvData(Penalty_as_factor,real) *IntvData(Penalty_am_factor,real)
*else
constraints *IntvData(Constraint_handler)
*endif
*# MONOTONIC
*if(strcmp(IntvData(Loading_path),"Monotonic")==0)
*# Integrator for Static Monotonic Analysis
*if(strcmp(IntvData(Integrator_type),"Load_control")==0)
*set var steps=IntvData(Analysis_steps,int)
*set var LoadIncr=operation(1.0/steps)
*format "%g"
integrator LoadControl *LoadIncr
*elseif(strcmp(IntvData(Integrator_type),"Displacement_control")==0)
*set var steps=IntvData(Analysis_steps,int)
*if(ndime==2)
*if(strcmp(IntvData(Control_node_direction),"UX")==0)
*set var NodeCtrlDOF=1
*set var DispIncr=operation(IntvData(Total_displacement,real)/steps)
*elseif(strcmp(IntvData(Control_node_direction),"UY")==0)
*set var NodeCtrlDOF=2
*set var DispIncr=operation(IntvData(Total_displacement,real)/steps)
*elseif(strcmp(IntvData(Control_node_direction),"RZ")==0)
*set var NodeCtrlDOF=3
*set var DispIncr=operation(IntvData(Total_rotation,real)/steps)
*else
*MessageBox Error: Invalid Control Node Direction for 2D Model.
*endif
*else
*if(strcmp(IntvData(Control_node_direction),"UX")==0)
*set var NodeCtrlDOF=1
*set var DispIncr=operation(IntvData(Total_displacement,real)/steps)
*elseif(strcmp(IntvData(Control_node_direction),"UY")==0)
*set var NodeCtrlDOF=2
*set var DispIncr=operation(IntvData(Total_displacement,real)/steps)
*elseif(strcmp(IntvData(Control_node_direction),"UZ")==0)
*set var NodeCtrlDOF=3
*set var DispIncr=operation(IntvData(Total_displacement,real)/steps)
*elseif(strcmp(IntvData(Control_node_direction),"RX")==0)
*set var NodeCtrlDOF=4
*set var DispIncr=operation(IntvData(Total_rotation,real)/steps)
*elseif(strcmp(IntvData(Control_node_direction),"RY")==0)
*set var NodeCtrlDOF=5
*set var DispIncr=operation(IntvData(Total_rotation,real)/steps)
*elseif(strcmp(IntvData(Control_node_direction),"RZ")==0)
*set var NodeCtrlDOF=6
*set var DispIncr=operation(IntvData(Total_rotation,real)/steps)
*endif
*endif
*format "%g%d%g"
integrator DisplacementControl *IntvData(Control_node) *NodeCtrlDOF *DispIncr
*else
*MessageBox Error: Invalid Analysis Options
*# end if Integrator type
*endif
*# Test for convergence
*if(strcmp(IntvData(Solution_algorithm),"Full_Newton-Raphson")==0 || strcmp(IntvData(Solution_algorithm),"Modified_Newton-Raphson")==0 || strcmp(IntvData(Solution_algorithm),"Newton-Raphson_with_line_search")==0 || strcmp(IntvData(Solution_algorithm),"Broyden")==0 || strcmp(IntvData(Solution_algorithm),"BFGS")==0 || strcmp(IntvData(Solution_algorithm),"KrylovNewton")==0)
*if(strcmp(IntvData(Convergence_criterion),"Norm_Unbalance")==0)
*format "%g%g"
test NormUnbalance *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Norm_Displacement_Increment")==0)
*format "%g%g"
test NormDispIncr *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Energy_Increment")==0)
*format "%g%g"
test EnergyIncr *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Unbalance")==0)
*format "%g%g"
test RelativeNormUnbalance *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Displacement_Increment")==0)
*format "%g%g"
test RelativeNormDispIncr *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Total_Relative_Norm_Displacement_Increment")==0)
*format "%g%g"
test RelativeTotalNormDispIncr *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Energy_Increment")==0)
*format "%g%g"
test RelativeEnergyIncr *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Fixed_Number_of_Iterations")==0)
*format "%g"
test FixedNumIter *IntvData(Max_Iterations_per_Step) *LoggingFlag
*endif
*# end if test convergence
*endif
*# Algorithm for Static Monotonic
*if(strcmp(IntvData(Solution_algorithm),"Linear")==0)
algorithm Linear
*elseif(strcmp(IntvData(Solution_algorithm),"Full_Newton-Raphson")==0)
algorithm Newton*\
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
 -initial
*else

*endif
*elseif(strcmp(IntvData(Solution_algorithm),"Modified_Newton-Raphson")==0)
algorithm ModifiedNewton*\
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
 -initial
*else

*endif
*elseif(strcmp(IntvData(Solution_algorithm),"Newton-Raphson_with_line_search")==0)
algorithm NewtonLineSearch -type *\
*if(strcmp(IntvData(Line_search_type),"Interpolated")==0)
InitialInterpolated *\
*elseif(strcmp(IntvData(Line_search_type),"RegulaFalsi")==0)
RegulaFalsi *\
*elseif(strcmp(IntvData(Line_search_type),"Bisection")==0)
Bisection *\
*elseif(strcmp(IntvData(Line_search_type),"Secant")==0)
Secant *\
*endif
*format "%g%d%g%g"
-tol *IntvData(Search_tolerance,real) -maxIter *IntvData(Max_iterations_for_search,int) -minEta *IntvData(Min_eta_value,real) -maxEta *IntvData(max_eta_value,real)
*elseif(strcmp(IntvData(Solution_algorithm),"Broyden")==0)
*format "%d"
algorithm Broyden *IntvData(Iterations_for_new_tangent,int)
*elseif(strcmp(IntvData(Solution_algorithm),"BFGS")==0)
algorithm BFGS
*elseif(strcmp(IntvData(Solution_algorithm),"KrylovNewton")==0)
algorithm KrylovNewton
*# end if algorithm
*else
*endif
*#
*# ANALYSIS
*#
analysis *IntvData(Analysis_type)
*if(strcmp(IntvData(Solution_algorithm),"Linear")!=0 && strcmp(IntvData(Integrator_type),"Displacement_control")==0)
*#
*# Pushover analysis (Displacement Control)
*#
*include StaticDisplacementControl.bas
*elseif(strcmp(IntvData(Solution_algorithm),"Linear")!=0 && strcmp(IntvData(Integrator_type),"Load_control")==0)
*#
*# Pushover analysis analysis (Load Control)
*#
*include StaticLoadControl.bas
*else
*#
*# Linear analysis
*#
set committedSteps 1
*format "%d"
for {set i 1} { $i <= *steps } {incr i 1} {
    set AnalOk [analyze 1]
    if {$AnalOk !=0} {
        break
    } else {
        set committedSteps [expr $committedSteps+1]
    }
}
if {$AnalOk == 0} {
    puts "\nAnalysis completed SUCCESSFULLY"
    puts "Committed steps : $committedSteps\n"
} else {
    puts "\nAnalysis FAILED"
    puts "Committed steps : $committedSteps\n"
}
*endif
*#
*# Cyclic analysis
*#
*elseif(strcmp(IntvData(Loading_path),"Cyclic")==0)
*# Integrator for Static Cyclic Analysis
*if(strcmp(IntvData(Integrator_type),"Displacement_control")==0)
*set var steps=IntvData(Analysis_steps,int)
*if(strcmp(IntvData(Control_node_direction),"UX")==0)
*set var NodeCtrlDOF=1
*set var DispIncr=operation(IntvData(Total_displacement,real)/steps)
*elseif(strcmp(IntvData(Control_node_direction),"UY")==0)
*set var NodeCtrlDOF=2
*set var DispIncr=operation(IntvData(Total_displacement,real)/steps)
*elseif(strcmp(IntvData(Control_node_direction),"UZ")==0)
*set var NodeCtrlDOF=3
*set var DispIncr=operation(IntvData(Total_displacement,real)/steps)
*elseif(strcmp(IntvData(Control_node_direction),"RX")==0)
*set var NodeCtrlDOF=4
*set var DispIncr=operation(IntvData(Total_rotation,real)/steps)
*elseif(strcmp(IntvData(Control_node_direction),"RY")==0)
*set var NodeCtrlDOF=5
*set var DispIncr=operation(IntvData(Total_rotation,real)/steps)
*elseif(strcmp(IntvData(Control_node_direction),"RZ")==0)
*set var NodeCtrlDOF=6
*set var DispIncr=operation(IntvData(Total_rotation,real)/steps)
*endif
*format "%g%d%g"
integrator DisplacementControl *IntvData(Control_node) *NodeCtrlDOF *DispIncr
*else
*MessageBox Error: Invalid Analysis Options
*# end if Integrator type
*endif
*# Test for convergence
*if(strcmp(IntvData(Solution_algorithm),"Full_Newton-Raphson")==0 || strcmp(IntvData(Solution_algorithm),"Modified_Newton-Raphson")==0 || strcmp(IntvData(Solution_algorithm),"Newton-Raphson_with_line_search")==0 || strcmp(IntvData(Solution_algorithm),"Broyden")==0 || strcmp(IntvData(Solution_algorithm),"BFGS")==0 || strcmp(IntvData(Solution_algorithm),"KrylovNewton")==0)
*if(strcmp(IntvData(Convergence_criterion),"Norm_Unbalance")==0)
*format "%g%g"
test NormUnbalance *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Norm_Displacement_Increment")==0)
*format "%g%g"
test NormDispIncr *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Energy_Increment")==0)
*format "%g%g"
test EnergyIncr *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Unbalance")==0)
*format "%g%g"
test RelativeNormUnbalance *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Displacement_Increment")==0)
*format "%g%g"
test RelativeNormDispIncr *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Total_Relative_Norm_Displacement_Increment")==0)
*format "%g%g"
test RelativeTotalNormDispIncr *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Energy_Increment")==0)
*format "%g%g"
test RelativeEnergyIncr *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Fixed_Number_of_Iterations")==0)
*format "%g"
test FixedNumIter *IntvData(Max_Iterations_per_Step) *LoggingFlag
*endif
*endif
*# Algorithm for Static Cyclic
*if(strcmp(IntvData(Solution_algorithm),"Linear")==0)
*MessageBox Error: Invalid Analysis Options
*elseif(strcmp(IntvData(Solution_algorithm),"Full_Newton-Raphson")==0)
algorithm Newton*\
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
 -initial
*else

*endif
*elseif(strcmp(IntvData(Solution_algorithm),"Modified_Newton-Raphson")==0)
algorithm ModifiedNewton*\
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
 -initial
*else

*endif
*elseif(strcmp(IntvData(Solution_algorithm),"Newton-Raphson_with_line_search")==0)
algorithm NewtonLineSearch -type *\
*if(strcmp(IntvData(Line_search_type),"Interpolated")==0)
InitialInterpolated *\
*elseif(strcmp(IntvData(Line_search_type),"RegulaFalsi")==0)
RegulaFalsi *\
*elseif(strcmp(IntvData(Line_search_type),"Bisection")==0)
Bisection *\
*elseif(strcmp(IntvData(Line_search_type),"Secant")==0)
Secant *\
*endif
*format "%g%d%g%g"
-tol *IntvData(Search_tolerance,real) -maxIter *IntvData(Max_iterations_for_search,int) -minEta *IntvData(Min_eta_value,real) -maxEta *IntvData(max_eta_value,real)
*elseif(strcmp(IntvData(Solution_algorithm),"Broyden")==0)
*format "%d"
algorithm Broyden *IntvData(Iterations_for_new_tangent,int)
*elseif(strcmp(IntvData(Solution_algorithm),"BFGS")==0)
algorithm BFGS
*elseif(strcmp(IntvData(Solution_algorithm),"KrylovNewton")==0)
algorithm KrylovNewton
*# end if Algorithm
*endif
analysis *IntvData(Analysis_type)
*include StaticCyclicAnalysis.bas
*# end if path is cyclic
*endif
*#
*# Transient analysis
*#
*elseif(strcmp(IntvData(Analysis_type),"Transient")==0)
system *IntvData(System_of_equations)
numberer *IntvData(DOF_numberer)
*if(strcmp(IntvData(Constraint_handler),"Penalty")==0)
*format "%g%g"
constraints Penalty *IntvData(Penalty_as_factor,real) *IntvData(Penalty_am_factor,real)
*else
constraints *IntvData(Constraint_handler)
*endif
*if(strcmp(IntvData(Integrator_type),"Newmark")==0)
*format "%g%g"
integrator Newmark *IntvData(gamma,real) *IntvData(beta,real)
*elseif(strcmp(IntvData(Integrator_type),"Hilber-Hughes-Taylor")==0)
*format "%g%g%g"
integrator HHT *IntvData(alpha,real) *IntvData(gamma,real) *IntvData(beta,real)
*else
*MessageBox Error: Invalid Analysis Options.
*endif
*# Test for convergence
*if(strcmp(IntvData(Solution_algorithm),"Linear")!=0)
*if(strcmp(IntvData(Convergence_criterion),"Norm_Unbalance")==0)
*format "%g%g"
test NormUnbalance *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Norm_Displacement_Increment")==0)
*format "%g%g"
test NormDispIncr *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Energy_Increment")==0)
*format "%g%g"
test EnergyIncr *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Unbalance")==0)
*format "%g%g"
test RelativeNormUnbalance *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Displacement_Increment")==0)
*format "%g%g"
test RelativeNormDispIncr *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Total_Relative_Norm_Displacement_Increment")==0)
*format "%g%g"
test RelativeTotalNormDispIncr *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Energy_Increment")==0)
*format "%g%g"
test RelativeEnergyIncr *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) *LoggingFlag
*elseif(strcmp(IntvData(Convergence_criterion),"Fixed_Number_of_Iterations")==0)
*format "%g"
test FixedNumIter *IntvData(Max_Iterations_per_Step) *LoggingFlag
*endif
*else
*MessageBox Error: Invalid Analysis Options.
*endif
*# Algorithm for Transient Analysis
*if(strcmp(IntvData(Solution_algorithm),"Linear")==0)
*MessageBox Error: Invalid Analysis Options
*elseif(strcmp(IntvData(Solution_algorithm),"Full_Newton-Raphson")==0)
algorithm Newton*\
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
 -initial
*else

*endif
*elseif(strcmp(IntvData(Solution_algorithm),"Modified_Newton-Raphson")==0)
algorithm ModifiedNewton*\
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
 -initial
*else

*endif
*elseif(strcmp(IntvData(Solution_algorithm),"Newton-Raphson_with_line_search")==0)
algorithm NewtonLineSearch -type *\
*if(strcmp(IntvData(Line_search_type),"Interpolated")==0)
InitialInterpolated *\
*elseif(strcmp(IntvData(Line_search_type),"RegulaFalsi")==0)
RegulaFalsi *\
*elseif(strcmp(IntvData(Line_search_type),"Bisection")==0)
Bisection *\
*elseif(strcmp(IntvData(Line_search_type),"Secant")==0)
Secant *\
*endif
*format "%g%d%g%g"
-tol *IntvData(Search_tolerance,real) -maxIter *IntvData(Max_iterations_for_search,int) -minEta *IntvData(Min_eta_value,real) -maxEta *IntvData(max_eta_value,real)
*elseif(strcmp(IntvData(Solution_algorithm),"Broyden")==0)
*format "%d"
algorithm Broyden *IntvData(Iterations_for_new_tangent,int)
*elseif(strcmp(IntvData(Solution_algorithm),"BFGS")==0)
algorithm BFGS
*elseif(strcmp(IntvData(Solution_algorithm),"KrylovNewton")==0)
algorithm KrylovNewton
*# end if Algorithm
*endif
analysis *IntvData(Analysis_type)

*# Uniform ground motion
*if(strcmp(IntvData(Loading_type),"Uniform_excitation")==0)
*# Uniform sine ground motion
*if(strcmp(IntvData(Excitation_type),"Sine")==0)
*include UniformSine.bas
*# Uniform ground motion from record
*else
*include UniformGroundMotionRecord.bas
*endif
*# Multiple support excitations
*elseif(strcmp(IntvData(Loading_type),"Multiple_support_excitation")==0)
*format "%g%g"
set DtAnalysis *IntvData(Analysis_time_step,real)
*format "%g%g"
set TmaxAnalysis *IntvData(Analysis_duration,real)
*include SolutionAlgorithmsDynamic.bas
*elseif(strcmp(IntvData(Loading_type),"Function")==0)
*format "%g%g"
set DtAnalysis *IntvData(Analysis_time_step,real)
*format "%g%g"
set TmaxAnalysis *IntvData(Analysis_duration,real)
*include SolutionAlgorithmsDynamic.bas
*else
*format "%g%g"
set DtAnalysis *IntvData(Analysis_time_step,real)
*format "%g%g"
set TmaxAnalysis *IntvData(Analysis_duration,real)
*include SolutionAlgorithmsDynamic.bas
*endif
*# end if Analysis type (Static, Transient etc.)
*endif
