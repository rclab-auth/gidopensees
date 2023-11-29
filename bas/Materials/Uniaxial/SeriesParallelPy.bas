*set var SeriesParallelTag=MaterialID
*set var Nuniax=0
*for(k=2;k<=10;k=k+2)
*if(MatProp(*k,int)==1)
*set var Nuniax=operation(Nuniax+1)
*set var SelUniaxMatID=tcl(FindMaterialNumber *MatProp(*operation(k+1)) *DomainNum)
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
*elseif(strcmp(MatProp(Material:),"Viscous")==0)
*include ..\..\Materials\Uniaxial\ViscousPy.bas
*else
*MessageBox Error: Invalid uniaxial material selected for Series/Parallel material
*endif
*break
*endif
*end materials
*endif
*endif
*endfor
*if(Nuniax==0)
*MessageBox Error: Series/Parallel uniaxialMaterial material without Uniaxial materials
*else
ops.uniaxialMaterial( *\
*if(strcmp(MatProp(Material:),"Parallel")==0)
"Parallel" *\
*else
"Series" *\
*endif
*SeriesParallelTag, *\
*for(k=2;k<=10;k=k+2)
*if(MatProp(*k,int)==1)
*if(k==10)
*tcl(FindMaterialNumber *MatProp(*operation(k+1)) *DomainNum))
*else
*tcl(FindMaterialNumber *MatProp(*operation(k+1)) *DomainNum), *\
*endif
*endif
*endfor
*endif