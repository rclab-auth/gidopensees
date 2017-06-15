*format "%d%g%g%g"
*if(strcmp(MatProp(Formulation),"Stress-Strain")==0)
uniaxialMaterial Steel01 *MaterialID *MatProp(Yield_Stress_Fy,real) *MatProp(Initial_elastic_tangent_E0,real) *MatProp(Strain-hardening_ratio_b,real)
*elseif(strcmp(MatProp(Formulation),"Force-Deformation")==0)
uniaxialMaterial Steel01 *MaterialID *MatProp(Force_Fy,real) *MatProp(Initial_stiffness_K,real) *MatProp(Strain-hardening_ratio_b,real)
*else
uniaxialMaterial Steel01 *MaterialID *MatProp(Moment_My,real) *MatProp(Moment_per_rotation_unit,real) *MatProp(Strain-hardening_ratio_b,real)
*endif