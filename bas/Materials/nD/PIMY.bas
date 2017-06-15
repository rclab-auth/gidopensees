*format "%d%d%g%g%g%g%g%g%g%g%g"
nDMaterial PressureIndependMultiYield *MaterialID *ndime *MatProp(Saturated_soil_mass_density,real) *MatProp(Reference_shear_modulus_Gr,real) *MatProp(Reference_bulk_modulus,real) *MatProp(Apparent_cohesion,real) *MatProp(Shear_strain_at_which_maximum_stress_is_reached,real) *MatProp(Friction_angle,real) *MatProp(Reference_mean_effective_confining_pressure_pr,real) *MatProp(Positive_constant_d,real) *\
*if(MatProp(Automatic_surface_generation,int)==1)
*MatProp(Yield_surfaces,int)
*else
-*MatProp(Yield_surfaces,int) *\
*set var Narray=MatProp(Define_yield_surfaces_based_on_shear_modulus_reduction_curve,int)
*for(i=1;i<=Narray;i=i+2)
*format "%g%g"
*MatProp(Define_yield_surfaces_based_on_shear_modulus_reduction_curve,*i) *MatProp(Define_yield_surfaces_based_on_shear_modulus_reduction_curve,*operation(i+1)) *\
*endfor

*endif