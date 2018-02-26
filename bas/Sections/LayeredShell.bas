*set var LayeredShellTag=SectionID
*set var PlaneStressUserMaterialTag=PlaneStressUserMaterialTag+1
*set var PlateFromPlaneStressMaterialTag=PlateFromPlaneStressMaterialTag+1
*set var PlateRebarLongTag=PlateRebarLongTag+1
*set var PlateRebarTransvTag=PlateRebarTransvTag+1
*# define PlaneStressUserMaterial for concrete
*format "%6d%6g%6g"
nDMaterial PlaneStressUserMaterial *PlaneStressUserMaterialTag 40 7 *MatProp(Concrete_compressive_strength,real) *MatProp(Concrete_tensile_strength,real) *\
*format "%6g%6g"
*MatProp(Concrete_crushing_strength,real) *MatProp(Concrete_strain_at_maximum_strength,real) *\
*format "%6g%6g"
*MatProp(Concrete_strain_at_crushing_strength,real) *MatProp(Ultimate_tensile_strain,real) *\
*format "%6g%6g"
*MatProp(Shear_retention_factor,real)
*# define PlateFromPlaneStress material
*format "%6d%6d%6g"
nDMaterial PlateFromPlaneStress *PlateFromPlaneStressMaterialTag *PlaneStressUserMaterialTag *MatProp(Shear_modulus_of_out_plane,real)
*# define PlateRebar for longitudinal reinforcement
*set var SelectedLongRBMaterial=tcl(FindMaterialNumber *MatProp(Longitudinal_bar_material) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedLongRBMaterial )
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *Matprop(0) *DomainNum)
*if(SelectedLongRBMaterial==MaterialID)
*if(strcmp(MatProp(Material:),"Steel01")==0)
*include ..\Materials\Uniaxial\Steel01.bas
*elseif(strcmp(MatProp(Material:),"Steel02")==0)
*include ..\Materials\Uniaxial\Steel02.bas
*elseif(strcmp(MatProp(Material:),"Hysteretic")==0)
*include ..\Materials\Uniaxial\Hysteretic.bas
*elseif(strcmp(MatProp(Material:),"ReinforcingSteel")==0)
*include ..\Materials\Uniaxial\ReinforcingSteel.bas
*elseif(strcmp(MatProp(Material:),"RambergOsgoodSteel")==0)
*include ..\Materials\Uniaxial\RambergOsgoodSteel.bas
*else
*MessageBox Error: Unsupported steel material for LayeredShell Section
*endif
*set var dummy=tcl(AddUsedMaterials *SelectedLongRBMaterial)
*break
*endif
*end materials
*endif
# PlateRebar for longitudinal reinforcement
*format "%6d%6d%6d"
nDMaterial PlateRebar *PlateRebarLongTag *SelectedLongRBMaterial 90
*set var SelectedTransverseRBMaterial=tcl(FindMaterialNumber *MatProp(Transverse_bar_material) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedTransverseRBMaterial )
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *Matprop(0) *DomainNum)
*if(SelectedTransverseRBMaterial==MaterialID)
*if(strcmp(MatProp(Material:),"Steel01")==0)
*include ..\Materials\Uniaxial\Steel01.bas
*elseif(strcmp(MatProp(Material:),"Steel02")==0)
*include ..\Materials\Uniaxial\Steel02.bas
*elseif(strcmp(MatProp(Material:),"Hysteretic")==0)
*include ..\Materials\Uniaxial\Hysteretic.bas
*elseif(strcmp(MatProp(Material:),"ReinforcingSteel")==0)
*include ..\Materials\Uniaxial\ReinforcingSteel.bas
*elseif(strcmp(MatProp(Material:),"RambergOsgoodSteel")==0)
*include ..\Materials\Uniaxial\RambergOsgoodSteel.bas
*else
*MessageBox Error: Unsupported steel material for LayeredShell Section
*endif
*set var dummy=tcl(AddUsedMaterials *SelectedTransverseRBMaterial)
*break
*endif
*end materials
*endif
# PlateRebar for transverse reinforcement
*format "%6d%6d%6d"
nDMaterial PlateRebar *PlateRebarTransvTag *SelectedTransverseRBMaterial 0
*set var height=MatProp(Height,real)
*set var totalThick=MatProp(Thickness,real)
*set var width=MatProp(Width,real)
*set var totalArea=operation(width*totalThick)
*set var cover=MatProp(Cover_depth_for_bars,real)
*set var nlongbars=MatProp(Longitudinal_bars,int)
*set var longbarArea=MatProp(Longitudinal_bar_area,real)
*set var transbarArea=MatProp(Transverse_bar_area,real)
*set var nlayersCover=2
*set var nlayersTransv=2
*set var nlayersLong=2
*set var nlayersCore=4
*set var nlayers=10
*set var coverArea=operation(2*cover*width)
*set var coverThick=operation(coverArea/(Width*nlayersCover))
*set var TotalLongBarArea=operation(longbarArea*nlongbars)
*set var LongBarThick=operation(TotalLongBarArea/(nlayersLong*width))
*set var TransSpace=MatProp(Transverse_reinforcement_space,int)
*set var temp1=tcl(Bas_round *height *TransSpace)
*set var temp=operation(temp1+1)
*set var TotalTransBarArea=operation(temp*transbarArea*2)
*set var TotalTransBarArea=operation(TotalTransBarArea/2.0)
*set var TransBarThick=operation(TotalTransBarArea/height)
*set var coreArea=operation((totalArea-coverArea-TotalLongBarArea))
*set var coreThick=operation(coreArea/(width*nlayersCore))
# section LayeredShell $sectionTag $nLayers $matTag1 $thickness1...$matTagn $thicknessn
*format "%6d%6d%6d%6g"
section LayeredShell *LayeredShellTag *nlayers *PlateFromPlaneStressMaterialTag *coverThick *\
*format "%6d%6g%6d%6g"
*PlateRebarTransvTag *TransBarThick *PlateRebarLongTag *LongBarThick *\
*format "%6d%6g%6d%6g%6d%6g%6d%6g"
*PlateFromPlaneStressMaterialTag *coreThick *PlateFromPlaneStressMaterialTag *coreThick *PlateFromPlaneStressMaterialTag *coreThick *PlateFromPlaneStressMaterialTag *coreThick *\
*format "%6d%6g%6d%6g%6d%6g"
*PlateRebarLongTag *LongBarThick *PlateRebarTransvTag *TransBarThick *PlateFromPlaneStressMaterialTag *coverThick