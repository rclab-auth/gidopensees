*#----------------------------------------------------------------------------------------
*#-----------------------Force-Based Beam Column Elements---------------------------------
*#----------------------------------------------------------------------------------------
*# variable to count Elastic Beam Column elements
*set var cntFBC=0
*loop elems 
*if(strcmp(ElemsMatProp(Element_type:),"forceBeamColumn")==0)
*set var cntFBC=operation(cntFBC+1)
*endif
*end elems
*if(cntFBC!=0)

# --------------------------------------------------------------------------------------------------------------
# F O R C E - B A S E D   B E A M - C O L U M N   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

*# variable to count the loops
*set var VarCount=1
*#-------------------------------3D-6DOF-----------------------------------------
*if(GenData(Dimensions,int)==3 && GenData(DOF,int)==6)
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"forceBeamColumn")==0)
*if(VarCount==1)
*if(GeomTransfPrinted==0)
*set var file=2
*# Linear geomTransf tags 
*set var TransfTag1=1
*set var TransfTag2=2
*# PDelta geomTransf tags
*set var TransfTag3=3
*set var TransfTag4=4
*#------------------------------------------------
*#-----------Geometric Transformation-------------
*#------------------------------------------------
# Geometric Transformation

*#-------------------- Z AXIS AS VERTICAL AXIS-------------------------
*if(strcmp(GenData(Vertical_Axis),"Z")==0)
*# Vertical elements
*# Vertical elements
geomTransf Linear *TransfTag1 -1 0 0 
geomTransf PDelta *TransfTag3 -1 0 0 
*# Not vertical elements
geomTransf Linear *TransfTag2  0 0 1
geomTransf PDelta *TransfTag4  0 0 1

*#-------------------- Y AXIS AS VERTICAL AXIS-------------------------
*elseif(strcmp(GenData(Vertical_Axis),"Y")==0)
*# Vertical elements
geomTransf Linear *TransfTag1 -1 0 0
geomTransf PDelta *TransfTag3 -1 0 0
*# Not vertical elements
geomTransf Linear *TransfTag2  0 1 0
geomTransf PDelta *TransfTag4  0 1 0

*endif
*set var GeomTransfPrinted=1
*endif
# Sections Definition for forceBeamColumn Elements

