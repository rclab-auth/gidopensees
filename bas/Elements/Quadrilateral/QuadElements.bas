*#--------------------------------------------------------------------------------
*#                                  Quad Elements                                -
*#--------------------------------------------------------------------------------
*# variable to check Quad Elements existance : 1 for existance, 0 for not
*set var cntQuad=0
*loop elems 
*if(strcmp(ElemsMatProp(Element_type:),"Quad")==0)
*set var cntQuad=operation(cntQuad+1)
*endif
*end elems
*if(cntQuad!=0)
#
# Quad Elements
#

*set var VarCount=1
*if(GenData(Dimensions,int)==2 && GenData(DOF,int)==2)
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Quad")==0)
*set var thickness=ElemsMatProp(Thickness,real)
*if(VarCount==1)
*if(file!=2)
*set var file=4
*endif
# nDMaterial Definition

*loop materials
*if(strcmp(MatProp(Element_type:),"Quad")==0)
nDMaterial *\
*Set Var oMujMat=tcl(FindMaterialNumber *MatProp(Material) )
*loop materials *NotUsed
*Set Var oMat=tcl(FindMaterialNumber *MatProp(0) )
*if(oMat==oMujMat)
*if(strcmp(MatProp(1),"ElasticIsotropic")==0)
ElasticIsotropic *oMat *MatProp(Elastic_Modulus_E,real) *MatProp(Poisson's_ratio,real) *MatProp(Mass_density,real)
*elseif(strcmp(MatProp(1),"ElasticOrthotropic")==0)
ElasticOrthotropic *oMat *MatProp(Elastic_Modulus_Ex,real) *MatProp(Elastic_Modulus_Ey,real) *MatProp(Elastic_Modulus_Ez,real) *MatProp(Poisson's_ratio_vxy,real) *MatProp(Poisson's_ratio_vyz,real) *MatProp(Poisson's_ratio_vzy,real) *MatProp(Shear_modulus_Gxy,real) *MatProp(Shear_modulus_Gyz,real) *MatProp(Shear_modulus_Gzx,real) *MatProp(Mass_density,real)
*endif
*break
*endif
*end materials
*endif
*end materials

# Quad elements Definition : element quad $EleTag $Nodei $Nodej Nodek $Nodel $thick $type $MatTag

*endif
*#*ElemsConec(4) *ElemsConec(1) *ElemsConec(2) *ElemsConec(3)
element quad *ElemsNum *ElemsConec *thickness  *\
*if(strcmp(ElemsMatProp(Plane_behavior),"PlaneStrain")==0)
PlaneStrain *tcl(FindMaterialNumber *ElemsMatProp(Material)) *ElemsMatProp(Surface_pressure) *ElemsMatProp(Mass_density) *ElemsMatProp(X-Direction) *ElemsMatProp(Y-Direction)
*elseif(strcmp(ElemsMatProp(Plane_behavior),"PlaneStress")==0)
PlaneStress *tcl(FindMaterialNumber *ElemsMatProp(Material)) *ElemsMatProp(Surface_pressure) *ElemsMatProp(Mass_density) *ElemsMatProp(X-Direction) *ElemsMatProp(Y-Direction)
*endif
*set var VarCount=VarCount+1
*endif
*end elems
*else
*MessageBox Error: Quad elements require 2D model and 2 DOFs
*endif
*endif