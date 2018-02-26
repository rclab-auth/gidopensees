uniaxialMaterial TzSimple1 *MaterialID *\
*if(strcmp(MatProp(t-z_backbone_curve),"Reese_and_O'Neill_relation")==0)
1 *\
*else
2 *\
*endif
*MatProp(Ultimate_capacity_tult,real) *MatProp(Displacement_at_which_the_50%_of_tult_is_mobilized_in_monotonic_loading,real) *MatProp(Viscous_damping_coefficient,real)