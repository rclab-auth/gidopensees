uniaxialMaterial PySimple1 *MaterialID *\
*if(strcmp(MatProp(p-y_backbone_curve),"Soft_clay")==0)
1 *\
*else
2 *\
*endif
*MatProp(Ultimate_capacity_pult,real) *MatProp(Displacement_at_which_the_50%_of_pult_is_mobilized_in_monotonic_loading,real) *MatProp(Coefficient_Cd,real) *MatProp(Viscous_damping_coefficient,real)