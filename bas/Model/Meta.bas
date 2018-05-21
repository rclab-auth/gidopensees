*set var elem1D=operation(cntEBC+cntETB+cntTruss+cntCorotTruss+cntFBC+cntDBC+cntDBCI)
*set var elem2D=operation(cntQuad+cntQuadUP+cntShell+cntTri31)
*set var elem3D=cntStdBrick
*set var frames=operation(cntEBC+cntETB+cntFBC+cntDBC+cntDBCI)

# --------------------------------------------------------------------------------------------------------------
#
# M E T A D A T A
#
# --------------------------------------------------------------------------------------------------------------

# Number of nodes
# *cntNodes

# Elements 1D
# *elem1D

# Elements 2D
# *elem2D

# Elements 3D
# *elem3D
*if(cntEBC!=0)

# ElasticBeamColumn
# *cntEBC
# *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ElasticBeamColumn")==0)
*ElemsNum *\
*endif
*end elems

*endif
*if(cntETB!=0)

# ElasticTimoshenkoBeamColumn
# *cntETB
# *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ElasticTimoshenkoBeamColumn")==0)
*ElemsNum *\
*endif
*end elems

*endif
*if(cntFBC!=0)

# ForceBeamColumn
# *cntFBC
# *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"forceBeamColumn")==0)
*ElemsNum *\
*endif
*end elems

*endif
*if(cntDBC!=0)

# DispBeamColumn
# *cntDBC
# *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"dispBeamColumn")==0)
*ElemsNum *\
*endif
*end elems

*endif
*if(cntDBCI!=0)

# DispBeamColumnInt
# *cntDBCI
# *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"dispBeamColumnInt")==0)
*ElemsNum *\
*endif
*end elems

*endif
*if(cntTruss!=0)

# Truss
# *cntTruss
# *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Truss")==0)
*ElemsNum *\
*endif
*end elems

*endif
*if(cntCorotTruss!=0)

# CorotTruss
# *cntCorotTruss
# *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"CorotationalTruss")==0)
*ElemsNum *\
*endif
*end elems

*endif
*if(cntQuad!=0)

# Quad
# *cntQuad
# *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Quad")==0)
*ElemsNum *\
*endif
*end elems

*endif
*if(cntQuadUP!=0)

# QuadUP
# *cntQuadUP
# *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"QuadUP")==0)
*ElemsNum *\
*endif
*end elems

*endif
*if(cntShell!=0)

# ShellMITC4
# *cntShell
# *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*ElemsNum *\
*endif
*end elems

*endif
*if(cntShellDKGQ!=0)

# ShellDKGQ
# *cntShellDKGQ
# *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ShellDKGQ")==0)
*ElemsNum *\
*endif
*end elems

*endif
*if(cntTri31!=0)

# Tri31
# *cntTri31
# *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Tri31")==0)
*ElemsNum *\
*endif
*end elems

*endif
*if(cntStdBrick!=0)

# stdBrick
# *cntStdBrick
# *\
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"stdBrick")==0)
*ElemsNum *\
*endif
*end elems

*endif
*if(frames!=0)

