# section LayeredShell $sectionTag $nLayers $matTag1 $thickness_1 ... $matTagn $thickness_n
# *tcl(UserMaterial::GetMaterialName *MatProp(0))

*#
*# define PlateRebar for longitudinal reinforcement
*#
*set var PlateRebarLongTag=PlateRebarLongTag+1
*set var SelectedLongRBMaterial=tcl(FindMaterialNumber *MatProp(Longitudinal_steel_material) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedLongRBMaterial )
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *Matprop(0) *DomainNum)
*if(SelectedLongRBMaterial==MaterialID)
*if(strcmp(MatProp(Material:),"Steel01")==0)
*include ..\Materials\Uniaxial\Steel01Py.bas
*elseif(strcmp(MatProp(Material:),"Steel02")==0)
*include ..\Materials\Uniaxial\Steel02Py.bas
*elseif(strcmp(MatProp(Material:),"Hysteretic")==0)
*include ..\Materials\Uniaxial\HystereticPy.bas
*elseif(strcmp(MatProp(Material:),"ReinforcingSteel")==0)
*include ..\Materials\Uniaxial\ReinforcingSteelPy.bas
*elseif(strcmp(MatProp(Material:),"RambergOsgoodSteel")==0)
*include ..\Materials\Uniaxial\RambergOsgoodSteelPy.bas
*else
*MessageBox Error: Unsupported steel material for LayeredShell Section
*endif
*set var dummy=tcl(AddUsedMaterials *SelectedLongRBMaterial)
*break
*endif
*end materials
*endif
*format "%6d%4d%4d"
ops.nDMaterial("PlateRebar", *PlateRebarLongTag, *SelectedLongRBMaterial, 90)
*#
*# define PlateRebar for transverse reinforcement
*#
*set var PlateRebarTransTag=PlateRebarTransTag+1
*set var SelectedTransverseRBMaterial=tcl(FindMaterialNumber *MatProp(Transverse_steel_material) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedTransverseRBMaterial )
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *Matprop(0) *DomainNum)
*if(SelectedTransverseRBMaterial==MaterialID)
*if(strcmp(MatProp(Material:),"Steel01")==0)
*include ..\Materials\Uniaxial\Steel01Py.bas
*elseif(strcmp(MatProp(Material:),"Steel02")==0)
*include ..\Materials\Uniaxial\Steel02Py.bas
*elseif(strcmp(MatProp(Material:),"Hysteretic")==0)
*include ..\Materials\Uniaxial\HystereticPy.bas
*elseif(strcmp(MatProp(Material:),"ReinforcingSteel")==0)
*include ..\Materials\Uniaxial\ReinforcingSteelPy.bas
*elseif(strcmp(MatProp(Material:),"RambergOsgoodSteel")==0)
*include ..\Materials\Uniaxial\RambergOsgoodSteelPy.bas
*else
*MessageBox Error: Unsupported steel material for LayeredShell Section
*endif
*set var dummy=tcl(AddUsedMaterials *SelectedTransverseRBMaterial)
*break
*endif
*end materials
*endif
*format "%6d%4d%4d"
ops.nDMaterial("PlateRebar", *PlateRebarTransTag, *SelectedTransverseRBMaterial, 0)
*#
*# define PlaneStressUserMaterial for cover concrete
*#
*set var PlaneStressUserMaterialTag=PlaneStressUserMaterialTag+1
*format "%6d%8g%8g"
ops.nDMaterial("PlaneStressUserMaterial", *PlaneStressUserMaterialTag, 40, 7, *MatProp(Cover_fc,real), *MatProp(Cover_ft,real), *\
*format "%8g%8g"
*MatProp(Cover_fu,real), *MatProp(Cover_ec,real), *\
*format "%8g%8g"
*MatProp(Cover_ecu,real), *MatProp(Cover_etu,real), *\
*format "%6g"
*MatProp(Cover_shear_ret._factor,real))
*#
*# define PlateFromPlaneStress material for cover concrete
*#
*set var PlateFromPlaneStressMaterialTag=PlateFromPlaneStressMaterialTag+1
*format "%6d%6d%10g"
ops.nDMaterial("PlateFromPlaneStress", *PlateFromPlaneStressMaterialTag, *PlaneStressUserMaterialTag, *MatProp(Cover_G,real))
*#
*# define PlaneStressUserMaterial for core concrete
*#
*set var PlaneStressUserMaterialTag=PlaneStressUserMaterialTag+1
*format "%6d%8g%8g"
ops.nDMaterial("PlaneStressUserMaterial", *PlaneStressUserMaterialTag, 40, 7, *MatProp(Core_fc,real), *MatProp(Core_ft,real), *\
*format "%8g%8g"
*MatProp(Core_fu,real), *MatProp(Core_ec,real), *\
*format "%8g%8g"
*MatProp(Core_ecu,real), *MatProp(Core_etu,real), *\
*format "%6g"
*MatProp(Core_shear_ret._factor,real))
*#
*# define PlateFromPlaneStress material for core concrete
*#
*set var PlateFromPlaneStressMaterialTag=PlateFromPlaneStressMaterialTag+1
*format "%6d%6d%10g"
ops.nDMaterial("PlateFromPlaneStress", *PlateFromPlaneStressMaterialTag, *PlaneStressUserMaterialTag, *MatProp(Core_G,real))
*#
*#
*#
*set var nlayersCover=MatProp(Cover_layers,int)
*set var nlayersLong=2
*set var nlayersTrans=2
*set var nlayersCore=MatProp(Core_layers,int)
*set var nlayers=operation(2*nlayersCover+nlayersLong+nlayersTrans+nlayersCore)
*#
*set var width=MatProp(Wall_width,real)
*set var cover=MatProp(Reinforcement_cover,real)
*set var LongRatio=MatProp(Longitudinal_reinforcement_ratio,real)
*set var LongThick=operation(LongRatio*width/2)
*set var TransRatio=MatProp(Transverse_reinforcement_ratio,real)
*set var TransThick=operation(TransRatio*width/2)
*set var CoverThick=operation(cover/nlayersCover)
*set var CoreThick=operation((width-2*(LongThick+TransThick+CoverThick))/nlayersCore)
*#
*#
*#
*set var LayeredShellTag=SectionID
*format "%d%d"
ops.section("LayeredShell", *LayeredShellTag,  *nlayers, *\
*set var PlateFromPlaneStressMaterialTag=PlateFromPlaneStressMaterialTag-1
*for(i=1;i<=nlayersCover;i=i+1)
*format "%d%g"
*PlateFromPlaneStressMaterialTag, *coverThick, *\
*endfor
*format "%d%g%d%g"
*PlateRebarTransTag, *TransThick, *PlateRebarLongTag, *LongThick, *\
*set var PlateFromPlaneStressMaterialTag=PlateFromPlaneStressMaterialTag+1
*for(i=1;i<=nlayersCore;i=i+1)
*format "%d%g"
*PlateFromPlaneStressMaterialTag, *coreThick, *\
*endfor
*format "%d%g%d%g"
*PlateRebarLongTag, *LongThick, *PlateRebarTransTag, *TransThick, *\
*set var PlateFromPlaneStressMaterialTag=PlateFromPlaneStressMaterialTag-1
*for(i=1;i<=nlayersCover;i=i+1)
*format "%d%g"
*PlateFromPlaneStressMaterialTag, *coverThick)

*endfor
*set var PlateFromPlaneStressMaterialTag=PlateFromPlaneStressMaterialTag+1