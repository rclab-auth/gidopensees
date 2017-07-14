*set var SeriesParallelTag=MaterialID
*set var Nuniax=0
*for(k=2;k<=10;k=k+2)
*if(MatProp(*k,int)==1)
*set var Nuniax=operation(Nuniax+1)
*set var SelUniaxMatID=tcl(FindMaterialNumber *MatProp(*operation(k+1)) )
*set var MaterialExists=tcl(CheckUsedMaterials *SelUniaxMatID )
*if(MaterialExists==-1)
*set var dummy=tcl(AddUsedMaterials *SelUniaxMatID)
*loop materials *NotUsed
*set Var MaterialID=tcl(FindMaterialNumber *MatProp(0) )
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
uniaxialMaterial *\
*if(strcmp(MatProp(Material:),"Parallel")==0)
Parallel *\
*else
Series *\
*endif
*SeriesParallelTag *\
*for(k=2;k<=10;k=k+2)
*if(MatProp(*k,int)==1)
*tcl(FindMaterialNumber *MatProp(*operation(k+1))) *\
*endif
*endfor

*endif