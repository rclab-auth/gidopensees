namespace eval Fiber {
	variable script
	variable scriptParent
	variable scriptRegions [list 1 2 3 4 5 6 7 8 9 10]
}

# Calculate reinforcing bar areas for fiber section (input = diameter)

proc Fiber::CalcReinfBarArea { event args } {

	switch $event {

		SYNC {

				set pi 3.14159265358979323846
				set GDN [lindex $args 0]
				set STRUCT [lindex $args 1]
				set QUESTION [lindex $args 2]

				set check [DWLocalGetValue $GDN $STRUCT $QUESTION]
				set Shape [DWLocalGetValue $GDN $STRUCT "Cross_section"]

				if { $check==1 } {

						if { $Shape == "Rectangular_Column" } {

								set CornerSizeUnit [DWLocalGetValue $GDN $STRUCT Corner_Bar_size]
								set InterSizeUnit [DWLocalGetValue $GDN $STRUCT Middle_Bar_size]

								set temp [GidConvertValueUnit $CornerSizeUnit]
								set temp [ParserNumberUnit $temp CornerSize CornerUnit]

								set temp [GidConvertValueUnit $InterSizeUnit]
								set temp [ParserNumberUnit $temp InterSize InterUnit]

								set CornerArea [format "%1.3e" [expr $pi*($CornerSize*$CornerSize)/4.0]]
								set CornerArea $CornerArea$CornerUnit^2

								set InterArea [format "%1.3e" [expr $pi*($InterSize*$InterSize)/4.0]]
								set InterArea $InterArea$InterUnit^2

								set ok [DWLocalSetValue $GDN $STRUCT Corner_bar_area $CornerArea]
								set ok [DWLocalSetValue $GDN $STRUCT Middle_bar_area $InterArea]
								return ""

						} elseif { $Shape == "Circular_Column" } {

								set SizeUnit [DWLocalGetValue $GDN $STRUCT Bar_size]

								set temp [GidConvertValueUnit $SizeUnit]
								set temp [ParserNumberUnit $temp Size Unit]

								set Area [format "%1.3e" [expr $pi*($Size*$Size)/4.0]]
								set Area $Area$Unit^2
								set ok [DWLocalSetValue $GDN $STRUCT Bar_area $Area]

								return ""
						} elseif { $Shape == "Rectangular_Beam" } {

								set TopBarSizeUnit [DWLocalGetValue $GDN $STRUCT Top_bar_size]
								set BottomBarSizeUnit [DWLocalGetValue $GDN $STRUCT Bottom_bar_size]

								set temp [GidConvertValueUnit $TopBarSizeUnit]
								set temp [ParserNumberUnit $temp TopBarSize TopBarUnit]

								set temp [GidConvertValueUnit $BottomBarSizeUnit]
								set temp [ParserNumberUnit $temp BottomBarSize BottomBarUnit]

								set TopBarArea [format "%1.3e" [expr $pi*($TopBarSize*$TopBarSize)/4.0]]
								set TopBarArea $TopBarArea$TopBarUnit^2

								set BottomBarArea [format "%1.3e" [expr $pi*($BottomBarSize*$BottomBarSize)/4.0]]
								set BottomBarArea $BottomBarArea$BottomBarUnit^2

								set ok [DWLocalSetValue $GDN $STRUCT Top_bar_area $TopBarArea]
								set ok [DWLocalSetValue $GDN $STRUCT Bottom_bar_area $BottomBarArea]

								return ""
						} elseif { $Shape == "Tee_Beam" } {

								set TopWebBarSizeUnit [DWLocalGetValue $GDN $STRUCT Top_beam_bar_size]
								set BottomBarSizeUnit [DWLocalGetValue $GDN $STRUCT Bottom_beam_bar_size]
								set TopSlabBarSizeUnit [DWLocalGetValue $GDN $STRUCT Slab_bar_size]

								set temp [GidConvertValueUnit $TopWebBarSizeUnit]
								set temp [ParserNumberUnit $temp TopWebBarSize TopWebBarUnit]

								set temp [GidConvertValueUnit $BottomBarSizeUnit]
								set temp [ParserNumberUnit $temp BottomBarSize BottomBarUnit]

								set temp [GidConvertValueUnit $TopSlabBarSizeUnit]
								set temp [ParserNumberUnit $temp TopSlabBarSize TopSlabBarUnit]

								set TopWebBarArea [format "%1.3e" [expr $pi*($TopWebBarSize*$TopWebBarSize)/4.0]]
								set TopWebBarArea $TopWebBarArea$TopWebBarUnit^2

								set BottomBarArea [format "%1.3e" [expr $pi*($BottomBarSize*$BottomBarSize)/4.0]]
								set BottomBarArea $BottomBarArea$BottomBarUnit^2

								set TopSlabBarArea [format "%1.3e" [expr $pi*($TopSlabBarSize*$TopSlabBarSize)/4.0]]
								set TopSlabBarArea $TopSlabBarArea$TopSlabBarUnit^2

								set ok [DWLocalSetValue $GDN $STRUCT Top_beam_bar_area $TopWebBarArea]
								set ok [DWLocalSetValue $GDN $STRUCT Bottom_beam_bar_area $BottomBarArea]
								set ok [DWLocalSetValue $GDN $STRUCT Slab_bar_area $TopSlabBarArea]

						} elseif { $Shape == "Bridge_Deck" } {

								set TopSlabBarSizeUnit [DWLocalGetValue $GDN $STRUCT Top_slab_bar_size]
								set BottomSlabBarSizeUnit [DWLocalGetValue $GDN $STRUCT Bottom_slab_bar_size]

								set temp [GidConvertValueUnit $TopSlabBarSizeUnit]
								set temp [ParserNumberUnit $temp TopSlabBarSize BarDiameterUnit]

								set temp [GidConvertValueUnit $BottomSlabBarSizeUnit]
								set temp [ParserNumberUnit $temp BottomSlabBarSize BarDiameterUnit]

								set TopSlabBarArea [format "%1.3e" [expr $pi*($TopSlabBarSize*$TopSlabBarSize)/4.0]]
								set TopSlabBarArea $TopSlabBarArea$BarDiameterUnit^2

								set BottomSlabBarArea [format "%1.3e" [expr $pi*($BottomSlabBarSize*$BottomSlabBarSize)/4.0]]
								set BottomSlabBarArea $BottomSlabBarArea$BarDiameterUnit^2

								set ok [DWLocalSetValue $GDN $STRUCT Top_slab_bar_area $TopSlabBarArea]
								set ok [DWLocalSetValue $GDN $STRUCT Bottom_slab_bar_area $BottomSlabBarArea]

								set includeChecked [DWLocalGetValue $GDN $STRUCT Include_additional_part]

								if {$includeChecked} {

										set AddSlabBarSizeUnit [DWLocalGetValue $GDN $STRUCT Additional_slab_bar_size]
										set BeamBarSizeUnit [DWLocalGetValue $GDN $STRUCT Beam_bar_size]

										set temp [GidConvertValueUnit $AddSlabBarSizeUnit]
										set temp [ParserNumberUnit $temp AddSlabBarSize BarDiameterUnit]

										set temp [GidConvertValueUnit $BeamBarSizeUnit]
										set temp [ParserNumberUnit $temp BeamBarSize BarDiameterUnit]

										set AddSlabBarArea [format "%1.3e" [expr $pi*($AddSlabBarSize*$AddSlabBarSize)/4.0]]
										set AddSlabBarArea $AddSlabBarArea$BarDiameterUnit^2

										set BeamBarArea [format "%1.3e" [expr $pi*($BeamBarSize*$BeamBarSize)/4.0]]
										set BeamBarArea $BeamBarArea$BarDiameterUnit^2

										set ok [DWLocalSetValue $GDN $STRUCT Additional_slab_bar_area $AddSlabBarArea]
										set ok [DWLocalSetValue $GDN $STRUCT Beam_bar_area $BeamBarArea]

								}

						} else {

								return ""

						}
				} else {

				return ""
				}
		}
	}

	return ""
}

