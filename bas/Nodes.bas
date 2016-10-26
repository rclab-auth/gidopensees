
# --------------------------------------------------------------------------------------------------------------
# N O D E S
# --------------------------------------------------------------------------------------------------------------

*set var cntNodes=0
*set var threeD=-1
*if(GenData(Dimensions,int)==3)
# node $NodeTag $XCoord $Ycoord %Zcoord

*loop nodes
*set var cntNodes=operation(cntNodes+1)
*format "%6d%8.3f%8.3f%8.3f"
node *NodesNum *nodescoord(1) *nodescoord(2) *nodescoord(3)
*if(nodescoord(3,real)!=0)
*set var threeD=threeD+1
*endif
*end nodes
*elseif(GenData(Dimensions,int)==2)
# node $NodeTag $XCoord $Ycoord

*loop nodes
*set var cntNodes=operation(cntNodes+1)
*format "%6d%8.3f%8.3f"
node *NodesNum *nodescoord(1) *nodescoord(2) 
*end nodes
*endif