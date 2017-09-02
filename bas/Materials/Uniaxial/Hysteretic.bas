*format "%d%g%g%g%g"
*if(strcmp(MatProp(Formulation),"Stress-Strain")==0)
uniaxialMaterial Hysteretic *MaterialID *MatProp(Stress_s1p,real) *MatProp(Strain_e1p,real) *MatProp(Stress_s2p,real) *MatProp(Strain_e2p,real) *\
*format "%g%g%g%g"
*MatProp(Stress_s3p,real) *MatProp(Strain_e3p,real) *MatProp(Stress_s1n,real) *MatProp(Strain_e1n,real) *\
*format "%g%g%g%g"
*MatProp(Stress_s2n,real) *MatProp(Strain_e2n,real) *MatProp(Stress_s3n,real) *MatProp(Strain_e3n,real) *\
*elseif(strcmp(MatProp(Formulation),"Force-Deformation")==0)
uniaxialMaterial Hysteretic *MaterialID *MatProp(Force_s1p,real) *MatProp(Displacement_e1p,real) *MatProp(Force_s2p,real) *MatProp(Displacement_e2p,real) *\
*format "%g%g%g%g"
*MatProp(Force_s3p,real) *MatProp(Displacement_e3p,real) *MatProp(Force_s1n,real) *MatProp(Displacement_e1n,real) *\
*format "%g%g%g%g"
*MatProp(Force_s2n,real) *MatProp(Displacement_e2n,real) *MatProp(Force_s3n,real) *MatProp(Displacement_e3n,real) *\
*else
uniaxialMaterial Hysteretic *MaterialID *MatProp(Moment_s1p,real) *MatProp(Rotation_e1p,real) *MatProp(Moment_s2p,real) *MatProp(Rotation_e2p,real) *\
*format "%g%g%g%g"
*MatProp(Moment_s3p,real) *MatProp(Rotation_e3p,real) *MatProp(Moment_s1n,real) *MatProp(Rotation_e1n,real) *\
*format "%g%g%g%g"
*MatProp(Moment_s2n,real) *MatProp(Rotation_e2n,real) *MatProp(Moment_s3n,real) *MatProp(Rotation_e3n,real) *\
*endif
*format "%g%g%g%g%g"
*MatProp(Pinching_factor_for_strain-deformation,real) *MatProp(Pinching_factor_for_stress-force,real) *MatProp(Damage_due_to_ductility,real) *MatProp(Damage_due_to_energy,real) *MatProp(Beta_power,real)