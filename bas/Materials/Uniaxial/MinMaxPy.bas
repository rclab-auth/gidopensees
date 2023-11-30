*set var MinMaxTag=MaterialID

*format "%d%d%g%g"
*if(strcmp(MatProp(Formulation),"Stress-Strain")==0)
*set var SelUniaxMatID=tcl(FindMaterialNumber *MatProp(Material_for_defining_stress-strain_behaviour) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelUniaxMatID )
*if(MaterialExists==-1)
*set var dummy=tcl(AddUsedMaterials *SelUniaxMatID)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(MaterialID==SelUniaxMatID)
*set var dummy=tcl(AddUsedMaterials *MaterialID)
*if(strcmp(MatProp(Material:),"Elastic")==0)
*include ..\..\Materials\Uniaxial\ElasticPy.bas
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlastic")==0)
*include ..\..\Materials\Uniaxial\ElasticPPPy.bas
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlasticwithGap")==0)
*include ..\..\Materials\Uniaxial\ElasticPPwithGapPy.bas
*elseif(strcmp(MatProp(Material:),"Steel01")==0)
*include ..\..\Materials\Uniaxial\Steel01Py.bas
*elseif(strcmp(MatProp(Material:),"Steel02")==0)
*include ..\..\Materials\Uniaxial\Steel02Py.bas
*elseif(strcmp(MatProp(Material:),"RambergOsgoodSteel")==0)
*include ..\..\Materials\Uniaxial\RambergOsgoodSteelPy.bas
*elseif(strcmp(MatProp(Material:),"ReinforcingSteel")==0)
*include ..\..\Materials\Uniaxial\ReinforcingSteelPy.bas
*elseif(strcmp(MatProp(Material:),"Hysteretic")==0)
*include ..\..\Materials\Uniaxial\HystereticPy.bas
*elseif(strcmp(MatProp(Material:),"Concrete01")==0)
*include ..\..\Materials\Uniaxial\Concrete01Py.bas
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*include ..\..\Materials\Uniaxial\Concrete02Py.bas
*elseif(strcmp(MatProp(Material:),"Concrete04")==0)
*include ..\..\Materials\Uniaxial\Concrete04Py.bas
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*include ..\..\Materials\Uniaxial\Concrete06Py.bas
*elseif(strcmp(MatProp(Material:),"ConcreteCM")==0)
*include ..\..\Materials\Uniaxial\ConcreteCMPy.bas
*else
*MessageBox Error: Invalid uniaxial material selected for Series/Parallel material
*endif
*break
*endif
*end materials
*endif
ops.uniaxialMaterial("MinMax", *MinMaxTag, *tcl(FindMaterialNumber *MatProp(Material_for_defining_stress-strain_behaviour) *DomainNum), "-min", *MatProp(Minimum_strain,real), "-max", *MatProp(Maximum_strain,real))
*elseif(strcmp(MatProp(Formulation),"Force-Deformation")==0)
*set var SelUniaxMatID=tcl(FindMaterialNumber *MatProp(Material_for_defining_force-deformation_behaviour)
*set var MaterialExists=tcl(CheckUsedMaterials *SelUniaxMatID )
*set var dummy=tcl(AddUsedMaterials *SelUniaxMatID)

ops.uniaxialMaterial("MinMax", *MinMaxTag, *tcl(FindMaterialNumber *MatProp(Material_for_defining_force-deformation_behaviour) *DomainNum), "-min", *MatProp(Minimum_deformation,real), "-max", *MatProp(Maximum_deformation,real))
*else
*set var SelUniaxMatID=tcl(FindMaterialNumber *MatProp(Material_for_defining_moment-rotation_behaviour)
*set var MaterialExists=tcl(CheckUsedMaterials *SelUniaxMatID )
*set var dummy=tcl(AddUsedMaterials *SelUniaxMatID)

ops.uniaxialMaterial("MinMax", *MinMaxTag, *tcl(FindMaterialNumber *MatProp(Material_for_defining_moment-rotation_behaviour) *DomainNum), "-min", *MatProp(Minimum_rotation,real), "-max", *MatProp(Maximum_rotation,real))
*endif