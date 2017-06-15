*format "%d%g%g%g%g%g%g%g%g%g"
nDMaterial Damage2p *MaterialID *MatProp(Concrete_compressive_strength,real) -fct *MatProp(Concrete_tensile_strength,real) -E *MatProp(Young_Modulus,real) -ni *MatProp(Poisson_coefficient,real) -Gt *MatProp(Tension_fracture_energy_density,real) -Gc *MatProp(Comp._fracture_energy_density,real) -rho_bar *MatProp(Parameter_of_plastic_volume_change,real) -H *MatProp(Linear_hardening_parameter,real) -theta *MatProp(Isotropic/kinematic_hardening_ratio,real) *\
*if(strcmp(MatProp(Computational_stiffness_matrix),"Computational_tangent")==0)
-tangent 0
*else
-tangent 1
*endif