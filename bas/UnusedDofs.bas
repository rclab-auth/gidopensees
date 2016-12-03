*set var dummy=tcl(ClearUnusedDofLists )
*set cond Surface_Restraints
*add cond Line_Restraints
*add cond Point_Restraints
*loop nodes *OnlyInCond
*set var dummy=tcl(AddFixedNode *NodesNum)
*end nodes

*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"stdBrick")==0)
*for(i=1;i<=8;i=i+1)
*set var NodeExists=tcl(CheckIfNodeIsFixed *ElemsConec(*i) )
*if(NodeExists==-1)
*set var xaxa=tcl(CheckStdBrickUnfixedNodes *ElemsConec(*i))
*if(xaxa==-1)
*set var dummy=tcl(AddstdBrickUnfixedNode *ElemsConec(*i))
*endif
*endif
*endfor
*elseif(strcmp(ElemsMatProp(Element_type:),"ElasticBeamColumn")==0)
*for(i=1;i<=2;i=i+1)
*set var NodeExists=tcl(CheckIfNodeIsFixed *ElemsConec(*i) )
*if(NodeExists==-1)
*set var dummy=tcl(AddEBCUnfixedNode *ElemsConec(*i))
*endif
*endfor
*elseif(strcmp(ElemsMatProp(Element_type:),"ElasticTimoshenkoBeamColumn")==0)
*for(i=1;i<=2;i=i+1)
*set var NodeExists=tcl(CheckIfNodeIsFixed *ElemsConec(*i) )
*if(NodeExists==-1)
*set var dummy=tcl(AddETBUnfixedNode *ElemsConec(*i))
*endif
*endfor
*elseif(strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*for(i=1;i<=4;i=i+1)
*set var NodeExists=tcl(CheckIfNodeIsFixed *ElemsConec*i) )
*if(NodeExists==-1)
*set var dummy=tcl(AddShellUnfixedNode *ElemsConec(*i))
*endif
*endfor
*endif
*end elems
# fix of unused DOFs for stdBrick nodes

*if(GenData(Dimensions,int)==3 && GenData(DOF,int)==6)
*set var dummy=tcl(AddstdBrickUnusedDofsNodes )
*set var length=tcl(stdBrickUnusedDofsNodeLength )
*if(length!=0)
*for(i=0;i<=length-1;i=i+1)
fix *tcl(FixstdBrickUnusedDofs *i)   0   0   0   1   1   1
*endfor
*endif 
*endif