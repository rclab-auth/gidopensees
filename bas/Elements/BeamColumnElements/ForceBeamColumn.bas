*#----------------------------------------------------------------------------------------
*#-----------------------Force-Based Beam Column Elements---------------------------------
*#----------------------------------------------------------------------------------------
*# variable to count Elastic Beam Column elements
*set var cntcurrFBC=0
*loop elems *OnlyInGroup
*if(strcmp(ElemsMatProp(Element_type:),"forceBeamColumn")==0)
*set var cntFBC=operation(cntFBC+1)
*set var cntcurrFBC=operation(cntcurrFBC+1)
*endif
*end elems
*if(cntcurrFBC!=0)

# --------------------------------------------------------------------------------------------------------------
# F O R C E - B A S E D   B E A M - C O L U M N   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

*# variable to count the loops
*set var VarCount=1
*#-------------------------------3D-6DOF-----------------------------------------
*if(ndime==3 && currentDOF==6)
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"forceBeamColumn")==0)
*if(VarCount==1)
*if(GeomTransfPrinted==0)
*# Linear geomTransf tags
*set var TransfTag1=1
*set var TransfTag2=2
*# PDelta geomTransf tags
*set var TransfTag3=3
*set var TransfTag4=4
*# Corotational geomTransf tags
*set var TransfTag5=5
*set var TransfTag6=6
# Geometric Transformation

*# Z AXIS AS VERTICAL AXIS
*if(strcmp(GenData(Vertical_axis),"Z")==0)
geomTransf Linear       *TransfTag1 -1 0 0; # vertical
geomTransf Linear       *TransfTag2  0 0 1; # non-vertical
geomTransf PDelta       *TransfTag3 -1 0 0; # vertical
geomTransf PDelta       *TransfTag4  0 0 1; # non-vertical
geomTransf Corotational *TransfTag5 -1 0 0; # vertical
geomTransf Corotational *TransfTag6  0 0 1; # non-vertical

*# Y AXIS AS VERTICAL AXIS
*elseif(strcmp(GenData(Vertical_axis),"Y")==0)
geomTransf Linear       *TransfTag1 -1 0 0; # vertical
geomTransf Linear       *TransfTag2  0 1 0; # non-vertical
geomTransf PDelta       *TransfTag3 -1 0 0; # vertical
geomTransf PDelta       *TransfTag4  0 1 0; # non-vertical
geomTransf Corotational *TransfTag5 -1 0 0; # vertical
geomTransf Corotational *TransfTag6  0 1 0; # non-vertical

*endif
*set var GeomTransfPrinted=1
*endif
# Sections Definition used by forceBeamColumn Elements
# (if they have not already been defined on this model domain)

*# Searching all assigned forceBeamColumn elements to check all Sections that they need
*loop materials
*if(strcmp(MatProp(Element_type:),"forceBeamColumn")==0)
*set var SelectedSection=tcl(FindMaterialNumber *MatProp(Section) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedSection)
*# IF IT HAS NOT BEEN DEFINED YET
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var SectionID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*# if the Section is FOUND
*if(SelectedSection==SectionID)
*# Add it to the used "Materials"
*set var dummy=tcl(AddUsedMaterials *SelectedSection)
*if(strcmp(MatProp(Section:),"Fiber")==0)
*include ..\..\Sections\Fiber.bas
*elseif(strcmp(MatProp(Section:),"FiberCustom")==0)
*include ..\..\Sections\FiberCustom.bas
*elseif(strcmp(MatProp(Section:),"SectionAggregator")==0)
*include ..\..\Sections\SectionAggregator.bas
*elseif(strcmp(MatProp(Section:),"ElasticSection")==0)
*include ..\..\Sections\ElasticSection.bas
*endif
*break
*endif
*# end materials for section searching
*end materials
*# endif section it is not defined
*endif
*# endif element type is forceBeamColumn
*endif
*# end materials (elements) to search for forceBeamColumn elements
*end materials

# Force-Based Beam Column Element Definition

# element forceBeamColumn $eleTag $iNode $jNode $numIntgrPts $secTag $transfTag