proc Fiber::CalcTorsionalStiffness { event args } {

	switch $event {

		SYNC {
				set pi 3.14159265358979323846
				set GDN [lindex $args 0]
				set STRUCT [lindex $args 1]
				set QUESTION [lindex $args 2]

				set check [DWLocalGetValue $GDN $STRUCT "Calculate_torsional_stiffness_(update_to_apply)"]

				if {$check} {

						set Shape [DWLocalGetValue $GDN $STRUCT "Cross_section"]

						set ShearModulus [DWLocalGetValue $GDN $STRUCT "Shear_modulus"]
						set temp [GidConvertValueUnit $ShearModulus]
						set temp [ParserNumberUnit $temp G Gunit]
						set GJunit "kNm^2"

						if { $Shape == "Rectangular_Column" || $Shape == "Rectangular_Beam" } {
								set height [DWLocalGetValue $GDN $STRUCT Height_h]
								set temp [GidConvertValueUnit $height]
								set temp [ParserNumberUnit $temp h dummy]

								set width [DWLocalGetValue $GDN $STRUCT Width_b]
								set temp [GidConvertValueUnit $width]
								set temp [ParserNumberUnit $temp b dummy]

								set a [expr max($h,$b)]
								set b [expr min($h,$b)]

								set J [expr $a*pow($b,3)*(1.0/3-0.21*$b/$a*(1-pow($b,4)/(12*pow($a,4))))]

								set GJ [format "%1.0f" [expr $G*$J]]
								set GJ $GJ$GJunit

								set ok [DWLocalSetValue $GDN $STRUCT Torsional_stiffness $GJ]

						} elseif { $Shape == "Circular_Column" } {

								set diameter [DWLocalGetValue $GDN $STRUCT Diameter_d]
								set temp [GidConvertValueUnit $diameter]
								set temp [ParserNumberUnit $temp d dummy]

								set Iz [expr $pi*pow($d,4)/64]
								set Iy [expr $pi*pow($d,4)/64]

								set J [expr $Iz+$Iy]

								set GJ [format "%1.0f" [expr $G*$J]]
								set GJ $GJ$GJunit

								set ok [DWLocalSetValue $GDN $STRUCT Torsional_stiffness $GJ]

						} elseif { $Shape=="Tee_Beam" } {

								set height [DWLocalGetValue $GDN $STRUCT Height_h]
								set temp [GidConvertValueUnit $height]
								set temp [ParserNumberUnit $temp h dummy]

								set width [DWLocalGetValue $GDN $STRUCT Width_bf]
								set temp [GidConvertValueUnit $width]
								set temp [ParserNumberUnit $temp b dummy]

								set webwidth [DWLocalGetValue $GDN $STRUCT Web_width_bw]
								set temp [GidConvertValueUnit $webwidth]
								set temp [ParserNumberUnit $temp tw dummy]

								set slabthick [DWLocalGetValue $GDN $STRUCT Slab_thickness_hf]
								set temp [GidConvertValueUnit $slabthick]
								set temp [ParserNumberUnit $temp tf dummy]

								set kremasi [expr $h-$tf]

								# does not matter if it is 2D or 3D. Just calculate Torsional constant.
								set Zcm [expr (($tf*$b)*($h-$tf/2)+($kremasi*$tw)*$kremasi/2)/($tf*$b+$kremasi*$tw)]
								set Iy [expr pow($tf,3)*$b/12 + pow($kremasi,3)*$tw/12 + ($tf*$b)*($h-($tf/2)-$Zcm)*($h-($tf/2)-$Zcm)+($kremasi*$tw)*($Zcm-$kremasi/2)*($Zcm-$kremasi/2)]
								set Iz [expr pow($b,3)*$tf/12 + pow($tw,3)*$kremasi/12]

								set J [expr $Iz+$Iy]

								set GJ [format "%1.0f" [expr $G*$J]]
								set GJ $GJ$GJunit

								set ok [DWLocalSetValue $GDN $STRUCT Torsional_stiffness $GJ]
						} else {
								return ""
						}
				}
		}
	}

	return ""
}

