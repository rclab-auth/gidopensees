# TODO: Create custom python function
*set var UserMaterialTag=SectionID
*set var FileExists=tcl(UserMaterial::UserMaterialFileExists *MatProp(0))
*if(FileExists==1)
source "../Scripts/*tcl(UserMaterial::GetScriptName *MatProp(0))"
*endif

*# end here