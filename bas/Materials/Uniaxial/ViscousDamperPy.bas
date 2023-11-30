*if(strcmp(MatProp(Parameter_Export), "Yes")==0)

*if(MatProp(Activate_gap_length,int)==1)
*format "%d%g"
viscousdamper_*MaterialID_Stiffness = *MatProp(Elastic_Stiffness,real)
viscousdamper_*MaterialID_dcCd = *MatProp(Damping_coefficient_Cd,real)
viscousdamper_*MaterialID_alpha = *MatProp(Velocity_exponent_alpha,real)
viscoudamper_*MaterialID_gap = *MatProp(Gap_length,real)
*format "%d%d%d%d%d"
ops.uniaxialMaterial("ViscousDamper", *MaterialID, viscousdamper_*MaterialID_Stiffness, viscousdamper_*MaterialID_dcCd, viscousdamper_*MaterialID_alpha, viscoudamper_*MaterialID_gap)
*else
*format "%d%g"
viscousdamper_*MaterialID_Stiffness = *MatProp(Elastic_Stiffness,real)
viscousdamper_*MaterialID_dcCd = *MatProp(Damping_coefficient_Cd,real)
viscousdamper_*MaterialID_alpha = *MatProp(Velocity_exponent_alpha,real)
*format "%d%d%d%d"
ops.uniaxialMaterial("ViscousDamper", *MaterialID, viscousdamper_*MaterialID_Stiffness, viscousdamper_*MaterialID_dcCd, viscousdamper_*MaterialID_alpha)
*endif

*else
*if(MatProp(Activate_gap_length,int)==1)
*format "%d%g%g%g%g"
ops.uniaxialMaterial("ViscousDamper", *MaterialID, *MatProp(Elastic_Stiffness,real), *MatProp(Damping_coefficient_Cd,real), *MatProp(Velocity_exponent_alpha,real), *MatProp(Gap_length,real))
*else
*format "%d%g%g%g"
ops.uniaxialMaterial("ViscousDamper", *MaterialID, *MatProp(Elastic_Stiffness,real), *MatProp(Damping_coefficient_Cd,real), *MatProp(Velocity_exponent_alpha,real))
*endif


*endif