*# Searching all assigned forceBeamColumn elements to check all Sections that they need 
*loop materials
*if(strcmp(MatProp(Element_type:),"forceBeamColumn")==0)
*set var SelectedSection=tcl(FindMaterialNumber *MatProp(Section) )
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedSection)
*# IF IT HAS NOT BEEN DEFINED YET
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var SecNum=tcl(FindMaterialNumber *MatProp(0) )
*# if the Section is FOUND
*if(SelectedSection==SecNum)
*# Add it to the used "Materials"
*set var dummy=tcl(AddUsedMaterials *SelectedSection)
*if(strcmp(MatProp(Section:),"Fiber")==0)
*# if it is a Fiber Section, We need to check which uniaxial materials we need to define
*set var SelectedCoreMaterial=tcl(FindMaterialNumber *MatProp(Core_material) )
*set var SelectedCoverMaterial=tcl(FindMaterialNumber *MatProp(Cover_material) )
*set var SelectedRBMaterial=tcl(FindMaterialNumber *MatProp(Reinforcing_Bar_material) )
*# CORE MATERIAL DEFINITION
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedCoreMaterial )
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MatNumber=tcl(FindMaterialNumber *Matprop(0))
*if(SelectedCoreMaterial==MatNumber)
*if(strcmp(MatProp(Material:),"Concrete01")==0)
*format "%d%g%g%g%g"
uniaxialMaterial Concrete01 *SelectedCoreMaterial *MatProp(Compressive_strength_fpc,real) *MatProp(Strain_at_maximum_strength_epsc0,real) *MatProp(Crushing_strength_fpcu,real) *MatProp(Strain_at_crushing_strength_epscU,real)
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*format "%d%g%g%g%g%g%g"
uniaxialMaterial Concrete02 *SelectedCoreMaterial *MatProp(Compressive_strength_fpc,real) *MatProp(Strain_at_maximum_strength_epsc0,real) *MatProp(Crushing_strength_fpcu,real) *MatProp(Strain_at_crushing_strength_epscU,real) *MatProp(ratio_between_unloading_slope_at_epscU_and_initial_slope_lamdba,real) *MatProp(Tensile_strength_Ft,real) *MatProp(Tension_softening_stiffness_Ets,real)
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*format "%d%g%g%g%g%g%g%g%g"
uniaxialMaterial Concrete06 *SelectedCoreMaterial *MatProp(Concrete_compressive_strength_fc,real) *MatProp(Strain_at_compressive_strength_e0,real) *MatProp(Compressive_shape_factor_n,real) *MatProp(Post-peak_compressive_shape_factor_k,real) *MatProp(Parameter_a1_for_compressive_plastic_strain_definition,real) *MatProp(Tensile_strength_fcr,real) *MatProp(Tensile_strain_at_peak_stress_ecr,real) *MatProp(Exponent_of_the_tension_stiffering_curve_b,real) *MatProp(Parameter_a2_for_tensile_plastic_strain_definition,real)
*else
*MessageBox *MatProp(0) is not ready for forceBeamColumn elements
*endif
*set var dummy=tcl(AddUsedMaterials *SelectedCoreMaterial)
*break
*endif
*end materials
*endif
*# Cover Material DEFINITION
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedCoverMaterial)
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MatNumber=tcl(FindMaterialNumber *Matprop(0) )
*if(SelectedCoverMaterial==MatNumber)
*if(strcmp(MatProp(Material:),"Concrete01")==0)
*format "%d%g%g%g%g"
uniaxialMaterial Concrete01 *SelectedCoverMaterial *MatProp(Compressive_strength_fpc,real) *MatProp(Strain_at_maximum_strength_epsc0,real) *MatProp(Crushing_strength_fpcu,real) *MatProp(Strain_at_crushing_strength_epscU,real)
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*format "%d%g%g%g%g%g%g"
uniaxialMaterial Concrete02 *SelectedCoverMaterial *MatProp(Compressive_strength_fpc,real) *MatProp(Strain_at_maximum_strength_epsc0,real) *MatProp(Crushing_strength_fpcu,real) *MatProp(Strain_at_crushing_strength_epscU,real) *MatProp(ratio_between_unloading_slope_at_epscU_and_initial_slope_lamdba,real) *MatProp(Tensile_strength_Ft,real) *MatProp(Tension_softening_stiffness_Ets,real)
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*format "%d%g%g%g%g%g%g%g%g"
uniaxialMaterial Concrete06 *SelectedCoverMaterial *MatProp(Concrete_compressive_strength_fc,real) *MatProp(Strain_at_compressive_strength_e0,real) *MatProp(Compressive_shape_factor_n,real) *MatProp(Post-peak_compressive_shape_factor_k,real) *MatProp(Parameter_a1_for_compressive_plastic_strain_definition,real) *MatProp(Tensile_strength_fcr,real) *MatProp(Tensile_strain_at_peak_stress_ecr,real) *MatProp(Exponent_of_the_tension_stiffering_curve_b,real) *MatProp(Parameter_a2_for_tensile_plastic_strain_definition,real)
*else
*MessageBox *MatProp(0) is not ready for forceBeamColumn elements
*endif
*set var dummy=tcl(AddUsedMaterials *SelectedCoverMaterial)
*break
*endif
*end materials
*endif
*# Reinforcing Bar MATERIAL DEFINITION
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedRBMaterial)
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MatNumber=tcl(FindMaterialNumber *Matprop(0) )
*if(SelectedRBMaterial==MatNumber)
*if(strcmp(MatProp(Material:),"Steel01")==0)
*format "%d%g%g%g"
uniaxialMaterial Steel01 *SelectedRBMaterial *MatProp(Yield_Stress_Fy,real) *MatProp(Initial_elastic_tangent_E0,real) *MatProp(Strain-hardening_ratio_b,real)
*else
*MessageBox *MatProp(0) is not ready for forceBeamColumn elements
*endif
*set var dummy=tcl(AddUsedMaterials *SelectedRBMaterial)
*break
*endif
*end materials
*# endif material has been already defined
*endif
*# ------------------------FIBER definition--------------------
*# ----------Rectangular Section-------------
*if(strcmp(Matprop(Cross_Section),"Rectangular")==0)
*set var height=Matprop(Height_h,real)
*set var width=MatProp(Width_b,real)
*set var zhalf=operation(height/2.0)
*set var yhalf=operation(width/2.0)
*set var cover=MatProp(Cover_depth_for_bars,real)

