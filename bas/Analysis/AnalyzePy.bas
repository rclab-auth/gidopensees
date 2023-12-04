*#
*# Eigenvalue analysis
*#
*if(IntvNum==1 && GenData(Activate_eigenvalue_analysis,int)==1)
# Perform eigenvalue analysis

print("Running eigenvalue analysis")

numModes = *GenData(Number_of_eigenvalues,int)

# Record eigenvectors

for k in range(numModes):
*if(ndime==2)
    ops.recorder("Node", "-file", f"Mode_{k}.out", "-nodeRange", 1, *cntNodes, "-dof", 1, 2, f"eigen {k}")
*else
    ops.recorder("Node", "-file", f"Mode_{k}.out", "-nodeRange", 1, *cntNodes, "-dof", 1, 2, 3, f"eigen {k}")
*endif

lambda_ = ops.eigen(*\
*if(strcmp(GenData(Solver),"Default")==0)
numModes)
*elseif(strcmp(GenData(Solver),"genBandArpack")==0)
"-genBandArpack", numModes)
*elseif(strcmp(GenData(Solver),"fullGenLapack")==0)
"-fullGenLapack", numModes)
*elseif(strcmp(GenData(Solver),"symmBandLapack")==0)
"-symmBandLapack", numModes)
*endif

# Modal report

ops.modalProperties('-file', 'ModalReport.out', '-unorm')
# Calculate periods

T = []
for lam in lambda_:
    T.append(6.283185/math.sqrt(lam))

# Write periods file
period = "Periods.out"
with open(period, "w") as file:
    for index, t in enumerate(T):
        file.write(f"{t}\n")
file.close()

*endif
*if(IntvNum==1)
*if(GenData(Activate_Global_Rayleigh_damping,int)==1)
# Rayleigh damping

*format "%g%g%g%g"
ops.rayleigh(*GenData(alphaM,real), *GenData(betaK,real), *GenData(betaKinit,real), *GenData(betaKcomm,real))

