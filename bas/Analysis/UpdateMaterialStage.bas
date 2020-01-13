*set var VarCount=0
*if(cntQuad!=0 || cntQuadUP!=0 || cntTri31!=0)
*loop materials
*if(strcmp(MatProp(Element_type:),"Quad")==0 || strcmp(MatProp(Element_type:),"QuadUP")==0 || strcmp(MatProp(Element_type:),"Tri31")==0)
*set var PMYID=tcl(getDomainMatID *MatProp(PMY_ID,int) *DomainNum)
*if(PMYID!=0)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(MaterialID==PMYID)
*if(strcmp(MatProp(1),"PressureIndependMultiYield")==0 || strcmp(MatProp(1),"PressureDependMultiYield")==0)
*if(MatProp(Activate_plastic_response,int)==1)
*set var UpdateInverval=MatProp(Activate_plastic_response_at_interval,int)
*if(IntvNum==UpdateInverval)
*set var VarCount=operation(VarCount+1)
*if(VarCount==1)
# Update PIMY/PDMY materials to Stage 1 - Plastic response

*endif
updateMaterialStage -material *PMYID -stage 1
*break
*endif
*endif
*endif
*endif
*end materials
*endif
*endif
*end materials
*endif