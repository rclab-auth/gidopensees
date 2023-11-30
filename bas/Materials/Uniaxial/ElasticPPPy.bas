*format "%d%g%g%g%g"
*if(strcmp(MatProp(Parameter_Export), "Yes")==0)

*if(strcmp(MatProp(Formulation),"Stress-Strain")==0)
elasticPP_*MaterialID_E = *MatProp(Elastic_modulus_E,real)
elasticPP_*MaterialID_epSP = *MatProp(Strain_epsP,real)
elasticPP_*MaterialID_epsN = *MatProp(Strain_epsN,real)
elasticPP_*MaterialID_eps0 = *MatProp(Initial_strain_eps0,real)
ops.uniaxialMaterial("ElasticPP", *MaterialID, elasticPP_*MaterialID_E, elasticPP_*MaterialID_epSP, elasticPP_*MaterialID_epsN, elsaticPP_*MaterialID_eps0)
*elseif(strcmp(MatProp(Formulation),"Force-Deformation")==0)
elasticPP_*MaterialID_K = *MatProp(Stiffness_K,real)
elasticPP_*MaterialID_epsP = *MatProp(Deformation_epsP,real)
elasticPP_*MaterialID_epsN = *MatProp(Deformation_epsN,real)
elasticPP_*MaterialID_eps0 = *MatProp(Initial_deformation_eps0,real)
ops.uniaxialMaterial("ElasticPP", *MaterialID, elasticPP_*MaterialID_K, elasticPP_*MaterialID_epsP, elasticPP_*MaterialID_epsN, elasticPP_*MaterialID_eps0)
*else
elasticPP_*MaterialID_MperRot = *MatProp(Moment_per_rotation_unit,real)
elasticPP_*MaterialID_epsP = *MatProp(Rotation_epsP,real)
elasticPP_*MaterialID_epsN = *MatProp(Rotation_epsN,real)
elasticPP_*MaterialID_eps0 = *MatProp(Initial_rotation_eps0,real)
ops.uniaxialMaterial("ElasticPP", *MaterialID, elasticPP_*MaterialID_MperRot, elasticPP_*MaterialID_epsP, elasticPP_*MaterialID_epsN, elasticPP_*MaterialID_eps0)
*endif

*else

*if(strcmp(MatProp(Formulation),"Stress-Strain")==0)
ops.uniaxialMaterial("ElasticPP", *MaterialID, *MatProp(Elastic_modulus_E,real), *MatProp(Strain_epsP,real), *MatProp(Strain_epsN,real), *MatProp(Initial_strain_eps0,real))
*elseif(strcmp(MatProp(Formulation),"Force-Deformation")==0)
ops.uniaxialMaterial("ElasticPP", *MaterialID, *MatProp(Stiffness_K,real), *MatProp(Deformation_epsP,real), *MatProp(Deformation_epsN,real), *MatProp(Initial_deformation_eps0,real))
*else
ops.uniaxialMaterial("ElasticPP", *MaterialID, *MatProp(Moment_per_rotation_unit,real), *MatProp(Rotation_epsP,real), *MatProp(Rotation_epsN,real), *MatProp(Initial_rotation_eps0,real))
*endif

*endif