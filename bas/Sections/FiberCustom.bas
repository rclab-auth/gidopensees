*set var FiberCustomTag=SectionID
*if(MatProp(Activate_torsional_stiffness,int)==1 && MatProp(Torsional_stiffness_GJ,real)!=0)
section Fiber *FiberCustomTag -GJ *MatProp(Torsional_stiffness_GJ,real) {
*else
section Fiber *FiberCustomTag {
*endif
*set var FileExists=tcl(Fiber::FiberCustomFileExists *MatProp(0) 1)
*if(FileExists==1)
*set var SelectedMaterial=tcl(FindMaterialNumber *MatProp(Region_1_material) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedMaterial )
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *Matprop(0) *DomainNum)
*if(SelectedMaterial==MaterialID)
*if(strcmp(MatProp(Material:),"Concrete01")==0)
*include ..\Materials\Uniaxial\Concrete01.bas
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*include ..\Materials\Uniaxial\Concrete02.bas
*elseif(strcmp(MatProp(Material:),"Concrete04")==0)
*include ..\Materials\Uniaxial\Concrete04.bas
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*include ..\Materials\Uniaxial\Concrete06.bas
*elseif(strcmp(MatProp(Material:),"ConcreteCM")==0)
*include ..\Materials\Uniaxial\ConcreteCM.bas
*elseif(strcmp(MatProp(Material:),"Steel01")==0)
*include ..\Materials\Uniaxial\Steel01.bas
*elseif(strcmp(MatProp(Material:),"Steel02")==0)
*include ..\Materials\Uniaxial\Steel02.bas
*elseif(strcmp(MatProp(Material:),"ReinforcingSteel")==0)
*include ..\Materials\Uniaxial\ReinforcingSteel.bas
*elseif(strcmp(MatProp(Material:),"RambergOsgoodSteel")==0)
*include ..\Materials\Uniaxial\RambergOsgoodSteel.bas
*elseif(strcmp(MatProp(Material:),"Hysteretic")==0)
*include ..\Materials\Uniaxial\Hysteretic.bas
*elseif(strcmp(MatProp(Material:),"MinMax")==0)
*include ..\Materials\Uniaxial\MinMax.bas
*else
*MessageBox Error: Unsupported Core material for Custom Fiber Section
*endif
*set var dummy=tcl(AddUsedMaterials *SelectedMaterial)
*break
*endif
*end materials
*endif
set MatTag *tcl(FindMaterialNumber *MatProp(Region_1_material:) *DomainNum)
source "../Scripts/*tcl(Fiber::GetScriptName *MatProp(0) 1)"
*endif
*set var FileExists=tcl(Fiber::FiberCustomFileExists *MatProp(0) 2)
*if(FileExists==1)
*set var SelectedMaterial=tcl(FindMaterialNumber *MatProp(Region_2_material) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedMaterial )
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *Matprop(0) *DomainNum)
*if(SelectedMaterial==MaterialID)
*if(strcmp(MatProp(Material:),"Concrete01")==0)
*include ..\Materials\Uniaxial\Concrete01.bas
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*include ..\Materials\Uniaxial\Concrete02.bas
*elseif(strcmp(MatProp(Material:),"Concrete04")==0)
*include ..\Materials\Uniaxial\Concrete04.bas
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*include ..\Materials\Uniaxial\Concrete06.bas
*elseif(strcmp(MatProp(Material:),"ConcreteCM")==0)
*include ..\Materials\Uniaxial\ConcreteCM.bas
*elseif(strcmp(MatProp(Material:),"Steel01")==0)
*include ..\Materials\Uniaxial\Steel01.bas
*elseif(strcmp(MatProp(Material:),"Steel02")==0)
*include ..\Materials\Uniaxial\Steel02.bas
*elseif(strcmp(MatProp(Material:),"ReinforcingSteel")==0)
*include ..\Materials\Uniaxial\ReinforcingSteel.bas
*elseif(strcmp(MatProp(Material:),"RambergOsgoodSteel")==0)
*include ..\Materials\Uniaxial\RambergOsgoodSteel.bas
*elseif(strcmp(MatProp(Material:),"Hysteretic")==0)
*include ..\Materials\Uniaxial\Hysteretic.bas
*elseif(strcmp(MatProp(Material:),"MinMax")==0)
*include ..\Materials\Uniaxial\MinMax.bas
*else
*MessageBox Error: Unsupported Core material for Custom Fiber Section
*endif
*set var dummy=tcl(AddUsedMaterials *SelectedMaterial)
*break
*endif
*end materials
*endif
set MatTag *tcl(FindMaterialNumber *MatProp(Region_2_material:) *DomainNum)
source "../Scripts/*tcl(Fiber::GetScriptName *MatProp(0) 2)"
*endif
*set var FileExists=tcl(Fiber::FiberCustomFileExists *MatProp(0) 3)
*if(FileExists==1)
*set var SelectedMaterial=tcl(FindMaterialNumber *MatProp(Region_3_material) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedMaterial )
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *Matprop(0) *DomainNum)
*if(SelectedMaterial==MaterialID)
*if(strcmp(MatProp(Material:),"Concrete01")==0)
*include ..\Materials\Uniaxial\Concrete01.bas
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*include ..\Materials\Uniaxial\Concrete02.bas
*elseif(strcmp(MatProp(Material:),"Concrete04")==0)
*include ..\Materials\Uniaxial\Concrete04.bas
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*include ..\Materials\Uniaxial\Concrete06.bas
*elseif(strcmp(MatProp(Material:),"ConcreteCM")==0)
*include ..\Materials\Uniaxial\ConcreteCM.bas
*elseif(strcmp(MatProp(Material:),"Steel01")==0)
*include ..\Materials\Uniaxial\Steel01.bas
*elseif(strcmp(MatProp(Material:),"Steel02")==0)
*include ..\Materials\Uniaxial\Steel02.bas
*elseif(strcmp(MatProp(Material:),"ReinforcingSteel")==0)
*include ..\Materials\Uniaxial\ReinforcingSteel.bas
*elseif(strcmp(MatProp(Material:),"RambergOsgoodSteel")==0)
*include ..\Materials\Uniaxial\RambergOsgoodSteel.bas
*elseif(strcmp(MatProp(Material:),"Hysteretic")==0)
*include ..\Materials\Uniaxial\Hysteretic.bas
*elseif(strcmp(MatProp(Material:),"MinMax")==0)
*include ..\Materials\Uniaxial\MinMax.bas
*else
*MessageBox Error: Unsupported Core material for Custom Fiber Section
*endif
*set var dummy=tcl(AddUsedMaterials *SelectedMaterial)
*break
*endif
*end materials
*endif
set MatTag *tcl(FindMaterialNumber *MatProp(Region_3_material:) *DomainNum)
source "../Scripts/*tcl(Fiber::GetScriptName *MatProp(0) 3)"
*endif
*set var FileExists=tcl(Fiber::FiberCustomFileExists *MatProp(0) 4)
*if(FileExists==1)
*set var SelectedMaterial=tcl(FindMaterialNumber *MatProp(Region_4_material) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedMaterial )
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *Matprop(0) *DomainNum)
*if(SelectedMaterial==MaterialID)
*if(strcmp(MatProp(Material:),"Concrete01")==0)
*include ..\Materials\Uniaxial\Concrete01.bas
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*include ..\Materials\Uniaxial\Concrete02.bas
*elseif(strcmp(MatProp(Material:),"Concrete04")==0)
*include ..\Materials\Uniaxial\Concrete04.bas
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*include ..\Materials\Uniaxial\Concrete06.bas
*elseif(strcmp(MatProp(Material:),"ConcreteCM")==0)
*include ..\Materials\Uniaxial\ConcreteCM.bas
*elseif(strcmp(MatProp(Material:),"Steel01")==0)
*include ..\Materials\Uniaxial\Steel01.bas
*elseif(strcmp(MatProp(Material:),"Steel02")==0)
*include ..\Materials\Uniaxial\Steel02.bas
*elseif(strcmp(MatProp(Material:),"ReinforcingSteel")==0)
*include ..\Materials\Uniaxial\ReinforcingSteel.bas
*elseif(strcmp(MatProp(Material:),"RambergOsgoodSteel")==0)
*include ..\Materials\Uniaxial\RambergOsgoodSteel.bas
*elseif(strcmp(MatProp(Material:),"Hysteretic")==0)
*include ..\Materials\Uniaxial\Hysteretic.bas
*elseif(strcmp(MatProp(Material:),"MinMax")==0)
*include ..\Materials\Uniaxial\MinMax.bas
*else
*MessageBox Error: Unsupported Core material for Custom Fiber Section
*endif
*set var dummy=tcl(AddUsedMaterials *SelectedMaterial)
*break
*endif
*end materials
*endif
set MatTag *tcl(FindMaterialNumber *MatProp(Region_4_material:) *DomainNum)
source "../Scripts/*tcl(Fiber::GetScriptName *MatProp(0) 4)"
*endif
*set var FileExists=tcl(Fiber::FiberCustomFileExists *MatProp(0) 5)
*if(FileExists==1)
*set var SelectedMaterial=tcl(FindMaterialNumber *MatProp(Region_5_material) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedMaterial )
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *Matprop(0) *DomainNum)
*if(SelectedMaterial==MaterialID)
*if(strcmp(MatProp(Material:),"Concrete01")==0)
*include ..\Materials\Uniaxial\Concrete01.bas
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*include ..\Materials\Uniaxial\Concrete02.bas
*elseif(strcmp(MatProp(Material:),"Concrete04")==0)
*include ..\Materials\Uniaxial\Concrete04.bas
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*include ..\Materials\Uniaxial\Concrete06.bas
*elseif(strcmp(MatProp(Material:),"ConcreteCM")==0)
*include ..\Materials\Uniaxial\ConcreteCM.bas
*elseif(strcmp(MatProp(Material:),"Steel01")==0)
*include ..\Materials\Uniaxial\Steel01.bas
*elseif(strcmp(MatProp(Material:),"Steel02")==0)
*include ..\Materials\Uniaxial\Steel02.bas
*elseif(strcmp(MatProp(Material:),"ReinforcingSteel")==0)
*include ..\Materials\Uniaxial\ReinforcingSteel.bas
*elseif(strcmp(MatProp(Material:),"RambergOsgoodSteel")==0)
*include ..\Materials\Uniaxial\RambergOsgoodSteel.bas
*elseif(strcmp(MatProp(Material:),"Hysteretic")==0)
*include ..\Materials\Uniaxial\Hysteretic.bas
*elseif(strcmp(MatProp(Material:),"MinMax")==0)
*include ..\Materials\Uniaxial\MinMax.bas
*else
*MessageBox Error: Unsupported Core material for Custom Fiber Section
*endif
*set var dummy=tcl(AddUsedMaterials *SelectedMaterial)
*break
*endif
*end materials
*endif
set MatTag *tcl(FindMaterialNumber *MatProp(Region_5_material:) *DomainNum)
source "../Scripts/*tcl(Fiber::GetScriptName *MatProp(0) 5)"
*endif
*set var FileExists=tcl(Fiber::FiberCustomFileExists *MatProp(0) 6)
*if(FileExists==1)
*set var SelectedMaterial=tcl(FindMaterialNumber *MatProp(Region_6_material) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedMaterial )
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *Matprop(0) *DomainNum)
*if(SelectedMaterial==MaterialID)
*if(strcmp(MatProp(Material:),"Concrete01")==0)
*include ..\Materials\Uniaxial\Concrete01.bas
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*include ..\Materials\Uniaxial\Concrete02.bas
*elseif(strcmp(MatProp(Material:),"Concrete04")==0)
*include ..\Materials\Uniaxial\Concrete04.bas
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*include ..\Materials\Uniaxial\Concrete06.bas
*elseif(strcmp(MatProp(Material:),"ConcreteCM")==0)
*include ..\Materials\Uniaxial\ConcreteCM.bas
*elseif(strcmp(MatProp(Material:),"Steel01")==0)
*include ..\Materials\Uniaxial\Steel01.bas
*elseif(strcmp(MatProp(Material:),"Steel02")==0)
*include ..\Materials\Uniaxial\Steel02.bas
*elseif(strcmp(MatProp(Material:),"ReinforcingSteel")==0)
*include ..\Materials\Uniaxial\ReinforcingSteel.bas
*elseif(strcmp(MatProp(Material:),"RambergOsgoodSteel")==0)
*include ..\Materials\Uniaxial\RambergOsgoodSteel.bas
*elseif(strcmp(MatProp(Material:),"Hysteretic")==0)
*include ..\Materials\Uniaxial\Hysteretic.bas
*elseif(strcmp(MatProp(Material:),"MinMax")==0)
*include ..\Materials\Uniaxial\MinMax.bas
*else
*MessageBox Error: Unsupported Core material for Custom Fiber Section
*endif
*set var dummy=tcl(AddUsedMaterials *SelectedMaterial)
*break
*endif
*end materials
*endif
set MatTag *tcl(FindMaterialNumber *MatProp(Region_6_material:) *DomainNum)
source "../Scripts/*tcl(Fiber::GetScriptName *MatProp(0) 6)"
*endif
*set var FileExists=tcl(Fiber::FiberCustomFileExists *MatProp(0) 7)
*if(FileExists==1)
*set var SelectedMaterial=tcl(FindMaterialNumber *MatProp(Region_7_material) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedMaterial )
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *Matprop(0) *DomainNum)
*if(SelectedMaterial==MaterialID)
*if(strcmp(MatProp(Material:),"Concrete01")==0)
*include ..\Materials\Uniaxial\Concrete01.bas
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*include ..\Materials\Uniaxial\Concrete02.bas
*elseif(strcmp(MatProp(Material:),"Concrete04")==0)
*include ..\Materials\Uniaxial\Concrete04.bas
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*include ..\Materials\Uniaxial\Concrete06.bas
*elseif(strcmp(MatProp(Material:),"ConcreteCM")==0)
*include ..\Materials\Uniaxial\ConcreteCM.bas
*elseif(strcmp(MatProp(Material:),"Steel01")==0)
*include ..\Materials\Uniaxial\Steel01.bas
*elseif(strcmp(MatProp(Material:),"Steel02")==0)
*include ..\Materials\Uniaxial\Steel02.bas
*elseif(strcmp(MatProp(Material:),"ReinforcingSteel")==0)
*include ..\Materials\Uniaxial\ReinforcingSteel.bas
*elseif(strcmp(MatProp(Material:),"RambergOsgoodSteel")==0)
*include ..\Materials\Uniaxial\RambergOsgoodSteel.bas
*elseif(strcmp(MatProp(Material:),"Hysteretic")==0)
*include ..\Materials\Uniaxial\Hysteretic.bas
*elseif(strcmp(MatProp(Material:),"MinMax")==0)
*include ..\Materials\Uniaxial\MinMax.bas
*else
*MessageBox Error: Unsupported Core material for Custom Fiber Section
*endif
*set var dummy=tcl(AddUsedMaterials *SelectedMaterial)
*break
*endif
*end materials
*endif
set MatTag *tcl(FindMaterialNumber *MatProp(Region_7_material:) *DomainNum)
source "../Scripts/*tcl(Fiber::GetScriptName *MatProp(0) 7)"
*endif
*set var FileExists=tcl(Fiber::FiberCustomFileExists *MatProp(0) 8)
*if(FileExists==1)
*set var SelectedMaterial=tcl(FindMaterialNumber *MatProp(Region_8_material) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedMaterial )
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *Matprop(0) *DomainNum)
*if(SelectedMaterial==MaterialID)
*if(strcmp(MatProp(Material:),"Concrete01")==0)
*include ..\Materials\Uniaxial\Concrete01.bas
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*include ..\Materials\Uniaxial\Concrete02.bas
*elseif(strcmp(MatProp(Material:),"Concrete04")==0)
*include ..\Materials\Uniaxial\Concrete04.bas
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*include ..\Materials\Uniaxial\Concrete06.bas
*elseif(strcmp(MatProp(Material:),"ConcreteCM")==0)
*include ..\Materials\Uniaxial\ConcreteCM.bas
*elseif(strcmp(MatProp(Material:),"Steel01")==0)
*include ..\Materials\Uniaxial\Steel01.bas
*elseif(strcmp(MatProp(Material:),"Steel02")==0)
*include ..\Materials\Uniaxial\Steel02.bas
*elseif(strcmp(MatProp(Material:),"ReinforcingSteel")==0)
*include ..\Materials\Uniaxial\ReinforcingSteel.bas
*elseif(strcmp(MatProp(Material:),"RambergOsgoodSteel")==0)
*include ..\Materials\Uniaxial\RambergOsgoodSteel.bas
*elseif(strcmp(MatProp(Material:),"Hysteretic")==0)
*include ..\Materials\Uniaxial\Hysteretic.bas
*elseif(strcmp(MatProp(Material:),"MinMax")==0)
*include ..\Materials\Uniaxial\MinMax.bas
*else
*MessageBox Error: Unsupported Core material for Custom Fiber Section
*endif
*set var dummy=tcl(AddUsedMaterials *SelectedMaterial)
*break
*endif
*end materials
*endif
set MatTag *tcl(FindMaterialNumber *MatProp(Region_8_material:) *DomainNum)
source "../Scripts/*tcl(Fiber::GetScriptName *MatProp(0) 8)"
*endif
*set var FileExists=tcl(Fiber::FiberCustomFileExists *MatProp(0) 9)
*if(FileExists==1)
*set var SelectedMaterial=tcl(FindMaterialNumber *MatProp(Region_9_material) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedMaterial )
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *Matprop(0) *DomainNum)
*if(SelectedMaterial==MaterialID)
*if(strcmp(MatProp(Material:),"Concrete01")==0)
*include ..\Materials\Uniaxial\Concrete01.bas
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*include ..\Materials\Uniaxial\Concrete02.bas
*elseif(strcmp(MatProp(Material:),"Concrete04")==0)
*include ..\Materials\Uniaxial\Concrete04.bas
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*include ..\Materials\Uniaxial\Concrete06.bas
*elseif(strcmp(MatProp(Material:),"ConcreteCM")==0)
*include ..\Materials\Uniaxial\ConcreteCM.bas
*elseif(strcmp(MatProp(Material:),"Steel01")==0)
*include ..\Materials\Uniaxial\Steel01.bas
*elseif(strcmp(MatProp(Material:),"Steel02")==0)
*include ..\Materials\Uniaxial\Steel02.bas
*elseif(strcmp(MatProp(Material:),"ReinforcingSteel")==0)
*include ..\Materials\Uniaxial\ReinforcingSteel.bas
*elseif(strcmp(MatProp(Material:),"RambergOsgoodSteel")==0)
*include ..\Materials\Uniaxial\RambergOsgoodSteel.bas
*elseif(strcmp(MatProp(Material:),"Hysteretic")==0)
*include ..\Materials\Uniaxial\Hysteretic.bas
*elseif(strcmp(MatProp(Material:),"MinMax")==0)
*include ..\Materials\Uniaxial\MinMax.bas
*else
*MessageBox Error: Unsupported Core material for Custom Fiber Section
*endif
*set var dummy=tcl(AddUsedMaterials *SelectedMaterial)
*break
*endif
*end materials
*endif
set MatTag *tcl(FindMaterialNumber *MatProp(Region_9_material:) *DomainNum)
source "../Scripts/*tcl(Fiber::GetScriptName *MatProp(0) 9)"
*endif
*set var FileExists=tcl(Fiber::FiberCustomFileExists *MatProp(0) 10)
*if(FileExists==1)
*set var SelectedMaterial=tcl(FindMaterialNumber *MatProp(Region_10_material) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedMaterial )
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *Matprop(0) *DomainNum)
*if(SelectedMaterial==MaterialID)
*if(strcmp(MatProp(Material:),"Concrete01")==0)
*include ..\Materials\Uniaxial\Concrete01.bas
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*include ..\Materials\Uniaxial\Concrete02.bas
*elseif(strcmp(MatProp(Material:),"Concrete04")==0)
*include ..\Materials\Uniaxial\Concrete04.bas
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*include ..\Materials\Uniaxial\Concrete06.bas
*elseif(strcmp(MatProp(Material:),"ConcreteCM")==0)
*include ..\Materials\Uniaxial\ConcreteCM.bas
*elseif(strcmp(MatProp(Material:),"Steel01")==0)
*include ..\Materials\Uniaxial\Steel01.bas
*elseif(strcmp(MatProp(Material:),"Steel02")==0)
*include ..\Materials\Uniaxial\Steel02.bas
*elseif(strcmp(MatProp(Material:),"ReinforcingSteel")==0)
*include ..\Materials\Uniaxial\ReinforcingSteel.bas
*elseif(strcmp(MatProp(Material:),"RambergOsgoodSteel")==0)
*include ..\Materials\Uniaxial\RambergOsgoodSteel.bas
*elseif(strcmp(MatProp(Material:),"Hysteretic")==0)
*include ..\Materials\Uniaxial\Hysteretic.bas
*elseif(strcmp(MatProp(Material:),"MinMax")==0)
*include ..\Materials\Uniaxial\MinMax.bas
*else
*MessageBox Error: Unsupported Core material for Custom Fiber Section
*endif
*set var dummy=tcl(AddUsedMaterials *SelectedMaterial)
*break
*endif
*end materials
*endif
set MatTag *tcl(FindMaterialNumber *MatProp(Region_10_material:) *DomainNum)
source "../Scripts/*tcl(Fiber::GetScriptName *MatProp(0) 10)"
*endif
}