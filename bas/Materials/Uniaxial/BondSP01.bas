*format "%d%g%g%g"
*if(strcmp(MatProp(Formulation),"Stress-Slip")==0)
uniaxialMaterial Bond_SP01 *MaterialID *MatProp(Yield_stress_Fy,real) *MatProp(Rebar_slip_at_Fy,real) *MatProp(Ultimate_stress_Fu,real) *\
*format "%g%g%g"
*MatProp(Rebar_slip_at_the_loaded_end_at_the_bar_fracture_strength,real) *MatProp(Initial_hardening,real) *MatProp(Pinching_factor_for_the_cyclic_slip_vs_bar_response,real)
*elseif(strcmp(MatProp(Formulation),"Force-Slip")==0)
uniaxialMaterial Bond_SP01 *MaterialID *MatProp(Yield_force_Fy,real) *MatProp(Rebar_slip_at_Fy,real) *MatProp(Ultimate_Force_Fu,real) *\
*format "%g%g%g"
*MatProp(Rebar_slip_at_the_loaded_end_at_the_bar_fracture_strength,real) *MatProp(Initial_hardening,real) *MatProp(Pinching_factor_for_the_cyclic_slip_vs_bar_response,real)
*endif 