section Fiber *SelectedSection {
*set var zdivision=MatProp(Fibers_in_local_z_direction,int)
*set var ydivision=MatProp(Fibers_in_local_y_direction,int)
*if(strcmp(GenData(Vertical_Axis),"Z")==0)
*set var ycoverFibers=tcl(NumofCoverFibers *cover *width *ydivision)
*set var zcoverFibers=tcl(NumofCoverFibers *cover *height *zdivision)
*elseif(strcmp(GenData(Vertical_Axis),"Y")==0)
*set var ycoverFibers=tcl(NumofCoverFibers *cover *height *ydivision)
*set var zcoverFibers=tcl(NumofCoverFibers *cover *width *zdivision)
*endif
*# --------------Core fibers definition-----------

# Create the Core fibers

*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoreMaterial *operation(ydivision-2*ycoverFibers) *operation(zdivision-2*zcoverFibers) *operation(cover-yhalf) *operation(cover-zhalf) *operation(yhalf-cover) *operation(zhalf-cover) 
*# --------------Cover fibers definition----------

# Create the Cover fibers

*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *ycoverFibers *operation(zdivision-2*zcoverFibers) *operation(yhalf-cover) *operation(-zhalf) *yhalf *zhalf
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *ycoverFibers *operation(zdivision-2*zcoverFibers) *operation(-yhalf) *operation(-zhalf) *operation(-yhalf+cover) *zhalf
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *operation(ydivision-2*ycoverFibers) *zcoverFibers *operation(-yhalf+cover) *operation(zhalf-cover) *operation(yhalf-cover) *zhalf
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *operation(ydivision-2*ycoverFibers) *zcoverFibers *operation(-yhalf+cover) *operation(-zhalf) *operation(yhalf-cover) *operation(-zhalf+cover)
*# Reinforcing Bars Definition along local z axis
*if(MatProp(Bars_along_z_axis_face,int)==2)

# Create the corner bars 

*format "%3d %12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial 2 *MatProp(Corner_Bar_Area,real) *operation(yhalf-cover) *operation(zhalf-cover) *operation(yhalf-cover) *operation(cover-zhalf)
*format "%3d %12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial 2 *MatProp(Corner_Bar_Area,real) *operation(cover-yhalf) *operation(zhalf-cover) *operation(cover-yhalf) *operation(cover-zhalf)
*elseif(MatProp(Bars_along_z_axis_face,int)==3)

# Create the corner bars 

*format "%3d %12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial 2 *MatProp(Corner_Bar_Area,real) *operation(yhalf-cover) *operation(zhalf-cover) *operation(yhalf-cover) *operation(cover-zhalf)
*format "%3d %12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial 2 *MatProp(Corner_Bar_Area,real) *operation(cover-yhalf) *operation(zhalf-cover) *operation(cover-yhalf) *operation(cover-zhalf) 

# Create the middle bars

*format "%10.6f%12.8f%3d"
fiber *operation(yhalf-cover) 0 *MatProp(Middle_Bar_Area,real) *SelectedRBMaterial
*format "%10.6f%12.8f%3d"
fiber *operation(-yhalf+cover) 0 *MatProp(Middle_Bar_Area,real) *SelectedRBMaterial
*else 
*set var Howmanybars=MatProp(Bars_along_z_axis_face,int)
*set var zdist=operation((height-2*cover)/(Howmanybars-1))
*set var zfirstcoord=operation(zhalf-cover-zdist)
*set var zlastcoord=operation(cover-zhalf+zdist)
*# Corner bars

# Create the corner bars

*format "%3d %12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial 2 *MatProp(Corner_Bar_Area,real) *operation(yhalf-cover) *operation(zhalf-cover) *operation(yhalf-cover) *operation(cover-zhalf)
*format "%3d %12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial 2 *MatProp(Corner_Bar_Area,real) *operation(cover-yhalf) *operation(zhalf-cover) *operation(cover-yhalf) *operation(cover-zhalf)
*# intermediate bars along z axis

# Create the middle Reinforcing Bars along local z axis

*format "%3d%3d%12.8f%10.6f%10.6f%10.6f%10.6f"

layer straight *SelectedRBMaterial *operation(Howmanybars-2) *MatProp(Middle_Bar_Area,real) *operation(yhalf-cover) *zfirstcoord *operation(yhalf-cover) *zlastcoord
*format "%3d%3d%12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial *operation(Howmanybars-2) *MatProp(Middle_Bar_Area,real) *operation(cover-yhalf) *zfirstcoord *operation(cover-yhalf) *zlastcoord 
*endif
*# Reinforcing bars along local y axis
*if(MatProp(Bars_along_y_axis_face,int)==3)

# Create the middle Reinforcing Bars along local y axis

*format "%10.6f  %12.8f%3d"
fiber 0 *operation(zhalf-cover) *MatProp(Middle_Bar_Area,real) *SelectedRBMaterial
*format "%10.6f  %12.8f%3d"
fiber 0 *operation(-zhalf+cover) *MatProp(Middle_Bar_Area,real) *SelectedRBMaterial
*elseif(MatProp(Bars_along_y_axis_face,int)>=4)
*set var Howmanybars=MatProp(Bars_along_y_axis_face,int)
*set var ydist=operation((width-2*cover)/(Howmanybars-1))
*set var yfirstcoord=operation(yhalf-cover-ydist)
*set var ylastcoord=operation(cover-yhalf+ydist)

# Create the middle Reinforcing Bars along local y axis

*format "%3d%3d%12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial *operation(Howmanybars-2) *MatProp(Middle_Bar_Area,real) *yfirstcoord *operation(zhalf-cover) *ylastcoord *operation(zhalf-cover)
*format "%3d%3d%12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial *operation(Howmanybars-2) *MatProp(Middle_Bar_Area,real) *yfirstcoord *operation(cover-zhalf) *ylastcoord *operation(cover-zhalf)  
*elseif(MatProp(Bars_along_y_axis_face,int)==1)
*MessageBox Error: Invalid number of longitudinal bars along local y face
*endif
}
*#---------Circular Section-------
*elseif(strcmp(Matprop(Cross_Section),"Circular")==0)
*set var diameter=MatProp(Diameter_d,real)
*set var radius=operation(diameter/2.0)
*set var cover=MatProp(Cover_depth_for_bars,real)
*set var circmdivision=MatProp(Fibers_in_the_circumferential_direction,int)
*set var raddivision=MatProp(Fibers_in_the_radial_direction,int)
*set var CoreExternalRadius=operation(radius-cover)
*set var coverFibers=tcl(NumofCoverFibers *cover *radius *raddivision)

