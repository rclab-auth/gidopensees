*set var dummy=tcl(ClearRegionsIDLists)
*set var RegionIDExists=-1
*set var RegionRayleighElemsFound=0
*set var RegionRayleighNodesFound=0
*set cond Volume_Rayleigh_Damping-Elements *elems
*add cond Surface_Rayleigh_Damping-Elements *elems
*add cond Line_Rayleigh_Damping-Elements *elems
*loop elems *OnlyInCond
*set var RegionRayleighElemsFound=1
*set var RegionIDExists=tcl(CheckElemRegionID *Cond(1,int))
*if(RegionIDExists==-1)
*set var dummy=tcl(AddElemRegionID *Cond(1,int))
*endif
*end elems
*set cond Volume_Rayleigh_Damping-Nodes *nodes
*add cond Surface_Rayleigh_Damping-Nodes *nodes
*add cond Line_Rayleigh_Damping-Nodes *nodes
*add cond Point_Rayleigh_Damping-Nodes *nodes
*loop nodes *OnlyInCond
*set var RegionRayleighNodesFound=1
*set var RegionIDExists=tcl(CheckNodeRegionID *Cond(1,int))
*if(RegionIDExists==-1)
*set var dummy=tcl(AddNodeRegionID *Cond(1,int))
*endif
*end nodes
*# count the number of node regions and elem regions respectively
*set var NNodeRegions=tcl(NNodeRegions)
*set var NElemRegions=tcl(NElemRegions)
*if(RegionRayleighElemsFound==1 || RegionRayleighNodesFound==1)

# Rayleigh Damping

*endif
*#    Element Regions
*if(RegionRayleighElemsFound!=0)
*for(i=1;i<=NElemRegions;i=i+1)
*set var RegionID=tcl(RegionElemID *i)
*set cond Volume_Rayleigh_Damping-Elements *elems
*add cond Surface_Rayleigh_Damping-Elements *elems
*add cond Line_Rayleigh_Damping-Elements *elems
region *RegionID -ele *\
*loop elems *OnlyInCond
*if(cond(1,int)==RegionID)
*ElemsNum *\
*endif
*end elems
*loop elems *OnlyInCond
*if(cond(1,int)==RegionID)
*set var alphaM=cond(2,real)
*set var betaK=cond(3,real)
*set var betaKinit=cond(4,real)
*set var betaKcomm=cond(5,real)
*break
*endif
*end elems
*format "%g%g%g%g"
-rayleigh *alphaM *betaK *betaKinit *betaKcomm
*endfor
*endif
*#    Node Regions
*if(RegionRayleighNodesFound!=0)
*for(i=1;i<=NNodeRegions;i=i+1)
*set var RegionID=tcl(RegionNodeID *i)
*set cond Volume_Rayleigh_Damping-Nodes *nodes
*add cond Surface_Rayleigh_Damping-Nodes *nodes
*add cond Line_Rayleigh_Damping-Nodes *nodes
*add cond Point_Rayleigh_Damping-Nodes *nodes
region *RegionID -node *\
*loop nodes *OnlyInCond
*if(cond(1,int)==RegionID)
*NodesNum *\
*endif
*end nodes
*loop nodes *OnlyInCond
*if(cond(1,int)==RegionID)
*set var alphaM=cond(2,real)
*set var betaK=cond(3,real)
*set var betaKinit=cond(4,real)
*set var betaKcomm=cond(5,real)
*break
*endif
*end nodes
*format "%g%g%g%g"
-rayleigh *alphaM *betaK *betaKinit *betaKcomm
*endfor
*endif