*#--------------------------------------------------------------------------------
*#                                  Tri31 Elements                                -
*#--------------------------------------------------------------------------------
*# variable to count Tri31 elements
*set var cntcurrTri31=0
*loop elems *OnlyInGroup
*if(strcmp(ElemsMatProp(Element_type:),"Tri31")==0)
*if(ElemsType!=2)
*MessageBox Error: Tri31 elements must be triangular.
*endif
*set var cntTri31=operation(cntTri31+1)
*set var cntcurrTri31=operation(cntcurrTri31+1)
*endif
*end elems
*if(cntcurrTri31!=0)

# --------------------------------------------------------------------------------------------------------------
# T R I 3 1   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

*set var VarCount=1
*if(ndime==2 && currentDOF==2)
*loop elems *OnlyInGroup
*if(strcmp(ElemsMatProp(Element_type:),"Tri31")==0)
*set var thickness=ElemsMatProp(Thickness,real)
*if(VarCount==1)
# nDMaterial Definition

*loop materials
*if(strcmp(MatProp(Element_type:),"Tri31")==0)
*set Var SelectedMaterial=tcl(FindMaterialNumber *MatProp(Material) )
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedMaterial)
*if(MaterialExists==-1)
*loop materials *NotUsed
*set Var MaterialID=tcl(FindMaterialNumber *MatProp(0) )
*if(MaterialID==SelectedMaterial)
*set var dummy=tcl(AddUsedMaterials *SelectedMaterial)
*if(strcmp(MatProp(1),"ElasticIsotropic")==0)
*include ..\..\Materials\nD\ElasticIsotropic.bas
*elseif(strcmp(MatProp(1),"ElasticOrthotropic")==0)
*include ..\..\Materials\nD\ElasticOrthotropic.bas
*elseif(strcmp(MatProp(Material:),"PressureIndependMultiYield")==0)
*include ..\..\Materials\nD\PIMY.bas
*elseif(strcmp(MatProp(Material:),"PressureDependMultiYield")==0)
*include ..\..\Materials\nD\PDMY.bas
*elseif(strcmp(MatProp(Material:),"J2Plasticity")==0)
*include ..\..\Materials\nD\J2Plasticity.bas
*elseif(strcmp(MatProp(Material:),"Damage2p")==0)
*include ..\..\Materials\nD\Damage2p.bas
*endif
*break
*endif
*end materials
*endif
*endif
*end materials

# Tri31 elements Definition : element tri31 $eleTag $iNode $jNode $kNode $thick $type $matTag <$pressure $rho $b1 $b2>

*endif
*format "%6d%6d%6d%6d%8.3f"
element tri31 *ElemsNum *ElemsConec *thickness  *\
*if(strcmp(ElemsMatProp(Plane_behavior),"PlaneStrain")==0)
*format "%8.3f%8.3f%8.3f%8.3f"
PlaneStrain   *tcl(FindMaterialNumber *ElemsMatProp(Material)) *ElemsMatProp(Surface_pressure) *ElemsMatProp(Mass_density) *ElemsMatProp(X-Direction) *ElemsMatProp(Y-Direction)
*elseif(strcmp(ElemsMatProp(Plane_behavior),"PlaneStress")==0)
*format "%8.3f%8.3f%8.3f%8.3f"
PlaneStress   *tcl(FindMaterialNumber *ElemsMatProp(Material)) *ElemsMatProp(Surface_pressure) *ElemsMatProp(Mass_density) *ElemsMatProp(X-Direction) *ElemsMatProp(Y-Direction)
*endif
*set var VarCount=VarCount+1
*endif
*end elems
*endif
*endif
