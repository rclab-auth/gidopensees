*format "%d%g%g%g"
*if(strcmp(MatProp(Parameter_Export),"Yes")==0)

*if(strcmp(MatProp(Formulation),"Stress-Strain")==0)
elasticppg_*MaterialID_E = *MatProp(Elastic_modulus_E,real)
elasticppg_*MaterialID_Fy = *MatProp(Yield_Stress_Fy,real)
elasticppg_*MaterialID_gap = *MatProp(Strain_gap,real)
ops.uniaxialMaterial("ElasticPPGap", *MaterialID, elasticppg_*MaterialID_E, *MatProp(Yield_Stress_Fy,real), elasticppg_*MaterialID_gap)
*elseif(strcmp(MatProp(Formulation),"Force-Deformation")==0)
elasticppg_*MaterialID_K = *MatProp(Stiffness_K,real)
elasticppg_*MaterialID_Fy = *MatProp(Force_Fy,real)
elasticppg_*MaterialID_gap = *MatProp(Deformation_gap,real)
ops.uniaxialMaterial("ElasticPPGap", *MaterialID, elasticppg_*MaterialID_K, elasticppg_*MaterialID_Fy, elasticppg_*MaterialID_gap)
*else
elasticppg_*MaterialID_MperRot = *MatProp(Moment_per_rotation_unit,real)
elasticppg_*MaterialID_My = *MatProp(Moment_My,real)
elasticppg_*MaterialID_gap = *MatProp(Rotation_gap,real)
ops.uniaxialMaterial("ElasticPPGap", *MaterialID, elasticppg_*MaterialID_MperRot, *MatProp(Moment_My,real), elasticppg_*MaterialID_gap)
*endif

*else

*if(strcmp(MatProp(Formulation),"Stress-Strain")==0)
ops.uniaxialMaterial("ElasticPPGap", *MaterialID, *MatProp(Elastic_modulus_E,real), *MatProp(Yield_Stress_Fy,real), *MatProp(Strain_gap,real))
*elseif(strcmp(MatProp(Formulation),"Force-Deformation")==0)
ops.uniaxialMaterial("ElasticPPGap", *MaterialID, *MatProp(Stiffness_K,real), *MatProp(Force_Fy,real), *MatProp(Deformation_gap,real))
*else
ops.uniaxialMaterial("ElasticPPGap", *MaterialID, *MatProp(Moment_per_rotation_unit,real), *MatProp(Moment_My,real), *MatProp(Rotation_gap,real))
*endif
*endif
