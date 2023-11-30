*#--------------------------------------------------------------------------------
*#                                  ShellDKGQ Elements
*#--------------------------------------------------------------------------------
*# variable count ShellDKGQ elements
*set var cntcurrShellDKGQ=0
*loop elems *OnlyInGroup
*if(strcmp(ElemsMatProp(Element_type:),"ShellDKGQ")==0)
*if(ElemsType!=3)
*MessageBox Error: Shell elements must be quadrilateral.
*endif
*set var cntShellDKGQ=operation(cntShellDKGQ+1)
*set var cntcurrShellDKGQ=operation(cntcurrShellDKGQ+1)
*endif
*end elems
*if(cntcurrShellDKGQ!=0)

# --------------------------------------------------------------------------------------------------------------
# S H E L L D K G Q  E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

*set var VarCount=1
*if(ndime==3 && currentDOF==6)
*loop elems *OnlyInGroup
*if(strcmp(ElemsMatProp(Element_type:),"ShellDKGQ")==0)
*if(VarCount==1)
# Materials/Sections Definition used by shellDKGQ elements
# (if not already defined on this model domain)

*loop materials
*if(strcmp(MatProp(Element_type:),"ShellDKGQ")==0)
*set var SelectedSection=tcl(FindMaterialNumber *MatProp(Type) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedSection)
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var SectionID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelectedSection==SectionID)
*set var dummy=tcl(AddUsedMaterials *SelectedSection)
*if(strcmp(MatProp(Section:),"PlateFiber")==0)
*include ..\..\Sections\PlateFiberPy.bas
*elseif(strcmp(MatProp(Section:),"ElasticMembranePlate")==0)
*include ..\..\Sections\ElasticMembranePlatePy.bas
*elseif(strcmp(MatProp(Section:),"LayeredShell")==0)
*include ..\..\Sections\LayeredShellPy.bas
*elseif(strcmp(MatProp(Material:),"UserMaterial")==0)
set MatTag *SelectedSection; # *tcl(UserMaterial::GetMaterialName *MatProp(0))
*include ..\..\Materials\User\UserMaterialPy.bas
*else
*MessageBox Error: Invalid Section selected for Shell element
*endif
*break
*endif
*end materials
*endif
*endif
*end materials

# ShellDKGQ Elements Definition: element ShellDKGQ $eleTag $iNode $jNode $kNode $lNode $secTag

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
*format "%6d%6d%6d%6d%6d%6d"
ops.element('ShellDKGQ', *ElemsNum, *n1, *n2, *n3, *n4, *tcl(FindMaterialNumber *ElemsMatProp(Type) *DomainNum)) # *ElemsMatProp(Type)
*set var VarCount=VarCount+1
*endif
*end elems
*endif
*endif