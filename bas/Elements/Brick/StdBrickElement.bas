*#--------------------------------------------------------------------------------
*#                                  stdBrick Elements
*#--------------------------------------------------------------------------------
*# variable to count stdBrick elements
*set var cntStdBrick=0
*loop elems 
*if(strcmp(ElemsMatProp(Element_type:),"stdBrick")==0)
*if(ElemsType!=5)
*MessageBox Error: Standard Brick Elements must be Hexahedra.
*endif
*set var cntStdBrick=operation(cntStdBrick+1)
*endif
*end elems
*if(cntStdBrick!=0)

# --------------------------------------------------------------------------------------------------------------
# S T A N D A R D   B R I C K   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

*set var VarCount=1
*if(GenData(Dimensions,int)==3 && GenData(DOF,int)==3)
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"stdBrick")==0)
*if(VarCount==1)
*if(file!=2)
*set var file=8
*endif
# nDMaterial Definition
*loop materials
*if(strcmp(MatProp(Element_type:),"stdBrick")==0)

nDMaterial *\
*Set Var oMujMat=tcl(FindMaterialNumber *MatProp(Material) )
*loop materials *NotUsed
*Set Var oMat=tcl(FindMaterialNumber *MatProp(0) )
*if(oMat==oMujMat)
*if(strcmp(MatProp(1),"ElasticIsotropic")==0)
*format "%d%g%g"
ElasticIsotropic *oMat *MatProp(Elastic_Modulus_E,real) *MatProp(Poisson's_ratio,real)
*elseif(strcmp(MatProp(1),"ElasticOrthotropic")==0)
*format "%d%g%g%g%g%g%g%g%g%g"
ElasticOrthotropic *oMat *MatProp(Elastic_Modulus_Ex,real) *MatProp(Elastic_Modulus_Ey,real) *MatProp(Elastic_Modulus_Ez,real) *MatProp(Poisson's_ratio_xy,real) *MatProp(Poisson's_ratio_yz,real) *MatProp(Poisson's_ratio_zx,real) *MatProp(Shear_Modulus_Gxy,real) *MatProp(Shear_Modulus_Gyz,real) *MatProp(Shear_Modulus_Gzx,real)
*endif
*endif
*end materials
*endif
*end materials

# stdBrick element definition: element stdBrick $eleTag $node1 $node2 $node3 $node4 $node5 $node6 $node7 $node8 $matTag <$b1 $b2 $b3>

*endif
*format "%6d%6d%6d%6d%6d%6d%6d%6d%6d   %8.3f%8.3f%8.3f"
element stdBrick *ElemsNum *ElemsConec(1) *ElemsConec(2) *ElemsConec(3) *ElemsConec(4) *ElemsConec(5) *ElemsConec(6) *ElemsConec(7) *ElemsConec(8) *tcl(FindMaterialNumber *ElemsMatProp(Material)) *ElemsMatProp(X-Direction) *ElemsMatProp(Y-Direction) *ElemsMatProp(Z-Direction)
*set var VarCount=VarCount+1
*endif
*end elems
*else
*MessageBox Error: Shell elements require a 3D / 6-DOF model.
*endif
*endif
