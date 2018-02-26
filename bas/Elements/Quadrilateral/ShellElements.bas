*#--------------------------------------------------------------------------------
*#                                  ShellMITC4 Elements
*#--------------------------------------------------------------------------------
*# variable count ShellMITC4 elements
*set var cntcurrShell=0
*loop elems *OnlyInGroup
*if(strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*if(ElemsType!=3)
*MessageBox Error: Shell elements must be quadrilateral.
*endif
*set var cntShell=operation(cntShell+1)
*set var cntcurrShell=operation(cntcurrShell+1)
*endif
*end elems
*if(cntcurrShell!=0)

# --------------------------------------------------------------------------------------------------------------
# S H E L L M I T C 4   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

*set var VarCount=1
*if(ndime==3 && currentDOF==6)
*loop elems *OnlyInGroup
*if(strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*if(VarCount==1)
# Materials/Sections Definition used by shell elements
# (if the have not already been defined on this model domain)

*loop materials
*if(strcmp(MatProp(Element_type:),"Shell")==0)
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

# ShellMITC4 Elements Definition: element ShellMITC4 $eleTag $iNode $jNode $kNode $lNode $secTag

*endif
*format "%6d%6d%6d%6d%6d   "
element ShellMITC4 *ElemsNum *ElemsConec *tcl(FindMaterialNumber *ElemsMatProp(Type) *DomainNum)
*set var VarCount=VarCount+1
*endif
*end elems
*endif
*endif