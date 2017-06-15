*set var FiberTag=SectionID
*if(ndime==3)
*# if it is a Fiber Section, We need to check which uniaxial materials we need to define
*set var SelectedCoreMaterial=tcl(FindMaterialNumber *MatProp(Core_material) )
*set var SelectedCoverMaterial=tcl(FindMaterialNumber *MatProp(Cover_material) )
*set var SelectedRBMaterial=tcl(FindMaterialNumber *MatProp(Reinforcing_Bar_material) )
*# CORE MATERIAL DEFINITION
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedCoreMaterial )
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *Matprop(0))
*if(SelectedCoreMaterial==MaterialID)
*if(strcmp(MatProp(Material:),"Concrete01")==0)
*include ..\Materials\Uniaxial\Concrete01.bas
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*include ..\Materials\Uniaxial\Concrete02.bas
*elseif(strcmp(MatProp(Material:),"Concrete04")==0)
*include ..\Materials\Uniaxial\Concrete04.bas
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*include ..\Materials\Uniaxial\Concrete06.bas
*else
*MessageBox Error: Unsupported Core material for Fiber Section
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
*set var MaterialID=tcl(FindMaterialNumber *Matprop(0) )
*if(SelectedCoverMaterial==MaterialID)
*if(strcmp(MatProp(Material:),"Concrete01")==0)
*include ..\Materials\Uniaxial\Concrete01.bas
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*include ..\Materials\Uniaxial\Concrete02.bas
*elseif(strcmp(MatProp(Material:),"Concrete04")==0)
*include ..\Materials\Uniaxial\Concrete04.bas
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*include ..\Materials\Uniaxial\Concrete06.bas
*else
*MessageBox Error: Unsupported Cover material for Fiber Section
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
*set var MaterialID=tcl(FindMaterialNumber *Matprop(0) )
*if(SelectedRBMaterial==MaterialID)
*if(strcmp(MatProp(Material:),"Steel01")==0)
*include ..\Materials\Uniaxial\Steel01.bas
*elseif(strcmp(MatProp(Material:),"ReinforcingSteel")==0)
*include ..\Materials\Uniaxial\ReinforcingSteel.bas
*else
*MessageBox Error: Unsupported Rebar material for Fiber Section
*endif
*set var dummy=tcl(AddUsedMaterials *MaterialID)
*break
*endif
*end materials
*# endif material has been already defined
*endif
*# ------------------------FIBER definition--------------------
*# ----------Rectangular_Column Section-------------
*if(strcmp(Matprop(Cross_section),"Rectangular_Column")==0)
*set var height=Matprop(Height_h,real)
*set var width=MatProp(Width_b,real)
*set var zhalf=operation(height/2.0)
*set var yhalf=operation(width/2.0)
*set var cover=MatProp(Cover_depth_for_bars,real)