*else
*include RegionsPy.bas
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
ops.wipeAnalysis()
ops.system('*IntvData(System_of_equations)')
ops.numberer('*IntvData(DOF_numberer)')
*if(strcmp(IntvData(Constraint_handler),"Penalty")==0)
*format "%g%g"
ops.constraints("Penalty", *IntvData(Penalty_as_factor,real), *IntvData(Penalty_am_factor,real))
*else
ops.constraints('*IntvData(Constraint_handler)')
*endif
*# MONOTONIC
*if(strcmp(IntvData(Loading_path),"Monotonic")==0)
*# Integrator for Static Monotonic Analysis
*if(strcmp(IntvData(Integrator_type),"Load_control")==0)
*set var steps=IntvData(Analysis_steps,int)
*set var LoadIncr=operation(1.0/steps)
*format "%g"
ops.integrator("LoadControl", *LoadIncr)
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
ops.integrator("DisplacementControl", *IntvData(Control_node), *NodeCtrlDOF, *DispIncr)
*else
*MessageBox Error: Invalid Analysis Options
*# end if Integrator type
*endif
*# Test for convergence
*if(strcmp(IntvData(Solution_algorithm),"Full_Newton-Raphson")==0 || strcmp(IntvData(Solution_algorithm),"Modified_Newton-Raphson")==0 || strcmp(IntvData(Solution_algorithm),"Newton-Raphson_with_line_search")==0 || strcmp(IntvData(Solution_algorithm),"Broyden")==0 || strcmp(IntvData(Solution_algorithm),"BFGS")==0 || strcmp(IntvData(Solution_algorithm),"KrylovNewton")==0)
*if(strcmp(IntvData(Convergence_criterion),"Norm_Unbalance")==0)
*format "%g%g"
ops.test("NormUnbalance", *IntvData(Tolerance,real), *IntvData(Max_Iterations_per_Step), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Norm_Displacement_Increment")==0)
*format "%g%g"
ops.test("NormDispIncr", *IntvData(Tolerance,real), *IntvData(Max_Iterations_per_Step), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Energy_Increment")==0)
*format "%g%g"
ops.test("EnergyIncr", *IntvData(Tolerance,real), *IntvData(Max_Iterations_per_Step), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Unbalance")==0)
*format "%g%g"
ops.test("RelativeNormUnbalance", *IntvData(Tolerance,real), *IntvData(Max_Iterations_per_Step), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Displacement_Increment")==0)
*format "%g%g"
ops.test("RelativeNormDispIncr", *IntvData(Tolerance,real), *IntvData(Max_Iterations_per_Step), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Total_Relative_Norm_Displacement_Increment")==0)
*format "%g%g"
ops.test("RelativeTotalNormDispIncr", *IntvData(Tolerance,real), *IntvData(Max_Iterations_per_Step), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Energy_Increment")==0)
*format "%g%g"
ops.test("RelativeEnergyIncr", *IntvData(Tolerance,real), *IntvData(Max_Iterations_per_Step), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Fixed_Number_of_Iterations")==0)
*format "%g"
ops.test("FixedNumIter", *IntvData(Max_Iterations_per_Step), *LoggingFlag)
*endif
*# end if test convergence
*endif
*# Algorithm for Static Monotonic
*if(strcmp(IntvData(Solution_algorithm),"Linear")==0)
ops.algorithm("Linear")
*elseif(strcmp(IntvData(Solution_algorithm),"Full_Newton-Raphson")==0)
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
ops.algorithm("Newton", secant=False, initial=True, initialThenCurrent=False)
*else
ops.algorithm("Newton")
*endif
*elseif(strcmp(IntvData(Solution_algorithm),"Modified_Newton-Raphson")==0)
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
ops.algorithm("ModifiedNewton", secant=False, initial=True)
*else
ops.algorithm("ModifiedNewton")
*endif

*elseif(strcmp(IntvData(Solution_algorithm),"Newton-Raphson_with_line_search")==0)
*if(strcmp(IntvData(Line_search_type),"Interpolated")==0)
ops.algorithm("NewtonLineSearch", Bisection=False, Secant=False, RegulaFalsi=False, InitialInterpolated=True, *\
*elseif(strcmp(IntvData(Line_search_type),"RegulaFalsi")==0)
ops.algorithm("NewtonLineSearch", Bisection=False, Secant=False, RegulaFalsi=True, InitialInterpolated=False, *\
*elseif(strcmp(IntvData(Line_search_type),"Bisection")==0)
ops.algorithm("NewtonLineSearch", Bisection=True, Secant=False, RegulaFalsi=False, InitialInterpolated=False, *\
*elseif(strcmp(IntvData(Line_search_type),"Secant")==0)
ops.algorithm("NewtonLineSearch", Bisection=False, Secant=True, RegulaFalsi=False, InitialInterpolated=False, *\
*endif
*format "%g%d%g%g"
"-tol", *IntvData(Search_tolerance,real), "-maxIter", *IntvData(Max_iterations_for_search,int), "-minEta", *IntvData(Min_eta_value,real), "-maxEta", *IntvData(max_eta_value,real))
*elseif(strcmp(IntvData(Solution_algorithm),"Broyden")==0)
*format "%d"
ops.algorithm("Broyden", *IntvData(Iterations_for_new_tangent,int))
*elseif(strcmp(IntvData(Solution_algorithm),"BFGS")==0)
ops.algorithm("BFGS")
*elseif(strcmp(IntvData(Solution_algorithm),"KrylovNewton")==0)
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
ops.algorithm("KrylovNewton", iterate="initial", increment="initial", *\
*else
ops.algorithm("KrylovNewton", iterate="current", increment="current", *\
*endif
maxDim=*IntvData(Max_iterations_until_tangent_is_reformed,int))
*# end if algorithm
*else
*endif
*#
*# ANALYSIS
*#
ops.analysis('*IntvData(Analysis_type)')
*if(strcmp(IntvData(Solution_algorithm),"Linear")!=0 && strcmp(IntvData(Integrator_type),"Displacement_control")==0)
*#
*# Pushover analysis (Displacement Control)
*#
*include StaticDisplacementControlPy.bas
*elseif(strcmp(IntvData(Solution_algorithm),"Linear")!=0 && strcmp(IntvData(Integrator_type),"Load_control")==0)
*#
*# Pushover analysis analysis (Load Control)
*#
*include StaticLoadControlPy.bas
*else
*#
*# Linear analysis
*#
committedSteps = 1
*format "%d"
for i in range(*steps):
    AnalOk = ops.analyze(1)
    if AnalOk !=0:
        break
    else:
        committedSteps += 1
if AnalOk == 0:
    print("Analysis completed SUCCESSFULLY")
    print(f"Committed steps : {committedSteps}")
else:
    print("Analysis FAILED")
    print(f"Committed steps : {committedSteps}")
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
ops.integrator("DisplacementControl", *IntvData(Control_node), *NodeCtrlDOF, *DispIncr)
*else
*MessageBox Error: Invalid Analysis Options
*# end if Integrator type
*endif
*# Test for convergence
*if(strcmp(IntvData(Solution_algorithm),"Full_Newton-Raphson")==0 || strcmp(IntvData(Solution_algorithm),"Modified_Newton-Raphson")==0 || strcmp(IntvData(Solution_algorithm),"Newton-Raphson_with_line_search")==0 || strcmp(IntvData(Solution_algorithm),"Broyden")==0 || strcmp(IntvData(Solution_algorithm),"BFGS")==0 || strcmp(IntvData(Solution_algorithm),"KrylovNewton")==0)
*if(strcmp(IntvData(Convergence_criterion),"Norm_Unbalance")==0)
*format "%g%g"
ops.test("NormUnbalance", *IntvData(Tolerance,real), *IntvData(Max_Iterations_per_Step), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Norm_Displacement_Increment")==0)
*format "%g%g"
ops.test("NormDispIncr", *IntvData(Tolerance,real), *IntvData(Max_Iterations_per_Step), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Energy_Increment")==0)
*format "%g%g"
ops.test("EnergyIncr", *IntvData(Tolerance,real), *IntvData(Max_Iterations_per_Step), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Unbalance")==0)
*format "%g%g"
ops.test("RelativeNormUnbalance", *IntvData(Tolerance,real), *IntvData(Max_Iterations_per_Step), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Displacement_Increment")==0)
*format "%g%g"
ops.test("RelativeNormDispIncr", *IntvData(Tolerance,real), *IntvData(Max_Iterations_per_Step), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Total_Relative_Norm_Displacement_Increment")==0)
*format "%g%g"
ops.test("RelativeTotalNormDispIncr", *IntvData(Tolerance,real), *IntvData(Max_Iterations_per_Step), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Energy_Increment")==0)
*format "%g%g"
ops.test("RelativeEnergyIncr", *IntvData(Tolerance,real), *IntvData(Max_Iterations_per_Step), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Fixed_Number_of_Iterations")==0)
*format "%g"
ops.test("FixedNumIter", *IntvData(Max_Iterations_per_Step), *LoggingFlag)
*endif
*endif
*# Algorithm for Static Cyclic
*if(strcmp(IntvData(Solution_algorithm),"Linear")==0)
*MessageBox Error: Invalid Analysis Options
*elseif(strcmp(IntvData(Solution_algorithm),"Full_Newton-Raphson")==0)
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
ops.algorithm("Newton", secant=False, initial=True, initialThenCurrent=False)
*else
ops.algorithm("Newton")
*endif
*elseif(strcmp(IntvData(Solution_algorithm),"Modified_Newton-Raphson")==0)
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
ops.algorithm("ModifiedNewton", secant=False, initial=True)
*else
ops.algorithm("ModifiedNewton")
*endif
*elseif(strcmp(IntvData(Solution_algorithm),"Newton-Raphson_with_line_search")==0)
*if(strcmp(IntvData(Line_search_type),"Interpolated")==0)
ops.algorithm("NewtonLineSearch", Bisection=False, Secant=False, RegulaFalsi=False, InitialInterpolated=True, *\
*elseif(strcmp(IntvData(Line_search_type),"RegulaFalsi")==0)
ops.algorithm("NewtonLineSearch", Bisection=False, Secant=False, RegulaFalsi=True, InitialInterpolated=False, *\
*elseif(strcmp(IntvData(Line_search_type),"Bisection")==0)
ops.algorithm("NewtonLineSearch", Bisection=True, Secant=False, RegulaFalsi=False, InitialInterpolated=False, *\
*elseif(strcmp(IntvData(Line_search_type),"Secant")==0)
ops.algorithm("NewtonLineSearch", Bisection=False, Secant=True, RegulaFalsi=False, InitialInterpolated=False, *\
*endif
*format "%g%d%g%g"
"-tol", *IntvData(Search_tolerance,real), "-maxIter", *IntvData(Max_iterations_for_search,int), "-minEta", *IntvData(Min_eta_value,real), "-maxEta", *IntvData(max_eta_value,real))
*elseif(strcmp(IntvData(Solution_algorithm),"Broyden")==0)
*format "%d"
ops.algorithm("Broyden", *IntvData(Iterations_for_new_tangent,int))
*elseif(strcmp(IntvData(Solution_algorithm),"BFGS")==0)
ops.algorithm("BFGS")
*elseif(strcmp(IntvData(Solution_algorithm),"KrylovNewton")==0)
ops.algorithm("KrylovNewton")
*# end if Algorithm
*endif
ops.analysis('*IntvData(Analysis_type)')
*include StaticCyclicAnalysisPy.bas
*# end if path is cyclic
*endif
*#
*# Transient analysis
*#
*elseif(strcmp(IntvData(Analysis_type),"Transient")==0)
ops.wipeAnalysis()
ops.system('*IntvData(System_of_equations)')
ops.numberer('*IntvData(DOF_numberer)')
*if(strcmp(IntvData(Constraint_handler),"Penalty")==0)
*format "%g%g"
ops.constraints("Penalty", *IntvData(Penalty_as_factor,real), *IntvData(Penalty_am_factor,real))
*else
ops.constraints('*IntvData(Constraint_handler)')
*endif
*if(strcmp(IntvData(Integrator_type),"Newmark")==0)
*format "%g%g"
ops.integrator("Newmark", *IntvData(gamma,real), *IntvData(beta,real))
*elseif(strcmp(IntvData(Integrator_type),"Hilber-Hughes-Taylor")==0)
*format "%g%g%g"
ops.integrator("HHT", *IntvData(alpha,real), *IntvData(gamma,real), *IntvData(beta,real))
*else
*MessageBox Error: Invalid Analysis Options.
*endif
*# Test for convergence
*if(strcmp(IntvData(Solution_algorithm),"Linear")!=0)
*if(strcmp(IntvData(Convergence_criterion),"Norm_Unbalance")==0)
*format "%g%g"
ops.test("NormUnbalance", *IntvData(Tolerance,real), *IntvData(Max_Iterations_per_Step), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Norm_Displacement_Increment")==0)
*format "%g%g"
ops.test("NormDispIncr", *IntvData(Tolerance,real), *IntvData(Max_Iterations_per_Step), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Energy_Increment")==0)
*format "%g%g"
ops.test("EnergyIncr", *IntvData(Tolerance,real), *IntvData(Max_Iterations_per_Step), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Unbalance")==0)
*format "%g%g"
ops.test("RelativeNormUnbalance", *IntvData(Tolerance,real), *IntvData(Max_Iterations_per_Step), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Displacement_Increment")==0)
*format "%g%g"
ops.test("RelativeNormDispIncr", *IntvData(Tolerance,real), *IntvData(Max_Iterations_per_Step), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Total_Relative_Norm_Displacement_Increment")==0)
*format "%g%g"
ops.test("RelativeTotalNormDispIncr", *IntvData(Tolerance,real), *IntvData(Max_Iterations_per_Step), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Energy_Increment")==0)
*format "%g%g"
ops.test("RelativeEnergyIncr", *IntvData(Tolerance,real), *IntvData(Max_Iterations_per_Step), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Fixed_Number_of_Iterations")==0)
*format "%g"
ops.test("FixedNumIter", *IntvData(Max_Iterations_per_Step), *LoggingFlag)
*endif
*else
*MessageBox Error: Invalid Analysis Options.
*endif
*# Algorithm for Transient Analysis
*if(strcmp(IntvData(Solution_algorithm),"Linear")==0)
*MessageBox Error: Invalid Analysis Options
*elseif(strcmp(IntvData(Solution_algorithm),"Full_Newton-Raphson")==0)
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
ops.algorithm("Newton", secant=False, initial=True, initialThenCurrent=False)
*else
ops.algorithm("Newton")
*endif
*elseif(strcmp(IntvData(Solution_algorithm),"Modified_Newton-Raphson")==0)
algorithm ModifiedNewton*\
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
ops.algorithm("ModifiedNewton", secant=False, initial=True)
*else
ops.algorithm("ModifiedNewton")
*endif
*elseif(strcmp(IntvData(Solution_algorithm),"Newton-Raphson_with_line_search")==0)
*if(strcmp(IntvData(Line_search_type),"Interpolated")==0)
ops.algorithm("NewtonLineSearch", Bisection=False, Secant=False, RegulaFalsi=False, InitialInterpolated=True, *\
*elseif(strcmp(IntvData(Line_search_type),"RegulaFalsi")==0)
ops.algorithm("NewtonLineSearch", Bisection=False, Secant=False, RegulaFalsi=True, InitialInterpolated=False, *\
*elseif(strcmp(IntvData(Line_search_type),"Bisection")==0)
ops.algorithm("NewtonLineSearch", Bisection=True, Secant=False, RegulaFalsi=False, InitialInterpolated=False, *\
*elseif(strcmp(IntvData(Line_search_type),"Secant")==0)
ops.algorithm("NewtonLineSearch", Bisection=False, Secant=True, RegulaFalsi=False, InitialInterpolated=False, *\
*endif
*format "%g%d%g%g"
"-tol", *IntvData(Search_tolerance,real), "-maxIter", *IntvData(Max_iterations_for_search,int), "-minEta", *IntvData(Min_eta_value,real), "-maxEta", *IntvData(max_eta_value,real))
*elseif(strcmp(IntvData(Solution_algorithm),"Broyden")==0)
*format "%d"
ops.algorithm("Broyden", *IntvData(Iterations_for_new_tangent,int))
*elseif(strcmp(IntvData(Solution_algorithm),"BFGS")==0)
ops.algorithm("BFGS")
*elseif(strcmp(IntvData(Solution_algorithm),"KrylovNewton")==0)
ops.algorithm("KrylovNewton")
*# end if Algorithm
*endif
ops.analysis('*IntvData(Analysis_type)')

*# Uniform ground motion
*if(strcmp(IntvData(Loading_type),"Uniform_excitation")==0)
*# Uniform sine ground motion
*if(strcmp(IntvData(Excitation_type),"Sine")==0)
*include UniformSinePy.bas
*# Uniform ground motion from record
*else
*include UniformGroundMotionRecordPy.bas
*endif
*# Multiple support excitations
*elseif(strcmp(IntvData(Loading_type),"Multiple_support_excitation")==0)
*format "%g%g"
DtAnalysis = *IntvData(Analysis_time_step,real)
*format "%g%g"
TmaxAnalysis = *IntvData(Analysis_duration,real)
*include SolutionAlgorithmsDynamicPy.bas
*elseif(strcmp(IntvData(Loading_type),"Function")==0)
*format "%g%g"
DtAnalysis = *IntvData(Analysis_time_step,real)
*format "%g%g"
TmaxAnalysis = *IntvData(Analysis_duration,real)
*include SolutionAlgorithmsDynamicPy.bas
*else
*format "%g%g"
DtAnalysis = *IntvData(Analysis_time_step,real)
*format "%g%g"
TmaxAnalysis = *IntvData(Analysis_duration,real)
*include SolutionAlgorithmsDynamicPy.bas
*endif
*# end if Analysis type (Static, Transient etc.)
*endif