# Calculate cross section area
proc Fiber::CalcArea { event args } {

	switch $event {

		SYNC {

				set GDN [lindex $args 0]
				set STRUCT [lindex $args 1]
				set QUESTION [lindex $args 2]

				set CrossSectionType [DWLocalGetValue $GDN $STRUCT Cross_section]

				if {$CrossSectionType == "Rectangular_Beam" || $CrossSectionType == "Rectangular_Column"} {

						set heightUnit [DWLocalGetValue $GDN $STRUCT Width_b]
						set widthUnit [DWLocalGetValue $GDN $STRUCT Height_h]
						set temp [GidConvertValueUnit $widthUnit]
						set temp [ParserNumberUnit $temp width Wunit]
						set temp [GidConvertValueUnit $heightUnit]
						set temp [ParserNumberUnit $temp height Hunit]
						set Areaunit $Hunit^2

						set AreaSize [expr $height*$width]
						set Area $AreaSize$Areaunit
						set ok [DWLocalSetValue $GDN $STRUCT "Cross_section_area" $Area]

				} elseif { $CrossSectionType == "Circular_Column" } {

						set diameterunit [DWLocalGetValue $GDN $STRUCT Diameter_d]
						set temp [GidConvertValueUnit $diameterunit]
						set temp [ParserNumberUnit $temp diameter Dunit]
						set diameter [format "%f" $diameter]

						set Areaunit $Dunit^2

						set AreaSize [expr 3.14159265359*$diameter*$diameter/4]
						set Area $AreaSize$Areaunit
						set ok [DWLocalSetValue $GDN $STRUCT "Cross_section_area" $Area]

				} elseif { $CrossSectionType == "Tee_Beam" } {

						set heightUnit [DWLocalGetValue $GDN $STRUCT Height_h]
						set widthUnit [DWLocalGetValue $GDN $STRUCT Width_bf]
						set SlabThickUnit [DWLocalGetValue $GDN $STRUCT Slab_thickness_hf]
						set WebThickUnit [DWLocalGetValue $GDN $STRUCT Web_width_bw]

						set temp [GidConvertValueUnit $widthUnit]
						set temp [ParserNumberUnit $temp w Wunit]
						set temp [GidConvertValueUnit $heightUnit]
						set temp [ParserNumberUnit $temp h Hunit]
						set temp [GidConvertValueUnit $SlabThickUnit]
						set temp [ParserNumberUnit $temp ts tsUnit]
						set temp [GidConvertValueUnit $WebThickUnit]
						set temp [ParserNumberUnit $temp tw twUnit]

						set Areaunit $Hunit^2

						set AreaSize [expr $w*$ts+($h-$ts)*$tw]
						set Area $AreaSize$Areaunit
						set ok [DWLocalSetValue $GDN $STRUCT "Cross_section_area" $Area]

				} elseif {$CrossSectionType == "Bridge_Deck"} {

						set wtunit [DWLocalGetValue $GDN $STRUCT Top_slab_width_wt]
						set wbunit [DWLocalGetValue $GDN $STRUCT Bottom_slab_width_wb]
						set ts1unit [DWLocalGetValue $GDN $STRUCT Top_slab_thickness_ts1]
						set ts2unit [DWLocalGetValue $GDN $STRUCT Bottom_slab_thickness_ts2]
						set hvunit [DWLocalGetValue $GDN $STRUCT Height_hv]

						set temp [GidConvertValueUnit $wtunit]
						set temp [ParserNumberUnit $temp wt Wunit]
						set temp [GidConvertValueUnit $wbunit]
						set temp [ParserNumberUnit $temp wb Wunit]
						set temp [GidConvertValueUnit $ts1unit]
						set temp [ParserNumberUnit $temp ts1 Wunit]
						set temp [GidConvertValueUnit $ts2unit]
						set temp [ParserNumberUnit $temp ts2 Wunit]
						set temp [GidConvertValueUnit $hvunit]
						set temp [ParserNumberUnit $temp hv Wunit]

						set Areaunit $Wunit^2

						set includeChecked [DWLocalGetValue $GDN $STRUCT Include_additional_part]
						set SolidChecked [DWLocalGetValue $GDN $STRUCT Solid_Section]

						if {$includeChecked} {

								set ts3unit [DWLocalGetValue $GDN $STRUCT Additional_slab_thickness_ts3]
								set ts4unit [DWLocalGetValue $GDN $STRUCT Sidewalk_thickness_ts4]
								set bswunit [DWLocalGetValue $GDN $STRUCT Sidewalk_width_bsw]
								set bunit [DWLocalGetValue $GDN $STRUCT Beam_width_b]
								set hunit [DWLocalGetValue $GDN $STRUCT Beam_height_h]

								set temp [GidConvertValueUnit $ts3unit]
								set temp [ParserNumberUnit $temp ts3 Wunit]
								set temp [GidConvertValueUnit $ts4unit]
								set temp [ParserNumberUnit $temp ts4 Wunit]
								set temp [GidConvertValueUnit $bswunit]
								set temp [ParserNumberUnit $temp bsw Wunit]
								set temp [GidConvertValueUnit $bunit]
								set temp [ParserNumberUnit $temp b Wunit]
								set temp [GidConvertValueUnit $hunit]
								set temp [ParserNumberUnit $temp h Wunit]

								if {$SolidChecked} {

										set AreaSize [expr $wb*$hv+$wb*$ts2+$wt*$ts1+$b*$h*2+$wt*$ts3+2*$ts4*$bsw]
										set Area $AreaSize$Areaunit

										set ok [DWLocalSetValue $GDN $STRUCT Cross_section_area $Area]

								} else {

										set twunit [DWLocalGetValue $GDN $STRUCT External_web_thickness_tw]
										set dvunit [DWLocalGetValue $GDN $STRUCT Void_width_dv]

										set temp [GidConvertValueUnit $twunit]
										set temp [ParserNumberUnit $temp tw Wunit]
										set temp [GidConvertValueUnit $dvunit]
										set temp [ParserNumberUnit $temp dv Wunit]

										set nvoids [DWLocalGetValue $GDN $STRUCT Number_of_voids]
										set nvoids [expr int($nvoids)]
										set nintwebs [expr $nvoids-1]
										set intwebthick [expr $wb-2*$tw-$nvoids*$dv]
										set AreaSize [expr $wb*$ts2+$nintwebs*$intwebthick*$hv+2*$tw*$h+$wt*$ts1+$wt*$ts3+2*$bsw*$ts4+2*$b*$h]
										set Area $AreaSize$Areaunit

										set ok [DWLocalSetValue $GDN $STRUCT Cross_section_area $Area]
								}

								# not including additional part
						} else {

								if {$SolidChecked} {

										set AreaSize [expr $wb*$hv+$wb*$ts2+$wt*$ts1]
										set Area $AreaSize$Areaunit

										set ok [DWLocalSetValue $GDN $STRUCT Cross_section_area $Area]

								} else {

										set twunit [DWLocalGetValue $GDN $STRUCT External_web_thickness_tw]
										set dvunit [DWLocalGetValue $GDN $STRUCT Void_width_dv]

										set temp [GidConvertValueUnit $twunit]
										set temp [ParserNumberUnit $temp tw Wunit]
										set temp [GidConvertValueUnit $dvunit]
										set temp [ParserNumberUnit $temp dv Wunit]

										set nvoids [DWLocalGetValue $GDN $STRUCT Number_of_voids]
										set nvoids [expr int($nvoids)]
										set nintwebs [expr $nvoids-1]
										set intwebthick [expr $wb-2*$tw-$nvoids*$dv]
										set AreaSize [expr $wb*$ts2+$nintwebs*$intwebthick*$hv+2*$tw*$hv+$wt*$ts1]
										set Area $AreaSize$Areaunit

										set ok [DWLocalSetValue $GDN $STRUCT Cross_section_area $Area]
								}
						}

				} else {

						return ""
				}

						return ""
		}
	}

	return ""
}