section Fiber *SectionID {
*set var zdivision=MatProp(Fibers_in_local_z_direction,int)
*set var ydivision=MatProp(Fibers_in_local_y_direction,int)
*set var ycoverFibers=tcl(NumofCoverFibers *cover *width *ydivision)
*set var zcoverFibers=tcl(NumofCoverFibers *cover *height *zdivision)

*# --------------Core fibers definition-----------
# Create the Core fibers

# patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoreMaterial *operation(ydivision-2*ycoverFibers) *operation(zdivision-2*zcoverFibers) *operation(cover-yhalf) *operation(cover-zhalf) *operation(yhalf-cover) *operation(zhalf-cover)
*# --------------Cover fibers definition----------

# Create the Cover fibers

# patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *ycoverFibers *zdivision *operation(yhalf-cover) *operation(-zhalf) *yhalf *zhalf
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *ycoverFibers *zdivision *operation(-yhalf) *operation(-zhalf) *operation(-yhalf+cover) *zhalf
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *operation(ydivision-2*ycoverFibers) *zcoverFibers *operation(-yhalf+cover) *operation(zhalf-cover) *operation(yhalf-cover) *zhalf
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *operation(ydivision-2*ycoverFibers) *zcoverFibers *operation(-yhalf+cover) *operation(-zhalf) *operation(yhalf-cover) *operation(-zhalf+cover)
*# Reinforcing Bars Definition along local z axis
*if(MatProp(Bars_along_z_axis_face,int)==2)

# Create the corner bars

# layer straight $matTag $numFiber $areaFiber $yStart $zStart $yEnd $zEnd
*format "%3d %12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial 2 *MatProp(Corner_Bar_Area,real) *operation(yhalf-cover) *operation(zhalf-cover) *operation(yhalf-cover) *operation(cover-zhalf)
*format "%3d %12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial 2 *MatProp(Corner_Bar_Area,real) *operation(cover-yhalf) *operation(zhalf-cover) *operation(cover-yhalf) *operation(cover-zhalf)
*elseif(MatProp(Bars_along_z_axis_face,int)==3)

# Create the corner bars

# layer straight $matTag $numFiber $areaFiber $yStart $zStart $yEnd $zEnd
*format "%3d %12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial 2 *MatProp(Corner_Bar_Area,real) *operation(yhalf-cover) *operation(zhalf-cover) *operation(yhalf-cover) *operation(cover-zhalf)
*format "%3d %12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial 2 *MatProp(Corner_Bar_Area,real) *operation(cover-yhalf) *operation(zhalf-cover) *operation(cover-yhalf) *operation(cover-zhalf)

# Create the middle bars

# fiber $yLoc $zLoc $A $matTag
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

# layer straight $matTag $numFiber $areaFiber $yStart $zStart $yEnd $zEnd
*format "%3d %12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial 2 *MatProp(Corner_Bar_Area,real) *operation(yhalf-cover) *operation(zhalf-cover) *operation(yhalf-cover) *operation(cover-zhalf)
*format "%3d %12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial 2 *MatProp(Corner_Bar_Area,real) *operation(cover-yhalf) *operation(zhalf-cover) *operation(cover-yhalf) *operation(cover-zhalf)
*# intermediate bars along z axis

# Create the middle Reinforcing Bars along local z axis

# layer straight $matTag $numFiber $areaFiber $yStart $zStart $yEnd $zEnd
*format "%3d%3d%12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial *operation(Howmanybars-2) *MatProp(Middle_Bar_Area,real) *operation(yhalf-cover) *zfirstcoord *operation(yhalf-cover) *zlastcoord
*format "%3d%3d%12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial *operation(Howmanybars-2) *MatProp(Middle_Bar_Area,real) *operation(cover-yhalf) *zfirstcoord *operation(cover-yhalf) *zlastcoord
*endif
*# Reinforcing bars along local y axis
*if(MatProp(Bars_along_y_axis_face,int)==3)

# Create the middle Reinforcing Bars along local y axis

# fiber $yLoc $zLoc $A $matTag
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

# layer straight $matTag $numFiber $areaFiber $yStart $zStart $yEnd $zEnd
*format "%3d%3d%12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial *operation(Howmanybars-2) *MatProp(Middle_Bar_Area,real) *yfirstcoord *operation(zhalf-cover) *ylastcoord *operation(zhalf-cover)
*format "%3d%3d%12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial *operation(Howmanybars-2) *MatProp(Middle_Bar_Area,real) *yfirstcoord *operation(cover-zhalf) *ylastcoord *operation(cover-zhalf)
*elseif(MatProp(Bars_along_y_axis_face,int)==1)
*MessageBox Error: Invalid number of longitudinal bars along local y face
*endif
}
*# -----------Rectangular Beam Section-----------
*elseif(strcmp(Matprop(Cross_section),"Rectangular_Beam")==0)
*set var height=Matprop(Height_h,real)
*set var width=MatProp(Width_b,real)
*set var zhalf=operation(height/2.0)
*set var yhalf=operation(width/2.0)
*set var cover=MatProp(Cover_depth_for_bars,real)

