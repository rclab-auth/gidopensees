*format "%d%g%g"
ops.uniaxialMaterial("RambergOsgoodSteel", *MaterialID, *MatProp(Yield_stress_fy,real), *MatProp(Initial_elastic_tangent_E0,real), *\
*format "%g%g"
*MatProp(Yield_offset,real), *MatProp(Parameter_n_to_control_transition_from_elastic_to_plastic_branches,real))