section Fiber *SelectedSection {

# Create the core fibers

#patch circ $matTag $numSubdivCirc $numSubdivRad $yCenter $zCenter $intRad $extRad $startAng $endAng
*format "%3d%3d%3d %8.3f "
patch circ *SelectedCoreMaterial *circmdivision *operation(raddivision-coverFibers) 0.0 0.0 0.0 *CoreExternalRadius 0 360

# Create the cover fibers

#patch circ $matTag $numSubdivCirc $numSubdivRad $yCenter $zCenter $intRad $extRad $startAng $endAng
*format "%3d%3d %8.3f%8.3f "
patch circ *SelectedCoverMaterial *circmdivision *coverFibers 0.0 0.0 *CoreExternalRadius *radius 0 360

# Create the reinforcing bars

#layer circ $matTag $numFiber $areaFiber $yCenter $zCenter $radius <$startAng $endAng>
*format "%3d%3d%12.8f %8.3f"
layer circ *SelectedRBMaterial *MatProp(Bars_along_arc,int) *MatProp(Bar_Area,real) 0.0 0.0 *CoreExternalRadius 
}
*# endif section is rectangular or circular 
*endif
*# endif section is fiber
*endif
*# endif section found
*endif
*# end materials for section searching
*end materials
*# endif section it is not defined
*endif
*# endif element type is forceBeamColumn
*endif
*# end materials (elements) to search for forceBeamColumn elements
*end materials

# Force-Based Beam Column Element Definition

# element forceBeamColumn $eleTag $iNode $jNode $numIntgrPts $secTag $transfTag

*set var VarCount=VarCount+1
*endif
*#--------------Z as vertical axis-------------
*if(strcmp(GenData(Vertical_Axis),"Z")==0)
*#Vertical elements
*if(NodesCoord(1,1)==NodesCoord(2,1) && NodesCoord(1,2)==NodesCoord(2,2))
*if(strcmp(ElemsMatProp(Geometric_transformation),"Linear")==0)
*set var TransfTag=TransfTag1
*elseif(strcmp(ElemsMatProp(Geometric_transformation),"P-Delta")==0)
*set var TransfTag=TransfTag3
*endif
*format "%6d%6d%6d%3d%3d"
element forceBeamColumn *ElemsNum *ElemsConec *ElemsMatProp(Number_of_integration_points,int) *tcl(FindMaterialNumber *ElemsMatProp(Section)) *TransfTag *\
*if(ElemsMatProp(Activate_iterative_scheme_for_satisfying_element_compatibility,int)==1)
*format "%4d%10.2e"
-iter *ElemsMatProp(Maximum_Iterations,int) *ElemsMatProp(Tolerance,real)
*else