section Fiber *FiberTag {
*set var zdivision=MatProp(Fibers_in_local_z_direction,int)
*set var ydivision=MatProp(Fibers_in_local_y_direction,int)
*set var ycoverFibers=tcl(NumofCoverFibers *cover *width *ydivision)
*set var zcoverFibers=tcl(NumofCoverFibers *cover *height *zdivision)

# Create the Core fibers

# patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoreMaterial *operation(ydivision-2*ycoverFibers) *operation(zdivision-2*zcoverFibers) *operation(cover-yhalf) *operation(cover-zhalf) *operation(yhalf-cover) *operation(zhalf-cover)
*# --------------Cover fibers definition----------

# Create the Cover fibers

# patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *ycoverFibers *zdivision *operation(yhalf-cover) *operation(-zhalf) *yhalf *zhalf
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *ycoverFibers *zdivision *operation(-yhalf) *operation(-zhalf) *operation(-yhalf+cover) *zhalf
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *operation(ydivision-2*ycoverFibers) *zcoverFibers *operation(-yhalf+cover) *operation(zhalf-cover) *operation(yhalf-cover) *zhalf
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *operation(ydivision-2*ycoverFibers) *zcoverFibers *operation(-yhalf+cover) *operation(-zhalf) *operation(yhalf-cover) *operation(-zhalf+cover)

*if(MatProp(Top_bars,int)>=2)
*set var HowmanyTopbars=MatProp(Top_bars,int)

# Create the Top bars (face on local z positive dir)

# layer straight $matTag $numFiber $areaFiber $yStart $zStart $yEnd $zEnd
*format "%3d%3d %12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial *HowmanyTopbars *MatProp(Top_bar_area,real) *operation(cover-yhalf) *operation(zhalf-cover) *operation(yhalf-cover) *operation(zhalf-cover)

*else
*MessageBox Error: Invalid Number of Top bars in a Fiber Section
*endif
*if(MatProp(Bottom_bars,int)>=2)
# Create the Bottom bars (face on local z negative dir)

*set var HowmanyBottombars=MatProp(Bottom_bars,int)
*format "%3d%3d%12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial *HowmanyBottombars *MatProp(Bottom_bar_area,real) *operation(cover-yhalf) *operation(cover-zhalf) *operation(yhalf-cover) *operation(cover-zhalf)
*else
*MessageBox Error: Invalid Number of Bottom Bars in a Fiber Section
*endif
}
*#---------------Tee Beam Section--------
*elseif(strcmp(MatProp(Cross_section),"Tee_Beam")==0)
*set var height=Matprop(Height_h,real)
*set var width=MatProp(Width_bf,real)
*set var tw=MatProp(Web_width_bw,real)
*set var ts=MatProp(Slab_thickness_hf,real)
*set var SlabArea=operation(ts*(width-tw))
*set var WebArea=operation(height*tw)
*set var Area=operation((height-ts)*tw+ts*width)
*set var Zcm=operation((WebArea*(height-ts)/2+SlabArea*(height-ts/2))/Area)
*set var zhalf=operation(height/2.0)
*set var yhalf=operation(width/2.0)
*set var cover=MatProp(Cover_depth_for_bars,real)
*if(width<=tw || height<=ts || cover>tw)
*MessageBox Error: Invalid geometric values in Fiber Tee Beam Section.
*endif
section Fiber *FiberTag {
*set var zdivision=MatProp(Fibers_in_local_z_direction,int)
*set var ydivision=MatProp(Fibers_in_local_y_direction,int)
*set var ycoverFibers=tcl(NumofCoverFibers *cover *width *ydivision)
*set var zcoverFibers=tcl(NumofCoverFibers *cover *height *zdivision)
*set var yslabFibers=tcl(NumofCoverFibers *operation((width-tw)/2) *width *ydivision)
*set var zslabFibers=tcl(NumofCoverFibers *ts *height *zdivision)
# Create the core fibers

# patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoreMaterial *operation(-2*(yslabFibers+ycoverFibers)+ydivision) *operation(zdivision-2*zcoverFibers) *operation(cover-tw/2) *operation(cover-Zcm) *operation(tw/2-cover) *operation(height-Zcm-cover)

# Create the Cover fibers

# patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *ycoverFibers *zdivision *operation(tw/2-cover) *operation(-Zcm) *operation(tw/2) *operation(height-Zcm)
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *ycoverFibers *zdivision *operation(-tw/2) *operation(-Zcm) *operation(-tw/2+cover) *operation(height-Zcm)
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *operation(-2*(yslabFibers+ycoverFibers)+ydivision) *zcoverFibers *operation(-tw/2+cover) *operation(height-Zcm-cover) *operation(tw/2-cover) *operation(height-Zcm)
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *operation(-2*(yslabFibers+ycoverFibers)+ydivision) *zcoverFibers *operation(-tw/2+cover) *operation(-Zcm) *operation(tw/2-cover) *operation(-Zcm+cover)

# Create the slab fibers
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *yslabFibers *zslabFibers *operation(-width/2) *operation(height-Zcm-ts) *operation(-tw/2) *operation(height-Zcm)
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *yslabFibers *zslabFibers *operation(tw/2) *operation(height-Zcm-ts) *operation(width/2) *operation(height-Zcm)
*if(MatProp(Top_beam_bars,int)>=2)
*set var HowmanyTopWebBars=MatProp(Top_beam_bars,int)

# Create the Top beam bars (face on local z positive dir)

# layer straight $matTag $numFiber $areaFiber $yStart $zStart $yEnd $zEnd
*format "%3d%3d %12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial *HowmanyTopWebBars *MatProp(Top_beam_bar_area,real) *operation(cover-tw/2) *operation(height-Zcm-cover) *operation(tw/2-cover) *operation(height-Zcm-cover)

*else
*MessageBox Error: Invalid Number of Top web bars in a Fiber Section
*endif
*if(MatProp(Bottom_beam_bars,int)>=2)
# Create the Bottom beam bars (face on local z negative dir)

*set var HowmanyBottombars=MatProp(Bottom_beam_bars,int)
*format "%3d%3d%12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial *HowmanyBottombars *MatProp(Bottom_beam_bar_area,real) *operation(cover-tw/2) *operation(cover-Zcm) *operation(tw/2-cover) *operation(cover-Zcm)
*else
*MessageBox Error: Invalid Number of Bottom Beam Bars in a Fiber Section
*endif
*set var HowmanyTopSlabBars=MatProp(Slab_bars,int)
*set var remainder=tcl(Bas_mod *HowmanyTopSlabBars 2)
*if(MatProp(Slab_bars,int)>=4 && remainder==0)
# Create the slab bars (face on local z positive dir)

*format "%3d%3d%12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial *HowmanyTopSlabBars *MatProp(Slab_bar_area,real) *operation(cover-width/2) *operation(height-Zcm-cover) *operation(-tw/2-cover) *operation(height-Zcm-cover)
*format "%3d%3d%12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial *HowmanyTopSlabBars *MatProp(Slab_bar_area,real) *operation(tw/2+cover) *operation(height-Zcm-cover) *operation(width/2-cover) *operation(height-Zcm-cover)

*elseif(MatProp(Slab_bars,int)==2)
# Create the slab bars (face on local z positive dir)

fiber *operation(-width/2+(width/2-tw/2)/2) *operation(height-Zcm-cover) *MatProp(Slab_bar_area,real) *SelectedRBMaterial
fiber *operation(width/2-(width/2-tw/2)/2) *operation(height-Zcm-cover) *MatProp(Slab_bar_area,real) *SelectedRBMaterial
*elseif(MatProp(Slab_bars,int)==0)
*# do nothing : No Slab bars
*else
*MessageBox Error: Invalid Number of Slab Bars in a Fiber Section.
*endif
}
*#---------Circular_Column Section-------
*elseif(strcmp(Matprop(Cross_section),"Circular_Column")==0)
*set var diameter=MatProp(Diameter_d,real)
*set var radius=operation(diameter/2.0)
*set var cover=MatProp(Cover_depth_for_bars,real)
*set var circmdivision=MatProp(Fibers_in_the_circumferential_direction,int)
*set var raddivision=MatProp(Fibers_in_the_radial_direction,int)
*set var CoreExternalRadius=operation(radius-cover)
*set var coverFibers=tcl(NumofCoverFibers *cover *radius *raddivision)