*set var VarCount=VarCount+1
*endif
*#--------------Z as vertical axis-------------
*if(strcmp(GenData(Vertical_axis),"Z")==0)
*#Vertical elements
*if(fabs(NodesCoord(1,1)-NodesCoord(2,1)) < 1e-6 && fabs(NodesCoord(1,2)-NodesCoord(2,2)) < 1e-6)
*if(strcmp(ElemsMatProp(Geometric_transformation),"Linear")==0)
*set var TransfTag=TransfTag1
*elseif(strcmp(ElemsMatProp(Geometric_transformation),"P-Delta")==0)
*set var TransfTag=TransfTag3
*else
*set var TransfTag=TransfTag5
*endif
*else
*if(strcmp(ElemsMatProp(Geometric_transformation),"Linear")==0)
*set var TransfTag=TransfTag2
*elseif(strcmp(ElemsMatProp(Geometric_transformation),"P-Delta")==0)
*set var TransfTag=TransfTag4
*else
*set var TransfTag=TransfTag6
*endif
*endif
*#--------------Y as vertical axis-------------
*elseif(strcmp(GenData(Vertical_axis),"Y")==0)
*#Vertical elements
*if(fabs(NodesCoord(1,1)-NodesCoord(2,1)) < 1e-6 && fabs(NodesCoord(1,3)-NodesCoord(2,3)) < 1e-6)
*if(strcmp(ElemsMatProp(Geometric_transformation),"Linear")==0)
*set var TransfTag=TransfTag1
*elseif(strcmp(ElemsMatProp(Geometric_transformation),"P-Delta")==0)
*set var TransfTag=TransfTag3
*else
*set var TransfTag=TransfTag5
*endif
*else
*if(strcmp(ElemsMatProp(Geometric_transformation),"Linear")==0)
*set var TransfTag=TransfTag2
*elseif(strcmp(ElemsMatProp(Geometric_transformation),"P-Delta")==0)
*set var TransfTag=TransfTag4
*else
*set var TransfTag=TransfTag6
*endif
*endif
*endif
*set var SecTag=tcl(FindMaterialNumber *ElemsMatProp(Section) *DomainNum)
*format "%6d%6d%7d%2d%6d%2d"
element forceBeamColumn *ElemsNum *ElemsConec *ElemsMatProp(Number_of_integration_points,int) *SecTag *TransfTag *\
*if(ElemsMatProp(Activate_iterative_scheme_for_satisfying_element_compatibility,int)==1)
*format "%4d%10.2e%g"
  -iter *ElemsMatProp(Maximum_Iterations,int) *ElemsMatProp(Tolerance,real) *\
*endif
*format "%g"
*set var SelectedSection=tcl(FindMaterialNumber *ElemsMatProp(Section) *DomainNum)
*loop materials *NotUsed
*set var SectionID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelectedSection==SectionID)
*if(strcmp(MatProp(Section:),"Fiber")==0)
*set var FiberArea=MatProp(Cross_section_area,real)
*elseif(strcmp(MatProp(Section:),"SectionAggregator")==0)
*if(MatProp(Select_section,int)==1)
*set var SelectedSectionTobeAggregated=tcl(FindMaterialNumber *MatProp(Section_to_be_aggregated) *DomainNum)
*loop materials *NotUsed
*set var SectionTobeAggregated=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelectedSectionTobeAggregated==SectionTobeAggregated)
*if(strcmp(MatProp(Section:),"Fiber")==0)
*set var FiberArea=MatProp(Cross_section_area,real)
*elseif(strcmp(MatProp(Section:),"ElasticSection")==0)
*set var FiberArea=MatProp(ElasticSection_Area,real)
*elseif(strcmp(MatProp(Section:),"FiberCustom")==0)
*set var FiberArea=MatProp(Cross_section_area,real)
*else
*MessageBox Invalid Section was selected for Section Aggregator. Only Fiber is supported.
*endif
*endif
*end materials
*else
*set var FiberArea=0.0
*endif
*elseif(strcmp(MatProp(Section:),"ElasticSection")==0)
*set var FiberArea=MatProp(ElasticSection_Area,real)
*elseif(strcmp(MatProp(Section:),"FiberCustom")==0)
*set var FiberArea=MatProp(Cross_section_area,real)
*endif
*endif
*end materials
*set var MassPerLength=operation(FiberArea*ElemsMatProp(Mass_density,real))
*format "%8g"
  -mass *MassPerLength
*# if it is FBC
*endif
*end elems
*#-------------------------------------------------------------------------------------------------------------------------
*#--------------------------------------------------------2D / 3DOF -------------------------------------------------------
*#-------------------------------------------------------------------------------------------------------------------------
*elseif(ndime==2 && currentDOF==3)
*loop elems *OnlyInGroup
*if(strcmp(ElemsMatProp(Element_type:),"forceBeamColumn")==0)
*if(VarCount==1)
*if(GeomTransfPrinted==0)
*set var TransfTag1=1
*set var TransfTag2=2
*set var TransfTag3=3
*#------------------------------------------------
*#-----------Geometric Transformation-------------
*#------------------------------------------------
# Geometric Transformation

geomTransf Linear *TransfTag1
geomTransf PDelta *TransfTag2
geomTransf Corotational *TransfTag3

