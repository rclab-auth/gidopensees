*#-----------------------------------------------------------------------------
*#---------------------- Elastic Beam Column Elements -------------------------
*#-----------------------------------------------------------------------------
*set var cntcurrEBC=0
*set Group *GroupName *elems
*# variable to count Elastic Beam Column elements
*loop elems *OnlyInGroup
*if(strcmp(ElemsMatProp(Element_type:),"ElasticBeamColumn")==0)
*set var cntEBC=operation(cntEBC+1)
*set var cntcurrEBC=operation(cntcurrEBC+1)
*endif
*end elems
*if(cntcurrEBC!=0)

# --------------------------------------------------------------------------------------------------------------
# E L A S T I C   B E A M - C O L U M N   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

*# variable to count the loops
*set var VarCount=1
*#-------------------------------3D-6DOF---------------------------------------
*if(ndime==3 && currentDOF==6)
*loop elems *OnlyInGroup
*if(strcmp(ElemsMatProp(Element_type:),"ElasticBeamColumn")==0)
*if(VarCount==1)
*# Linear geomTransf tags
*set var TransfTag1=1
*set var TransfTag2=2
*# PDelta geomTransf tags
*set var TransfTag3=3
*set var TransfTag4=4
*# Corotational geomTransf tags
*set var TransfTag5=5
*set var TransfTag6=6
# Geometric Transformation

*# Z AXIS AS VERTICAL AXIS
*if(strcmp(GenData(Vertical_axis),"Z")==0)
ops.geomTransf('Linear', *TransfTag1, -1, 0, 0) # vertical
ops.geomTransf('Linear', *TransfTag2,  0, 0, 1) # non-vertical
ops.geomTransf('PDelta', *TransfTag3, -1, 0, 0) # vertical
ops.geomTransf('PDelta', *TransfTag4,  0, 0, 1) # non-vertical
ops.geomTransf('Corotational', *TransfTag5, -1, 0, 0) # vertical
ops.geomTransf('Corotational', *TransfTag6,  0, 0, 1) # non-vertical

*# Y AXIS AS VERTICAL AXIS
*elseif(strcmp(GenData(Vertical_axis),"Y")==0)
ops.geomTransf('Linear', *TransfTag1, -1, 0, 0) # vertical
ops.geomTransf('Linear', *TransfTag2,  0, 1, 0) # non-vertical
ops.geomTransf('PDelta', *TransfTag3, -1, 0, 0) # vertical
ops.geomTransf('PDelta', *TransfTag4,  0, 1, 0) # non-vertical
ops.geomTransf('Corotational', *TransfTag5, -1, 0, 0) # vertical
ops.geomTransf('Corotational', *TransfTag6,  0, 1, 0) # non-vertical

*endif
# Elastic Beam Column Definition

# element elasticBeamColumn $eleTag $iNode $jNode $A $E $G $J $Iy $Iz $transfTag <-mass $MassPerUnitLength>