section Fiber *FiberTag {

# Create the core fibers

# patch circ $matTag $numSubdivCirc $numSubdivRad $yCenter $zCenter $intRad $extRad $startAng $endAng
*format "%3d%3d%3d %8.3f "
patch circ *SelectedCoreMaterial *circmdivision *operation(raddivision-coverFibers) 0.0 0.0 0.0 *CoreExternalRadius 0 360

# Create the cover fibers

# patch circ $matTag $numSubdivCirc $numSubdivRad $yCenter $zCenter $intRad $extRad $startAng $endAng
*format "%3d%3d%3d %8.3f "
patch circ *SelectedCoverMaterial *circmdivision *coverFibers 0.0 0.0 *CoreExternalRadius *radius 0 360

# Create the reinforcing bars

# layer circ $matTag $numFiber $areaFiber $yCenter $zCenter $radius <$startAng $endAng>
*format "%3d%3d%12.8f %8.3f"
layer circ *SelectedRBMaterial *MatProp(Bars_along_arc,int) *MatProp(Bar_Area,real) 0.0 0.0 *CoreExternalRadius
}
*# endif section is rectangular or circular
*endif
*# --------------------------------------------- 2D ---------------------------------------------------
*elseif(ndime==2)
*set var SelectedCoreMaterial=tcl(FindMaterialNumber *MatProp(Core_material) )
*set var SelectedCoverMaterial=tcl(FindMaterialNumber *MatProp(Cover_material) )
*set var SelectedRBMaterial=tcl(FindMaterialNumber *MatProp(Reinforcing_Bar_material) )
*# CORE MATERIAL DEFINITION
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedCoreMaterial )
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *Matprop(0))
*if(SelectedCoreMaterial==MaterialID)
*if(strcmp(MatProp(Material:),"Concrete01")==0)
*include ..\Materials\Uniaxial\Concrete01.bas
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*include ..\Materials\Uniaxial\Concrete02.bas
*elseif(strcmp(MatProp(Material:),"Concrete04")==0)
*include ..\Materials\Uniaxial\Concrete04.bas
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*include ..\Materials\Uniaxial\Concrete06.bas
*else
*MessageBox Error: Unsupported Core material for Fiber Section
*endif
*set var dummy=tcl(AddUsedMaterials *MaterialID)
*break
*endif
*end materials
*endif
*# Cover Material DEFINITION
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedCoverMaterial)
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *Matprop(0) )
*if(SelectedCoverMaterial==MaterialID)
*if(strcmp(MatProp(Material:),"Concrete01")==0)
*include ..\Materials\Uniaxial\Concrete01.bas
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*include ..\Materials\Uniaxial\Concrete02.bas
*elseif(strcmp(MatProp(Material:),"Concrete04")==0)
*include ..\Materials\Uniaxial\Concrete04.bas
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*include ..\Materials\Uniaxial\Concrete06.bas
*else
*MessageBox Error: Unsupported Cover material for Fiber Section
*endif
*set var dummy=tcl(AddUsedMaterials *MaterialID)
*break
*endif
*end materials
*endif
*# Reinforcing Bar MATERIAL DEFINITION
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedRBMaterial)
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *Matprop(0) )
*if(SelectedRBMaterial==MaterialID)
*if(strcmp(MatProp(Material:),"Steel01")==0)
*include ..\Materials\Uniaxial\Steel01.bas
*elseif(strcmp(MatProp(Material:),"ReinforcingSteel")==0)
*include ..\Materials\Uniaxial\ReinforcingSteel.bas
*else
*MessageBox Error: Unsupported Rebar material for Fiber Section
*endif
*set var dummy=tcl(AddUsedMaterials *MaterialID)
*break
*endif
*end materials
*# endif material has not been already defined
*endif
*# ------------------------FIBER definition!!!----------------
*if(strcmp(Matprop(Cross_section),"Rectangular_Column")==0)
*set var height=Matprop(Height_h,real)
*set var width=MatProp(Width_b,real)
*set var yhalf=operation(height/2.0)
*set var zhalf=operation(width/2.0)
*set var cover=MatProp(Cover_depth_for_bars,real)

