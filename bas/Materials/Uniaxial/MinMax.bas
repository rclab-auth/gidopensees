*set var MinMaxTag=MaterialID

*format "%d%d%g%g"
*if(strcmp(MatProp(Formulation),"Stress-Strain")==0)
*set var SelUniaxMatID=tcl(FindMaterialNumber *MatProp(Material_for_defining_stress-strain_behaviour))
*set var MaterialExists=tcl(CheckUsedMaterials *SelUniaxMatID )
*if(MaterialExists==-1)
*set var dummy=tcl(AddUsedMaterials *SelUniaxMatID)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(MaterialID==SelUniaxMatID)
*set var dummy=tcl(AddUsedMaterials *MaterialID)
*if(strcmp(MatProp(Material:),"Elastic")==0)
*include ..\..\Materials\Uniaxial\Elastic.bas
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlastic")==0)
*include ..\..\Materials\Uniaxial\ElasticPP.bas
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlasticwithGap")==0)
*include ..\..\Materials\Uniaxial\ElasticPPwithGap.bas
*elseif(strcmp(MatProp(Material:),"Steel01")==0)
*include ..\..\Materials\Uniaxial\Steel01.bas
*elseif(strcmp(MatProp(Material:),"Steel02")==0)
*include ..\..\Materials\Uniaxial\Steel02.bas
*elseif(strcmp(MatProp(Material:),"RambergOsgoodSteel")==0)
*include ..\..\Materials\Uniaxial\RambergOsgoodSteel.bas
*elseif(strcmp(MatProp(Material:),"ReinforcingSteel")==0)
*include ..\..\Materials\Uniaxial\ReinforcingSteel.bas
*elseif(strcmp(MatProp(Material:),"Hysteretic")==0)
*include ..\..\Materials\Uniaxial\Hysteretic.bas
*elseif(strcmp(MatProp(Material:),"Concrete01")==0)
*include ..\..\Materials\Uniaxial\Concrete01.bas
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*include ..\..\Materials\Uniaxial\Concrete02.bas
*elseif(strcmp(MatProp(Material:),"Concrete04")==0)
*include ..\..\Materials\Uniaxial\Concrete04.bas
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*include ..\..\Materials\Uniaxial\Concrete06.bas
*elseif(strcmp(MatProp(Material:),"ConcreteCM")==0)
*include ..\..\Materials\Uniaxial\ConcreteCM.bas
*else
*MessageBox Error: Invalid uniaxial material selected for Series/Parallel material
*endif
*break
*endif
*end materials
*endif
uniaxialMaterial MinMax *MinMaxTag *tcl(FindMaterialNumber *MatProp(Material_for_defining_stress-strain_behaviour) *DomainNum) -min *MatProp(Minimum_strain,real) -max *MatProp(Maximum_strain,real)
*elseif(strcmp(MatProp(Formulation),"Force-Deformation")==0)
*set var SelUniaxMatID=tcl(FindMaterialNumber *MatProp(Material_for_defining_force-deformation_behaviour)
*set var MaterialExists=tcl(CheckUsedMaterials *SelUniaxMatID )
*set var dummy=tcl(AddUsedMaterials *SelUniaxMatID)

uniaxialMaterial MinMax *MinMaxTag *tcl(FindMaterialNumber *MatProp(Material_for_defining_force-deformation_behaviour) *DomainNum) -min *MatProp(Minimum_deformation,real) -max *MatProp(Maximum_deformation,real)
*else
*set var SelUniaxMatID=tcl(FindMaterialNumber *MatProp(Material_for_defining_moment-rotation_behaviour)
*set var MaterialExists=tcl(CheckUsedMaterials *SelUniaxMatID )
*set var dummy=tcl(AddUsedMaterials *SelUniaxMatID)

uniaxialMaterial MinMax *MinMaxTag *tcl(FindMaterialNumber *MatProp(Material_for_defining_moment-rotation_behaviour) *DomainNum) -min *MatProp(Minimum_rotation,real) -max *MatProp(Maximum_rotation,real)
*endif 
