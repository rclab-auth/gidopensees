*set var parameterTag=1
*if(cntQuadUP!=0)
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"QuadUP")==0)
*if(ElemsMatProp(Update_permeabilities,int)==1)
*set var UpdateInverval=ElemsMatProp(Update_permeabilities_at_interval,int)
*if(IntvNum==UpdateInverval)
ops.parameter(*parameterTag, "element", *ElemsNum, "vPerm")
ops.updateParameter(*parameterTag *ElemsMatProp(Permeability_coefficient_in_vertical_direction,real))
*set var parameterTag=operation(parameterTag+1)
ops.parameter(*parameterTag, "element", *ElemsNum, "hPerm")
ops.updateParameter(*parameterTag, *ElemsMatProp(Permeability_coefficient_in_horizontal_direction,real))
*set var parameterTag=operation(parameterTag+1)
*endif
*endif
*endif
*end elems
*endif