*endif
*else
*if(strcmp(ElemsMatProp(Geometric_transformation),"Linear")==0)
*set var TransfTag=TransfTag2
*elseif(strcmp(ElemsMatProp(Geometric_transformation),"P-Delta")==0)
*set var TransfTag=TransfTag4
*endif
*format "%6d%6d%6d%3d%3d"
element forceBeamColumn *ElemsNum *ElemsConec *ElemsMatProp(Number_of_integration_points,int) *tcl(FindMaterialNumber *ElemsMatProp(Section)) *TransfTag *\
*if(ElemsMatProp(Activate_iterative_scheme_for_satisfying_element_compatibility,int)==1)
*format "%4d%10.2e"
-iter *ElemsMatProp(Maximum_Iterations,int) *ElemsMatProp(Tolerance,real)
*else

*endif
*endif
*#--------------Y as vertical axis-------------
*elseif(strcmp(GenData(Vertical_Axis),"Y")==0)
*#Vertical elements
*if(NodesCoord(1,1)==NodesCoord(2,1) && NodesCoord(1,3)==NodesCoord(2,3))
*if(strcmp(ElemsMatProp(Geometric_transformation),"Linear")==0)
*set var TransfTag=TransfTag1
*elseif(strcmp(ElemsMatProp(Geometric_transformation),"P-Delta")==0)
*set var TransfTag=TransfTag3
*endif
*format "%6d%6d%6d%3d%3d"
element forceBeamColumn *ElemsNum *ElemsConec *ElemsMatProp(Number_of_integration_points,int) *tcl(FindMaterialNumber *ElemsMatProp(Section)) *TransfTag *\
*if(ElemsMatProp(Activate_iterative_scheme_for_satisfying_element_compatibility,int)==1)
*format "%4d%10.2e"
-iter *ElemsMatProp(Maximum_Iterations,int) *ElemsMatProp(Tolerance,real)
*else

*endif
*else
*if(strcmp(ElemsMatProp(Geometric_transformation),"Linear")==0)
*set var TransfTag=TransfTag2
*elseif(strcmp(ElemsMatProp(Geometric_transformation),"P-Delta")==0)
*set var TransfTag=TransfTag4
*endif
*format "%6d%6d%6d%3d%3d%4d%10.2e"
element forceBeamColumn *ElemsNum *ElemsConec *ElemsMatProp(Number_of_integration_points,int) *tcl(FindMaterialNumber *ElemsMatProp(Section)) *TransfTag *\
*if(ElemsMatProp(Activate_iterative_scheme_for_satisfying_element_compatibility,int)==1)
*format "%4d%10.2e"
-iter *ElemsMatProp(Maximum_Iterations,int) *ElemsMatProp(Tolerance,real)
*else

*endif
*endif
*endif
*# if it is FBC
*endif
*end elems
*#-------------------------------------------------------------------------------------------------------------------------
*#--------------------------------------------------------2D / 3DOF -------------------------------------------------------
*#-------------------------------------------------------------------------------------------------------------------------
*elseif(GenData(Dimensions,int)==2 && GenData(DOF,int)==3)
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"forceBeamColumn")==0)
*if(VarCount==1)
*if(GeomTransfPrinted==0)
*set var file=2
*set var TransfTag1=1
*set var TransfTag2=2
*#------------------------------------------------
*#-----------Geometric Transformation-------------
*#------------------------------------------------
# Geometric Transformation

geomTransf Linear *TransfTag1 
geomTransf PDelta *TransfTag2
 
*set var GeomTransfPrinted=1
*endif
# Sections Definition for forceBeamColumn Elements