*set var GeomTransfPrinted=1
*endif
# Sections Definition used by forceBeamColumn Elements
# (if they have not already been defined on this model domain)

*loop materials
*if(strcmp(MatProp(Element_type:),"forceBeamColumn")==0)
*set var SelectedSection=tcl(FindMaterialNumber *MatProp(Section) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedSection)
*# IF IT HAS NOT BEEN DEFINED YET
*if(MaterialExists==-1)
*# meta valto sti lista me ta used materials
*loop materials *NotUsed
*set var SectionID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*# Section FOUND
*if(SelectedSection==SectionID)
*set var dummy=tcl(AddUsedMaterials *SelectedSection)
*if(strcmp(MatProp(Section:),"Fiber")==0)
*include ..\..\Sections\Fiber.bas
*elseif(strcmp(MatProp(Section:),"FiberCustom")==0)
*include ..\..\Sections\FiberCustom.bas
*elseif(strcmp(MatProp(Section:),"SectionAggregator")==0)
*include ..\..\Sections\SectionAggregator.bas
*elseif(strcmp(MatProp(Section:),"ElasticSection")==0)
*include ..\..\Sections\ElasticSection.bas
*elseif(strcmp(MatProp(Material:),"UserMaterial")==0)
set MatTag *SectionID; # *tcl(UserMaterial::GetMaterialName *MatProp(0))
*include ..\..\Materials\User\UserMaterial.bas
*endif
*break
*endif
*# end materials for section searching
*end materials
*# endif section it is not defined
*endif
*# endif element type is forceBeamColumn
*endif
*# end materials (elements) to search for forceBeamColumn elements
*end materials

# Force-Based Beam-Column Element definition

# element forceBeamColumn $eleTag $iNode $jNode $numIntgrPts $secTag $transfTag

*set var VarCount=VarCount+1
*endif
*if(strcmp(ElemsMatProp(Geometric_transformation),"Linear")==0)
*set var TransfTag=TransfTag1
*elseif(strcmp(ElemsMatProp(Geometric_transformation),"P-Delta")==0)
*set var TransfTag=TransfTag2
*else
*set var TransfTag=TransfTag3
*endif
*set var SecTag=tcl(FindMaterialNumber *ElemsMatProp(Section) *DomainNum)
*format "%6d%6d%7d%2d%6d%2d"
element forceBeamColumn *ElemsNum *ElemsConec *ElemsMatProp(Number_of_integration_points,int) *SecTag *TransfTag *\
*if(ElemsMatProp(Activate_iterative_scheme_for_satisfying_element_compatibility,int)==1)
*format "%4d%10.2e"
  -iter *ElemsMatProp(Maximum_Iterations,int) *ElemsMatProp(Tolerance,real) *\
*endif
*set var SelectedSection=tcl(FindMaterialNumber *ElemsMatProp(Section) *DomainNum)
*loop materials *NotUsed
*set var SectionID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelectedSection==SectionID)
*if(strcmp(MatProp(Section:),"Fiber")==0)
*set var FiberArea=MatProp(Cross_section_area,real)
*elseif(strcmp(MatProp(Section:),"SectionAggregator")==0)
*if(MatProp(Select_section,int)==1)
*set var SelectedSectionTobeAggregated=tcl(FindMaterialNumber *MatProp(Section_to_be_aggregated) *DomainNum)
*loop materials *NotUsed
*set var SectionTobeAggregated=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelectedSectionTobeAggregated==SectionTobeAggregated)
*if(strcmp(MatProp(Section:),"Fiber")==0)
*set var FiberArea=MatProp(Cross_section_area,real)
*elseif(strcmp(MatProp(Section:),"ElasticSection")==0)
*set var FiberArea=MatProp(ElasticSection_Area,real)
*elseif(strcmp(MatProp(Section:),"FiberCustom")==0)
*set var FiberArea=MatProp(Cross_section_area,real)
*else
*MessageBox Invalid Section was selected for Section Aggregator. Only Fiber is supported.
*endif
*endif
*end materials
*else
*set var FiberArea=0.0
*endif
*elseif(strcmp(MatProp(Section:),"ElasticSection")==0)
*set var FiberArea=MatProp(ElasticSection_Area,real)
*elseif(strcmp(MatProp(Section:),"FiberCustom")==0)
*set var FiberArea=MatProp(Cross_section_area,real)
*endif
*endif
*end materials
*set var MassPerLength=operation(FiberArea*ElemsMatProp(Mass_density,real))
*format "%8g"
  -mass *MassPerLength
*# if it is FBC
*endif
*end elems
*endif
*# endif counter!=0
*endif