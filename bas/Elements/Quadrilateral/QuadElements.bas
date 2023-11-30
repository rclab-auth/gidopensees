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
# (only if they have not already been defined on this model domain)

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
*elseif(strcmp(MatProp(Material:),"UserMaterial")==0)
set MatTag *MaterialID; # *tcl(UserMaterial::GetMaterialName *MatProp(0))
*include ..\..\Materials\User\UserMaterial.bas
*endif
*break
*endif
*end materials
*endif
*endif
*end materials

# Quad elements Definition : element quad $EleTag $Nodei $Nodej Nodek $Nodel $thick $type $MatTag

*endif
*#
*# orientation for vertical surfaces
*#
*set var n1=ElemsConec(1)
*set var n2=ElemsConec(2)
*set var n3=ElemsConec(3)
*set var n4=ElemsConec(4)
*#
*set var x1=NodesCoord(1,1)
*set var x2=NodesCoord(2,1)
*set var x3=NodesCoord(3,1)
*set var x4=NodesCoord(4,1)
*set var y1=NodesCoord(1,2)
*set var y2=NodesCoord(2,2)
*set var y3=NodesCoord(3,2)
*set var y4=NodesCoord(4,2)
*set var z1=NodesCoord(1,3)
*set var z2=NodesCoord(2,3)
*set var z3=NodesCoord(3,3)
*set var z4=NodesCoord(4,3)
*# axis 1-2
*set var L12=operation(sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1)+(z2-z1)*(z2-z1)))
*set var V12x=operation((x2-x1)/L12)
*set var V12y=operation((y2-y1)/L12)
*set var V12z=operation((z2-z1)/L12)
*# axis 1-4
*set var L14=operation(sqrt((x4-x1)*(x4-x1)+(y4-y1)*(y4-y1)+(z4-z1)*(z4-z1)))
*set var V14x=operation((x4-x1)/L14)
*set var V14y=operation((y4-y1)/L14)
*set var V14z=operation((z4-z1)/L14)
*# vector 1-2 to positive z
*if((fabs(V12x)<1e-3) && (fabs(V12y)<1e-3) && (fabs(V12z-1)<1e-3))
*set var n1=ElemsConec(4)
*set var n2=ElemsConec(1)
*set var n3=ElemsConec(2)
*set var n4=ElemsConec(3)
*# vector 1-2 to negative z
*elseif((fabs(V12x)<1e-3) && (fabs(V12y)<1e-3) && (fabs(V12z+1)<1e-3))
*set var n1=ElemsConec(2)
*set var n2=ElemsConec(3)
*set var n3=ElemsConec(4)
*set var n4=ElemsConec(1)
*# vector 1-4 to negative z
*elseif((fabs(V14x)<1e-3) && (fabs(V14y)<1e-3) && (fabs(V14z+1)<1e-3))
*set var n1=ElemsConec(3)
*set var n2=ElemsConec(4)
*set var n3=ElemsConec(1)
*set var n4=ElemsConec(2)
*# vector 1-4 to positive z and other cases
*else
*set var n1=ElemsConec(1)
*set var n2=ElemsConec(2)
*set var n3=ElemsConec(3)
*set var n4=ElemsConec(4)
*endif
*#
*# ------------------------------------
*#
*format "%6d%6d%6d%6d%6d%8g"
element quad *ElemsNum *n1 *n2 *n3 *n4 *thickness  *\
*if(strcmp(ElemsMatProp(Plane_behavior),"PlaneStrain")==0)
*set var ID=tcl(FindMaterialNumber *ElemsMatProp(Material) *DomainNum)
*format "%3d%8g%8g%8g%8g"
PlaneStrain *ID *ElemsMatProp(Surface_pressure) *ElemsMatProp(Mass_density) *ElemsMatProp(X-Direction) *ElemsMatProp(Y-Direction); # *ElemsMatProp(Material)
*elseif(strcmp(ElemsMatProp(Plane_behavior),"PlaneStress")==0)
*set var ID=tcl(FindMaterialNumber *ElemsMatProp(Material) *DomainNum)
*format "%6d%8g%8g%8g%8g"
PlaneStress *ID *ElemsMatProp(Surface_pressure) *ElemsMatProp(Mass_density) *ElemsMatProp(X-Direction) *ElemsMatProp(Y-Direction); # *ElemsMatProp(Material)
*endif
*set var VarCount=VarCount+1
*endif
*end elems
*endif
*endif
