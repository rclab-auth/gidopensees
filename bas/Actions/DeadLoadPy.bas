*#
*# Frame elements
*#
*if(cntEBC!=0 || cntETB!=0 || cntFBC!=0 || cntDBC!=0 ||cntDBCI!=0 )
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ElasticBeamColumn")==0 || strcmp(ElemsMatProp(Element_type:),"ElasticTimoshenkoBeamColumn")==0 || strcmp(ElemsMatProp(Element_type:),"forceBeamColumn")==0 || strcmp(ElemsMatProp(Element_type:),"dispBeamColumn")==0 || strcmp(ElemsMatProp(Element_type:),"dispBeamColumnInt")==0)
*if(strcmp(ElemsMatProp(Element_type:),"ElasticBeamColumn")==0 || strcmp(ElemsMatProp(Element_type:),"ElasticTimoshenkoBeamColumn")==0)
*# Calculate Area
*if(strcmp(elemsMatProp(Cross_section),"Rectangular")==0)
*set var height=elemsMatProp(Height_h,real)
*set var width=elemsMatProp(Width_b,real)
*set var A=operation(width*height)
*elseif(strcmp(elemsMatProp(Cross_section),"Tee")==0)
*set var height=elemsMatProp(Height_h,real)
*set var Bf=elemsMatProp(Width_Bf,real)
*set var tf=elemsMatProp(Height_hf,real)
*set var tw=elemsMatProp(Width_Bw,real)
*set var A=operation(Bf*tf+(height-tf)*tw)
*elseif(strcmp(elemsMatProp(Cross_section),"Circular")==0)
*set var D=elemsMatProp(Diameter_D,real)
*set var A=operation(3.1415*D*D/4)
*elseif(strcmp(ElemsMatProp(Cross_section),"General")==0)
*set var A=ElemsMatProp(Area_A,real)
*endif
*elseif(strcmp(ElemsMatProp(Element_type:),"forceBeamColumn")==0 || strcmp(ElemsMatProp(Element_type:),"dispBeamColumn")==0)
*set var SelectedSection=tcl(FindMaterialNumber *ElemsMatProp(Section) *DomainNum)
*loop materials *NotUsed
*set var SectionID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelectedSection==SectionID)
*if(strcmp(MatProp(Section:),"Fiber")==0)
*set var A=MatProp(Cross_section_area,real)
*break
*elseif(strcmp(MatProp(Section:),"ElasticSection")==0)
*set var A=MatProp(ElasticSection_Area,real)
*elseif(strcmp(MatProp(Section:),"FiberCustom")==0)
*set var A=MatProp(Cross_section_area,real)
*elseif(strcmp(MatProp(Section:),"SectionAggregator")==0)
*if(MatProp(Select_section,int)==1)
*set var SelectedSectionTobeAggregated=tcl(FindMaterialNumber *MatProp(Section_to_be_aggregated) *DomainNum)
*loop materials *NotUsed
*set var SectionTobeAggregated=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelectedSectionTobeAggregated==SectionTobeAggregated)
*if(strcmp(MatProp(Section:),"Fiber")==0)
*set var A=MatProp(Cross_section_area,real)
*break
*elseif(strcmp(MatProp(Section:),"ElasticSection")==0)
*set var A=MatProp(ElasticSection_Area,real)
*break
*elseif(strcmp(MatProp(Section:),"FiberCustom")==0)
*set var A=MatProp(Cross_section_area,real)
*break
*else
*MessageBox Invalid Section was selected for Section Aggregator. Only Fiber is supported.
*endif
*endif
*end materials
*# not a cross section is selected to calculate the Area. So area is assumed zero. Dead loads may be given as external loads.
*else
*set var A=0.0
*endif
*endif
*endif
*end materials
*elseif(strcmp(ElemsMatProp(Element_type:),"dispBeamColumnInt")==0)
*set var SelectedSection=tcl(FindMaterialNumber *ElemsMatProp(Section) *DomainNum)
*loop materials *NotUsed
*set var SectionID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelectedSection==SectionID)
*if(strcmp(MatProp(Section:),"FiberInt")==0)
*set var t1=MatProp(Thickness,real)
*set var t2=MatProp(_Thickness,real)
*set var t3=MatProp(__Thickness,real)
*set var d1=MatProp(Width,real)
*set var d2=MatProp(_Width,real)
*set var d3=MatProp(__Width,real)
*set var c1=MatProp(Cover,real)
*set var c3=MatProp(_Cover,real)
*set var Area1=operation(t1*d1)
*set var Area2=operation(t2*d2)
*set var Area3=operation(t3*d3)
*set var A=operation(Area1+Area2+Area3)
*break
*else
*set var A=0.0
*endif
*endif
*end materials
*endif
*#
*set var WeightDensity=ElemsMatProp(Weight_density,real)
*set var DeadLoad=operation(WeightDensity*A)
*if((DeadLoad<1e-6) && (DeadLoad>-1e-6))
*set var DeadLoad=0
*endif
*if(DeadLoad != 0)
*# end coordinates
*set var x1=NodesCoord(1,1)
*set var y1=NodesCoord(1,2)
*set var z1=NodesCoord(1,3)
*set var x2=NodesCoord(2,1)
*set var y2=NodesCoord(2,2)
*set var z2=NodesCoord(2,3)
*# Vertical axis = Y
*if(strcmp(GenData(Vertical_axis),"Y")==0)
*# 3D analysis
*if(ndime==3)
*# vertical elems
*if(fabs(NodesCoord(1,1)-NodesCoord(2,1)) < 1e-6 && fabs(NodesCoord(1,3)-NodesCoord(2,3)) < 1e-6)
*if(y2>y1)
*format "%6d%8g"
    ops.eleLoad("-ele", *ElemsNum, "-type", "-beamUniform", 0, 0, *operation(-DeadLoad))