*loop materials
*if(strcmp(MatProp(Element_type:),"forceBeamColumn")==0)
*set var SelectedSection=tcl(FindMaterialNumber *MatProp(Section) )
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedSection)
*# IF IT HAS NOT BEEN DEFINED YET
*if(MaterialExists==-1)
*# meta valto sti lista me ta used materials
*loop materials *NotUsed
*set var SecNum=tcl(FindMaterialNumber *MatProp(0) )
*# Section FOUND
*if(SelectedSection==SecNum)
*set var dummy=tcl(AddUsedMaterials *SelectedSection)
*if(strcmp(MatProp(Section:),"Fiber")==0)
*set var SelectedCoreMaterial=tcl(FindMaterialNumber *MatProp(Core_material) )
*set var SelectedCoverMaterial=tcl(FindMaterialNumber *MatProp(Cover_material) )
*set var SelectedRBMaterial=tcl(FindMaterialNumber *MatProp(Reinforcing_Bar_material) )
*# CORE MATERIAL DEFINITION
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedCoreMaterial )
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MatNumber=tcl(FindMaterialNumber *Matprop(0))
*if(SelectedCoreMaterial==MatNumber)
*if(strcmp(MatProp(Material:),"Concrete01")==0)
*format "%d%g%g%g%g"
uniaxialMaterial Concrete01 *SelectedCoreMaterial *MatProp(Compressive_strength_fpc,real) *MatProp(Strain_at_maximum_strength_epsc0,real) *MatProp(Crushing_strength_fpcu,real) *MatProp(Strain_at_crushing_strength_epscU,real)
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*format "%d%g%g%g%g%g%g"
uniaxialMaterial Concrete02 *SelectedCoreMaterial *MatProp(Compressive_strength_fpc,real) *MatProp(Strain_at_maximum_strength_epsc0,real) *MatProp(Crushing_strength_fpcu,real) *MatProp(Strain_at_crushing_strength_epscU,real) *MatProp(ratio_between_unloading_slope_at_epscU_and_initial_slope_lamdba,real) *MatProp(Tensile_strength_Ft,real) *MatProp(Tension_softening_stiffness_Ets,real)
*else
*MessageBox *MatProp(0) is not ready for forceBeamColumn elements
*endif
*set var dummy=tcl(AddUsedMaterials *SelectedCoreMaterial)
*break
*endif
*end materials
*endif
*# Cover Material DEFINITION
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedCoverMaterial)
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MatNumber=tcl(FindMaterialNumber *Matprop(0) )
*if(SelectedCoverMaterial==MatNumber)
*if(strcmp(MatProp(Material:),"Concrete01")==0)
*format "%d%g%g%g%g"
uniaxialMaterial Concrete01 *SelectedCoverMaterial *MatProp(Compressive_strength_fpc,real) *MatProp(Strain_at_maximum_strength_epsc0,real) *MatProp(Crushing_strength_fpcu,real) *MatProp(Strain_at_crushing_strength_epscU,real)
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*format "%d%g%g%g%g%g%g"
uniaxialMaterial Concrete02 *SelectedCoverMaterial *MatProp(Compressive_strength_fpc,real) *MatProp(Strain_at_maximum_strength_epsc0,real) *MatProp(Crushing_strength_fpcu,real) *MatProp(Strain_at_crushing_strength_epscU,real) *MatProp(ratio_between_unloading_slope_at_epscU_and_initial_slope_lamdba,real) *MatProp(Tensile_strength_Ft,real) *MatProp(Tension_softening_stiffness_Ets,real)
*else
*MessageBox *MatProp(0) is not ready for forceBeamColumn elements
*endif
*set var dummy=tcl(AddUsedMaterials *SelectedCoverMaterial)
*break
*endif
*end materials
*endif
*# Reinforcing Bar MATERIAL DEFINITION
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedRBMaterial)
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MatNumber=tcl(FindMaterialNumber *Matprop(0) )
*if(SelectedRBMaterial==MatNumber)
*if(strcmp(MatProp(Material:),"Steel01")==0)
*format "%d%g%g%g"
uniaxialMaterial Steel01 *SelectedRBMaterial *MatProp(Yield_Stress_Fy,real) *MatProp(Initial_elastic_tangent_E0,real) *MatProp(Strain-hardening_ratio_b,real)
*else
*MessageBox *MatProp(0) is not ready for forceBeamColumn elements
*endif
*set var dummy=tcl(AddUsedMaterials *SelectedRBMaterial)
*break
*endif
*end materials
*# endif material has not been already defined
*endif
*# ------------------------FIBER definition!!!----------------
*if(strcmp(Matprop(Cross_Section),"Rectangular")==0)
*set var height=Matprop(Height_h,real)
*set var width=MatProp(Width_b,real)
*set var yhalf=operation(height/2.0)
*set var zhalf=operation(width/2.0)
*set var cover=MatProp(Cover_depth_for_bars,real)

