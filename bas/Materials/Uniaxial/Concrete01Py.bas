*format "%d%g%g%g%g"
ops.uniaxialMaterial("Concrete01", *MaterialID, *MatProp(Compressive_strength_fpc,real), *MatProp(Strain_at_maximum_strength_epsc0,real), *MatProp(Crushing_strength_fpcu,real), *MatProp(Strain_at_crushing_strength_epscU,real))