*else
*format "%6d%8g"
    ops.eleLoad("-ele", *ElemsNum, "-type", "-beamUniform", 0, 0 *DeadLoad)
*endif
*# not vertical elems
*else
*set var num=operation(fabs(y2-y1))
*set var denum=operation(sqrt((x2-x1)*(x2-x1)+(z2-z1)*(z2-z1)))
*set var theta=operation(atan(num/denum))
*set var stheta=operation(sin(theta))
*set var ctheta=operation(cos(theta))
*if((stheta<1e-6) && (stheta>-1e-6))
*set var stheta=0
*endif
*if((ctheta<1e-6) && (ctheta>-1e-6))
*set var ctheta=0
*endif
*if(y2>=y1)
*format "%6d%8g%8g"
    ops.eleLoad("-ele", *ElemsNum, "-type" ,"-beamUniform", 0, *operation(-DeadLoad*ctheta), *operation(-DeadLoad*stheta))
*else
*format "%6d%8g%8g"
    ops.eleLoad("-ele", *ElemsNum ,"-type" ,"-beamUniform", 0 ,*operation(-DeadLoad*ctheta), *operation(DeadLoad*stheta))
*endif
*endif
*# 2D analysis
*else
*# vertical elems
*if(fabs(NodesCoord(1,1)-NodesCoord(2,1)) < 1e-6 && fabs(NodesCoord(1,3)-NodesCoord(2,3)) < 1e-6)
*if(y2>y1)
*format "%6d%8g"
    ops.eleLoad("-ele", *ElemsNum, "-type", "-beamUniform", 0, *operation(-DeadLoad))
*else
*format "%6d%8g"
    ops.eleLoad("-ele", *ElemsNum, "-type", "-beamUniform", 0 ,*DeadLoad)
*endif
*# not vertical elems
*else
*set var num=operation(fabs(y2-y1))
*set var denum=operation(sqrt((x2-x1)*(x2-x1)+(z2-z1)*(z2-z1)))
*set var theta=operation(atan(num/denum))
*set var stheta=operation(sin(theta))
*set var ctheta=operation(cos(theta))
*if((stheta<1e-6) && (stheta>-1e-6))
*set var stheta=0
*endif
*if((ctheta<1e-6) && (ctheta>-1e-6))
*set var ctheta=0
*endif
*if(y2>=y1)
*if(x2>x1)
*format "%6d%8g%8g"
    eleLoad -ele *ElemsNum -type -beamUniform *operation(-DeadLoad*ctheta) *operation(-DeadLoad*stheta)
*else
*format "%6d%8g%8g"
    eleLoad -ele *ElemsNum -type -beamUniform *operation(DeadLoad*ctheta) *operation(-DeadLoad*stheta)
*endif
*else
*if(x2<x1)
*format "%6d%8g%8g"
    eleLoad -ele *ElemsNum -type -beamUniform *operation(DeadLoad*ctheta) *operation(DeadLoad*stheta)
*else
*format "%6d%8g%8g"
    eleLoad -ele *ElemsNum -type -beamUniform *operation(-DeadLoad*ctheta) *operation(DeadLoad*stheta)
