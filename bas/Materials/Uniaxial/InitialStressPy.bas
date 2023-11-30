*set var InitStressTag=MaterialID
*set var OtherMaterial=tcl(FindMaterialNumber *MatProp(Material_for_defining_initial_stress) *DomainNum)
*# Define Other Material first, if has not been yet
*set var MaterialExists=tcl(CheckUsedMaterials *OtherMaterial )
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *Matprop(0) *DomainNum)
*if(OtherMaterial==MaterialID)
*set var dummy=tcl(AddUsedMaterials *OtherMaterial)
*if(strcmp(MatProp(Material:),"Concrete01")==0)
*include Concrete01Py.bas
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*include Concrete02Py.bas
*elseif(strcmp(MatProp(Material:),"Concrete04")==0)
*include Concrete04Py.bas
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*include Concrete06Py.bas
*elseif(strcmp(MatProp(Material:),"Elastic")==0)
*include ElasticPy.bas
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlastic")==0)
*include ElasticPPPy.bas
*elseif(strcmp(MatProp(Material:),"Steel01")==0)
*include Steel01Py.bas
*elseif(strcmp(MatProp(Material:),"Steel02")==0)
*include Steel02Py.bas
*elseif(strcmp(MatProp(Material:),"ReinforcingSteel")==0)
*include ReinforcingSteelPy.bas
*elseif(strcmp(MatProp(Material:),"RambergOsgoodSteel")==0)
*include RambergOsgoodSteelPy.bas
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlasticwithGap")==0)
*include ElasticPPwithGapPy.bas
*elseif(strcmp(MatProp(Material:),"Hysteretic")==0)
*include HystereticPy.bas
*elseif(strcmp(MatProp(Material:),"Parallel")==0 || strcmp(MatProp(Material:),"Series")==0)
*include SeriesParallelPy.bas
*else
*MessageBox Error: Unsupported uniaxialMaterial for Initstrain Material
*endif
*break
*endif
*end materials
*endif
*format "%d%d%g"
ops.uniaxialMaterial("InitStressMaterial", *InitStressTag, *OtherMaterial, *MatProp(Initial_stress,real))