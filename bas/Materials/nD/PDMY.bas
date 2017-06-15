*format "%d%d%g%g%g"
nDMaterial PressureDependMultiYield *MaterialID *ndime *MatProp(Saturated_soil_mass_density,real) *MatProp(Reference_shear_modulus_Gr,real) *MatProp(Reference_bulk_modulus,real) *\
*format "%g%g%g%g"
*MatProp(Friction_angle,real) *MatProp(Shear_strain_at_which_maximum_stress_is_reached,real) *MatProp(Reference_mean_effective_confining_pressure_pr,real) *MatProp(Positive_constant_d,real) *\
*format "%g%g%g%g"
*MatProp(Phase_transformation_angle,real) *MatProp(Contraction_rate_constant,real) *MatProp(Dilation_rate_constant_1,real) *MatProp(Dilation_rate_constant_2,real) *\
*format "%g%g%g"
*MatProp(Liquefaction_parameter_1,real) *MatProp(Liquefaction_parameter_2,real) *MatProp(Liquefaction_parameter_3,real) *\
*if(MatProp(Automatic_surface_generation,int)==1)
*format "%d"
*MatProp(Yield_surfaces,int) *\
*else
*format "%d"
-*MatProp(Yield_surfaces,int) *\
*set var Nmatrix=MatProp(Define_yield_surfaces_based_on_shear_modulus_reduction_curve,int)
*for(i=1;i<=Nmatrix;i=i+2)
*format "%g%g"
*MatProp(Define_yield_surfaces_based_on_shear_modulus_reduction_curve,*i) *MatProp(Define_yield_surfaces_based_on_shear_modulus_reduction_curve,*operation(i+1)) *\
*endfor
*endif
*format "%g%g%g%g%g%g"
*MatProp(Initial_void_ratio,real) *MatProp(Critical_straight_line_parameter_cs1,real) *MatProp(Critical_straight_line_parameter_cs2,real) *MatProp(Critical_straight_line_parameter_cs3,real) *MatProp(Atmospheric_pressure_for_normalization,real) *MatProp(Numerical_constant,real)