*endif
*endif
*endif
*endif
*# Vertical axis = Z
*else
*# vertical elems
*if(fabs(NodesCoord(1,1)-NodesCoord(2,1)) < 1e-6 && fabs(NodesCoord(1,2)-NodesCoord(2,2)) < 1e-6)
*if(z2>z1)
*format "%6d%8g"
    eleLoad -ele *ElemsNum -type -beamUniform        0        0 *operation(-DeadLoad)
*else
*format "%6d%8g"
    eleLoad -ele *ElemsNum -type -beamUniform        0        0 *DeadLoad
*endif
*# not vertical elems
*else
*set var num=operation(fabs(z2-z1))
*set var denum=operation(sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1)))
*set var theta=operation(atan(num/denum))
*set var stheta=operation(sin(theta))
*set var ctheta=operation(cos(theta))
*if((stheta<1e-6) && (stheta>-1e-6))
*set var stheta=0
*endif
*if((ctheta<1e-6) && (ctheta>-1e-6))
*set var ctheta=0
*endif
*if(z2>=z1)
*format "%6d%8g%8g"
    eleLoad -ele *ElemsNum -type -beamUniform        0 *operation(-DeadLoad*ctheta) *operation(-DeadLoad*stheta)
*else
*format "%6d%8g%8g"
    eleLoad -ele *ElemsNum -type -beamUniform        0 *operation(-DeadLoad*ctheta) *operation(DeadLoad*stheta)
*endif
*endif
*endif
*endif
*endif
*end elems
*endif
*#
*# Truss elements
*#
*if(cntTruss!=0 || cntCorotTruss!=0)
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Truss")==0 || strcmp(ElemsMatProp(Element_type:),"CorotationalTruss")==0)
*if(strcmp(elemsMatProp(Cross_section),"Rectangular")==0)
*set var height=ElemsMatProp(Height_H,real)
*set var width=ElemsMatProp(Width_B,real)
*set var A=operation(height*width)
*elseif(strcmp(elemsMatProp(Cross_section),"Tee")==0)
*set var height=elemsMatProp(Height_H,real)
*set var Bf=elemsMatProp(Width_Bf,real)
*set var tf=elemsMatProp(Height_Hf,real)
*set var tw=elemsMatProp(Width_Bw,real)
*set var A=operation(Bf*tf+(height-tf)*tw)
*elseif(strcmp(elemsMatProp(Cross_section),"Circular")==0)
*set var D=elemsMatProp(Diameter_D,real)
*set var A=operation(3.14*D*D/4)
*elseif(strcmp(elemsMatProp(Cross_section),"General")==0)
*set var A=ElemsMatProp(Area_A,real)
*endif
*# end coordinates
*set var x1=NodesCoord(1,1)
*set var y1=NodesCoord(1,2)
*set var z1=NodesCoord(1,3)
*set var x2=NodesCoord(2,1)
*set var y2=NodesCoord(2,2)
*set var z2=NodesCoord(2,3)
*set var WeightDensity=ElemsMatProp(Weight_density,real)
*set var Length=operation(fabs(sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1)+(z2-z1)*(z2-z1))))
*set var DeadLoad=operation(WeightDensity*A*Length/2)
*if((DeadLoad<1e-6) && (DeadLoad>-1e-6))
*set var DeadLoad=0
*endif
*if(ndime==3)
*if(strcmp(GenData(Vertical_axis),"Y")==0)
*format "%6d%8g"
  load *ElemsConec(1) 0.0 *operation(-DeadLoad) 0.0
*format "%6d%8g"
  load *ElemsConec(2) 0.0 *operation(-DeadLoad) 0.0
*else
*format "%6d%8g"
  load *ElemsConec(1) 0.0 0.0 *operation(-DeadLoad)
*format "%6d%8g"
  load *ElemsConec(2) 0.0 0.0 *operation(-DeadLoad)
*endif
*else
*format "%6d%8g"
  load *ElemsConec(1) 0.0 *operation(-DeadLoad)
*format "%6d%8g"
  load *ElemsConec(2) 0.0 *operation(-DeadLoad)