proc Fiber::SuggestFibers { event args } {

	switch $event {

		INIT {

				return ""

		}

		SYNC {

				set GDN [lindex $args 0]
				set STRUCT [lindex $args 1]
				set QUESTION [lindex $args 2]
				set ndm [OpenSees::ReturnProjectDimensions]
				set check [DWLocalGetValue $GDN $STRUCT $QUESTION]
				set Shape [DWLocalGetValue $GDN $STRUCT "Cross_section"]

				if { $check==1 } {

						switch $Shape {

								"Rectangular_Column" {

										set heightUnit [DWLocalGetValue $GDN $STRUCT "Height_h"]
										set widthUnit [DWLocalGetValue $GDN $STRUCT "Width_b"]
										set temp [GidConvertValueUnit $heightUnit]
										set temp [ParserNumberUnit $temp height dummy]
										set temp [GidConvertValueUnit $widthUnit]
										set temp [ParserNumberUnit $temp width dummy]

										switch $ndm {

												"3" {

														if { $height >= $width } {
																set Fibers_z [roundUp [expr 15*$height/$width] ]
																set Fibers_y 15

														} elseif { $height<$width } {

																set Fibers_y [roundUp [expr 15*$height/$width] ]
																set Fibers_z 15

														} else {
																return ""
														}
												}
												"2" {

														if { $height >= $width } {
																set Fibers_y [roundUp [expr 15*$height/$width] ]
																set Fibers_z 15

														} elseif { $height<$width } {

																set Fibers_z [roundUp [expr 15*$height/$width] ]
																set Fibers_y 15

														} else {
																return ""
														}
												}
										}

										set ok [DWLocalSetValue $GDN $STRUCT Fibers_in_local_z_direction $Fibers_z]
										set ok [DWLocalSetValue $GDN $STRUCT Fibers_in_local_y_direction $Fibers_y]
								}

								"Rectangular_Beam" {

										set heightUnit [DWLocalGetValue $GDN $STRUCT "Height_h"]
										set widthUnit [DWLocalGetValue $GDN $STRUCT "Width_b"]
										set temp [GidConvertValueUnit $heightUnit]
										set temp [ParserNumberUnit $temp height dummy]
										set temp [GidConvertValueUnit $widthUnit]
										set temp [ParserNumberUnit $temp width dummy]

										set TopBars [DWLocalGetValue $GDN $STRUCT "Top_bars"]
										set BottomBars [DWLocalGetValue $GDN $STRUCT "Bottom_bars"]

										# Height may be greater than width for Beam
										if { $height >= $width } {
												switch $ndm {

														"3" {

																set Fibers_y [expr {4*max($TopBars,$BottomBars)}]
																set Fibers_z [expr $Fibers_y*$height/$width]

														}
														"2" {

																set Fibers_z [expr {4*max($TopBars,$BottomBars)}]
																set Fibers_y [expr $Fibers_z*$height/$width]

														}
												}
										set ok [DWLocalSetValue $GDN $STRUCT Fibers_in_local_z_direction [roundUp $Fibers_z]]
										set ok [DWLocalSetValue $GDN $STRUCT Fibers_in_local_y_direction [roundUp $Fibers_y]]
										}
								}

								"Circular_Column" {

										set ok [DWLocalSetValue $GDN $STRUCT Fibers_in_the_circumferential_direction 15]
										set ok [DWLocalSetValue $GDN $STRUCT Fibers_in_the_radial_direction 15]

								}

								"Tee_Beam" {

										set heightUnit [DWLocalGetValue $GDN $STRUCT "Height_h"]
										set widthUnit [DWLocalGetValue $GDN $STRUCT "Width_bf"]
										set temp [GidConvertValueUnit $heightUnit]
										set temp [ParserNumberUnit $temp height dummy]
										set temp [GidConvertValueUnit $widthUnit]
										set temp [ParserNumberUnit $temp width dummy]

										set TopBars [DWLocalGetValue $GDN $STRUCT "Top_beam_bars"]
										set BottomBars [DWLocalGetValue $GDN $STRUCT "Bottom_beam_bars"]
										set TopSlabBars [DWLocalGetValue $GDN $STRUCT "Slab_bars"]

												switch $ndm {

														"3" {

																set Fibers_y [expr {max(8*$TopBars,8*$BottomBars,10*$width,20)}]
																set Fibers_z [expr {max($Fibers_y*$height/$width,10*$height,15)}]

														}
														"2" {

																set Fibers_z [expr {max(8*$TopBars,8*$BottomBars,10*$width,20)}]
																set Fibers_y [expr {max($Fibers_z*$height/$width,10*$height,15)}]
														}
												}
										set ok [DWLocalSetValue $GDN $STRUCT Fibers_in_local_z_direction [roundUp $Fibers_z]]
										set ok [DWLocalSetValue $GDN $STRUCT Fibers_in_local_y_direction [roundUp $Fibers_y]]
								}

								"Bridge_Deck" {

										set wtunit [DWLocalGetValue $GDN $STRUCT Top_slab_width_wt]
										set wbunit [DWLocalGetValue $GDN $STRUCT Bottom_slab_width_wb]
										set ts1unit [DWLocalGetValue $GDN $STRUCT Top_slab_thickness_ts1]
										set ts2unit [DWLocalGetValue $GDN $STRUCT Bottom_slab_thickness_ts2]
										set hvunit [DWLocalGetValue $GDN $STRUCT Height_hv]

										set temp [GidConvertValueUnit $wtunit]
										set temp [ParserNumberUnit $temp wt dummy]
										set temp [GidConvertValueUnit $wbunit]
										set temp [ParserNumberUnit $temp wb dummy]
										set temp [GidConvertValueUnit $ts1unit]
										set temp [ParserNumberUnit $temp ts1 dummy]
										set temp [GidConvertValueUnit $ts2unit]
										set temp [ParserNumberUnit $temp ts2 dummy]
										set temp [GidConvertValueUnit $hvunit]
										set temp [ParserNumberUnit $temp hv dummy]

										set FibersTopSlabWidth [expr 10*$wt]
										set FibersTopSlabWidth [roundUp $FibersTopSlabWidth]

										set FibersTopSlabThickness [expr {max(10*$ts1,5)}]
										set FibersTopSlabThickness [roundUp $FibersTopSlabThickness]

										set FibersBotSlabWidth [expr 10*$wb]
										set FibersBotSlabWidth [roundUp $FibersBotSlabWidth]

										set FibersBotSlabThickness [expr {max(10*$ts2,5)}]
										set FibersBotSlabThickness [roundUp $FibersBotSlabThickness]

										set FibersWebHeight [expr {max(10*$hv,10)}]
										set FibersWebHeight [roundUp $FibersWebHeight]

										# change values
										set ok [DWLocalSetValue $GDN $STRUCT Fibers_along_top_slab_width $FibersTopSlabWidth]
										set ok [DWLocalSetValue $GDN $STRUCT Fibers_along_top_slab_thickness $FibersTopSlabThickness]
										set ok [DWLocalSetValue $GDN $STRUCT Fibers_along_bottom_slab_width $FibersBotSlabWidth]
										set ok [DWLocalSetValue $GDN $STRUCT Fibers_along_bottom_slab_thickness $FibersBotSlabThickness]
										set ok [DWLocalSetValue $GDN $STRUCT Fibers_along_web_height $FibersWebHeight]

										set SolidChecked [DWLocalGetValue $GDN $STRUCT Solid_Section]
										set nvoids [DWLocalGetValue $GDN $STRUCT Number_of_voids]

										if {$SolidChecked} {

												set FibersExtWebThickness [expr 5*$wb]
												set FibersExtWebThickness [roundUp $FibersExtWebThickness]
												set ok [DWLocalSetValue $GDN $STRUCT Fibers_along_external_web_thickness $FibersExtWebThickness]

										} else {

												set twunit [DWLocalGetValue $GDN $STRUCT External_web_thickness_tw]
												set dvunit [DWLocalGetValue $GDN $STRUCT Void_width_dv]

												set temp [GidConvertValueUnit $twunit]
												set temp [ParserNumberUnit $temp tw dummy]
												set temp [GidConvertValueUnit $dvunit]
												set temp [ParserNumberUnit $temp dv dummy]

												# internal web thickness
												set inttw [expr $wb-2*$tw-$nvoids*$dv]

												set FibersExtWebThickness [expr {max(10*$tw,5)}]
												set FibersExtWebThickness [roundUp $FibersExtWebThickness]

												set FibersIntWebThickness [expr {max(10*$inttw,5)}]
												set FibersIntWebThickness [roundUp $FibersIntWebThickness]

												set ok [DWLocalSetValue $GDN $STRUCT Fibers_along_external_web_thickness $FibersExtWebThickness]
												set ok [DWLocalSetValue $GDN $STRUCT Fibers_along_internal_web_thickness $FibersIntWebThickness]

										}

										set includeChecked [DWLocalGetValue $GDN $STRUCT Include_additional_part]

										if {$includeChecked} {

												set bunit [DWLocalGetValue $GDN $STRUCT Beam_width_b]
												set hunit [DWLocalGetValue $GDN $STRUCT Beam_height_h]

												set temp [GidConvertValueUnit $bunit]
												set temp [ParserNumberUnit $temp b dummy]
												set temp [GidConvertValueUnit $hunit]
												set temp [ParserNumberUnit $temp h dummy]

												set FibersBeamHeight [expr {max(10*$h,5)}]
												set FibersBeamHeight [roundUp $FibersBeamHeight]

												set FibersBeamWidth [expr {max(10*$b,5)}]
												set FibersBeamWidth [roundUp $FibersBeamWidth]

												set ok [DWLocalSetValue $GDN $STRUCT Fibers_along_beam_height $FibersBeamHeight]
												set ok [DWLocalSetValue $GDN $STRUCT Fibers_along_beam_width $FibersBeamWidth]

										}
								}
						}
				}
		}
	}

	return ""
}

