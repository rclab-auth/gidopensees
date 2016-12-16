*#
*# Eigenvalue analysis
*#
*if(IntvNum==1 && GenData(Activate_eigenvalue_analysis,int)==1)

# Perform eigenvalue analysis

set numModes *GenData(Number_of_eigenvalues,int)

# Record eigenvectors

for { set k 1 } { $k <= $numModes } { incr k } {
*if(GenData(Dimensions,int)==3)
*if(GenData(DOF,int)==3)
  recorder Node -file [format "Mode_%i.out" $k] -nodeRange 1 *cntNodes -dof 1 2 3  "eigen $k"
*else
  recorder Node -file [format "Mode_%i.out" $k] -nodeRange 1 *cntNodes -dof 1 2 3 4 5 6 "eigen $k"
*endif
*else
*if(GenData(DOF,int)==2)
  recorder Node -file [format "Mode_%i.out" $k] -nodeRange 1 *cntNodes -dof 1 2   "eigen $k"
*else
  recorder Node -file [format "Mode_%i.out" $k] -nodeRange 1 *cntNodes -dof 1 2 6  "eigen $k" 
*endif
*endif
}

set lambda [eigen *\
*if(strcmp(GenData(Solver),"genBandArpack")==0)
-genBandArpack $numModes];
*elseif(strcmp(GenData(Solver),"fullGenLapack")==0)
-fullGenLapack $numModes];
*elseif(strcmp(GenData(Solver),"symmBandLapack")==0)
-symmBandLapack $numModes];
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
*if(IntvNum==1 && GenData(Activate_Reyleigh_damping,int)==1)

# Rayleigh damping

*format "%g%g%g%g"
rayleigh *GenData(alphaM,real) *GenData(betaK,real) *GenData(betaKinit,real) *GenData(betaKcomm,real)
*endif
*#
*# Analysis Options
*#

# Analysis options

system *IntvData(System_of_Equations)
numberer *IntvData(DOF_Numberer)
constraints *IntvData(Constraint_Handler)
*# Check for cyclic loading. If not, integrator command is written normally 
*if(strcmp(IntvData(Loading_Path),"Monotonic")==0)
*if(strcmp(IntvData(Integrator_Type),"Load_Control")==0)
*set var steps=IntvData(Analysis_Steps,int)
*set var LoadIncr=operation(1.0/steps)
*format "%g"
integrator LoadControl *LoadIncr 
*elseif(strcmp(IntvData(Integrator_Type),"Displacement_Control")==0)
*set var steps=IntvData(Analysis_Steps,int)
*set var DispIncr=operation(IntvData(Total_Displacement,real)/steps)
*if(strcmp(IntvData(Control_Node_Direction),"UX")==0)
*set var NodeCtrlDOF=1
*elseif(strcmp(IntvData(Control_Node_Direction),"UY")==0)
*set var NodeCtrlDOF=2
*elseif(strcmp(IntvData(Control_Node_Direction),"YZ")==0)
*set var NodeCtrlDOF=3
*elseif(strcmp(IntvData(Control_Node_Direction),"RX")==0)
*set var NodeCtrlDOF=4
*elseif(strcmp(IntvData(Control_Node_Direction),"RY")==0)
*set var NodeCtrlDOF=5
*elseif(strcmp(IntvData(Control_Node_Direction),"RZ")==0)
*set var NodeCtrlDOF=6
*endif
*format "%g%d%g"
integrator DisplacementControl *IntvData(Control_Node) *NodeCtrlDOF *DispIncr
*elseif(strcmp(IntvData(Integrator_Type),"Newmark")==0)
integrator Newmark *IntvData(gamma,real) *IntvData(beta,real)
*elseif(strcmp(IntvData(Integrator_Type),"Hilber-Hughes-Taylor")==0)
integrator Newmark *IntvData(alpha,real) *IntvData(gamma,real) *IntvData(beta,real)
*endif
*endif
*if(strcmp(IntvData(Solution_Algorithm),"Full_Newton-Raphson")==0 || strcmp(IntvData(Solution_Algorithm),"Modified_Newton-Raphson")==0)
*if(strcmp(IntvData(Convergence_Criteria_Type),"Norm_Unbalance")==0)
*format "%g%g"
test NormUnbalance *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) 1
*elseif(strcmp(IntvData(Convergence_Criteria_Type),"Norm_Displacement_Increment")==0)
*format "%g%g"
test NormDispIncr *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) 1
*elseif(strcmp(IntvData(Convergence_Criteria_Type),"Energy_Increment")==0)
*format "%g%g"
test EnergyIncr *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) 1
*elseif(strcmp(IntvData(Convergence_Criteria_Type),"Relative_Norm_Unbalance")==0)
*format "%g%g"
test RelativeNormUnbalance *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) 1
*elseif(strcmp(IntvData(Convergence_Criteria_Type),"Relative_Norm_Displacement_Increment")==0)
*format "%g%g"
test RelativeNormDispIncr *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) 1
*elseif(strcmp(IntvData(Convergence_Criteria_Type),"Total_Relative_Norm_Displacement_Increment")==0)
*format "%g%g"
test RelativeTotalNormDispIncr *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) 1
*elseif(strcmp(IntvData(Convergence_Criteria_Type),"Relative_Energy_Increment")==0)
*format "%g%g"
test RelativeEnergyIncr *IntvData(Tolerance,real) *IntvData(Max_Iterations_per_Step) 1
*elseif(strcmp(IntvData(Convergence_Criteria_Type),"Fixed_Number_of_Iterations")==0)
*format "%g"
test FixedNumIter *IntvData(Max_Iterations_per_Step) 1
*endif
*endif
*if(strcmp(IntvData(Solution_Algorithm),"Linear")==0)
algorithm Linear 
*elseif(strcmp(IntvData(Solution_Algorithm),"Full_Newton-Raphson")==0)
algorithm Newton *\
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
-initial 
*else

