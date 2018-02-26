# --------------------------------------------------------------------------------------------------------------
# N O D E S
# --------------------------------------------------------------------------------------------------------------

*set var cntcurrNodes=0
*set Group *GroupName *nodes
*if(ndime==3)
# node $NodeTag $XCoord $Ycoord $Zcoord

*loop nodes *OnlyInGroup
*set var dummy=tcl(AssignToGroupNodeList *NodesNum *currentDOF)
*set var cntNodes=operation(cntNodes+1)
*set var cntcurrNodes=operation(cntcurrNodes+1)
*format "%6d%10g%10g%10g"
node *NodesNum *nodescoord(1) *nodescoord(2) *nodescoord(3)
*end nodes
*elseif(ndime==2)
# node $NodeTag $XCoord $Ycoord

*loop nodes *OnlyInGroup
*set var dummy=tcl(AssignToGroupNodeList *NodesNum *currentDOF)
*set var cntcurrNodes=operation(cntcurrNodes+1)
*set var cntNodes=operation(cntNodes+1)
*format "%6d%10g%10g"
node *NodesNum *nodescoord(1) *nodescoord(2)
*end nodes
*endif