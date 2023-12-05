*#--------------------------------------------------------------------------------
*#                                  stdBrick Elements
*#--------------------------------------------------------------------------------
*# variable to count stdBrick elements
*set var cntcurrStdBrick=0
*loop elems *OnlyInGroup
*if(strcmp(ElemsMatProp(Element_type:),"stdBrick")==0)
*if(ElemsType!=5)
*MessageBox Error: Standard Brick Elements must be Hexahedra (Mesh-->Element Type-->Hexahedra.
*endif
*set var cntStdBrick=operation(cntStdBrick+1)
*set var cntcurrStdBrick=operation(cntcurrStdBrick+1)
*endif
*end elems
*if(cntcurrStdBrick!=0)

# --------------------------------------------------------------------------------------------------------------
# S T A N D A R D   B R I C K   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

*set var VarCount=1
*if(ndime==3 && currentDOF==3)
*loop elems *OnlyInGroup
*if(strcmp(ElemsMatProp(Element_type:),"stdBrick")==0)
*if(VarCount==1)
# nDMaterial Definition used by stdBrick Elements
# (if they have not already been defined on this model domain)

*loop materials
*if(strcmp(MatProp(Element_type:),"stdBrick")==0)
*set var SelectedMaterial=tcl(FindMaterialNumber *MatProp(Material) *DomainNum)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(MaterialID==SelectedMaterial)
*if(strcmp(MatProp(Material:),"ElasticIsotropic")==0)
*include ..\..\Materials\nD\ElasticIsotropic.bas
*elseif(strcmp(MatProp(Material:),"ElasticOrthotropic")==0)
*include ..\..\Materials\nD\ElasticOrthotropic.bas
*elseif(strcmp(MatProp(Material:),"PressureIndependMultiYield")==0)
*include ..\..\Materials\nD\PIMY.bas
*elseif(strcmp(MatProp(Material:),"PressureDependMultiYield")==0)
*include ..\..\Materials\nD\PDMY.bas
*elseif(strcmp(MatProp(Material:),"J2Plasticity")==0)
*include ..\..\Materials\nD\J2Plasticity.bas
*elseif(strcmp(MatProp(Material:),"Damage2p")==0)
*include ..\..\Materials\nD\Damage2p.bas
*elseif(strcmp(MatProp(Material:),"UserMaterial")==0)
set MatTag *MaterialID; # *tcl(UserMaterial::GetMaterialName *MatProp(0))
*include ..\..\Materials\User\UserMaterial.bas
*endif
*break
*endif
*end materials
*endif
*end materials

# stdBrick element definition: element stdBrick $eleTag $node1 $node2 $node3 $node4 $node5 $node6 $node7 $node8 $matTag <$b1 $b2 $b3>

*endif
*format "%6d%6d%6d%6d%6d%6d%6d%6d%6d   %8g%8g%8g"
element stdBrick *ElemsNum *ElemsConec(1) *ElemsConec(2) *ElemsConec(3) *ElemsConec(4) *ElemsConec(5) *ElemsConec(6) *ElemsConec(7) *ElemsConec(8) *tcl(FindMaterialNumber *ElemsMatProp(Material) *DomainNum) *ElemsMatProp(X-Direction) *ElemsMatProp(Y-Direction) *ElemsMatProp(Z-Direction) ; # *ElemsMatProp(Material)
*set var VarCount=VarCount+1
*endif
*end elems
*endif
*endif