proc Fiber::CheckFieldValues { event args } {

	switch $event {

		SYNC {

				set GDN [lindex $args 0]
				set STRUCT [lindex $args 1]
				set QUESTION [lindex $args 2]

				# List of concrete uniaxial materials that can be used for core/cover material of Fiber Section
				set CompatibleConcreteMaterials " \
				Concrete01 \
				Concrete02 \
				Concrete04 \
				Concrete06 \
				ConcreteCM \
				InitStrain \
				InitStress \
				MinMax \
				"

				# List of steel uniaxial materials that can be used for reinforcing bar material of Fiber Section
				set CompatibleSteelMaterials " \
				Steel01 \
				Steel02 \
				ReinforcingSteel \
				RamberOsgoodSteel \
				Hysteretic \
				MinMax \
				"

				set CrossSection [DWLocalGetValue $GDN $STRUCT "Cross_section"]

				# Check material options

				if { $CrossSection != "Bridge_Deck" } {

						set ChosenCoreMaterial [DWLocalGetValue $GDN $STRUCT "Core_material"]
						set ChosenCoverMaterial [DWLocalGetValue $GDN $STRUCT "Cover_material"]
						set ChosenBarMaterial [DWLocalGetValue $GDN $STRUCT "Reinforcing_Bar_material"]

						#GiD_AccessValue get materials : Search the value of a field of a material.
						# $ChosenSection is the material name
						# Section: is the question name of the Section $ChosenSection

						#CoreMatType is the value of the field: material: of the chosen material from the combo box!

						if {![catch {GiD_AccessValue get materials $ChosenCoreMaterial "Material:"}]} {

							set CoreMatType [GiD_AccessValue get materials $ChosenCoreMaterial "Material:"]

							if { [lsearch $CompatibleConcreteMaterials $CoreMatType]==-1 } {

								WarnWinText "Uncompatible Core material ($CoreMatType) selected for Fiber Section"
								DWLocalSetValue $GDN $STRUCT "Core_material" "Concrete04_(Popovics_concrete)"

							}

						} else {

							WarnWinText "Uncompatible Core material selected for Fiber Section"
							DWLocalSetValue $GDN $STRUCT "Core_material" "Concrete04_(Popovics_concrete)"

						}

						if {![catch {GiD_AccessValue get materials $ChosenCoverMaterial "Material:"}]} {

							set CoverMatType [GiD_AccessValue get materials $ChosenCoverMaterial "Material:"]

							if { [lsearch $CompatibleConcreteMaterials $CoverMatType]==-1 } {

								WarnWinText "Uncompatible Cover material ($CoverMatType) selected for Fiber Section"
								DWLocalSetValue $GDN $STRUCT "Cover_material" "Concrete04_(Popovics_concrete)"

							}

						} else {

							WarnWinText "Uncompatible Cover material selected for Fiber Section"
							DWLocalSetValue $GDN $STRUCT "Cover_material" "Concrete04_(Popovics_concrete)"

						}

						if {![catch {GiD_AccessValue get materials $ChosenBarMaterial "Material:"}]} {

							set BarMatType [GiD_AccessValue get materials $ChosenBarMaterial "Material:"]

							if { [lsearch $CompatibleSteelMaterials $BarMatType]==-1 } {

								WarnWinText "Uncompatible Reinforcing bar material ($BarMatType) selected for Fiber Section"

							}
						} else {

							WarnWinText "Uncompatible Reinforcing bar material selected for Fiber Section"

						}

				} else {

						set ChosenMainConcrete [DWLocalGetValue $GDN $STRUCT "Main_section_material"]
						set ChosenTopBarMaterial [DWLocalGetValue $GDN $STRUCT "Top_slab_reinforcing_bar_material"]
						set ChosenBotBarMaterial [DWLocalGetValue $GDN $STRUCT "Bottom_slab_reinforcing_bar_material"]

						if {![catch {GiD_AccessValue get materials $ChosenMainConcrete "Material:"}]} {

							set MainConcreteType [GiD_AccessValue get materials $ChosenMainConcrete "Material:"]

							if { [lsearch $CompatibleConcreteMaterials $MainConcreteType]==-1 } {

								WarnWinText "Uncompatible concrete material ($MainConcreteType) selected for Fiber Section"
								DWLocalSetValue $GDN $STRUCT "Main_section_material" "Concrete04_(Popovics_concrete)"

							}

						} else {

							WarnWinText "Uncompatible concrete material selected for Fiber Section"
							DWLocalSetValue $GDN $STRUCT "Main_section_material" "Concrete04_(Popovics_concrete)"

						}

						if {![catch {GiD_AccessValue get materials $ChosenTopBarMaterial "Material:"}]} {

							set TopBarMatType [GiD_AccessValue get materials $ChosenTopBarMaterial "Material:"]

							if { [lsearch $CompatibleSteelMaterials $TopBarMatType]==-1 } {

								WarnWinText "Uncompatible steel material ($TopBarMatType) selected for Fiber Section"
								DWLocalSetValue $GDN $STRUCT "Top_slab_reinforcing_bar_material" "Steel01"

							}

						} else {

							WarnWinText "Uncompatible steel material selected for Fiber Section"
							DWLocalSetValue $GDN $STRUCT "Top_slab_reinforcing_bar_material" "Steel01"

						}

						if {![catch {GiD_AccessValue get materials $ChosenBotBarMaterial "Material:"}]} {

							set BotBarMatType [GiD_AccessValue get materials $ChosenBotBarMaterial "Material:"]

							if { [lsearch $CompatibleSteelMaterials $BotBarMatType]==-1 } {

								WarnWinText "Uncompatible steel material ($BotBarMatType) selected for Fiber Section"
								DWLocalSetValue $GDN $STRUCT "Bottom_slab_reinforcing_bar_material" "Steel01"

							}

						} else {

							WarnWinText "Uncompatible steel material selected for Fiber Section"
							DWLocalSetValue $GDN $STRUCT "Bottom_slab_reinforcing_bar_material" "Steel01"

						}

						set includeChecked [DWLocalGetValue $GDN $STRUCT "Include_additional_part"]

						if {$includeChecked} {

								set ChosenAddConcrete [DWLocalGetValue $GDN $STRUCT "Additional_part_material"]
								set ChosenAddSlabBarMaterial [DWLocalGetValue $GDN $STRUCT "Additional_slab_reinforcing_bar_material"]
								set ChosenBeamBarMaterial [DWLocalGetValue $GDN $STRUCT "Beam_reinforcing_bar_material"]

								set AddConcreteType [GiD_AccessValue get materials $ChosenAddConcrete "Material:"]
								set AddSlabBarType [GiD_AccessValue get materials $ChosenAddSlabBarMaterial "Material:"]
								set BeamBarType [GiD_AccessValue get materials $ChosenBeamBarMaterial "Material:"]

								if { [lsearch $CompatibleConcreteMaterials $AddConcreteType]==-1 } {

								WarnWinText "Uncompatible concrete material ($AddConcreteType) selected for Fiber Section"
								DWLocalSetValue $GDN $STRUCT "Additional_part_material" "Concrete04_(Popovics_concrete)"

								}

								if { [lsearch $CompatibleSteelMaterials $AddSlabBarType]==-1 } {

								WarnWinText "Uncompatible steel material ($AddSlabBarType) selected for Fiber Section"
								DWLocalSetValue $GDN $STRUCT "Top_slab_reinforcing_bar_material" "Steel01"

								}

								if { [lsearch $CompatibleSteelMaterials $BeamBarType]==-1 } {

								WarnWinText "Uncompatible steel material ($BeamBarType) selected for Fiber Section"
								DWLocalSetValue $GDN $STRUCT "Beam_reinforcing_bar_material" "Steel01"

						}

						}

				}

				# Check if number of bars are integer and slab bars even
				if {$CrossSection == "Rectangular_Column" } {
						set BarsZface [DWLocalGetValue $GDN $STRUCT "Bars_along_z_axis_face"]
						set BarsYface [DWLocalGetValue $GDN $STRUCT "Bars_along_y_axis_face"]
						set IntBarsZface [expr int($BarsZface)]
						set IntBarsYface [expr int($BarsYface)]
						set remainderz [expr fmod($BarsZface,2)]
						set remaindery [expr fmod($BarsYface,2)]
						if {$BarsZface != $IntBarsZface || $BarsYface != $IntBarsYface} {
								WarnWinText "Warning: Number of bars must be integer."
						}

				} elseif {$CrossSection == "Rectangular_Beam"} {
						set TopBars [DWLocalGetValue $GDN $STRUCT "Top_bars"]
						set BottomBars [DWLocalGetValue $GDN $STRUCT "Bottom_bars"]
						set IntTopBars [expr int($TopBars)]
						set IntBottomBars [expr int($BottomBars)]
						if {$TopBars != $IntTopBars || $BottomBars != $IntBottomBars} {
								WarnWinText "Warning: Number of bars must be integer."
						}
				} elseif {$CrossSection == "Tee_Beam"} {
						set TopBeamBars [DWLocalGetValue $GDN $STRUCT "Top_Beam_bars"]
						set BottomBeamBars [DWLocalGetValue $GDN $STRUCT "Bottom_beam_bars"]
						set SlabBars [DWLocalGetValue $GDN $STRUCT "Slab_bars"]
						set IntTopBeamBars [expr int($TopBeamBars)]
						set IntBottomBeamBars [expr int($BottomBeamBars)]
						set IntSlabBars [expr int($SlabBars)]
						set remainder [expr fmod($SlabBars,2)]
						if {$TopBeamBars != $IntTopBeamBars || $BottomBeamBars != $IntBottomBeamBars || $SlabBars != $IntSlabBars} {
								WarnWinText "Warning: Number of bars must be integer"
						}
						if {$remainder != 0} {
								WarnWinText "Warning: Number of slab bars must be even"
						}
				} elseif {$CrossSection == "Circular_Column"} {
						set Bars [DWLocalGetValue $GDN $STRUCT "Bars_along_arc"]
						set IntBars [expr int($Bars)]

						if {$Bars != $IntBars} {
								WarnWinText "Warning: Number of bars must be integer"
						}

				} elseif {$CrossSection == "Bridge_Deck"} {

						set wbSizeUnit [DWLocalGetValue $GDN $STRUCT Bottom_slab_width_wb]
						set wtSizeUnit [DWLocalGetValue $GDN $STRUCT Top_slab_width_wt]
						set ts1SizeUnit [DWLocalGetValue $GDN $STRUCT Top_slab_thickness_ts1]
						set ts2SizeUnit [DWLocalGetValue $GDN $STRUCT Bottom_slab_thickness_ts2]
						set hvSizeUnit [DWLocalGetValue $GDN $STRUCT Height_hv]

						set temp [GidConvertValueUnit $wbSizeUnit]
						set temp [ParserNumberUnit $temp wbSize Lunit]
						set temp [GidConvertValueUnit $wtSizeUnit]
						set temp [ParserNumberUnit $temp wtSize Lunit]
						set temp [GidConvertValueUnit $ts1SizeUnit]
						set temp [ParserNumberUnit $temp ts1Size Lunit]
						set temp [GidConvertValueUnit $ts2SizeUnit]
						set temp [ParserNumberUnit $temp ts2Size Lunit]
						set temp [GidConvertValueUnit $hvSizeUnit]
						set temp [ParserNumberUnit $temp hvSize Lunit]

						if {$wtSize < $wbSize} {

								WarnWinText "Warning: Top slab width wt must be greater or equal to Bottom slab's width wb."
								set wtSize [format "%g" $wbSize]
								set wt $wtSize$Lunit
								set ok [DWLocalSetValue $GDN $STRUCT Top_slab_width_wt $wt]

						}

						set SolidChecked [DWLocalGetValue $GDN $STRUCT Solid_Section]
						set nvoids [DWLocalGetValue $GDN $STRUCT Number_of_voids]
						set dvSizeUnit [DWLocalGetValue $GDN $STRUCT Void_width_dv]
						set exttwSizeUnit [DWLocalGetValue $GDN $STRUCT External_web_thickness_tw]

						set temp [GidConvertValueUnit $dvSizeUnit]
						set temp [ParserNumberUnit $temp dvSize Lunit]
						set temp [GidConvertValueUnit $exttwSizeUnit]
						set temp [ParserNumberUnit $temp exttwSize Lunit]

						set halfwbSize [format "%f" [expr $wbSize/2]]

						if {($nvoids==0 || $dvSize==0 || $exttwSize>=$halfwbSize) && $SolidChecked==0} {

								WarnWinText "Warning: Some field values corresponds to a solid section. Section is assumed as solid."
								set ok [DWLocalSetValue $GDN $STRUCT Solid_Section 1]

						}
				}
				return ""
		}

		CLOSE {

			UpdateInfoBar

		}
	}

	return ""
}

