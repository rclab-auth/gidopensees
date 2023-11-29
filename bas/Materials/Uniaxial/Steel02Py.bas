*format "%d%g%g%g"
*if(strcmp(MatProp(Formulation),"Stress-Strain")==0)
ops.uniaxialMaterial("Steel02", *MaterialID, *MatProp(Yield_Stress_Fy,real), *MatProp(Initial_elastic_tangent_E0,real), *MatProp(Strain-hardening_ratio_b,real), *\
*format "%g%g%g"
*MatProp(Parameter_R0,real), *MatProp(Parameter_cR1,real), *MatProp(Parameter_cR2,real), *\
*format "%g%g%g%g%g"
*MatProp(Isotropic_hardening_parameter_a1,real), *MatProp(Isotropic_hardening_parameter_a2,real), *MatProp(Isotropic_hardening_parameter_a3,real), *MatProp(Isotropic_hardening_parameter_a4,real), *MatProp(Initial_stress,real))
*elseif(strcmp(MatProp(Formulation),"Force-Deformation")==0)
ops.uniaxialMaterial("Steel02", *MaterialID, *MatProp(Force_Fy,real), *MatProp(Initial_stiffness_K,real), *MatProp(Strain-hardening_ratio_b,real), *\
*format "%g%g%g"
*MatProp(Parameter_R0,real), *MatProp(Parameter_cR1,real), *MatProp(Parameter_cR2,real), *\
*format "%g%g%g%g%g"
*MatProp(Isotropic_hardening_parameter_a1,real), *MatProp(Isotropic_hardening_parameter_a2,real), *MatProp(Isotropic_hardening_parameter_a3,real), *MatProp(Isotropic_hardening_parameter_a4,real), *MatProp(Initial_stress,real))
*else
ops.uniaxialMaterial("Steel02", *MaterialID, *MatProp(Moment_My,real), *MatProp(Moment_per_rotation_unit,real), *MatProp(Strain-hardening_ratio_b,real), *\
*format "%g%g%g"
*MatProp(Parameter_R0,real), *MatProp(Parameter_cR1,real), *MatProp(Parameter_cR2,real), *\
*format "%g%g%g%g%g"
*MatProp(Isotropic_hardening_parameter_a1,real), *MatProp(Isotropic_hardening_parameter_a2,real), *MatProp(Isotropic_hardening_parameter_a3,real), *MatProp(Isotropic_hardening_parameter_a4,real), *MatProp(Initial_stress,real))
*endif 