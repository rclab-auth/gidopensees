*if(MatProp(Set_as_variable,int)==1)



*if(strcmp(MatProp(Formulation),"Stress-Strain")==0)
*format "%d%g"
steel01_*MaterialID_Fy = *MatProp(Yield_Stress_Fy,real)
steel01_*MaterialID_E0 = *MatProp(Initial_elastic_tangent_E0,real)
steel01_*MaterialID_b = *MatProp(Strain-hardening_ratio_b,real)
steel01_*MaterialID_a1 = *MatProp(Isotropic_hardening_parameter_a1,real)
steel01_*MaterialID_a2 = *MatProp(Isotropic_hardening_parameter_a2,real)
steel01_*MaterialID_a3 = *MatProp(Isotropic_hardening_parameter_a3,real)
steel01_*MaterialID_a4 = *MatProp(Isotropic_hardening_parameter_a4,real)
*format "%d%d%d%d%d%d%d%d"
ops.uniaxialMaterial("Steel01", *MaterialID, steel01_*MaterialID_Fy, steel01_*MaterialID_E0, steel01_*MaterialID_b, steel01_*MaterialID_a1, steel01_*MaterialID_a2, steel01_*MaterialID_a3, *MatProp(Isotropic_hardening_parameter_a4,real))
*elseif(strcmp(MatProp(Formulation),"Force-Deformation")==0)
ops.uniaxialMaterial("Steel01", *MaterialID, *MatProp(Force_Fy,real), *MatProp(Initial_stiffness_K,real), *MatProp(Strain-hardening_ratio_b,real), *MatProp(Isotropic_hardening_parameter_a1,real), *MatProp(Isotropic_hardening_parameter_a2,real), *MatProp(Isotropic_hardening_parameter_a3,real), *MatProp(Isotropic_hardening_parameter_a4,real))
*else
ops.uniaxialMaterial("Steel01", *MaterialID, *MatProp(Moment_My,real), *MatProp(Moment_per_rotation_unit,real), *MatProp(Strain-hardening_ratio_b,real), *MatProp(Isotropic_hardening_parameter_a1,real), *MatProp(Isotropic_hardening_parameter_a2,real), *MatProp(Isotropic_hardening_parameter_a3,real), *MatProp(Isotropic_hardening_parameter_a4,real))
*endif

*else

*format "%d%g%g%g%g%g%g%g"
*if(strcmp(MatProp(Formulation),"Stress-Strain")==0)
ops.uniaxialMaterial("Steel01", *MaterialID, *MatProp(Yield_Stress_Fy,real), *MatProp(Initial_elastic_tangent_E0,real), *MatProp(Strain-hardening_ratio_b,real), *MatProp(Isotropic_hardening_parameter_a1,real), *MatProp(Isotropic_hardening_parameter_a2,real), *MatProp(Isotropic_hardening_parameter_a3,real), *MatProp(Isotropic_hardening_parameter_a4,real))
*elseif(strcmp(MatProp(Formulation),"Force-Deformation")==0)
ops.uniaxialMaterial("Steel01", *MaterialID, *MatProp(Force_Fy,real), *MatProp(Initial_stiffness_K,real), *MatProp(Strain-hardening_ratio_b,real), *MatProp(Isotropic_hardening_parameter_a1,real), *MatProp(Isotropic_hardening_parameter_a2,real), *MatProp(Isotropic_hardening_parameter_a3,real), *MatProp(Isotropic_hardening_parameter_a4,real))
*else
ops.uniaxialMaterial("Steel01", *MaterialID, *MatProp(Moment_My,real), *MatProp(Moment_per_rotation_unit,real), *MatProp(Strain-hardening_ratio_b,real), *MatProp(Isotropic_hardening_parameter_a1,real), *MatProp(Isotropic_hardening_parameter_a2,real), *MatProp(Isotropic_hardening_parameter_a3,real), *MatProp(Isotropic_hardening_parameter_a4,real))
*endif

*endif