section Fiber *FiberTag {
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
patch rect *SelectedCoverMaterial *ydivision *zcoverFibers *yhalf *operation(zhalf-cover) *operation(-yhalf) *zhalf
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *ydivision *zcoverFibers *yhalf *operation(-zhalf) *operation(-yhalf) *operation(cover-zhalf)
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
*elseif(strcmp(MatProp(Cross_section),"Rectangular_Beam")==0)
*set var height=Matprop(Height_h,real)
*set var width=MatProp(Width_b,real)
*set var yhalf=operation(height/2.0)
*set var zhalf=operation(width/2.0)
*set var cover=MatProp(Cover_depth_for_bars,real)

section Fiber *FiberTag {
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
patch rect *SelectedCoverMaterial *ydivision *zcoverFibers *yhalf *operation(zhalf-cover) *operation(-yhalf) *zhalf
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *ydivision *zcoverFibers *yhalf *operation(-zhalf) *operation(-yhalf) *operation(cover-zhalf)
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *ycoverFibers *operation(zdivision-2*zcoverFibers) *operation(-yhalf) *operation(cover-zhalf) *operation(cover-yhalf) *operation(zhalf-cover)
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *ycoverFibers *operation(zdivision-2*zcoverFibers) *operation(yhalf-cover) *operation(cover-zhalf) *yhalf *operation(zhalf-cover)

*if(MatProp(Top_bars,int)>=2)
*set var HowmanyTopbars=MatProp(Top_bars,int)

# Create the Top bars (face on local y positive dir)

*format "%3d%3d %12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial *HowmanyTopbars *MatProp(Top_bar_area,real) *operation(yhalf-cover) *operation(zhalf-cover) *operation(yhalf-cover) *operation(cover-zhalf)

*else
*MessageBox Error: Invalid Number of Top bars in a Fiber Section
*endif
*if(MatProp(Bottom_bars,int)>=2)
# Create the Bottom bars (face on local y negative dir)

*set var HowmanyBottombars=MatProp(Bottom_bars,int)
*format "%3d%3d%12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial *HowmanyBottombars *MatProp(Bottom_bar_area,real) *operation(cover-yhalf) *operation(zhalf-cover) *operation(cover-yhalf) *operation(cover-zhalf)
*else
*MessageBox Error: Invalid Number of Bottom Bars in a Fiber Section
*endif
}
*#---------------Tee Beam Section--------
*elseif(strcmp(MatProp(Cross_section),"Tee_Beam")==0)
*set var height=Matprop(Height_h,real)
*set var width=MatProp(Width_bf,real)
*set var tw=MatProp(Web_width_bw,real)
*set var ts=MatProp(Slab_thickness_hf,real)
*set var SlabArea=operation(ts*(width-tw))
*set var WebArea=operation(height*tw)
*set var Area=operation((height-ts)*tw+ts*width)
*set var Ycm=operation((WebArea*(height-ts)/2+SlabArea*(height-ts/2))/Area)
*set var cover=MatProp(Cover_depth_for_bars,real)
*if(width<=tw || height<=ts || cover>tw)
*MessageBox Error: Invalid geometric values in Fiber Tee Beam Section.
*endif
section Fiber *FiberTag {
*set var zdivision=MatProp(Fibers_in_local_z_direction,int)
*set var ydivision=MatProp(Fibers_in_local_y_direction,int)
*set var ycoverFibers=tcl(NumofCoverFibers *cover *height *ydivision)
*set var zcoverFibers=tcl(NumofCoverFibers *cover *width *zdivision)
*set var zslabFibers=tcl(NumofCoverFibers *operation((width-tw)/2) *width *zdivision)
*set var yslabFibers=tcl(NumofCoverFibers *ts *height *ydivision)
# Create the Core fibers

# patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoreMaterial *operation(ydivision-2*ycoverFibers) *operation(-2*(zslabFibers+zcoverFibers)+zdivision) *operation(cover-Ycm) *operation(cover-tw/2) *operation(height-Ycm-cover) *operation(tw/2-cover)

# Create the Cover fibers

# patch rect $matTag $numSubdivY $numSubdivZ $yI $zI $yJ $zJ
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *ydivision *zcoverFibers *operation(-Ycm) *operation(tw/2-cover) *operation(height-Ycm) *operation(tw/2)
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *ydivision *zcoverFibers *operation(-Ycm) *operation(-tw/2) *operation(height-Ycm) *operation(-tw/2+cover)
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *ycoverFibers *operation(-2*(zslabFibers+zcoverFibers)+zdivision) *operation(height-Ycm-cover) *operation(-tw/2+cover) *operation(height-Ycm) *operation(tw/2-cover)
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *ycoverFibers *operation(-2*(zslabFibers+zcoverFibers)+zdivision) *operation(-Ycm) *operation(-tw/2+cover) *operation(-Ycm+cover) *operation(tw/2-cover)

# Create the slab fibers
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *yslabFibers *zslabFibers *operation(height-Ycm-ts) *operation(-width/2) *operation(height-Ycm) *operation(-tw/2)
*format "%3d%6d%6d%10.6f%10.6f%10.6f%10.6f"
patch rect *SelectedCoverMaterial *yslabFibers *zslabFibers *operation(height-Ycm-ts) *operation(tw/2) *operation(height-Ycm) *operation(width/2)
*if(MatProp(Top_beam_bars,int)>=2)
*set var HowmanyTopWebBars=MatProp(Top_beam_bars,int)

# Create the Top beam bars (face on local y positive dir)

# layer straight $matTag $numFiber $areaFiber $yStart $zStart $yEnd $zEnd
*format "%3d%3d %12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial *HowmanyTopWebBars *MatProp(Top_beam_bar_area,real) *operation(height-Ycm-cover) *operation(cover-tw/2) *operation(height-Ycm-cover) *operation(tw/2-cover)

*else
*MessageBox Error: Invalid Number of Top web bars in a Fiber Section
*endif
*if(MatProp(Bottom_beam_bars,int)>=2)
# Create the Bottom beam bars (face on local y negative dir)

*set var HowmanyBottombars=MatProp(Bottom_beam_bars,int)
*format "%3d%3d%12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial *HowmanyBottombars *MatProp(Bottom_beam_bar_area,real) *operation(cover-Ycm) *operation(cover-tw/2) *operation(cover-Ycm) *operation(tw/2-cover)
*else
*MessageBox Error: Invalid Number of Bottom Bars in a Fiber Section
*endif
*set var HowmanyTopSlabBars=MatProp(Slab_bars,int)
*set var remainder=tcl(Bas_mod *HowmanyTopSlabBars 2)
*if(MatProp(Slab_bars,int)>=4 && remainder==0)
# Create the slab bars (face on local y positive dir)

*format "%3d%3d%12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial *HowmanyTopSlabBars *MatProp(Slab_bar_area,real) *operation(height-Ycm-cover) *operation(cover-width/2) *operation(height-Ycm-cover) *operation(-tw/2-cover)
*format "%3d%3d%12.8f%10.6f%10.6f%10.6f%10.6f"
layer straight *SelectedRBMaterial *HowmanyTopSlabBars *MatProp(Slab_bar_area,real) *operation(height-Ycm-cover) *operation(tw/2+cover) *operation(height-Ycm-cover) *operation(width/2-cover)

*elseif(MatProp(Slab_bars,int)==2)
# Create the slab bars (face on local y positive dir)

fiber *operation(height-Ycm-cover) *operation(-width/2+(width/2-tw/2)/2) *MatProp(Slab_bar_area,real) *SelectedRBMaterial
fiber *operation(height-Ycm-cover) *operation(+width/2-(width/2-tw/2)/2) *MatProp(Slab_bar_area,real) *SelectedRBMaterial
*elseif(MatProp(Slab_bars,int)==0)
*# do nothing : No slab bars
*else
*MessageBox Error: Invalid Number of Bottom Bars in a Fiber Section
*endif
}
*elseif(strcmp(Matprop(Cross_section),"Circular_Column")==0)
*set var diameter=MatProp(Diameter_d,real)
*set var radius=operation(diameter/2.0)
*set var cover=MatProp(Cover_depth_for_bars,real)
*set var circmdivision=MatProp(Fibers_in_the_circumferential_direction,int)
*set var raddivision=MatProp(Fibers_in_the_radial_direction,int)
*set var CoreExternalRadius=operation(radius-cover)
*set var coverFibers=tcl(NumofCoverFibers *cover *radius *raddivision)

section Fiber *FiberTag {

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
*# end of 2D or 3D
*endif