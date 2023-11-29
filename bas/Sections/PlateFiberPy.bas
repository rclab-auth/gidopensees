*set var PlateThickness=MatProp(Plate_thickness_h,real)
*set var PlateFiberTag=SectionID
*set var SelectedMaterial=tcl(FindMaterialNumber *MatProp(Material) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedMaterial)
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelectedMaterial==MaterialID)
*set var dummy=tcl(AddUsedMaterials *SelectedMaterial)
*if(strcmp(MatProp(Material:),"ElasticIsotropic")==0)
*include ..\Materials\nD\ElasticIsotropicPy.bas
*elseif(strcmp(MatProp(Material:),"ElastiOrthotropic")==0)
*include ..\Materials\nD\ElasticOrthotropicPy.bas
*elseif(strcmp(MatProp(Material:),"PressureIndependMultiYield")==0)
*MessageBox Shell Elements do not support Plate Fiber Section with PressureIndependMultiYield Material assigned to each fiber
*elseif(strcmp(MatProp(Material:),"PressureDependMultiYield")==0)
*MessageBox Shell Elements do not support Plate Fiber Section with PressureDependMultiYield Material assigned to each fiber
*elseif(strcmp(MatProp(Material:),"J2Plasticity")==0)
*include ..\Materials\nD\J2PlasticityPy.bas
*elseif(strcmp(MatProp(Material:),"Damage2p")==0)
*include ..\Materials\nD\Damage2pPy.bas
*endif
*break
*endif
*end materials
*endif
*format "%d%d%g"
ops.section("PlateFiber", *PlateFiberTag, *SelectedMaterial, *PlateThickness)