*endif
*endif
*end elems
*endif
*#
*# ShellDKGQ and ShellMITC4 elements
*#
*if(cntShellDKGQ!=0 || cntShell!=0)
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"ShellDKGQ")==0 || strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*set var SelectedSection=tcl(FindMaterialNumber *ElemsMatProp(Type) *DomainNum)
*loop materials *NotUsed
*set var SectionID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelectedSection==SectionID)
*set var dummy=tcl(AddUsedMaterials *SelectedSection)
*if(strcmp(MatProp(Section:),"PlateFiber")==0)
*set var thickness=MatProp(Plate_thickness_h,real)
*elseif(strcmp(MatProp(Section:),"ElasticMembranePlate")==0)
*set var thickness=MatProp(Section_depth_h,real)
*elseif(strcmp(MatProp(Section:),"LayeredShell")==0)
*set var thickness=MatProp(Wall_width,real)
*elseif(strcmp(MatProp(Section:),"UserMaterial")==0)
*set var thickness=MatProp(Width,real)
*else
*MessageBox Error: Invalid Section selected for Shell/ShellDKGQ element
*endif
*break
*endif
*end materials
*# end coordinates
*set var x1=NodesCoord(1,1)
*set var y1=NodesCoord(1,2)
*set var z1=NodesCoord(1,3)
*set var x2=NodesCoord(2,1)
*set var y2=NodesCoord(2,2)
*set var z2=NodesCoord(2,3)
*set var x3=NodesCoord(3,1)
*set var y3=NodesCoord(3,2)
*set var z3=NodesCoord(3,3)
*set var x4=NodesCoord(4,1)
*set var y4=NodesCoord(4,2)
*set var z4=NodesCoord(4,3)
*set var vecx1=operation(x2-x1)
*set var vecx2=operation(x3-x2)
*set var vecy1=operation(y2-y1)
*set var vecy2=operation(y3-y2)
*set var vecz1=operation(z2-z1)
*set var vecz2=operation(z3-z2)
*set var vecx3=operation(x4-x1)
*set var vecx4=operation(x4-x3)
*set var vecy3=operation(y4-y1)
*set var vecy4=operation(y4-y3)
*set var vecz3=operation(z4-z1)
*set var vecz4=operation(z4-z3)
*set var dotproduct1=operation(vecx1*vecx2+vecy1*vecy2+vecz1*vecz2)
*set var dotproduct2=operation(vecx3*vecx4+vecy3*vecy4+vecz3*vecz4)
*set var magn1=operation(sqrt(vecx1*vecx1+vecy1*vecy1+vecz1*vecz1))
*set var magn2=operation(sqrt(vecx2*vecx2+vecy2*vecy2+vecz2*vecz2))
*set var magn3=operation(sqrt(vecx3*vecx3+vecy3*vecy3+vecz3*vecz3))
*set var magn4=operation(sqrt(vecx4*vecx4+vecy4*vecy4+vecz4*vecz4))
*set var theta1=operation(acos(dotproduct1/(magn1*magn2)))
*set var theta2=operation(acos(dotproduct2/(magn3*magn4)))
*set var A=operation((magn1*magn2*sin(theta1))/2+(magn3*magn4*sin(theta2))/2)
*set var WeightDensity=ElemsMatProp(Weight_density,real)
*set var DeadLoad=operation(WeightDensity*A*thickness/4)
*if((DeadLoad<1e-6) && (DeadLoad>-1e-6))
*set var DeadLoad=0
*endif
*if(ndime==3)
*if(strcmp(GenData(Vertical_axis),"Y")==0)
*format "%6d%8.4g"
    ops.load(*ElemsConec(1), 0.0, *operation(-DeadLoad), 0.0, 0.0, 0.0, 0.0)
*format "%6d%8.4g"
    ops.load(*ElemsConec(2), 0.0, *operation(-DeadLoad), 0.0, 0.0, 0.0, 0.0)
*format "%6d%8.4g"
    ops.load(*ElemsConec(3), 0.0, *operation(-DeadLoad), 0.0, 0.0, 0.0, 0.0)
*format "%6d%8.4g"
    ops.load(*ElemsConec(4), 0.0, *operation(-DeadLoad), 0.0, 0.0, 0.0, 0.0)
*else
*format "%6d%8.4g"
    ops.load(*ElemsConec(1), 0.0, 0.0, *operation(-DeadLoad), 0.0, 0.0, 0.0)
*format "%6d%8.4g"
    ops.load(*ElemsConec(2), 0.0, 0.0, *operation(-DeadLoad), 0.0, 0.0, 0.0)
*format "%6d%8.4g"
    ops.load(*ElemsConec(3), 0.0, 0.0, *operation(-DeadLoad), 0.0, 0.0, 0.0)
*format "%6d%8.4g"
    ops.load(*ElemsConec(4), 0.0, 0.0, *operation(-DeadLoad), 0.0, 0.0, 0.0)
*endif
*endif
*endif
*end elems
*endif 