*set var GeomTransfPrinted=1
*endif
*#----------- Cross Section Properties ---------------
*if(strcmp(elemsMatProp(Cross_section),"Rectangular")==0)
*set var height=elemsMatProp(Height_h,real)
*set var width=elemsMatProp(Width_b,real)
*set var A=operation(width*height)
*set var Iz=operation(width*width*width*height/12)
*set var Iy=operation(height*height*height*width/12)
*set var alpha=operation(max(height,width))
*set var beta=operation(min(height,width))
*set var J=operation(1-beta*beta*beta*beta/(12*alpha*alpha*alpha*alpha))
*set var J=operation(1.0/3-0.21*beta/alpha*J)
*set var J=operation(alpha*beta*beta*beta*J)
*elseif(strcmp(elemsMatProp(Cross_section),"Tee")==0)
*set var height=elemsMatProp(Height_h,real)
*set var Bf=elemsMatProp(Width_Bf,real)
*set var tf=elemsMatProp(Height_hf,real)
*set var tw=elemsMatProp(Width_Bw,real)
*set var Ycm=operation((Bf*Bf*tf/2+tw*(height-tf)*Bf/2)/(Bf*tf+(height-tf)*tw))
*set var Zcm=operation((Bf*tf*(height-tf/2)+(tw*(height-tf))*(height-tf)/2)/(Bf*tf+(height-tf)*tw))
*set var Iz=operation((1.0/12*Bf*Bf*Bf*tf+(Bf*tf)*(Bf/2-Ycm)*(Bf/2-Ycm))+(1.0/12*tw*tw*tw*(height-tf)+(height-tf)*tw*(Bf/2-Ycm)*(Bf/2-Ycm)))
*set var temp=operation(height-tf)
*set var Iy=operation(pow(temp,3)*tw/12+pow(tf,3)*Bf/12+(tf*Bf)*(height-(tf/2)-Zcm)*(height-(tf/2)-Zcm)+(temp*tw)*((temp/2)-Zcm)*((temp/2)-Zcm))
*set var J=operation(Iy+Iz)
*set var A=operation(Bf*tf+(height-tf)*tw)
*elseif(strcmp(elemsMatProp(Cross_section),"Circular")==0)
*set var D=elemsMatProp(Diameter_D,real)
*set var A=operation(3.14159*D*D/4)
*set var Iz=operation(3.14159*D*D*D*D/64)
*set var Iy=operation(3.14159*D*D*D*D/64)
*set var J=operation(Iz+Iy)
*elseif(strcmp(ElemsMatProp(Cross_section),"General")==0)
*set var A=ElemsMatProp(Area_A,real)
*set var Iy=ElemsMatProp(Moment_of_inertia_about_local-y_Iyy,real)
*set var Iz=ElemsMatProp(Moment_of_inertia_about_local-z_Izz,real)
*set var J=ElemsMatProp(Torsional_moment_of_inertia_Iyz,real)
*endif
*#----------------Material Properties ----------------------
*set var SelMatID=tcl(FindMaterialNumber *elemsMatProp(Material) *DomainNum)
*loop materials *NotUsed
*set var matID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelMatID==matID)
*set var E=MatProp(Elastic_modulus_E,real)
*set var Pr=MatProp(Poisson's_ratio,real)
*set var G=operation(E/((1+Pr)*2))
*set var MassDens=MatProp(Mass_density,real)
*break
*endif
*end materials
*set var MassPerLength=operation(A*MassDens)
*# Cross Section Properties Modification Factors
*if(ElemsMatProp(Set_modification_factors,int)==1)
*set var Amod=ElemsMatProp(mod._A,real)
*set var Izmod=ElemsMatProp(mod._Izz,real)
*set var Iymod=ElemsMatProp(mod._Iyy,real)
*set var Jmod=ElemsMatProp(mod._Iyz,real)
*set var A=operation(A*Amod)
*set var Iz=operation(Iz*Izmod)
*set var Iy=operation(Iy*Iymod)
*set var J=operation(J*Jmod)
*endif
*#NodesCoord(1,2) : y coordinate of the 1st node!
*#----------------Z axis as Vertical Axis----------------
*if(strcmp(GenData(Vertical_axis),"Z")==0)
*# VERTICAL ELEMENTS //Z AXIS
*if(fabs(NodesCoord(1,1)-NodesCoord(2,1)) < 1e-6 && fabs(NodesCoord(1,2)-NodesCoord(2,2)) < 1e-6)
*if(strcmp(ElemsMatProp(Geometric_transformation),"Linear")==0)
*set var TransfTag=TransfTag1
*elseif(strcmp(ElemsMatProp(Geometric_transformation),"P-Delta")==0)
*set var TransfTag=TransfTag3
*else
*set var TransfTag=TransfTag5
*endif
element_list_str = "*elemsConec"
*format "%6d%6d%7d"
ops.element('elasticBeamColumn', *ElemsNum, *elemsConec , *\
*format "%10g%10g%10g%12g%12g%12g   "
*A, *E, *G, *J, *Iy, *Iz, *TransfTag, '-mass', *\
*format "%8g"
*MassPerLength) # *ElemsMatProp(Material)
*else
*# NOT VERTICAL ELEMENTS
*if(strcmp(ElemsMatProp(Geometric_transformation),"Linear")==0)
*set var TransfTag=TransfTag2
*elseif(strcmp(ElemsMatProp(Geometric_transformation),"P-Delta")==0)
*set var TransfTag=TransfTag4
*else
*set var TransfTag=TransfTag6
*endif
element_list_str = "*elemsConec"
*format "%6d%6d%d"
ops.element('elasticBeamColumn', *ElemsNum, *elemsConec, *\
*format "%10g%10g%10g%12g%12g%12g   "
*A, *E, *G, *J, *Iy, *Iz, *TransfTag, '-mass', *\
*format "%8g"
*MassPerLength)  # *ElemsMatProp(Material)
*endif
*#-----------------Y axis as Vertical Axis--------------
*else
*# Vertical elements // Y AXIS
*if(fabs(NodesCoord(1,1)-NodesCoord(2,1)) < 1e-6 && fabs(NodesCoord(1,3)-NodesCoord(2,3)) < 1e-6)
*if(strcmp(ElemsMatProp(Geometric_transformation),"Linear")==0)
*set var TransfTag=TransfTag1
*elseif(strcmp(ElemsMatProp(Geometric_transformation),"P-Delta")==0)
*set var TransfTag=TransfTag3
*else
*set var TransfTag=TransfTag5
*endif
element_list_str = "*elemsConec"
*format "%6d%6d%7d"
ops.element('elasticBeamColumn', *ElemsNum, *elemsConec, *\
*format "%10g%10g%10g%12g%12g%12g   "
*A, *E, *G, *J, *Iy, *Iz, *TransfTag, '-mass' *\
*format "%8g"
*MassPerLength) ; # *ElemsMatProp(Material)
*# Not Vertical Elements
*else
*if(strcmp(ElemsMatProp(Geometric_transformation),"Linear")==0)
*set var TransfTag=TransfTag2
*elseif(strcmp(ElemsMatProp(Geometric_transformation),"P-Delta")==0)
*set var TransfTag=TransfTag4
*else
*set var TransfTag=TransfTag6
*endif
element_list_str = "*elemsConec"
*format "%6d%6d%7d"
ops.element('elasticBeamColumn', *ElemsNum, *elemsConec, *\
*format "%10g%10g%10g%12g%12g%12g   "
*A, *E, *G, *J, *Iy, *Iz, *TransfTag, '-mass', *\
*format "%8g"
*MassPerLength)  # *ElemsMatProp(Material)
*endif
*endif
*set var VarCount=VarCount+1
*endif
*end elems
*#--------------------------------------------------------------------------------------------------------------
*#-----------------------------------    2D     3DOF         ---------------------------------------------------
*#--------------------------------------------------------------------------------------------------------------
*elseif(ndime==2 && currentDOF)
*loop elems *OnlyInGroup
*if(strcmp(ElemsMatProp(Element_type:),"ElasticBeamColumn")==0)
*if(VarCount==1)
*set var TransfTag1=1
*set var TransfTag2=2
*set var TransfTag3=3
*#------------------------------------------------
*#-----------Geometric Transformation-------------
*#------------------------------------------------
# Geometric Transformation

ops.geomTransf('Linear', *TransfTag1)
ops.geomTransf('PDelta', *TransfTag2)
ops.geomTransf('Corotational', *TransfTag3)

*set var GeomTransfPrinted=1
# Elastic Beam Column Definition

# element elasticBeamColumn $eleTag $iNode $jNode $A $E $Iz $transfTag <-mass $MassPerUnitLength>

*endif
*if(strcmp(elemsMatProp(Cross_section),"Rectangular")==0)
*set var height=elemsMatProp(Height_h,real)
*set var width=elemsMatProp(Width_b,real)
*set var A=operation(width*height)
*set var Iz=operation(width*height*height*height/12)
*elseif(strcmp(elemsMatProp(Cross_section),"Tee")==0)
*set var height=elemsMatProp(Height_h,real)
*set var Bf=elemsMatProp(Width_Bf,real)
*set var tf=elemsMatProp(Height_hf,real)
*set var tw=elemsMatProp(Width_Bw,real)
*set var Ycm=operation((Bf*tf*(height-tf/2)+(tw*(height-tf))*(height-tf)/2)/(Bf*tf+(height-tf)*tw))
*set var temp=operation(height-tf)
*set var Iz=operation(pow(temp,3)*tw/12+pow(tf,3)*Bf/12+(tf*Bf)*(height-(tf/2)-Ycm)*(height-(tf/2)-Ycm)+(temp*tw)*((temp/2)-Ycm)*((temp/2)-Ycm))
*set var A=operation(Bf*tf+(height-tf)*tw)
*elseif(strcmp(elemsMatProp(Cross_section),"Circular")==0)
*set var D=elemsMatProp(Diameter_D,real)
*set var A=operation(3.14*D*D/4)
*set var Iz=operation(3.14*D*D*D*D/64)
*elseif(strcmp(ElemsMatProp(Cross_section),"General")==0)
*set var A=ElemsMatProp(Area_A,real)
*set var Iz=ElemsMatProp(Moment_of_inertia_about_local-z_Izz,real)
*endif
*# SelMatID : Id number of the material that user selected from the ElasticBeamColumn Definition
*set var SelMatID=tcl(FindMaterialNumber *ElemsMatProp(Material) *DomainNum)
*loop materials *NotUsed
*set var matID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelMatID==matID)
*# WHEN WE FIND THE SELECTED MATERIAL , WE TAKE THE PROPERTIES TO BE PRINTED
*set var E=MatProp(Elastic_modulus_E,real)
*set var MassDens=MatProp(Mass_density,real)
*break
*endif
*end materials
*set var MassPerLength=operation(A*MassDens)
*if(strcmp(ElemsMatProp(Geometric_transformation),"Linear")==0)
*set var TransfTag=TransfTag1
*elseif(strcmp(ElemsMatProp(Geometric_transformation),"P-Delta")==0)
*set var TransfTag=TransfTag2
*else
*set var TransfTag=TransfTag3
*endif
*# Cross Section Properties Modification Factors
*if(ElemsMatProp(Set_modification_factors,int)==1)
*set var Amod=ElemsMatProp(mod._A,real)
*set var Izmod=ElemsMatProp(mod._Izz,real)
*set var A=operation(A*Amod)
*set var Iz=operation(Iz*Izmod)
*endif
*format "%6d%6d%d%d"
ops.element('elasticBeamColumn', *ElemsNum, *elemsConec(1), *elemsConec(2), *\
*format "%10g%10g%10g   "
*A, *E, *Iz, *TransfTag, '-mass', *\
*format "%8g"
*MassPerLength) # *ElemsMatProp(Material)
*set var VarCount=VarCount+1
*endif
*end elems
*endif
*endif