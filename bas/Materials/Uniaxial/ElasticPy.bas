*if(strcmp(Matprop(Parameter_Export), "Yes")==0)

*if(strcmp(MatProp(Formulation),"Stress-Strain")==0)
*format "%d%g"
elastic_*MaterialID_E = *MatProp(Elastic_modulus_E,real)
*format "%d%d"
ops.uniaxialMaterial("Elastic", *MaterialID, Elastic_*MaterialID_E)
*elseif(strcmp(MatProp(Formulation),"Force-Deformation")==0)
*format "%d%g"
elastic_*MaterialID_K = *MatProp(Stiffness_K,real)
*format "%d%d"
ops.uniaxialMaterial("Elastic", *MaterialID, Elastic_*MaterialID_K)
*else
*format "%d%g"
elastic_*MaterialID_Moment_per_rot = *MatProp(Moment_per_rotation_unit,real)
*format "%d%d"
ops.uniaxialMaterial("Elastic", *MaterialID, elastic_*MaterialID_Moment_per_rot)
*endif

*else

*format "%d%g"
*if(strcmp(MatProp(Formulation),"Stress-Strain")==0)
ops.uniaxialMaterial("Elastic", *MaterialID, *MatProp(Elastic_modulus_E,real))
*elseif(strcmp(MatProp(Formulation),"Force-Deformation")==0)
ops.uniaxialMaterial("Elastic", *MaterialID, *MatProp(Stiffness_K,real))
*else
ops.uniaxialMaterial("Elastic", *MaterialID, *MatProp(Moment_per_rotation_unit,real))
*endif
*endif