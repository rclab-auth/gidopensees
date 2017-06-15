*format "%d%g"
*if(strcmp(MatProp(Formulation),"Stress-Strain")==0)
uniaxialMaterial Elastic *MaterialID *MatProp(Elastic_modulus_E,real)
*elseif(strcmp(MatProp(Formulation),"Force-Deformation")==0)
uniaxialMaterial Elastic *MaterialID *MatProp(Stiffness_K,real)
*else
uniaxialMaterial Elastic *MaterialID *MatProp(Moment_per_rotation_unit,real)
*endif