*endif
*elseif(strcmp(IntvData(Solution_Algorithm),"Modified_Newton-Raphson")==0)
algorithm ModifiedNewton *\
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
-initial 
*else

*endif
*endif
analysis *IntvData(Analysis_Type)
*# For integrator command check if the loading is cyclic 
*# For cyclic loading
*if(strcmp(IntvData(Loading_Path),"Cyclic")==0)

*if(strcmp(IntvData(Integrator_Type),"Displacement_Control")==0)
*set var steps=IntvData(Analysis_Steps,int)
*set var NCycles=IntvData(Number_of_Cycles,int)
*if(strcmp(IntvData(Control_Node_Direction),"UX")==0)
*set var NodeCtrlDOF=1
*elseif(strcmp(IntvData(Control_Node_Direction),"UY")==0)
*set var NodeCtrlDOF=2
*elseif(strcmp(IntvData(Control_Node_Direction),"UZ")==0)
*set var NodeCtrlDOF=3
*elseif(strcmp(IntvData(Control_Node_Direction),"RX")==0)
*set var NodeCtrlDOF=4
*elseif(strcmp(IntvData(Control_Node_Direction),"RY")==0)
*set var NodeCtrlDOF=5
*elseif(strcmp(IntvData(Control_Node_Direction),"RZ")==0)
*set var NodeCtrlDOF=6
*endif
*set var DispIncr=operation(IntvData(Total_Displacement,real)/steps)
*else
*MessageBox Error: For Cyclic loading, only Displacement Control is valid.
*endif
*for(i=1;i<=NCycles;i=i+1)
*format "%g%g%g)
foreach Dincr {*DispIncr *operation(-2*DispIncr) *DispIncr} {
*format "%6d%3d"
integrator DisplacementControl *IntvData(Control_Node) *NodeCtrlDOF $Dincr
analyze *steps
}
*endfor
*# For monotonic loading
*else
analyze *steps
*endif