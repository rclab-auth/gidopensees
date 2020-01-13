*#--------------------------------------------------------------------------------
*#                                  Quad Elements                                -
*#--------------------------------------------------------------------------------
*# variable to count Quad elements
*set var cntcurrQuad=0
*set Group *GroupName *elems
*loop elems *OnlyInGroup
*if(strcmp(ElemsMatProp(Element_type:),"Quad")==0)
*if(ElemsType!=3)
*MessageBox Error: Quad elements must be quadrilateral.
*endif
*set var cntQuad=operation(cntQuad+1)
*set var cntcurrQuad=operation(cntcurrQuad+1)
*endif
*end elems
*if(cntcurrQuad!=0)

# --------------------------------------------------------------------------------------------------------------
# Q U A D   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

*set var VarCount=1
*if(ndime==2 && currentDOF==2)
*loop elems *OnlyInGroup
*if(strcmp(ElemsMatProp(Element_type:),"Quad")==0)
*set var thickness=ElemsMatProp(Thickness,real)
*if(VarCount==1)
# nDMaterial Definition used by Quad Elements
# (ïnly if they have not already been defined on this model domain)

*loop materials
*if(strcmp(MatProp(Element_type:),"Quad")==0)
*set var SelectedMaterial=tcl(FindMaterialNumber *MatProp(Material) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedMaterial)
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(MaterialID==SelectedMaterial)
*set var dummy=tcl(AddUsedMaterials *SelectedMaterial)
*if(strcmp(MatProp(Material:),"ElasticIsotropic")==0)
*include ..\..\Materials\nD\ElasticIsotropic.bas
*elseif(strcmp(MatProp(Material:),"ElasticOrthotropic")==0)
*include ..\..\Materials\nD\ElasticOrthotropic.bas
*elseif(strcmp(MatProp(Material:),"PressureIndependMultiYield")==0)
*include ..\..\Materials\nD\PIMY.bas
*elseif(strcmp(MatProp(Material:),"PressureDependMultiYield")==0)
*include ..\..\Materials\nD\PDMY.bas
*elseif(strcmp(MatProp(Material:),"PressureDependMultiYield02")==0)
*include ..\..\Materials\nD\PDMY2.bas
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

# Quad elements Definition : element quad $EleTag $Nodei $Nodej Nodek $Nodel $thick $type $MatTag

*endif
*format "%6d%6d%6d%6d%6d%8g"
element quad *ElemsNum *ElemsConec *thickness  *\
*if(strcmp(ElemsMatProp(Plane_behavior),"PlaneStrain")==0)
*set var ID=tcl(FindMaterialNumber *ElemsMatProp(Material) *DomainNum)
*format "%3d%8g%8g%8g%8g"
PlaneStrain *ID *ElemsMatProp(Surface_pressure) *ElemsMatProp(Mass_density) *ElemsMatProp(X-Direction) *ElemsMatProp(Y-Direction)
*elseif(strcmp(ElemsMatProp(Plane_behavior),"PlaneStress")==0)
*set var ID=tcl(FindMaterialNumber *ElemsMatProp(Material) *DomainNum)
*format "%3d%8g%8g%8g%8g"
PlaneStress *ID *ElemsMatProp(Surface_pressure) *ElemsMatProp(Mass_density) *ElemsMatProp(X-Direction) *ElemsMatProp(Y-Direction)
*endif
*set var VarCount=VarCount+1
*endif
*end elems
*endif
*endif
