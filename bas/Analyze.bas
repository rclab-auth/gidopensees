
#
# Analysis options
#

*if(GenData(Perform_eigen_analysis,int)==1)
*#------------------------------------------------
*#              Eigen analysis
*#------------------------------------------------
# perform eigen analysis

file mkdir modes;
set numModes *GenData(Number_of_eigenvalues,int)
set NumOfEigenValuesFile [open "NumOfEigenValues.out" w]
puts $NumOfEigenValuesFile "$numModes"
close $NumOfEigenValuesFile

# record eigenvectors

*loop nodes
*set var nodeRangeLastNode=NodesNum
*end nodes
for { set k 1 } { $k <= $numModes } { incr k } {
*if(GenData(DOF,int)==3)
  recorder Node -file [format "modes/mode%i.out" $k] -nodeRange 1 *nodeRangeLastNode -dof 1 2 3  "eigen $k"
*elseif(GenData(DOF,int)==6)
  recorder Node -file [format "modes/mode%i.out" $k] -nodeRange 1 *nodeRangeLastNode -dof 1 2 3 4 5 6 "eigen $k"
*else 
  recorder Node -file [format "modes/mode%i.out" $k] -nodeRange 1 *nodeRangeLastNode -dof 1 2   "eigen $k"
*endif
}
set lambda [eigen *GenData(Solver) $numModes];

# calculate frequencies and periods of the structure

set omega {}
set f {}
set T {}
set pi 3.141593
*set var pi=3.141593

foreach lam $lambda {
  lappend omega [expr sqrt($lam)]
  lappend f [expr sqrt($lam)/(*operation(2*pi))]
  lappend T [expr (*operation(2*pi))/sqrt($lam)]
}

# write the output file cosisting of periods

set period "modes/Periods.txt"
set Periods [open $period "w"]
foreach t $T {
  puts $Periods " $t"
}
close $Periods

*endif
*#----------------------------
*# Analysis Options
*#----------------------------
*if(strcmp(GenData(System_of_Equation_Type),"BandGeneral")==0)
system *GenData(system);  # how to store and solve the system of equations in the analysis (large model: try UmfPack)
*else
system *GenData(system)
*endif
*if(strcmp(GenData(DOF_Numberer_Type),"RCM")==0)
numberer *GenData(DOF_Numberer_Type);  # renumber dof's to minimize band-width (optimization), if you want to
*else
numberer *GenData(DOF_Numberer_Type)
*endif
constraints *GenData(Constraint_Handler_Type);  # how it handles boundary conditions
integrator *\ 
*if(strcmp(GenData(Integrator_Type),"Load_Control")==0)
LoadControl *GenData(Load_factor_increment) *GenData(Number_of_interations) *GenData(Minimum_stepsize) *GenData(Maximum_stepsize) *GenData(Type_of_norm)
*elseif(strcmp(GenData(Integrator_Type),"Displacement_Control")==0)
DisplacementControl *GenData(Node_controler) *GenData(Dof_at_the_node) *GenData(First_displacement_increment_ΔUdof)
*endif
*if(GenData(Use_test,int)==1)
*if(strcmp(GenData(Convergence_Test_Type),"Energy_Increment")==0)
test EnergyIncr *GenData(Tolerance,real) *GenData(Maximum_iterations) *GenData(Display)
*elseif(strcmp(GenData(Convergence_Test_Type),"Norm_Displacement_Increment")==0)
test NormDispIncr *GenData(Tolerance,real) *GenData(Maximum_iterations) *GenData(Display)
*endif
*endif
*if(strcmp(GenData(Solution_Algorithm_Type),"Newton")==0)
algorithm *GenData(Solution_Algorithm_Type);  # use Newton's solution algorithm: updates tangent stiffness at every iteration
*else
algorithm *GenData(Solution_Algorithm_Type)
*endif
analysis *GenData(Analysis);  # define type of analysis
*#
*include recorders.bas
*#

logFile log.txt

puts "OpenSees Analysis\n"

set time_start [clock seconds]
puts "Analysis started  : [clock format $time_start -format %H:%M:%S]"

*set var steps=operation(1.0/GenData(Load_factor_increment,real))
*format "%1.0f"
analyze *steps

set time_finish [clock seconds]
puts "Analysis finished : [clock format $time_finish -format %H:%M:%S]"
puts "Analysis time     : [expr $time_finish - $time_start] seconds"

*if(GenData(Dimensions,int)==3)
print NodesDisp3D.out -node 
*else
print NodesDisp2D.out -node 
*endif
*if(file==2)
*if(GenData(Dimensions,int)==3)
print ElemForces.out -ele 
*else
print ElemForces2d.out -ele 
*endif
*elseif(file==4)
print ElemStresses.out -ele 
*endif
