*format "%d%g%g%g"
uniaxialMaterial ViscousDamper *MaterialID *MatProp(Elastic_Stiffness,real) *MatProp(Damping_coefficient_Cd,real) *\
*MatProp(Velocity_exponent_alpha,real) *\
*if(MatProp(Activate_gap_length,int)==1)
*format "%g"
*MatProp(Gap_length,real)
*else

*endif