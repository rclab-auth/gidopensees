*#--------------------------------------------------------------------------------
*#                                  Shell Elements
*#--------------------------------------------------------------------------------
*# variable to check Shell Elements existance : 1 for existance, 0 for not
*set var ShellFound=0
*loop elems 
*if(strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*set var ShellFound=1
*break
*endif
*end elems
*if(ShellFound==1)
#
# Shell Elements
#

*set var VarCount=1
*if(GenData(Dimensions,int)==3 && GenData(DOF,int)==6)
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*if(VarCount==1)

*if(file!=2)
*set var file=4
*endif
# Materials/Sections Definition for shell elements

*loop materials 
*if(strcmp(MatProp(Element_type:),"Shell")==0)
*Set Var oMujMat=tcl(FindMaterialNumber *MatProp(Type) )
*loop materials *NotUsed
*Set Var oMat=tcl(FindMaterialNumber *MatProp(0) )
*if(oMat==oMujMat)
*if(strcmp(MatProp(Section:),"PlateFiber")==0)
*set var PlateThickness=MatProp(Plate_thickness_h,real)
*set var PlateFiberTag=oMat
*set var oMujMat2=tcl(FindMaterialNumber *MatProp(Material) )
*loop materials *NotUsed
*set var oMat2=tcl(FindMaterialNumber *MatProp(0) )
*if(oMat2==oMujMat2)
*if(strcmp(MatProp(Material:),"ElasticIsotropic")==0)
nDMaterial ElasticIsotropic *oMat2 *MatProp(Elastic_Modulus_E,real) *MatProp(Poisson's_ratio,real) *MatProp(Mass_density,real)
*elseif(strcmp(MatProp(Material:),"ElastiOrthotropic")==0)
nDMaterial ElasticOrthotropic *oMat *MatProp(Elastic_Modulus_Ex,real) *MatProp(Elastic_Modulus_Ey,real) *MatProp(Elastic_Modulus_Ez,real) *MatProp(Poisson's_ratio_vxy,real) *MatProp(Poisson's_ratio_vyz,real) *MatProp(Poisson's_ratio_vzy,real) *MatProp(Shear_modulus_Gxy,real) *MatProp(Shear_modulus_Gyz,real) *MatProp(Shear_modulus_Gzx,real) *MatProp(Mass_density,real)
*endif
section PlateFiber *PlateFiberTag *oMat2 *PlateThickness
*break
*endif
*end materials
*elseif(strcmp(MatProp(Section:),"ElasticMembranePlate")==0)
*set var ElasticMembranePlateTag=oMat
section ElasticMembranePlateSection *ElasticMembranePlateTag *MatProp(Elastic_Modulus_E,real) *MatProp(Poisson's_ratio,real) *MatProp(Section_depth_h,real) *MatProp(Mass_density,real)
*endif
*endif
*end materials
*endif
*end materials
# Shell Elements Definition: element ShellMITC4 $eleTag $iNode $jNode $kNode $lNode $secTag
*endif
element ShellMITC4 *ElemsNum *ElemsConec *tcl(FindMaterialNumber *ElemsMatProp(Type) )
*set var VarCount=VarCount+1
*endif
*end elems
*else
*MessageBox Error: Shell Elements require 3D model with 6 DOF
*endif
*endif