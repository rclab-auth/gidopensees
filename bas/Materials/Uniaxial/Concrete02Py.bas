*format "%d%g%g%g%g%g%g%g"
ops.uniaxialMaterial("Concrete02", *MaterialID, *MatProp(Compressive_strength_fpc,real), *MatProp(Strain_at_maximum_strength_epsc0,real), *MatProp(Crushing_strength_fpcu,real), *MatProp(Strain_at_crushing_strength_epscU,real), *MatProp(Ratio_between_unloading_slope_at_epscU_and_initial_slope_lambda,real), *MatProp(Tensile_strength_Ft,real), *MatProp(Tension_softening_stiffness_Ets,real))