*set var PlateThickness=MatProp(Plate_thickness_h,real)
*set var PlateFiberTag=SectionID
*set var SelectedMaterial=tcl(FindMaterialNumber *MatProp(Material) )
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *MatProp(0) )
*if(SelectedMaterial==MaterialID)
*if(strcmp(MatProp(Material:),"ElasticIsotropic")==0)
*include ..\Materials\nD\ElasticIsotropic.bas
*elseif(strcmp(MatProp(Material:),"ElastiOrthotropic")==0)
*include ..\Materials\nD\ElasticOrthotropic.bas
*elseif(strcmp(MatProp(Material:),"PressureIndependMultiYield")==0)
*MessageBox Shell Elements do not support Plate Fiber Section with PressureIndependMultiYield Material assigned to each fiber
*elseif(strcmp(MatProp(Material:),"PressureDependMultiYield")==0)
*MessageBox Shell Elements do not support Plate Fiber Section with PressureDependMultiYield Material assigned to each fiber
*elseif(strcmp(MatProp(Material:),"J2Plasticity")==0)
*include ..\Materials\nD\J2Plasticity.bas
*elseif(strcmp(MatProp(Material:),"Damage2p")==0)
*include ..\Materials\nD\Damage2p.bas
*if(strcmp(MatProp(Computational_stiffness_matrix),"Computational_tangent")==0)
-tangent 0
*else
-tangent 1
*endif
*endif
*format "%d%d%g"
section PlateFiber *PlateFiberTag *SelectedMaterial *PlateThickness
*break
*endif
*end materials