*format "%d%g%g%g%g%g%g%g%g"
ops.uniaxialMaterial("Concrete06", *MaterialID, *MatProp(Concrete_compressive_strength_fc,real), *MatProp(Strain_at_compressive_strength_e0,real), *MatProp(Compressive_shape_factor_n,real), *MatProp(Post-peak_compressive_shape_factor_k,real), *MatProp(Parameter_a1_for_compressive_plastic_strain_definition,real), *MatProp(Tensile_strength_fcr,real), *MatProp(Tensile_strain_at_peak_stress_ecr,real), *MatProp(Exponent_of_the_tension_stiffering_curve_b,real), *MatProp(Parameter_a2_for_tensile_plastic_strain_definition,real))