# ----------------------------------------------------------------------------------------------------------------------------------------------------------
#
# F R A M E   L O C A L   A X E S   O R I E N T A T I O N
#
# ----------------------------------------------------------------------------------------------------------------------------------------------------------
#
#      ID                           Type                          Local-x                          Local-y                          Local-z          Literal
#
*loop elems
*set var exist=0
*#
*# check for valid element
*#
*format "#  %6d"
*if(strcmp(ElemsMatProp(Element_type:),"ElasticBeamColumn")==0)
*ElemsNum              ElasticBeamColumn*\
*set var exist=1
*elseif(strcmp(ElemsMatProp(Element_type:),"ElasticTimoshenkoBeamColumn")==0)
*ElemsNum    ElasticTimoshenkoBeamColumn*\
*set var exist=1
*elseif(strcmp(ElemsMatProp(Element_type:),"forceBeamColumn")==0)
*ElemsNum                forceBeamColumn*\
*set var exist=1
*elseif(strcmp(ElemsMatProp(Element_type:),"dispBeamColumn")==0)
*ElemsNum                 dispBeamColumn*\
*set var exist=1
*elseif(strcmp(ElemsMatProp(Element_type:),"dispBeamColumnInt")==0)
*ElemsNum              dispBeamColumnInt*\
*set var exist=1
*endif
*#
*# process element
*#
*if(exist)
*# end coordinates
*set var x1=NodesCoord(1,1)
*set var y1=NodesCoord(1,2)
*set var z1=NodesCoord(1,3)
*set var x2=NodesCoord(2,1)
*set var y2=NodesCoord(2,2)
*set var z2=NodesCoord(2,3)
*# vector Vx
*set var L=operation(sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1)+(z2-z1)*(z2-z1)))
*set var Vx1=operation((x2-x1)/L)
*set var Vx2=operation((y2-y1)/L)
*set var Vx3=operation((z2-z1)/L)
*# 2D Problem
*if(ndime==2)
*# Vecxz = +Z
*set var Vecxz1=0.0
*set var Vecxz2=0.0
*set var Vecxz3=1.0
*# 3D Problem
*elseif(ndime==3)
*# vertical axis Y
*if(strcmp(GenData(Vertical_axis),"Y")==0)
*if(x1!=x2 || z1!=z2)
*# vertical axis Y - oblique element
*set var Vecxz1=0.0
*set var Vecxz2=1.0
*set var Vecxz3=0.0
*else
*# vertical axis Y - vertical element Vecxz = -X
*set var Vecxz1=-1.0
*set var Vecxz2=0.0
*set var Vecxz3=0.0
*endif
*endif
*# vertical axis Z
*if(strcmp(GenData(Vertical_axis),"Z")==0)
*if(x1!=x2 || y1!=y2)
*# vertical axis Z - oblique element
*set var Vecxz1=0.0
*set var Vecxz2=0.0
*set var Vecxz3=1.0
*else
*# vertical axis Z - vertical element Vecxz = -X
*set var Vecxz1=-1.0
*set var Vecxz2=0.0
*set var Vecxz3=0.0
*endif
*endif
*endif
*# Vy = Vecxz x Vx
*set var Vy1=operation(Vecxz2*Vx3-Vecxz3*Vx2)
*set var Vy2=operation(Vecxz3*Vx1-Vecxz1*Vx3)
*set var Vy3=operation(Vecxz1*Vx2-Vecxz2*Vx1)
*# convert to unit vector
*set var L=operation(sqrt(Vy1*Vy1+Vy2*Vy2+Vy3*Vy3))
*set var Vy1=operation(Vy1/L)
*set var Vy2=operation(Vy2/L)
*set var Vy3=operation(Vy3/L)
*# Vz = Vx x Vy
*set var Vz1=operation(Vx2*Vy3-Vx3*Vy2)
*set var Vz2=operation(Vx3*Vy1-Vx1*Vy3)
*set var Vz3=operation(Vx1*Vy2-Vx2*Vy1)
*# convert to unit vector
*set var L=operation(sqrt(Vz1*Vz1+Vz2*Vz2+Vz3*Vz3))
*set var Vz1=operation(Vz1/L)
*set var Vz2=operation(Vz2/L)
*set var Vz3=operation(Vz3/L)
*# write axis in vector form
*format "     {%+7.5f %+7.5f %+7.5f}     {%+7.5f %+7.5f %+7.5f}     {%+7.5f %+7.5f %+7.5f}"
*Vx1*Vx2*Vx3*Vy1*Vy2*Vy3*Vz1*Vz2*Vz3     {*\
*# write literal axes
*for(i=1;i<=3;i=i+1)
*set var check=0
*if(i==1)
*set var V1=Vx1
*set var V2=Vx2
*set var V3=Vx3
*elseif(i==2)
*set var V1=Vy1
*set var V2=Vy2
*set var V3=Vy3
*elseif(i==3)
*set var V1=Vz1
*set var V2=Vz2
*set var V3=Vz3
*endif
*if((V1<1e-6) && (V1>-1e-6))
*set var V1=0
*endif
*if((V2<1e-6) && (V2>-1e-6))
*set var V2=0
*endif
*if((V3<1e-6) && (V3>-1e-6))
*set var V3=0
*endif
*if((V1==1) && (V2==0) && (V3 == 0))
 +X*\
*elseif((V1==-1) && (V2==0) && (V3 == 0))
 -X*\
*elseif((V1==0) && (V2==1) && (V3 == 0))
 +Y*\
*elseif((V1==0) && (V2==-1) && (V3 == 0))
 -Y*\
*elseif((V1==0) && (V2==0) && (V3 == 1))
 +Z*\
*elseif((V1==0) && (V2==0) && (V3 == -1))
 -Z*\
*else
  O*\
*endif
*endfor
 }
*endif
*end elems
*endif 