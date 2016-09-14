*#-----------------------------------------------------------------------------
*#-----------------------Elastic Beam Column Elements---------------------------------
*#-----------------------------------------------------------------------------
*# variable to check Elastic Beam Column existance : 1 for existance, 0 for not
*set var cntEBC=0
*loop elems 
*if(strcmp(ElemsMatProp(Element_type:),"ElasticBeamColumn")==0)
*set var cntEBC=operation(cntEBC+1)
*endif
*end elems
*if(cntEBC!=0)
#
# Elastic beam-column elements
#

*# variable to count the loops
*set var VarCount=1
*#-------------------------------3D-6DOF---------------------------------------
*if(GenData(Dimensions,int)==3 && GenData(DOF,int)==6)
*loop elems 
*if(strcmp(ElemsMatProp(Element_type:),"ElasticBeamColumn")==0)
*if(VarCount==1)
*set var file=2
*set var TransfTag1=1
*set var TransfTag2=2
*#------------------------------------------------
*#------------Geometric Transformation------------
*#------------------------------------------------
# Geometric Transformation
*#-------------------- Z AXIS AS VERTICAL AXIS-------------------------
*if(strcmp(GenData(Vertical_Axis),"Z")==0)
*# Vertical elements
geomTransf *elemsMatProp(Geometric_transformation) *TransfTag1 -1 0 0 
*# Not vertical elements
geomTransf *elemsMatProp(Geometric_transformation) *TransfTag2 0 0 1

*#-------------------- Y AXIS AS VERTICAL AXIS-------------------------
*elseif(strcmp(GenData(Vertical_Axis),"Y")==0)
*# Vertical elements
geomTransf *elemsMatProp(Geometric_transformation) *TransfTag1 -1 0 0
*# Not vertical elements
geomTransf *elemsMatProp(Geometric_transformation) *TransfTag2 0 1 0

