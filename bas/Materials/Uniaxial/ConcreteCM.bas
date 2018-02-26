*format "%d%g%g%g%g%g%g%g%g%g"
uniaxialMaterial ConcreteCM *MaterialID *MatProp(Concrete_compressive_strength_fpcc,real) *Matprop(Strain_at_compressive_strength_epcc,real) *MatProp(Initial_tangent_modulus_Ec,real) *MatProp(Shape_parameter_rc_in_Tsai's_equation_for_compression,real) *MatProp(Critical_strain_on_compression_envelope,real) *MatProp(Tensile_strength_ft,real) *MatProp(Strain_at_tensile_strength_et,real) *MatProp(Shape_parameter_rc_in_Tsai's_equation_for_compression,real) *MatProp(Critical_strain_on_tension_envelope,real) *\
*if(MatProp(Consider_gap_closure,int)==1)
*format "%g"
-GapClose *MatProp(Gap_parameter,real)
*else

*endif
