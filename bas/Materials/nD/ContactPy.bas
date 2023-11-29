*format "%d"
*if(ndime == 2)
ops.nDMaterial("ContactMaterial2D", *MaterialID, *\
*else
ops.nDMaterial("ContactMaterial3D", *MaterialID, *\
*endif
*format "%g%g"
*MatProp(Frictional_coefficient,real), *MatProp(Stiffness_parameter,real), *\
*format "%g%g"
*MatProp(Cohesive_intercept,real), *MatProp(Tensile_strength,real))