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
# (if the have not already been defined on this model domain)

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
*include ..\..\Sections\PlateFiber.bas
*elseif(strcmp(MatProp(Section:),"ElasticMembranePlate")==0)
*include ..\..\Sections\ElasticMembranePlate.bas
*elseif(strcmp(MatProp(Section:),"LayeredShell")==0)
*include ..\..\Sections\LayeredShell.bas
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
*format "%6d%6d%6d%6d%6d   "
element ShellDKGQ *ElemsNum *ElemsConec *tcl(FindMaterialNumber *ElemsMatProp(Type) *DomainNum)
*set var VarCount=VarCount+1
*endif
*end elems
*endif
*endif