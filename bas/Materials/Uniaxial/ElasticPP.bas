*format "%d%g%g%g%g"
*if(strcmp(MatProp(Formulation),"Stress-Strain")==0)
uniaxialMaterial ElasticPP *MaterialID *MatProp(Elastic_modulus_E,real) *MatProp(Strain_epsP,real) *MatProp(Strain_epsN,real) *MatProp(Initial_strain_eps0,real)
*elseif(strcmp(MatProp(Formulation),"Force-Deformation")==0)
uniaxialMaterial ElasticPP *MaterialID *MatProp(Stiffness_K,real) *MatProp(Deformation_epsP,real) *MatProp(Deformation_epsN,real) *MatProp(Initial_deformation_eps0,real)
*else
uniaxialMaterial ElasticPP *MaterialID *MatProp(Moment_per_rotation_unit,real) *MatProp(Rotation_epsP,real) *MatProp(Rotation_epsN,real) *MatProp(Initial_rotation_eps0,real)
*endif