# control the field dependencies when "include additional part" checkbox is restored or hidden

proc Fiber::BridgeDeck_IncludeAddPart { event args } {

	switch $event {

	DEPEND {

		lassign $args GDN STRUCT QUESTION ACTION VALUE

		if { $ACTION == "RESTORE" } {

				set checked [DWLocalGetValue $GDN $STRUCT $QUESTION]

				# if checkbox was on, restore the fields below
				if {$checked} {

						set dummy [TK_DWSet $GDN $STRUCT Additional_slab_thickness_ts3 "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT Sidewalk_width_bsw "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT Sidewalk_thickness_ts4 "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT Beam_width_b "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT Beam_height "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT Fibers_along_beam_height "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT Fibers_along_beam_width "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT Bars_on_top_layer_of_additional_slab "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT Bars_on_bottom_layer_of_additional_slab "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT Bars_along_beam_height "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT Bars_along_beam_width "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT Additional_slab_bar_size "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT Beam_bar_size "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT Additional_slab_bar_area "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT Beam_bar_area "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT Additional_part_material "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT Additional_slab_reinforcing_bar_material "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT Beam_reinforcing_bar_material "#CURRENT#" normal]
				}

		} elseif { $ACTION == "HIDE" } {

						set dummy [TK_DWSet $GDN $STRUCT Additional_slab_thickness_ts3 "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT Sidewalk_width_bsw "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT Sidewalk_thickness_ts4 "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT Beam_width_b "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT Beam_height "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT Fibers_along_beam_height "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT Fibers_along_beam_width "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT Bars_on_top_layer_of_additional_slab "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT Bars_on_bottom_layer_of_additional_slab "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT Bars_along_beam_height "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT Bars_along_beam_width "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT Additional_slab_bar_size "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT Beam_bar_size "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT Additional_slab_bar_area "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT Beam_bar_area "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT Additional_part_material "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT Additional_slab_reinforcing_bar_material "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT Beam_reinforcing_bar_material "#CURRENT#" hidden]

		}
	}
	}

	return ""
}

# Control the field dependencies when "Solid Section" checkbox is restored or hidden

proc Fiber::BridgeDeck_Solid {event args} {

	switch $event {

		DEPEND {

				lassign $args GDN STRUCT QUESTION ACTION VALUE

				if { $ACTION == "RESTORE" } {

						set checked [DWLocalGetValue $GDN $STRUCT $QUESTION]

						if {$checked} {
								set dummy [TK_DWSet $GDN $STRUCT Void_width_dv "#CURRENT#" normal]
								set dummy [TK_DWSet $GDN $STRUCT Number_of_voids "#CURRENT#" normal]

								set dummy [TK_DWSet $GDN $STRUCT Void_width_dv "#CURRENT#" disabled]
								set dummy [TK_DWSet $GDN $STRUCT Number_of_voids "#CURRENT#" disabled]

						} else {

								set dummy [TK_DWSet $GDN $STRUCT Void_width_dv "#CURRENT#" normal]
								set dummy [TK_DWSet $GDN $STRUCT Number_of_voids "#CURRENT#" normal]

						}

				} elseif { $ACTION == "HIDE" } {

						set dummy [TK_DWSet $GDN $STRUCT Void_width_dv "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT Number_of_voids "#CURRENT#" hidden]

				}
		}
	}

	return ""
}

set ::FiberCustomVisited 0

proc Fiber::Script { event args } {

	variable script
	variable scriptParent
	variable scriptRegions

	switch $event {

		INIT {
				global FiberCustomVisited
				set FiberCustomVisited 1
				set data [GiD_Info Project]
				set ProjectName [lindex $data 1]

				set PARENT [lindex $args 0]
				upvar [lindex $args 1] ROW
				set GDN [lindex $args 2]
				set STRUCT [lindex $args 3]
				set QUESTION [lindex $args 4]
				#WarnWinText "Row: $ROW"
				#WarnWinText "QUESTION: $QUESTION"
				#WarnWinText "GDN : $GDN"
				#WarnWinText "Struct : $STRUCT"
				set MaterialName [lindex [split $STRUCT {,}] 1]
				set MaterialTag [FindMaterialNumber $MaterialName]
				set RegionNumber [expr $ROW/3-1]
				set scriptParent($MaterialName) $PARENT

				OpenSees::SetProjectNameAndPath
				set GiDProjectDir [OpenSees::GetProjectPath]

				if { $ProjectName != "UNNAMED" } {

						set filename [Fiber::GetScriptName $MaterialName $RegionNumber]
						set filepath [file join $GiDProjectDir Scripts $filename]
						set fexist [file exists $filepath]

						if { $fexist } {

							set fp [open $filepath r]
							set text [read $fp]
							set ok [Fiber::SetScript $MaterialName $RegionNumber $text]
						close $fp

						} else {

							set text ""
							set ok [Fiber::SetScript $MaterialName $RegionNumber $text]; # initializing

						}

				} else {

					#WarnWinText "[info exists script]"
					#WarnWinText "[info exists script($MaterialTag,$RegionNumber]"
					#WarnWinText "[info exists Fiber::script]"
					#WarnWinText "[info exists Fiber::script($MaterialTag,$RegionNumber]"

					if {![info exists Fiber::script($MaterialName,$RegionNumber)]} {

						set ok [Fiber::SetScript $MaterialName $RegionNumber ""]

					}
				}

				grid [text $PARENT.fiberscript$MaterialName$RegionNumber -width 100 -height 8 -font {Calibri -12} ] -column 1 -row [expr $ROW]
				$PARENT.fiberscript$MaterialName$RegionNumber delete 1.0 end
				$PARENT.fiberscript$MaterialName$RegionNumber insert 1.0 "$script($MaterialName,$RegionNumber)"
		}

		SYNC {
				global FiberCustomVisited
				set GDN [lindex $args 0]
				set STRUCT [lindex $args 1]
				set QUESTION [lindex $args 2]

				set MaterialName [lindex [split $STRUCT {,}] 1]
				set MaterialTag [FindMaterialNumber $MaterialName]

				foreach RegionNumber $scriptRegions {

						if {$FiberCustomVisited} {

							set ok [Fiber::SetScript $MaterialName $RegionNumber ["$scriptParent($MaterialName).fiberscript$MaterialName$RegionNumber" get 1.0 end] ]
							set ok [Fiber::SaveScriptFile $MaterialName $RegionNumber]

						}
				}
		}

		CLOSE {

			global FiberCustomVisited
			set FiberCustomVisited 0

		}

		}

	return ""
}

proc Fiber::SetScript { Material Region text } {
	variable script

	set script($Material,$Region) $text
	return ""
}

proc Fiber::SaveScriptFile { Material Region } {

	variable script

	set data [GiD_Info Project]
	set ProjectName [lindex $data 1]

	OpenSees::SetProjectNameAndPath

	set GiDProjectDir [OpenSees::GetProjectPath]

	set script($Material,$Region) [string trim $script($Material,$Region)]

	if { $ProjectName != "UNNAMED" } {

		set filename [Fiber::GetScriptName $Material $Region]
		set folderpath [file join $GiDProjectDir Scripts]
		set filepath [file join $GiDProjectDir Scripts $filename]

		set fexists [file exists $filepath]
		set folderexists [file exists $folderpath]

		if {!$folderexists} {

			file mkdir [file join $GiDProjectDir Scripts]
		}

		if {$script($Material,$Region) != ""} {

			cd "$GiDProjectDir/Scripts"
			set fp [open $filepath w]
			puts $fp $script($Material,$Region)
			close $fp

		} else {
		# empty textbox
			if {$fexists} {

				file delete -force $filepath

			}
		}
	}

	return ""
}

proc Fiber::FiberCustomFileExists { MaterialName RegionNum } {

	OpenSees::SetProjectNameAndPath

	set GiDProjectDir [OpenSees::GetProjectPath]

	set filename [Fiber::GetScriptName $MaterialName $RegionNum]
	set filepath [file join $GiDProjectDir Scripts $filename]
	set fexists [file exists $filepath]

	if {$fexists} {
		return 1
	}
	return 0
}

proc Fiber::GetScriptName { MaterialName RegionNum } {

	set filename [string map {" " "_"} $MaterialName]
	append filename "_" "$RegionNum" ".tcl"

	return $filename
}