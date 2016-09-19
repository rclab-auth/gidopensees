*loop elems
*if(strcmp(elemsMatProp(Element_type:),"Truss")==0)
*if(elemsconec(1)==NodesNum)
*set var NodeIDnum1=elemsconec(1)
*set var NodeIDnum2=elemsconec(2)
*loop nodes
*if(NodesNum==NodeIDnum1)
*set var Zcoord1=NodesCoord(3)
*set var Xcoord1=NodesCoord(1)
*set var Ycoord1=NodesCoord(2)
*elseif(NodesNum==NodeIDnum2)
*set var Zcoord2=NodesCoord(3)
*set var Xcoord2=NodesCoord(1)
*set var Ycoord2=NodesCoord(2)
*endif
*end nodes
*if(operation(Zcoord2-Zcoord1)!=0)
*set var Translz=0
*endif
*if(operation(Xcoord1-Xcoord2)!=0)
*set var Translx=0
*endif
*if(operation(Ycoord1-Ycoord2)!=0)
*set var Transly=0
*endif
*elseif(elemsconec(2)==NodesNum)
*set var NodeIDnum1=elemsconec(1)
*set var NodeIDnum2=elemsconec(2)
*loop nodes
*if(NodesNum==NodeIDnum1)
*set var Zcoord1=NodesCoord(3)
*set var Xcoord1=NodesCoord(1)
*set var Ycoord1=NodesCoord(2)
*elseif(NodesNum==NodeIDnum2)
*set var Zcoord2=NodesCoord(3)
*set var Xcoord2=NodesCoord(1)
*set var Ycoord2=NodesCoord(2)
*endif
*end nodes
*if(operation(Zcoord2-Zcoord1)!=0)
*set var Translz=0
*endif
*if(operation(Xcoord1-Xcoord2)!=0)
*set var Translx=0
*endif
*if(operation(Ycoord1-Ycoord2)!=0)
*set var Transly=0
*endif
*endif
*endif
*end elems