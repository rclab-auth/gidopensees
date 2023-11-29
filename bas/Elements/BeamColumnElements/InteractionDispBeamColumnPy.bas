*#-------------------------------------------------------------------------------------------------------------
*#------------------Flexure-Shear Interaction Displacement-Based Beam Column Elements--------------------------
*#-------------------------------------------------------------------------------------------------------------
*# variable to count Elastic Beam Column elements
*set var cntcurrDBCI=0
*loop elems *OnlyInGroup
*if(strcmp(ElemsMatProp(Element_type:),"dispBeamColumnInt")==0)
*set var cntDBCI=operation(cntDBCI+1)
*set var cntcurrDBCI=operation(cntcurrDBCI+1)
*endif
*end elems
*if(cntcurrDBCI!=0)

# --------------------------------------------------------------------------------------------------------------
# F L E X U R E - S H E A R  I N T E R A C T I O N  D I S P L A C E M E N T - B A S E D   B E A M - C O L U M N   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

*# variable to count the loops
*set var VarCount=1
*if(ndime==2 && currentDOF==3)
*loop elems *OnlyInGroup
*if(strcmp(ElemsMatProp(Element_type:),"dispBeamColumnInt")==0)
*if(VarCount==1)
# Geometric Transformation
*set var TransfTag1=7

ops.geomTransf('LinearInt' *TransfTag1)

# Sections Definition used by dispBeamColumnInt Elements
# (if they have not already been defined on this model domain)

*loop materials
*if(strcmp(MatProp(Element_type:),"dispBeamColumnInt")==0)
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
*if(strcmp(MatProp(Section:),"FiberInt")==0)
*include ..\..\Sections\FiberIntPy.bas
*else
*MessageBox Error: Unsupported section for DispBeamColumnInt Element
*endif
*break
*endif
*# end materials for section searching
*end materials
*# endif section it is not defined
*endif
*# endif element type is dispBeamColumnInt
*endif
*# end materials (elements) to search for dispBeamColumnInt elements
*end materials

# Flexural-Shear Interaction Displacement-Based Beam-Column Element definition

# element dispBeamColumnInt $eleTag $iNode $jNode $numIntgrPts $secTag $transfTag $cRot

*set var VarCount=VarCount+1
*endif
*set var SecTag=tcl(FindMaterialNumber *ElemsMatProp(Section) *DomainNum)
*format "%6d%6d%7d%2d%6d%2d%4g"
ops.element('dispBeamColumnInt', *ElemsNum, *ElemsConec, *ElemsMatProp(Number_of_integration_points,int), *SecTag, *TransfTag1, *ElemsMatProp(Fraction_of_the_height_from_bottom_to_the_rotation_center,real), *\
*set var SelectedSection=tcl(FindMaterialNumber *ElemsMatProp(Section) *DomainNum)
*loop materials *NotUsed
*set var SectionID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelectedSection==SectionID)
*if(strcmp(MatProp(Section:),"FiberInt")==0)
*set var t1=MatProp(Thickness,real)
*set var t2=MatProp(_Thickness,real)
*set var t3=MatProp(__Thickness,real)
*set var d1=MatProp(Width,real)
*set var d2=MatProp(_Width,real)
*set var d3=MatProp(__Width,real)
*set var c1=MatProp(Cover,real)
*set var c3=MatProp(_Cover,real)
*set var Area1=operation(t1*d1)
*set var Area2=operation(t2*d2)
*set var Area3=operation(t3*d3)
*set var FiberIntArea=operation(Area1+Area2+Area3)
*break
*endif
*endif
*end materials
*set var MassPerLength=operation(FiberIntArea*ElemsMatProp(Mass_density,real))
*format "%8g"
  '-mass', *MassPerLength)
*endif
*end elems
*else
*MessageBox Error: Flexural-Shear Interaction Displacement Beam Column elements can be used only for 2D analysis
*endif
*endif 