*endif
# Elastic Beam Column Definition : 
#element elasticBeamColumn $eleTag $iNode $jNode $A $E $G $J $Iy $Iz $transfTag <-mass $MassPerUnitLength>
*set var GeomTransfPrinted=1
*endif
*#----------- Cross Section Properties ---------------
*if(strcmp(elemsMatProp(Cross_Section),"Rectangular")==0)
*set var height=elemsMatProp(Height_h,real)
*set var width=elemsMatProp(Width_b,real)
*set var A=operation(width*height)
*set var Iz=operation(width*width*width*height/12)
*set var Iy=operation(height*height*height*width/12)
*set var J=operation(Iz+Iy)
*elseif(strcmp(elemsMatProp(Cross_Section),"Tee")==0)
*set var height=elemsMatProp(Height_h,real)
*set var Bf=elemsMatProp(Width_Bf,real)
*set var tf=elemsMatProp(Height_hf,real)
*set var tw=elemsMatProp(Width_Bw,real)
*set var Ycm=operation((Bf*Bf*tf/2+tw*(height-tf)*Bf/2)/(Bf*tf+(height-tf)*tw))
*set var Zcm=operation((Bf*tf*(height-tf/2)+(tw*(height-tf))*(height-tf)/2)/(Bf*tf+(height-tf)*tw))
*set var Iz=operation((1/12*Bf*Bf*Bf*tf+(Bf*tf)*(Bf/2-Ycm)*(Bf/2-Ycm))+(1/12*tw*tw*tw*(height-tf)+(height-tf)*tw*(Bf/2-Ycm)*(Bf/2-Ycm)))
*set var Iy=operation((1/12*tf*tf*tf*Bf+(Bf*tf)*(height-tf/2-Zcm)*(height-tf/2-Zcm))+(1/12*(height-tf)*(height-tf)*(height-tf)*tw+(height-tf)*tw*(height/2-tf/2-Zcm)*(height/2-tf/2-Zcm)))
*set var J=operation(Iz+Iy)
*set var A=operation(Bf*tf+(height-tf)*tw)
*elseif(strcmp(elemsMatProp(Cross_Section),"Circular")==0)
*set var D=elemsMatProp(Diameter_D,real)
*set var A=operation(3.14*D*D/4)
*set var Iz=operation(3.14*D*D*D*D/64)
*set var Iy=operation(3.14*D*D*D*D/64)
*set var J=operation(Iz+Iy)
*elseif(strcmp(ElemsMatProp(Cross_Section),"General")==0)
*set var A=ElemsMatProp(Area_A,real)
*set var J=ElemsMatProp(Polar_moment_of_inertia_J,real)
*set var Iy=ElemsMatProp(Moment_of_Inertia_about_local_y,real)
*set var Iz=ElemsMatProp(Moment_of_Inertia_about_local_z,real)
*endif
*#----------------Material Properties ----------------------
*set var SelMatID=tcl(FindMaterialNumber *elemsMatProp(Material))
*loop materials *NotUsed
*set var matID=tcl(FindMaterialNumber *MatProp(0))
*if(SelMatID==matID)
*set var E=MatProp(Elastic_Modulus_E,real)
*set var Pr=MatProp(Poisson's_ratio,real)
*set var G=operation(E/((1+Pr)*2))
*set var MassDens=MatProp(Mass_density,real)
*break
*endif
*end materials
*set var MassPerLength=operation(A*MassDens)
*#NODESCOORD(1,2) : y coordinate of the 1st node!
*#----------------Z axis as Vertical Axis----------------
*if(strcmp(GenData(Vertical_Axis),"Z")==0)
*# VERTICAL ELEMENTS //Z AXIS
*if(NodesCoord(1,1)==NodesCoord(2,1) && NodesCoord(1,2)==NodesCoord(2,2))
element elasticBeamColumn *ElemsNum *elemsConec *\
*format "%1.4f%1.2f%1.2f%1.4f%1.4f%1.4f"
*A *E *G *J *Iy *Iz *TransfTag1 *\
-mass *\
*format "%1.3f"
*MassPerLength
*else
*# NOT VERTICAL ELEMENTS
element elasticBeamColumn *ElemsNum *elemsConec *\
*format "%1.4f%1.2f%1.2f%1.4f%1.4f%1.4f"
*A *E *G *J *Iy *Iz *TransfTag2 *\
-mass *\
*format "%1.3f"
*MassPerLength
*endif
*#-----------------Y axis as Vertical Axis--------------
*else
*# Vertical elements // Y AXIS
*if(NodesCoord(1,1)==NodesCoord(2,1) && NodesCoord(1,3)==NodesCoord(2,3))
element elasticBeamColumn *ElemsNum *elemsConec *\
*format "%1.4f%1.2f%1.2f%1.4f%1.4f%1.4f"
*A *E *G *J *Iy *Iz *TransfTag1 *\
-mass *\
*format "%1.3f"
*MassPerLength
*# Not Vertical Elements
*else
element elasticBeamColumn *ElemsNum *elemsConec *\
*format "%1.4f%1.2f%1.2f%1.4f%1.4f%1.4f"
*A *E *G *J *Iy *Iz *TransfTag2 *\
-mass *\
*format "%1.3f"
*MassPerLength
*endif
*endif
*set var VarCount=VarCount+1
*endif
*end elems
*#--------------------------------------------------------------------------------------------------------------
*#-----------------------------------    2D     3DOF         ---------------------------------------------------
*#--------------------------------------------------------------------------------------------------------------
*elseif(GenData(Dimensions,int)==2 && GenData(DOF,int)==3)
*loop elems 
*if(strcmp(ElemsMatProp(Element_type:),"ElasticBeamColumn")==0)
*if(VarCount==1)
*set var TransfTag1=1
*set var file=2
*#------------------------------------------------
*#-----------Geometric Transformation-------------
*#------------------------------------------------
# Geometric Transformation

geomTransf *elemsMatProp(Geometric_transformation) *TransfTag1 

*set var GeomTransfPrinted=1
# Elastic Beam Column Definition : 
#element elasticBeamColumn $eleTag $iNode $jNode $A $E $G $J $Iy $Iz $transfTag <-mass $MassPerUnitLength>

*endif
*if(strcmp(elemsMatProp(Cross_Section),"Rectangular")==0)
*set var height=elemsMatProp(Height_h,real)
*set var width=elemsMatProp(Width_b,real)
*set var A=operation(width*height)
*set var Iz=operation(width*height*height*height/12)
*elseif(strcmp(elemsMatProp(Cross_Section),"Tee")==0)
*set var height=elemsMatProp(Height_h,real)
*set var Bf=elemsMatProp(Width_Bf,real)
*set var tf=elemsMatProp(Height_hf,real)
*set var tw=elemsMatProp(Width_Bw,real)
*set var Ycm=operation((Bf*tf*(height-tf/2)+(tw*(height-tf))*(height-tf)/2)/(Bf*tf+(height-tf)*tw))
*set var Iz=operation((1/12*tf*tf*tf*Bf+(Bf*tf)*(height-tf/2-Ycm)*(height-tf/2-Ycm))+(1/12*(height-tf)*(height-tf)*(height-tf)*tw+(height-tf)*tw*(height/2-tf/2-Ycm)*(height/2-tf/2-Ycm)))
*set var A=operation(Bf*tf+(height-tf)*tw)
*elseif(strcmp(elemsMatProp(Cross_Section),"Circular")==0)
*set var D=elemsMatProp(Diameter_D,real)
*set var A=operation(3.14*D*D/4)
*set var Iz=operation(3.14*D*D*D*D/64)
*elseif(strcmp(ElemsMatProp(Cross_Section),"General")==0)
*set var A=ElemsMatProp(Area_A,real)
*set var Iz=ElemsMatProp(Moment_of_Inertia_about_local_z,real)
*endif
*# SelMatID : Id number of the material that user selected from the ElasticBeamColumn Definition 
*set var SelMatID=tcl(FindMaterialNumber *ElemsMatProp(Material))
*loop materials *NotUsed
*set var matID=tcl(FindMaterialNumber *MatProp(0))
*if(SelMatID==matID)
*# WHEN WE FIND THE SELECTED MATERIAL , WE TAKE THE PROPERTIES TO BE PRINTED
*set var E=MatProp(Elastic_Modulus_E,real)
*set var MassDens=MatProp(Mass_density,real)
*break
*endif
*end materials
*set var MassPerLength=operation(A*MassDens)
element elasticBeamColumn *ElemsNum *elemsConec *\
*format "%1.4f%1.2f%1.4f"
*A *E *Iz *TransfTag1 *\
-mass *\
*format "%1.3f"
*MassPerLength
*set var VarCount=VarCount+1
*endif
*end elems
*else
*MessageBox Error: Elastic Beam Column Elements require 2D-3DOF OR 3D-6DOF Model.
*endif
*endif