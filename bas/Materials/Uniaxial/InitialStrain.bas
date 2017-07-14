*set var InitStrainTag=MaterialID
*set var OtherMaterial=tcl(FindMaterialNumber *MatProp(Material_for_defining_initial_strain))
*# Define Other Material first, if has not been yet
*set var MaterialExists=tcl(CheckUsedMaterials *OtherMaterial )
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *Matprop(0))
*if(OtherMaterial==MaterialID)
*set var dummy=tcl(AddUsedMaterials *OtherMaterial)
*if(strcmp(MatProp(Material:),"Concrete01")==0)
*include Concrete01.bas
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*include Concrete02.bas
*elseif(strcmp(MatProp(Material:),"Concrete04")==0)
*include Concrete04.bas
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*include Concrete06.bas
*elseif(strcmp(MatProp(Material:),"Elastic")==0)
*include Elastic.bas
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlastic")==0)
*include ElasticPP.bas
*elseif(strcmp(MatProp(Material:),"Steel01")==0)
*include Steel01.bas
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlasticwithGap")==0)
*include ElasticPPwithGap.bas
*elseif(strcmp(MatProp(Material:),"Hysteretic")==0)
*include Hysteretic.bas
*elseif(strcmp(MatProp(Material:),"Parallel")==0 || strcmp(MatProp(Material:),"Series")==0)
*include SeriesParallel.bas
*else
*MessageBox Error: Unsupported uniaxialMaterial for Initstrain Material
*endif
*break
*endif
*end materials
*endif
*format "%d%d%g"
uniaxialMaterial InitStrainMaterial *InitStrainTag *OtherMaterial *MatProp(Initial_strain,real)