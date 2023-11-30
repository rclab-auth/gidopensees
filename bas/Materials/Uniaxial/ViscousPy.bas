*if(strcmp(MatProp(Parameter_Export), "Yes")==0)
*format "%d%g"
viscous_*MaterialID_dc = *MatProp(Damping_coefficient,real)
viscous_*MaterialID_pf = *MatProp(Power_factor,real)
*format "%d%d%d"
ops.uniaxialMaterial("Viscous", *MaterialID, viscous_*MaterialID_dc, viscous_*MaterialID_pf)
*else
*format "%d%g%g"
ops.uniaxialMaterial("Viscous", *MaterialID, *MatProp(Damping_coefficient,real), *MatProp(Power_factor,real))
*endif