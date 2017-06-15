*format "%d%g%g%g"
*if(strcmp(MatProp(Formulation),"Stress-Strain")==0)
uniaxialMaterial ElasticPPGap *MaterialID *MatProp(Elastic_modulus_E,real) *MatProp(Yield_Stress_Fy,real) *MatProp(Strain_gap,real)
*elseif(strcmp(MatProp(Formulation),"Force-Deformation")==0)
uniaxialMaterial ElasticPPGap *MaterialID *MatProp(Stiffness_K,real) *MatProp(Force_Fy,real) *MatProp(Deformation_gap,real)
*else
uniaxialMaterial ElasticPPGap *MaterialID *MatProp(Moment_per_rotation_unit,real) *MatProp(Moment_My,real) *MatProp(Rotation_gap,real)
*endif