section Fiber *SelectedSection {
*set var ydivision=MatProp(Fibers_in_local_y_direction,int)
*set var zdivision=MatProp(Fibers_in_local_z_direction,int)
*set var ycoverFibers=tcl(NumofCoverFibers *cover *height *ydivision)
*set var zcoverFibers=tcl(NumofCoverFibers *cover *width *zdivision)
*# --------------Core fibers-----------

# Create the Core fibers

*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoreMaterial *operation(ydivision-2*ycoverFibers) *operation(zdivision-2*zcoverFibers) *operation(cover-yhalf) *operation(cover-zhalf) *operation(yhalf-cover) *operation(zhalf-cover)
*# --------------Cover fibers----------

# Create the Cover fibers

*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *operation(ydivision-2*ycoverFibers) *zcoverFibers *yhalf *operation(zhalf-cover) *operation(-yhalf) *zhalf
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *operation(ydivision-2*ycoverFibers) *zcoverFibers *yhalf *operation(-zhalf) *operation(-yhalf) *operation(cover-zhalf) 
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *ycoverFibers *operation(zdivision-2*zcoverFibers) *operation(-yhalf) *operation(cover-zhalf) *operation(cover-yhalf) *operation(zhalf-cover)
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *ycoverFibers *operation(zdivision-2*zcoverFibers) *operation(yhalf-cover) *operation(cover-zhalf) *yhalf *operation(zhalf-cover)
*# Reinforcing Bars Definition along local y axis
*if(MatProp(Bars_along_y_axis_face,int)==2)

# Create the corner bars

*format "%3d %12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial 2 *MatProp(Corner_Bar_Area,real) *operation(yhalf-cover) *operation(zhalf-cover) *operation(-yhalf+cover) *operation(zhalf-cover)
*format "%3d %12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial 2 *MatProp(Corner_Bar_Area,real) *operation(yhalf-cover) *operation(-zhalf+cover) *operation(-yhalf+cover) *operation(-zhalf+cover)
*elseif(MatProp(Bars_along_y_axis_face,int)==3)

# Create the corner bars

*format "%3d% 12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial 2 *MatProp(Corner_Bar_Area,real) *operation(yhalf-cover) *operation(zhalf-cover) *operation(-yhalf+cover) *operation(zhalf-cover)
*format "%3d %12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial 2 *MatProp(Corner_Bar_Area,real) *operation(yhalf-cover) *operation(-zhalf+cover) *operation(-yhalf+cover) *operation(-zhalf+cover) 

# Create the middle bars

*format "%10.6f%12.8f%3d"
fiber 0 *operation(zhalf-cover) *MatProp(Middle_Bar_Area,real) *SelectedRBMaterial
*format "%10.6f%12.8f%3d"
fiber 0 *operation(-zhalf+cover) *MatProp(Middle_Bar_Area,real) *SelectedRBMaterial
*else 
*set var Howmanybars=MatProp(Bars_along_y_axis_face,int)
*set var ydist=operation((height-2*cover)/(Howmanybars-1))
*set var yfirstcoord=operation(yhalf-cover-ydist)
*set var ylastcoord=operation(cover-yhalf+ydist)
*# Corner bars

# Create the corner bars

*format "%3d %12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial 2 *MatProp(Corner_Bar_Area,real) *operation(yhalf-cover) *operation(zhalf-cover) *operation(-yhalf+cover) *operation(zhalf-cover)
*format "%3d %12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial 2 *MatProp(Corner_Bar_Area,real) *operation(yhalf-cover) *operation(-zhalf+cover) *operation(-yhalf+cover) *operation(-zhalf+cover)
*# middle bars along y axis

# Create the middle bars along local y axis

*format "%3d%3d%12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial *operation(Howmanybars-2) *MatProp(Middle_Bar_Area,real) *yfirstcoord *operation(zhalf-cover) *ylastcoord *operation(zhalf-cover)
*format "%3d%3d%12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial *operation(Howmanybars-2) *MatProp(Middle_Bar_Area,real) *yfirstcoord *operation(cover-zhalf) *ylastcoord *operation(cover-zhalf)
*endif
*# middle Reinforcing bars along local z axis
*if(MatProp(Bars_along_z_axis_face,int)==3)

# Create the middle bars 

*format "%10.6f  %12.8f%3d"
fiber *operation(yhalf-cover) 0 *MatProp(Middle_Bar_Area,real) *SelectedRBMaterial
*format "%10.6f  %12.8f%3d"
fiber *operation(-yhalf+cover) 0 *MatProp(Middle_Bar_Area,real) *SelectedRBMaterial
*elseif(MatProp(Bars_along_z_axis_face,int)>=4)
*set var Howmanybars=MatProp(Bars_along_z_axis_face,int)
*set var zdist=operation((width-2*cover)/(Howmanybars-1))
*set var zfirstcoord=operation(zhalf-cover-zdist)
*set var zlastcoord=operation(cover-zhalf+zdist)

# Create the middle bars along local z axis

*format "%3d%3d%12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial *operation(Howmanybars-2) *MatProp(Middle_Bar_Area,real) *operation(yhalf-cover) *zfirstcoord *zlastcoord *operation(yhalf-cover)
*format "%3d%3d%12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial *operation(Howmanybars-2) *MatProp(Middle_Bar_Area,real) *operation(cover-yhalf) *zfirstcoord *zlastcoord *operation(cover-yhalf)  
*elseif(MatProp(Bars_along_z_axis_face,int)==1)
*MessageBox Error: Invalid number of longitudinal bars along local y face (1)
*endif
}
*elseif(strcmp(Matprop(Cross_Section),"Circular")==0)
*set var diameter=MatProp(Diameter_d,real)
*set var radius=operation(diameter/2.0)
*set var cover=MatProp(Cover_depth_for_bars,real)
*set var circmdivision=MatProp(Fibers_in_the_circumferential_direction,int)
*set var raddivision=MatProp(Fibers_in_the_radial_direction,int)
*set var CoreExternalRadius=operation(radius-cover)
*set var coverFibers=tcl(NumofCoverFibers *cover *radius *raddivision)

section Fiber *SelectedSection {

# Create the core fibers

#patch circ $matTag $numSubdivCirc $numSubdivRad $yCenter $zCenter $intRad $extRad $startAng $endAng
*format "%3d%3d%3d %8.3f "
patch circ *SelectedCoreMaterial *circmdivision *operation(raddivision-coverFibers) 0.0 0.0 0.0 *CoreExternalRadius 0 360

# Create the cover fibers

#patch circ $matTag $numSubdivCirc $numSubdivRad $yCenter $zCenter $intRad $extRad $startAng $endAng
*format "%3d%3d%3d %8.3f%8.3f "
patch circ *SelectedCoverMaterial *circmdivision *coverFibers 0.0 0.0 *CoreExternalRadius *radius 0 360

# Create the reinforcing bars

#layer circ $matTag $numFiber $areaFiber $yCenter $zCenter $radius <$startAng $endAng>
*format "%3d%3d%12.8f %8.3f"
layer circ *SelectedRBMaterial *MatProp(Bars_along_arc,int) *MatProp(Bar_Area,real) 0.0 0.0 *CoreExternalRadius 
}
*# endif section is rectangular or circular 
*endif
*# endif section is fiber
*endif
*# endif section found
*endif
*# end materials for section searching
*end materials
*# endif section it is not defined
*endif
*# endif element type is forceBeamColumn
*endif
*# end materials (elements) to search for forceBeamColumn elements
*end materials

# Force-Based Beam-Column Element definition
 
# element forceBeamColumn $eleTag $iNode $jNode $numIntgrPts $secTag $transfTag

*set var VarCount=VarCount+1
*endif
*if(strcmp(ElemsMatProp(Geometric_transformation),"Linear")==0)
*set var TransfTag=TransfTag1
*elseif(strcmp(ElemsMatProp(Geometric_transformation),"P-Delta")==0)
*set var TransfTag=TransfTag2
*endif
*format "%6d%6d%6d%3d%3d"
element forceBeamColumn *ElemsNum *ElemsConec *ElemsMatProp(Number_of_integration_points,int) *tcl(FindMaterialNumber *ElemsMatProp(Section)) *TransfTag *\
*if(ElemsMatProp(Activate_iterative_scheme_for_satisfying_element_compatibility,int)==1)
*format "%4d%10.2e"
-iter *ElemsMatProp(Maximum_Iterations,int) *ElemsMatProp(Tolerance,real)
*else

*endif
*# if it is FBC
*endif
*end elems
*else
*MessageBox Error: forceBeamColumn Element require 2D/3DOF or 3D/6DOF Model
*endif
*# endif counter!=0
*endif