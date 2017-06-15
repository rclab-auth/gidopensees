proc TK_CheckMaterialForElasticBeamColumn { event args } {

	switch $event {

		INIT {

			return ""
		}

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			set ChosenMaterial [DWLocalGetValue $GDN $STRUCT $QUESTION]
			set MatType [GiD_AccessValue get materials $ChosenMaterial "Material:"]

			if { $MatType != "ElasticIsotropic"} {
				WarnWinText "Material $ChosenMaterial ($MatType material) can not be used for beam-column elements."
				WarnWinText "Use an elastic isotropic material instead."

				# Change the value of the field "Material:" to Elastic_Isotropic

				DWLocalSetValue $GDN $STRUCT $QUESTION "Elastic_Isotropic"
			}

			return ""
		}

		DEPEND {

			return ""
		}

		CLOSE {

			return ""
		}
	}

	return ""
}

proc Calculate_Reinf_Areas_for_Fiber { event args } {

	switch $event {

		INIT {

			return ""
		}

		SYNC {

			set pi 3.14159265358979323846
			set GDN  [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			set check [DWLocalGetValue $GDN $STRUCT $QUESTION]
			set Shape [DWLocalGetValue $GDN $STRUCT "Cross_section"]

			if { $check==1 } {

				if { $Shape=="Rectangular_Column" } {

					set CornerSizeUnit [DWLocalGetValue $GDN $STRUCT Corner_Bar_size]
					set InterSizeUnit [DWLocalGetValue $GDN $STRUCT Middle_Bar_size]

					set temp1 [GidConvertValueUnit $CornerSizeUnit]
					set temp1 [ParserNumberUnit $temp1 CornerSize CornerUnit]

					set temp2 [GidConvertValueUnit $InterSizeUnit]
					set temp2 [ParserNumberUnit $temp2 InterSize InterUnit]

					set CornerArea [format "%1.3e" [expr $pi*($CornerSize*$CornerSize)/4.0]]
					set CornerArea $CornerArea$CornerUnit^2

					set InterArea [format "%1.3e" [expr $pi*($InterSize*$InterSize)/4.0]]
					set InterArea $InterArea$InterUnit^2

					set ok [DWLocalSetValue $GDN $STRUCT Corner_bar_area $CornerArea]
					set ok [DWLocalSetValue $GDN $STRUCT Middle_bar_area $InterArea]
					return ""

				} elseif { $Shape=="Circular_Column" } {

					set SizeUnit [DWLocalGetValue $GDN $STRUCT Bar_size]

					set temp [GidConvertValueUnit $SizeUnit]
					set temp [ParserNumberUnit $temp Size Unit]

					set Area [format "%1.3e" [expr $pi*($Size*$Size)/4.0]]
					set Area $Area$Unit^2
					set ok [DWLocalSetValue $GDN $STRUCT Bar_area $Area]

					return ""
				} elseif { $Shape=="Rectangular_Beam" } {

				set TopBarSizeUnit [DWLocalGetValue $GDN $STRUCT Top_bar_size]
				set BottomBarSizeUnit [DWLocalGetValue $GDN $STRUCT Bottom_bar_size]

				set temp1 [GidConvertValueUnit $TopBarSizeUnit]
				set temp1 [ParserNumberUnit $temp1 TopBarSize TopBarUnit]

				set temp2 [GidConvertValueUnit $BottomBarSizeUnit]
				set temp2 [ParserNumberUnit $temp2 BottomBarSize BottomBarUnit]

				set TopBarArea [format "%1.3e" [expr $pi*($TopBarSize*$TopBarSize)/4.0]]
				set TopBarArea $TopBarArea$TopBarUnit^2

				set BottomBarArea [format "%1.3e" [expr $pi*($BottomBarSize*$BottomBarSize)/4.0]]
				set BottomBarArea $BottomBarArea$BottomBarUnit^2

				set ok [DWLocalSetValue $GDN $STRUCT Top_bar_area $TopBarArea]
				set ok [DWLocalSetValue $GDN $STRUCT Bottom_bar_area $BottomBarArea]

				return ""
				} elseif { $Shape=="Tee_Beam" } {

					set TopWebBarSizeUnit [DWLocalGetValue $GDN $STRUCT Top_beam_bar_size]
					set BottomBarSizeUnit [DWLocalGetValue $GDN $STRUCT Bottom_beam_bar_size]
					set TopSlabBarSizeUnit [DWLocalGetValue $GDN $STRUCT Slab_bar_size]

					set temp1 [GidConvertValueUnit $TopWebBarSizeUnit]
					set temp1 [ParserNumberUnit $temp1 TopWebBarSize TopWebBarUnit]

					set temp2 [GidConvertValueUnit $BottomBarSizeUnit]
					set temp2 [ParserNumberUnit $temp2 BottomBarSize BottomBarUnit]

					set temp3 [GidConvertValueUnit $TopSlabBarSizeUnit]
					set temp3 [ParserNumberUnit $temp3 TopSlabBarSize TopSlabBarUnit]

					set TopWebBarArea [format "%1.3e" [expr $pi*($TopWebBarSize*$TopWebBarSize)/4.0]]
					set TopWebBarArea $TopWebBarArea$TopWebBarUnit^2

					set BottomBarArea [format "%1.3e" [expr $pi*($BottomBarSize*$BottomBarSize)/4.0]]
					set BottomBarArea $BottomBarArea$BottomBarUnit^2

					set TopSlabBarArea [format "%1.3e" [expr $pi*($TopSlabBarSize*$TopSlabBarSize)/4.0]]
					set TopSlabBarArea $TopSlabBarArea$TopSlabBarUnit^2

					set ok [DWLocalSetValue $GDN $STRUCT Top_beam_bar_area $TopWebBarArea]
					set ok [DWLocalSetValue $GDN $STRUCT Bottom_beam_bar_area $BottomBarArea]
					set ok [DWLocalSetValue $GDN $STRUCT Slab_bar_area $TopSlabBarArea]

				} else {

					return ""

				}
			} else {

			return ""
			}
		}

		DEPEND {

			return ""
		}

		CLOSE {

			return ""
		}
	}

	return ""
}

proc TK_CalcFiberCrossSectionArea { event args } {

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
			set ok [DWLocalSetValue $GDN $STRUCT "Cross_section_Area" $Area]

			} elseif { $CrossSectionType == "Circular_Column" } {

			set diameterunit [DWLocalGetValue $GDN $STRUCT Diameter_d]
			set temp [GidConvertValueUnit $diameterunit]
			set temp [ParserNumberUnit $temp diameter Dunit]
			set Areaunit $Dunit^2

			set AreaSize [expr 3.14159265359*$diameter*$diameter/4]
			set Area $AreaSize$Areaunit
			set ok [DWLocalSetValue $GDN $STRUCT "Cross_section_Area" $Area]

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
			set ok [DWLocalSetValue $GDN $STRUCT "Cross_section_Area" $Area]

			} else {

			return ""

			}
			return ""
		}
		return ""
	}

	return ""
}

proc TK_CheckSectionForFBC { event args } {

	switch $event {

		INIT {

			return ""
		}

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			# i.e. ChosenMaterial can be Plate_fiber (from combo box "Section" in force based beam column definition)
			set ChosenMaterial [DWLocalGetValue $GDN $STRUCT $QUESTION]

			#GiD_AccessValue get materials : Search the value of a field of a material.
			# $ChosenMaterial is the material name
			# Section: is the question name of the Section $ChosenMaterial
			set SecType [GiD_AccessValue get materials $ChosenMaterial "Section:"]
			#SecType is the value of the question: Section: of the chosen Section from the combo box!

			if { $SecType == "PlateFiber" || $SecType == "ElasticMembranePlate" } {
				WarnWinText "ERROR : Section $ChosenMaterial ($SecType section) can not be used for Force-Based beam-column elements."
				WarnWinText "It has been changed to Fiber section."
				# Change the value of the field "Section:" to Fiber
				DWLocalSetValue $GDN $STRUCT $QUESTION "Fiber"
			}

			return ""
		}

		DEPEND {

			return ""
		}

		CLOSE {

			return ""
		}
	}

	return ""
}

proc TK_CheckSectionForDBC { event args } {

	switch $event {

		INIT {

			return ""
		}

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			# i.e. ChosenMaterial can be Plate_fiber (from combo box "Section" in force based beam column definition)
			set ChosenMaterial [DWLocalGetValue $GDN $STRUCT $QUESTION]

			#GiD_AccessValue get materials : Search the value of a field of a material.
			# $ChosenMaterial is the material name
			# Section: is the question name of the Section $ChosenMaterial
			set SecType [GiD_AccessValue get materials $ChosenMaterial "Section:"]
			#SecType is the value of the question: Section: of the chosen Section from the combo box!

			if { $SecType == "PlateFiber" || $SecType == "ElasticMembranePlate" } {
				WarnWinText "ERROR : Section $ChosenMaterial ($SecType section) can not be used for Displacement-Based beam-column elements."
				WarnWinText "It has been changed to Fiber section."
				# Change the value of the field "Section:" to Fiber
				DWLocalSetValue $GDN $STRUCT $QUESTION "Fiber"
			}

			return ""
		}

		DEPEND {

			return ""
		}

		CLOSE {

			return ""
		}
	}

	return ""
}

proc TK_Suggest_Fibers_for_Fiber_Section { event args } {

	switch $event {

		INIT {

			return ""

		}

		SYNC {

			set GDN  [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]
			set ndm [ReturnProjectDimensions]
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

								if { $height >= $width  } {
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

								if { $height >= $width  } {
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

										set Fibers_y [expr {max(8*$TopBars,8*$BottomBars,20)}]
										set Fibers_z [expr $Fibers_y*$height/$width]

								}
								"2" {

										set Fibers_z [expr {max(8*$TopBars,8*$BottomBars,20)}]
										set Fibers_y [expr $Fibers_z*$height/$width]

								}
							}
						set ok [DWLocalSetValue $GDN $STRUCT Fibers_in_local_z_direction [roundUp $Fibers_z]]
						set ok [DWLocalSetValue $GDN $STRUCT Fibers_in_local_y_direction [roundUp $Fibers_y]]
					}
				}
			}
		}

		CLOSE {

			return ""
		}
	}

	return ""
}

proc TK_CheckFieldValuesForFiber { event args } {

	switch $event {

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			# i.e. ChosenSection can be Elastic_Orthotropic (from combo box "Material" in beam column definition)
			set ChoosedCoreMaterial [DWLocalGetValue $GDN $STRUCT "Core_material"]
			set ChoosedCoverMaterial [DWLocalGetValue $GDN $STRUCT "Cover_material"]
			set ChoosedBarMaterial [DWLocalGetValue $GDN $STRUCT "Reinforcing_Bar_material"]

			#GiD_AccessValue get materials : Search the value of a field of a material.
			# $ChosenSection is the material name
			# Section: is the question name of the Section $ChosenSection
			set CoreMatType [GiD_AccessValue get materials $ChoosedCoreMaterial "Material:"]
			set CoverMatType [GiD_AccessValue get materials $ChoosedCoverMaterial "Material:"]
			set BarMatType [GiD_AccessValue get materials $ChoosedBarMaterial "Material:"]

			#CoreMatType is the value of the field: material: of the chosen material from the combo box!

			if { $BarMatType != "Steel01" && $BarMatType != "ReinforcingSteel" } {
				WarnWinText "ERROR : Material $ChoosedBarMaterial ($BarMatType material) can not be used for fiber sections in this version."
				WarnWinText "It has been changed to Steel01 material."

				DWLocalSetValue $GDN $STRUCT "Reinforcing_Bar_material" "Steel01"
			}

			set CrossSection [DWLocalGetValue $GDN $STRUCT "Cross_section"]

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

			}
			return ""
		}

		CLOSE {

			UpdateInfoBar

		}
	}

	return ""
}

proc TK_GenerateUniaxialConcreteProperties { event args } {

	switch $event {

		INIT {

			return ""
		}

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			set matType [DWLocalGetValue $GDN $STRUCT "Material:"]
			set Class [DWLocalGetValue $GDN $STRUCT "Strength_class"]
			set format [DWLocalGetValue $GDN $STRUCT "Strength_type"]
			set unit "MPa"
			set Eunit "GPa"

			if {$Class != "Custom"} {

				switch $Class {

					"C12/15" {
						set fck -12
						set fctm 1.6
						set fcm -20
						set ec1 -1.8e-3
						set ecu1 -3.5e-3
						set E 27
					}
					"C16/20" {
						set fck -16
						set fcm -24
						set fctm 1.9
						set ec1 -1.8e-3
						set ecu1 -3.5e-3
						set E 29
					}
					"C20/25" {
						set fck -20
						set fcm -28
						set fctm 2.2
						set ec1 -2.0e-3
						set ecu1 -3.5e-3
						set E 30
					}
					"C25/30" {
						set fck -25
						set fcm -33
						set fctm 2.6
						set ec1 -2.1e-3
						set ecu1 -3.5e-3
						set E 31
					}
					"C30/37" {
						set fck -30
						set fcm -38
						set fctm 2.9
						set ec1 -2.2e-3
						set ecu1 -3.5e-3
						set E 33
					}
					"C35/45" {
						set fck -35
						set fcm -43
						set fctm 3.2
						set ec1 -2.25e-3
						set ecu1 -3.5e-3
						set E 34
					}
					"C40/50" {
						set fck -40
						set fcm -48
						set fctm 3.5
						set ec1 -2.3e-3
						set ecu1 -3.5e-3
						set E 35
					}
					"C45/55" {
						set fck -45
						set fcm -53
						set fctm 3.8
						set ec1 -2.4e-3
						set ecu1 -3.5e-3
						set E 36
					}
					"C50/60" {
						set fck -50
						set fcm -58
						set fctm 4.1
						set ec1 -2.45e-3
						set ecu1 -3.5e-3
						set E 37
					}
					"C55/67" {
						set fck -55
						set fcm -63
						set fctm 4.2
						set ec1 -2.5e-3
						set ecu1 -3.2e-3
						set E 38
					}
					"C60/75" {
						set fck -60
						set fcm -68
						set fctm 4.4
						set ec1 -2.6e-3
						set ecu1 -3e-3
						set E 39
					}
					"C70/85" {
						set fck -70
						set fcm -78
						set fctm 4.6
						set ec1 -2.7e-3
						set ecu1 -2.8e-3
						set E 41
					}
					"C80/95" {
						set fck -80
						set fcm -88
						set fctm 4.8
						set ec1 -2.8e-3
						set ecu1 -2.8e-3
						set E 42
					}
					"C90/105" {
						set fck -90
						set fcm -24
						set fctm 5.0
						set ec1 -2.8e-3
						set ecu1 -2.8e-3
						set E 44
					}
				}

				switch $matType {

					"Concrete06" {
						if {$format == "Mean" } {
							set fpcu [expr 0.85*$fcm]
							set ok [DWLocalSetValue $GDN $STRUCT "Concrete_compressive_strength_fc" $fcm$unit]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_at_compressive_strength_e0" $ec1]
							set ok [DWLocalSetValue $GDN $STRUCT "Tensile_strength_fcr" $fctm$unit]
							set a1 [format "%1.3e" [expr $ecu1-$fcm/(2*$fcm/$ec1)]]
							set ok [DWLocalSetValue $GDN $STRUCT "Parameter_a1_for_compressive_plastic_strain_definition" $a1]
							set ecr [format "%1.3e" [expr $fctm/(2*$fcm/$ec1)]]
							set ok [DWLocalSetValue $GDN $STRUCT "Tensile_strain_at_peak_stress_ecr" $ecr]
							set a2 [format "%1.3e" [expr 7*$ecr]]
							set ok [DWLocalSetValue $GDN $STRUCT "Parameter_a2_for_tensile_plastic_strain_definition" $a2]

						} elseif {$format == "Characteristic"} {
							set fpcu [expr 0.85*$fck]
							set ok [DWLocalSetValue $GDN $STRUCT "Concrete_compressive_strength_fc" $fck$unit]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_at_compressive_strength_e0" $ec1]
							set ok [DWLocalSetValue $GDN $STRUCT "Tensile_strength_fcr" $fctm$unit]
							set a1 [format "%1.3e" [expr $ecu1-$fck/(2*$fck/$ec1)]]
							set ok [DWLocalSetValue $GDN $STRUCT "Parameter_a1_for_compressive_plastic_strain_definition" $a1]
							set ecr [format "%1.3e" [expr $fctm/(2*$fck/$ec1)]]
							set ok [DWLocalSetValue $GDN $STRUCT "Tensile_strain_at_peak_stress_ecr" $ecr]
							set a2 [format "%1.3e" [expr 7*$ecr]]
							set ok [DWLocalSetValue $GDN $STRUCT "Parameter_a2_for_tensile_plastic_strain_definition" $a2]
						}
					}
					"Concrete01" {
						if {$format == "Mean" } {
							set fpcu [expr 0.85*$fcm]
							set ok [DWLocalSetValue $GDN $STRUCT "Compressive_strength_fpc" $fcm$unit]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_at_maximum_strength_epsc0" $ec1]
							set ok [DWLocalSetValue $GDN $STRUCT "Crushing_strength_fpcu" $fpcu$unit]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_at_crushing_strength_epscU" $ecu1]
						} elseif {$format == "Characteristic"} {
							set fpcu [expr 0.85*$fck]
							set ok [DWLocalSetValue $GDN $STRUCT "Compressive_strength_fpc" $fck$unit]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_at_maximum_strength_epsc0" $ec1]
							set ok [DWLocalSetValue $GDN $STRUCT "Crushing_strength_fpcu" $fpcu$unit]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_at_crushing_strength_epscU" $ecu1]
						}
					}
					"Concrete02" {
						if {$format == "Mean" } {
							set fpcu [expr 0.85*$fcm]
							set ok [DWLocalSetValue $GDN $STRUCT "Compressive_strength_fpc" $fcm$unit]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_at_maximum_strength_epsc0" $ec1]
							set ok [DWLocalSetValue $GDN $STRUCT "Crushing_strength_fpcu" $fpcu$unit]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_at_crushing_strength_epscU" $ecu1]
							set ok [DWLocalSetValue $GDN $STRUCT "Tensile_strength_ft" $fctm$unit]
							set Ets [format "%g" [expr (2*$fcm/$ec1)/10000]]
							set ok [DWLocalSetValue $GDN $STRUCT "Tension_softening_stiffness_Ets" $Ets$Eunit]
						} elseif {$format == "Characteristic"} {
							set fpcu [expr 0.85*$fck]
							set ok [DWLocalSetValue $GDN $STRUCT "Compressive_strength_fpc" $fck$unit]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_at_maximum_strength_epsc0" $ec1]
							set ok [DWLocalSetValue $GDN $STRUCT "Crushing_strength_fpcu" $fpcu$unit]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_at_crushing_strength_epscU" $ecu1]
							set ok [DWLocalSetValue $GDN $STRUCT "Tensile_strength_ft" $fctm$unit]
							set Ets [format "%g" [expr (2*$fck/$ec1)/10000]]
							set ok [DWLocalSetValue $GDN $STRUCT "Tension_softening_stiffness_Ets" $Ets$Eunit]
						}
					}
					"Concrete04" {
						if {$format == "Mean" } {
							set ok [DWLocalSetValue $GDN $STRUCT "Compressive_strength" $fcm$unit]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_at_maximum_strength" $ec1]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_at_crushing_strength" $ecu1]
							set ok [DWLocalSetValue $GDN $STRUCT "Initial_stiffness" $E$Eunit]
							set ok [DWLocalSetValue $GDN $STRUCT "Maximum_tensile_strength" $fctm$unit]
						} elseif {$format == "Characteristic"} {
							set ok [DWLocalSetValue $GDN $STRUCT "Compressive_strength" $fck$unit]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_at_maximum_strength" $ec1]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_at_crushing_strength" $ecu1]
							set ok [DWLocalSetValue $GDN $STRUCT "Initial_stiffness" $E$Eunit]
							set ok [DWLocalSetValue $GDN $STRUCT "Maximum_tensile_strength" $fctm$unit]
						}
					}
				}
			}

			return ""
		}

		DEPEND {

			return ""
		}

		CLOSE {

			return ""
		}
	}

	return ""
}

proc TK_GenerateUniaxialSteelProperties { event args } {

	switch $event {

		INIT {

			return ""
		}

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			set matType [DWLocalGetValue $GDN $STRUCT "Material:"]
			set Grade [DWLocalGetValue $GDN $STRUCT "Steel_grade"]
			set unit "MPa"
			set Eunit "GPa"

				switch $Grade {
					"S235" {
						set Fy 235
						set E 200
					}
					"S275" {
						set Fy 275
						set E 200
					}
					"S355" {
						set Fy 355
						set E 200
					}
					"S450" {
						set Fy 450
						set E 200
					}
					"B500C" {
						set Fy 500
						set E 200
					}
					default {
						return ""
					}
				}

				switch $matType {

					"Steel01" {
					set ok [DWLocalSetValue $GDN $STRUCT "Yield_Stress_Fy" $Fy$unit]
					set ok [DWLocalSetValue $GDN $STRUCT "Initial_elastic_tangent_E0" $E$Eunit]
					return ""
					}
					"ReinforcingSteel" {
					set ok [DWLocalSetValue $GDN $STRUCT "Yield_stress_fy" $Fy$unit]
					set ok [DWLocalSetValue $GDN $STRUCT "Initial_elastic_tangent_Es" $E$Eunit]
					return ""
					}
				}
		}

		DEPEND {

			return ""
		}

		CLOSE {

			return ""
		}
	}

	return ""
}

proc TK_GenerateUniaxialMaterialsProperties { event args } {

	switch $event {

		INIT {

			return ""
		}

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]
			set unit "MPa"
			set Eunit "GPa"
			set matType [DWLocalGetValue $GDN $STRUCT $QUESTION]
			set mat [DWLocalGetValue $GDN $STRUCT "Material:"]
			set formulation [DWLocalGetValue $GDN $STRUCT "Formulation"]

			if {$formulation == "Stress-Strain"} {
				switch $matType {
					"Concrete" {
						set Concrete_class [DWLocalGetValue $GDN $STRUCT "Concrete_class"]
						switch $Concrete_class {
							"C12/15" {
								set fck -12
								set fctm 1.6
								set fcm -20
								set E 27
								set ec1 -1.8e-3
								set ecu1 -3.5e-3
							}
							"C16/20" {
								set fck -16
								set fcm -24
								set fctm 1.9
								set E 29
								set ec1 -1.8e-3
								set ecu1 -3.5e-3
							}
							"C20/25" {
									set fck -20
									set fcm -28
									set fctm 2.2
									set E 30
									set ec1 -2.0e-3
									set ecu1 -3.5e-3
							}
							"C25/30" {
								set fck -25
								set fcm -33
								set fctm 2.6
								set E 31
								set ec1 -2.1e-3
								set ecu1 -3.5e-3
							}
							"C30/37" {
								set fck -30
								set fcm -38
								set fctm 2.9
								set E 33
								set ec1 -2.2e-3
								set ecu1 -3.5e-3
							}
							"C35/45" {
								set fck -35
								set fcm -43
								set fctm 3.2
								set E 34
								set ec1 -2.25e-3
								set ecu1 -3.5e-3
							}
							"C40/50" {
								set fck -40
								set fcm -48
								set fctm 3.5
								set E 35
								set ec1 -2.3e-3
								set ecu1 -3.5e-3
							}
							"C45/55" {
								set fck -45
								set fcm -53
								set fctm 3.8
								set E 36
								set ec1 -2.4e-3
								set ecu1 -3.5e-3
							}
							"C50/60" {
								set fck -50
								set fcm -58
								set fctm 4.1
								set E 37
								set ec1 -2.45e-3
								set ecu1 -3.5e-3
							}
							"C55/67" {
								set fck -55
								set fcm -63
								set fctm 4.2
								set E 38
								set ec1 -2.5e-3
								set ecu1 -3.2e-3
							}
							"C60/75" {
								set fck -60
								set fcm -68
								set fctm 4.4
								set E 39
								set ec1 -2.6e-3
								set ecu1 -3e-3
							}
							"C70/85" {
								set fck -70
								set fcm -78
								set fctm 4.6
								set E 41
								set ec1 -2.7e-3
								set ecu1 -2.8e-3
							}
							"C80/95" {
								set fck -80
								set fcm -88
								set fctm 4.8
								set E 42
								set ec1 -2.8e-3
								set ecu1 -2.8e-3
							}
							"C90/105" {
								set fck -90
								set fcm -24
								set fctm 5.0
								set E 44
								set ec1 -2.8e-3
								set ecu1 -2.8e-3
							}
							default {
								return ""
							}
						}
					}
					"Steel" {
						set steelGrade [DWLocalGetValue $GDN $STRUCT "Steel_grade"]
						switch $steelGrade {
							"S235" {
								set Fy 235
								set E 200
								set epsP 1.175e-3
								set epsN -1.175e-3
							}
							"S275" {
								set Fy 275
								set E 200
								set epsP 1.375e-3
								set epsN -1.375e-3
							}
							"S355" {
								set Fy 355
								set E 200
								set epsP 1.775e-3
								set epsN -1.775e-3
							}
							"S450" {
								set Fy 450
								set E 200
								set epsP 2.25e-3
								set epsN -2.25e-3
							}
							"B500" {
								set Fy 500
								set E 200
								set epsP 2.5e-3
								set epsN -2.5e-3
							}
							default {
								return ""
							}
						}
					}
					default {
					return ""
					}
				}
				switch $mat {
					"Elastic" {
						set ok [DWLocalSetValue $GDN $STRUCT "Elastic_modulus_E" $E$Eunit]
					}
					"ElasticPerfectlyPlastic" {
						if { $matType == "Concrete"} {
							set strength_type [DWLocalGetValue $GDN $STRUCT "Strength_type"]

							if { $strength_type=="Mean" } {
								set Ec [format "%1.4g" [expr (2*$fcm/$ec1)/1000]]
							} elseif { $strength_type=="Characteristic" } {
								set Ec [format "%1.3g" [expr (2*$fck/$ec1)/1000]]
							}
							set epsP [format "%1.2e" [expr $fctm/(1000*$Ec)]]
							set ok [DWLocalSetValue $GDN $STRUCT "Elastic_modulus_E" $Ec$Eunit]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_epsP" $epsP]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_epsN" $ec1]
						} elseif { $matType == "Steel" } {
							set ok [DWLocalSetValue $GDN $STRUCT "Elastic_modulus_E" $E$Eunit]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_epsP" $epsP]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_epsN" $epsN]
						}
					}
					"ElasticPerfectlyPlasticwithGap" {
						if { $matType == "Concrete"} {
							set strength_type [DWLocalGetValue $GDN $STRUCT "Strength_type"]

							if { $strength_type=="Mean" } {
								set Ec [format "%g" [expr (2*$fcm/$ec1)/1000]]
								set ok [DWLocalSetValue $GDN $STRUCT "Yield_Stress_Fy" $fcm$unit]
							} elseif { $strength_type=="Characteristic" } {
								set Ec [format "%g" [expr (2*$fck/$ec1)/1000]]
								set ok [DWLocalSetValue $GDN $STRUCT "Yield_Stress_Fy" $fck$unit]
							}
							set ok [DWLocalSetValue $GDN $STRUCT "Elastic_modulus_E" $Ec$Eunit]

						} elseif { $matType == "Steel" } {
							set ok [DWLocalSetValue $GDN $STRUCT "Yield_Stress_Fy" $Fy$unit]
							set ok [DWLocalSetValue $GDN $STRUCT "Elastic_modulus_E" $E$Eunit]
						}
					}
				}
			}

		}

		DEPEND {

			lassign $args GDN STRUCT QUESTION ACTION VALUE
			if { $ACTION == "RESTORE" } {
				set mat_type [DWLocalGetValue $GDN $STRUCT $QUESTION]
				if { $mat_type == "Steel" } {
					set dummy [TK_DWSet $GDN $STRUCT "Material_type" "Steel" normal]
				} elseif { $mat_type == "Concrete" } {
					set dummy [TK_DWSet $GDN $STRUCT "Material_type" "Concrete" normal]
				}
			}
		}

		CLOSE {

			return ""
		}
	}

	return ""
}

proc TK_GenerateNDMaterialsProperties { event args } {

	switch $event {

		INIT {

			return ""
		}

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]
			set unit "MPa"
			set Eunit "GPa"
			set matType [DWLocalGetValue $GDN $STRUCT $QUESTION]
			set mat [DWLocalGetValue $GDN $STRUCT "Material:"]

			switch $matType {
				"Concrete" {
					set Concrete_class [DWLocalGetValue $GDN $STRUCT "Concrete_class"]
					switch $Concrete_class {
						"C12/15" {
							set E 27
							set poisson 0.20
						}
						"C16/20" {
							set E 29
							set poisson 0.20
						}
						"C20/25" {
							set E 30
							set poisson 0.20
						}
						"C25/30" {
							set E 31
							set poisson 0.20
						}
						"C30/37" {
							set E 33
							set poisson 0.20
						}
						"C35/45" {
							set E 34
							set poisson 0.20
						}
						"C40/50" {
							set E 35
							set poisson 0.20
						}
						"C45/55" {
							set E 36
							set poisson 0.20
						}
						"C50/60" {
							set E 37
							set poisson 0.20
						}
						"C55/67" {
							set E 38
							set poisson 0.20
						}
						"C60/75" {
							set E 39
							set poisson 0.20
						}
						"C70/85" {
							set E 41
							set poisson 0.20
						}
						"C80/95" {
							set E 42
							set poisson 0.20
						}
						"C90/105" {
							set E 44
							set poisson 0.20
						}
						default {
							return ""
						}
					}

				}
				"Steel" {
					set E 200
					set poisson 0.30
				}
				default {
					return ""
				}
			}
			switch $mat {
				"ElasticIsotropic" {
					set ok [DWLocalSetValue $GDN $STRUCT "Elastic_modulus_E" $E$Eunit]
					set ok [DWLocalSetValue $GDN $STRUCT "Poisson's_ratio" $poisson]
				}
				default {
					return ""
				}
			}

			return ""
		}

		DEPEND {

			return ""
		}

		CLOSE {

			return ""
		}
	}

	return ""
}

proc TK_Damage2pDefaultValues { event args } {

	switch $event {

		INIT {

		return ""
		}

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]
			set unit "MPa"
			set Eunit "GPa"
			set AssignDefault [DWLocalGetValue $GDN $STRUCT $QUESTION]

			if {$AssignDefault==1} {

				set fccValueUnit [DWLocalGetValue $GDN $STRUCT "Concrete_compressive_strength"]

				set temp [GidConvertValueUnit $fccValueUnit]
				set temp [ParserNumberUnit $temp fccValue fccUnit]

				set fccValue [ConvertToMPa $fccValue $fccUnit]

				set fct [expr 0.1*abs($fccValue)]
				set E [format "%1.5g" [expr 4.75*sqrt(abs($fccValue)) ]]
				set Gt [format "%1.3e" [expr 1840*$fct*$fct/(1000*$E)/1000]]
				set Gc [format "%1.3e" [expr 6250*$fccValue*$fccValue/(1000*$E)/1000]]
				set rho_bar 0.20
				set H [format "%1.4g" [expr 0.25*$E]]
				set theta 0.50
				set ok [DWLocalSetValue $GDN $STRUCT Concrete_tensile_strength $fct$unit]
				set ok [DWLocalSetValue $GDN $STRUCT Young_Modulus $E$Eunit]
				set ok [DWLocalSetValue $GDN $STRUCT Poisson_coefficient 0.15]
				set ok [DWLocalSetValue $GDN $STRUCT Tension_fracture_energy_density $Gt$Eunit]
				set ok [DWLocalSetValue $GDN $STRUCT Comp._fracture_energy_density $Gc$Eunit]
				set ok [DWLocalSetValue $GDN $STRUCT Parameter_of_plastic_volume_change $rho_bar]
				set ok [DWLocalSetValue $GDN $STRUCT Parameter_of_plastic_volume_change $rho_bar]
				set ok [DWLocalSetValue $GDN $STRUCT Linear_hardening_parameter $H$Eunit]
				set ok [DWLocalSetValue $GDN $STRUCT Isotropic/kinematic_hardening_ratio $theta]
				set ok [DWLocalSetValue $GDN $STRUCT Computational_stiffness_matrix "Computational_tangent"]

				return ""
			}
		}
	}

	return ""
}

proc TK_PIMY_FastProperties { event args } {

	switch $event {

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]
			set kPaunit "kPa"
			set MPaunit "MPa"
			set GPaunit "GPa"
			set mdunit "ton/m^3"
			set Soil_type [DWLocalGetValue $GDN $STRUCT $QUESTION]

				switch $Soil_type {

					"Soft_Clay" {
						set rho 1.3
						set Gr 13
						set Bulk 65
						set cohesion 18
						set gammamax 0.1
						set Fangle 0.0
						set d 0.0
						set ok [DWLocalSetValue $GDN $STRUCT Saturated_soil_mass_density $rho$mdunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_shear_modulus_Gr $Gr$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_bulk_modulus $Bulk$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Apparent_cohesion $cohesion$kPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Shear_strain_at_which_maximum_stress_is_reached $gammamax]
						set ok [DWLocalSetValue $GDN $STRUCT Friction_angle $Fangle]
						set ok [DWLocalSetValue $GDN $STRUCT Positive_constant_d $d]
					}
					"Medium_Clay" {
						set rho 1.5
						set Gr 60
						set Bulk 300
						set cohesion 37
						set gammamax 0.1
						set Fangle 0.0
						set d 0.0
						set ok [DWLocalSetValue $GDN $STRUCT Saturated_soil_mass_density $rho$mdunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_shear_modulus_Gr $Gr$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_bulk_modulus $Bulk$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Apparent_cohesion $cohesion$kPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Shear_strain_at_which_maximum_stress_is_reached $gammamax]
						set ok [DWLocalSetValue $GDN $STRUCT Friction_angle $Fangle]
						set ok [DWLocalSetValue $GDN $STRUCT Positive_constant_d $d]
					}
					"Stiff_Clay" {
						set rho 1.8
						set Gr 150
						set Bulk 750
						set cohesion 75
						set gammamax 0.1
						set Fangle 0.0
						set d 0.0
						set ok [DWLocalSetValue $GDN $STRUCT Saturated_soil_mass_density $rho$mdunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_shear_modulus_Gr $Gr$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_bulk_modulus $Bulk$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Apparent_cohesion $cohesion$kPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Shear_strain_at_which_maximum_stress_is_reached $gammamax]
						set ok [DWLocalSetValue $GDN $STRUCT Friction_angle $Fangle]
						set ok [DWLocalSetValue $GDN $STRUCT Positive_constant_d $d]
					}
					"Custom" {
						return ""
					}
					default {
						return ""
					}
				}
		}
	}

	return ""
}

proc TK_PDMY_FastProperties { event args } {

	switch $event {

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]
			set kPaunit "kPa"
			set MPaunit "MPa"
			set GPaunit "GPa"
			set mdunit "ton/m^3"
			set Soil_type [DWLocalGetValue $GDN $STRUCT $QUESTION]

				switch $Soil_type {

					"Loose_Sand" {
						set rho 1.7 ;# ton/m^3
						set Gr 55; # MPa
						set Bulk 150 ;# MPa
						set gammamax 0.1
						set Fangle 29
						set d 0.5
						set pr 80; #kPa
						set ptang 29
						set contraction 0.21
						set dilat1 0.0
						set dilat2 0.0
						set liquefac1 10; # kPa
						set liquefac2 0.02
						set liquefac3 1.0
						set voidratio 0.85
						set ok [DWLocalSetValue $GDN $STRUCT Saturated_soil_mass_density $rho$mdunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_shear_modulus_Gr $Gr$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_bulk_modulus $Bulk$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Shear_strain_at_which_maximum_stress_is_reached $gammamax]
						set ok [DWLocalSetValue $GDN $STRUCT Friction_angle $Fangle]
						set ok [DWLocalSetValue $GDN $STRUCT Positive_constant_d $d]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_mean_effective_confining_pressure_pr $pr$kPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Phase_transformation_angle $ptang]
						set ok [DWLocalSetValue $GDN $STRUCT Contraction_rate_constant $contraction]
						set ok [DWLocalSetValue $GDN $STRUCT Dilation_rate_constant_1 $dilat1]
						set ok [DWLocalSetValue $GDN $STRUCT Dilation_rate_constant_2 $dilat2]
						set ok [DWLocalSetValue $GDN $STRUCT Liquefaction_parameter_1 $liquefac1$kPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Liquefaction_parameter_2 $liquefac2]
						set ok [DWLocalSetValue $GDN $STRUCT Liquefaction_parameter_3 $liquefac3]
						set ok [DWLocalSetValue $GDN $STRUCT Initial_void_ratio $voidratio]
					}
					"Medium_Sand" {
						set rho 1.9 ;# ton/m^3
						set Gr 75; # MPa
						set Bulk 200 ;# MPa
						set gammamax 0.1
						set Fangle 33
						set d 0.5
						set pr 80; #kPa
						set ptang 27
						set contraction 0.07
						set dilat1 0.4
						set dilat2 2.0
						set liquefac1 10; # kPa
						set liquefac2 0.01
						set liquefac3 1.0
						set voidratio 0.70
						set ok [DWLocalSetValue $GDN $STRUCT Saturated_soil_mass_density $rho$mdunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_shear_modulus_Gr $Gr$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_bulk_modulus $Bulk$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Shear_strain_at_which_maximum_stress_is_reached $gammamax]
						set ok [DWLocalSetValue $GDN $STRUCT Friction_angle $Fangle]
						set ok [DWLocalSetValue $GDN $STRUCT Positive_constant_d $d]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_mean_effective_confining_pressure_pr $pr$kPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Phase_transformation_angle $ptang]
						set ok [DWLocalSetValue $GDN $STRUCT Contraction_rate_constant $contraction]
						set ok [DWLocalSetValue $GDN $STRUCT Dilation_rate_constant_1 $dilat1]
						set ok [DWLocalSetValue $GDN $STRUCT Dilation_rate_constant_2 $dilat2]
						set ok [DWLocalSetValue $GDN $STRUCT Liquefaction_parameter_1 $liquefac1$kPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Liquefaction_parameter_2 $liquefac2]
						set ok [DWLocalSetValue $GDN $STRUCT Liquefaction_parameter_3 $liquefac3]
						set ok [DWLocalSetValue $GDN $STRUCT Initial_void_ratio $voidratio]
					}
					"Medium-dense_Sand" {
						set rho 2.0 ;# ton/m^3
						set Gr 100; # MPa
						set Bulk 300 ;# MPa
						set gammamax 0.1
						set Fangle 37
						set d 0.5
						set pr 80; #kPa
						set ptang 27
						set contraction 0.05
						set dilat1 0.6
						set dilat2 3.0
						set liquefac1 5; # kPa
						set liquefac2 0.003
						set liquefac3 1
						set voidratio 0.55
						set ok [DWLocalSetValue $GDN $STRUCT Saturated_soil_mass_density $rho$mdunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_shear_modulus_Gr $Gr$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_bulk_modulus $Bulk$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Shear_strain_at_which_maximum_stress_is_reached $gammamax]
						set ok [DWLocalSetValue $GDN $STRUCT Friction_angle $Fangle]
						set ok [DWLocalSetValue $GDN $STRUCT Positive_constant_d $d]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_mean_effective_confining_pressure_pr $pr$kPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Phase_transformation_angle $ptang]
						set ok [DWLocalSetValue $GDN $STRUCT Contraction_rate_constant $contraction]
						set ok [DWLocalSetValue $GDN $STRUCT Dilation_rate_constant_1 $dilat1]
						set ok [DWLocalSetValue $GDN $STRUCT Dilation_rate_constant_2 $dilat2]
						set ok [DWLocalSetValue $GDN $STRUCT Liquefaction_parameter_1 $liquefac1$kPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Liquefaction_parameter_2 $liquefac2]
						set ok [DWLocalSetValue $GDN $STRUCT Liquefaction_parameter_3 $liquefac3]
						set ok [DWLocalSetValue $GDN $STRUCT Initial_void_ratio $voidratio]
					}
					"Dense_Sand" {
						set rho 2.1 ;# ton/m^3
						set Gr 135; # MPa
						set Bulk 390 ;# MPa
						set gammamax 0.1
						set Fangle 40
						set d 0.5
						set pr 80; #kPa
						set ptang 27
						set contraction 0.03
						set dilat1 0.8
						set dilat2 5.0
						set liquefac1 0.0; # kPa
						set liquefac2 0.0
						set liquefac3 0.0
						set voidratio 0.45
						set ok [DWLocalSetValue $GDN $STRUCT Saturated_soil_mass_density $rho$mdunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_shear_modulus_Gr $Gr$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_bulk_modulus $Bulk$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Shear_strain_at_which_maximum_stress_is_reached $gammamax]
						set ok [DWLocalSetValue $GDN $STRUCT Friction_angle $Fangle]
						set ok [DWLocalSetValue $GDN $STRUCT Positive_constant_d $d]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_mean_effective_confining_pressure_pr $pr$kPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Phase_transformation_angle $ptang]
						set ok [DWLocalSetValue $GDN $STRUCT Contraction_rate_constant $contraction]
						set ok [DWLocalSetValue $GDN $STRUCT Dilation_rate_constant_1 $dilat1]
						set ok [DWLocalSetValue $GDN $STRUCT Dilation_rate_constant_2 $dilat2]
						set ok [DWLocalSetValue $GDN $STRUCT Liquefaction_parameter_1 $liquefac1$kPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Liquefaction_parameter_2 $liquefac2]
						set ok [DWLocalSetValue $GDN $STRUCT Liquefaction_parameter_3 $liquefac3]
						set ok [DWLocalSetValue $GDN $STRUCT Initial_void_ratio $voidratio]
					}
					"Custom" {
						return ""
					}
					default {
						return ""
					}
				}
		}
	}

	return ""
}

global Description_text
set Description_text ""

proc TK_DescriptionField { event args } {

	global Description_text
	global Description_Parent GiDProjectDir GiDProjectName

	switch $event {

		INIT {

			set data [GiD_Info Project]
			set ProjectName [lindex $data 1]

			if { $ProjectName != "UNNAMED" } {

				GetProjectDirPath

				set filename [file join $GiDProjectDir "$GiDProjectName.txt"]
				set fexist [file exist $filename]

				if { $fexist == 1 } {
				set fp [open $filename r]
				set Description_text [read $fp]
				close $fp
				}
			}

			set PARENT [lindex $args 0]
			set Description_Parent $PARENT
			upvar [lindex $args 1] ROW
			set GDN [lindex $args 2]
			set STRUCT [lindex $args 3]
			set QUESTION [lindex $args 4]
			grid [text $PARENT.description -width 70 -height 13 -font {Calibri -14} ] -column 1 -row [expr $ROW+1]
			$PARENT.description delete 1.0 end
			$PARENT.description insert 1.0 "$Description_text"
			return ""
		}

		SYNC {
			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]
			set Description_text [$Description_Parent.description get 1.0 end]
			set ok [SaveProjectDescriptionFile]
		}

		DEPEND {

			return ""
		}

		CLOSE {
			UpdateInfoBar
			return ""
		}
	}

	return ""
}

proc SaveProjectDescriptionFile { } {

	set data [GiD_Info Project]
	set ProjectName [lindex $data 1]
	global GiDProjectDir GiDProjectName
	global Description_text

	set Description_text [string trim $Description_text]

	if { $ProjectName != "UNNAMED" } {

		GetProjectDirPath

		set file [file join $GiDProjectDir "$GiDProjectName.txt"]

		set fp [open $file w]
		puts $fp $Description_text
		close $fp
	}

	return ""
}

proc TK_ActiveIntervalinLoads { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set GDN [lindex $args 2]
			set STRUCT [lindex $args 3]
			set QUESTION [lindex $args 4]
			set data [GiD_Info intvdata num]
			set activeInterval [lindex $data 0]
			#set ok [DWLocalSetValue $GDN $STRUCT "Active_Interval:" $activeInterval]
			set cmd "GiD_Process Mescape Data Intervals ChangeInterval"
			set b [Button $PARENT.changeintv -text [= "Change Interval"] -helptext [= "Change Interval"] -command $cmd -state normal ]
			#set b [button $PARENT.changeintvbutton -image .actvintv -command $cmd -state normal -height 32 -width 32]
			grid $b -column 1 -row [expr $ROW] -sticky nw -pady 5

			return  ""
		}

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]
			set data [GiD_Info intvdata num]
			set activeInterval [lindex $data 0]
			#set ok [DWLocalSetValue $GDN $STRUCT "Active_Interval:" $activeInterval]

			return ""
		}
	}

	return ""
}

proc TK_EditInterval { event args } {

	switch $event {

		CLOSE {

			UpdateInfoBar

			return ""
		}
	}

	return ""
}

proc TK_UpdateInfoBar { event args } {

	switch $event {

		CLOSE {

			UpdateInfoBar

		}
	}

	return ""
}

global SelectedVerticalAxis

proc TK_EditModelDim { event args } {
global SelectedVerticalAxis
			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set GDN [lindex $args 2]
			set STRUCT [lindex $args 3]
			set QUESTION [lindex $args 4]

	switch $event {

		INIT {

			set SelectedVerticalAxis [GiD_AccessValue get gendata Vertical_axis]
			set dim [ReturnProjectDimensions]
			set dummy [DWLocalSetValue $GDN $STRUCT $QUESTION $dim]

			if {$dim == 2} {

				set dummy [DWLocalSetValue $GDN $STRUCT Vertical_axis "Y"]

			} else {
				set dummy [GiD_AccessValue set gendata Vertical_axis $SelectedVerticalAxis]
			}
			return ""
		}
	}

	return ""
}

proc TK_ElementWikiInfo { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set GDN [lindex $args 2]
			set STRUCT [lindex $args 3]
			set QUESTION [lindex $args 4]
			set ElemType [DWLocalGetValue $GDN $STRUCT "Element_type:"]

			switch $ElemType {

				"ElasticBeamColumn" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Elastic_Beam_Column_Element"
				}
				"ElasticTimoshenkoBeamColumn" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Elastic_Timoshenko_Beam_Column_Element"
				}
				"forceBeamColumn" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Force-Based_Beam-Column_Element"
				}
				"Truss" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Truss_Element"
				}
				"CorotationalTruss" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Corotational_Truss_Element"
				}
				"Quad" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Quad_Element"
				}
				"Shell" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Shell_Element"
				}
				"Tri31" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Tri31_Element"
				}
				"QuadUP" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Four_Node_Quad_u-p_Element"
				}
				"stdBrick" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Standard_Brick_Element"
				}
				"dispBeamColumn" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Displacement-Based_Beam-Column_Element"
				}

			}

			set b [Button $PARENT.wikiinfo -text [= "Element Info"] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal ]
			grid $b -column 1 -row [expr $ROW+1] -sticky nw -pady 5

			return  ""
		}
	}

	return ""
}

proc TK_MaterialWikiInfo { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set GDN [lindex $args 2]
			set STRUCT [lindex $args 3]
			set QUESTION [lindex $args 4]
			set MatType [DWLocalGetValue $GDN $STRUCT "Material:"]

			switch $MatType {

				"Elastic" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Elastic_Uniaxial_Material"
				}
				"ElasticPerfectlyPlastic" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Elastic-Perfectly_Plastic_Material"
				}
				"ElasticPerfectlyPlasticwithGap" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Elastic-Perfectly_Plastic_Gap_Material"
				}
				"Viscous" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Viscous_Material"
				}
				"Concrete01" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Concrete01_Material_--_Zero_Tensile_Strength"
				}
				"Concrete02" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Concrete02_Material_--_Linear_Tension_Softening"
				}
				"Concrete06" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Concrete06_Material"
				}
				"Concrete04" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Concrete04_Material_--_Popovics_Concrete_Material"
				}
				"Steel01" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Steel01_Material"
				}
				"ReinforcingSteel" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Reinforcing_Steel_Material"
				}
				"ElasticIsotropic" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Elastic_Isotropic_Material"
				}
				"ElasticOrthotropic" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Elastic_Orthotropic_Material"
				}
				"J2Plasticity" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/J2_Plasticity_Material"
				}
				"Damage2p" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Damage2p"
				}
				"PressureIndependMultiYield" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/PressureIndependMultiYield_Material"
				}
				"PressureDependMultiYield" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/PressureDependMultiYield_Material"
				}
				"Series" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Series_Material"
				}
				"Parallel" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Parallel_Material"
				}
				"Hysteretic" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Hysteretic_Material"
				}
			}

			set b [Button $PARENT.wikiinfo -text [= "Material info"] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal ]
			grid $b -column 1 -row [expr $ROW+1] -sticky nw -pady 5

			return  ""
		}
	}

	return ""
}

proc TK_SectionWikiInfo { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set GDN [lindex $args 2]
			set STRUCT [lindex $args 3]
			set QUESTION [lindex $args 4]
			set SecType [DWLocalGetValue $GDN $STRUCT "Section:"]

			switch $SecType {

				"Fiber" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Fiber_Section"
				}
				"PlateFiber" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Elastic_Membrane_Plate_Section"
				}
				"ElasticMembranePlate" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Plate_Fiber_Section"
				}
				"SectionAggregator" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Section_Aggregator"
				}
			}

			set b [Button $PARENT.wikiinfo -text [= "Section info"] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal ]
			grid $b -column 1 -row [expr $ROW+1] -sticky nw -pady 5

			return  ""
		}
	}

	return ""
}

proc TK_ZeroLengthWikiInfo { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/ZeroLength_Element"

			set b [Button $PARENT.wikiinfo -text [= "Element Info"] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal ]
			grid $b -column 1 -row [expr $ROW+1] -sticky nw -pady 5

		}
	}

	return ""
}

proc TK_MassWikiInfo { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Mass_Command"

			set b [Button $PARENT.wikiinfo -text [= "More info"] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal ]
			grid $b -column 1 -row [expr $ROW+1] -sticky nw -pady 5
		}
	}

	return ""
}

proc TK_RigidDiaphragmWikiInfo  { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/RigidDiaphragm_command"

			set b [Button $PARENT.wikiinfo -text [= "More Info"] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal ]
			grid $b -column 1 -row [expr $ROW+1] -sticky nw -pady 5
		}
	}

	return ""
}

proc TK_EqualDOFWikiInfo { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/EqualDOF_command"

			set b [Button $PARENT.wikiinfo -text [= "More info"] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal ]
			grid $b -column 1 -row [expr $ROW+3] -sticky nw -pady 5
		}
	}

	return ""
}

proc TK_LineLoadsWikiInfo { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/EleLoad_Command"

			set b [Button $PARENT.wikiinfo -text [= "More Info"] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal ]
			grid $b -column 1 -row [expr $ROW] -sticky nw -pady 5
		}
	}

	return ""
}

proc TK_LoadsWikiInfo { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/NodalLoad_Command"

			set b [Button $PARENT.wikiinfo -text [= "More info"] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal ]
			grid $b -column 1 -row [expr $ROW] -sticky nw -pady 5
		}
	}

	return ""
}

proc TK_DisplacementsWikiInfo { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Sp_Command"

			set b [Button $PARENT.wikiinfo -text [= "More info"] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal ]
			grid $b -column 1 -row [expr $ROW] -sticky nw -pady 5
		}
	}

	return ""
}

proc TK_RestraintsWikiInfo { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Fix_command"

			set b [Button $PARENT.wikiinfo -text [= "More info"] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal ]
			grid $b -column 1 -row [expr $ROW+2] -sticky nw -pady 5
		}
	}

	return ""
}

proc TK_AnalWikiInfo { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Analysis_Commands"

			set b [Button $PARENT.wikiinfo -text [= "Analysis info"] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal ]
			grid $b -column 1 -row [expr $ROW+2] -sticky nw -pady 5

		}
	}

	return ""
}

proc TK_RegionWikiInfo { event args } {

	switch $event {

		INIT {
			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Region_Command"

			set b [Button $PARENT.wikiinfo -text [= "More info"] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal ]
			grid $b -column 1 -row [expr $ROW+2] -sticky nw -pady 5
		}
	}
}

proc TK_CheckQuadFieldOptions { event args } {

	switch $event {

		CLOSE {

			UpdateInfoBar
		}

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]
			set SelMat [DWLocalGetValue $GDN $STRUCT Material]
			set Behavior [DWLocalGetValue $GDN $STRUCT Plane_behavior]
			set MatType [GiD_AccessValue get materials $SelMat "Material:"]

			if { $MatType=="PressureDependMultiYield" || $MatType=="PressureIndependMultiYield" } {

				if { $Behavior=="PlaneStress" } {

					WarnWinText "For PressureDependMultiYield or PressureIndependMultiYield Material use PlaneStrain behavior"
				}
			}
		}
	}

	return ""
}

proc TK_OpenRecordsWindow { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set cmd "GidOpenMaterials Records"

			set b [Button $PARENT.buttonRecordwindow -text [= "Open Records window"] -helptext [= "Open the Records dialog"] -command $cmd -state normal ]
			grid $b -column 1 -row [expr $ROW+1] -sticky nw -pady 5

		}
	}

	return ""
}

proc TK_RecordFileButton { event args } {

	global tkwidgedprivfilenamebutton
	switch $event {

		INIT {

			lassign $args PARENT current_row_variable GDN STRUCT QUESTION
			upvar $current_row_variable ROW
			#initialize variable to current field value
			set tkwidgedprivfilenamebutton($QUESTION,filename) [DWLocalGetValue $GDN $STRUCT $QUESTION]
			#set entry $PARENT.e$ROW
			set entry ""
			foreach item [grid slaves $PARENT -row [expr $ROW-1]] {
				if { [winfo class $item] == "Entry"  || [winfo class $item] == "TEntry" } {
					#assumed that it is the only entry of this row
					set entry $item
					break
				}
			}
			#trick to fill in the values pressing transfer from an applied condition
			if { [lindex [info level 2] 0] == "DWUpdateConds" } {
				set values [lrange [lindex [info level 2] 2] 3 end]
				set index_field [LabelField $GDN $STRUCT $QUESTION]
				set value [lindex $values $index_field-1]
				set tkwidgedprivfilenamebutton($QUESTION,filename) $value
			}
			set w [ttk::frame $PARENT.cfilenamebutton$QUESTION] ;#use a name depending on $QUESTION to allow more than one row changed
			ttk::entry $w.e1 -textvariable tkwidgedprivfilenamebutton($QUESTION,filename)
			ttk::button $w.b1 -image [gid_themes::GetImage "folder.png"] \
				-command [list GetRecordFilenameCmd tkwidgedprivfilenamebutton($QUESTION,filename) $w.e1 1]
			set tkwidgedprivfilenamebutton($QUESTION,widget) $w
			grid $w.e1 $w.b1 -sticky ew
			grid columnconfigure $w {0} -weight 1
			grid $w -row [expr $ROW-1] -column 1 -sticky ew
			if { $entry != "" } {
				grid remove $entry
			} else {
				#assumed that entry is hidden and then hide the usurpating frame
				#grid remove $w
			}
		}

		SYNC {

			lassign $args GDN STRUCT QUESTION
			if { [info exists tkwidgedprivfilenamebutton($QUESTION,filename)] } {
				DWLocalSetValue $GDN $STRUCT $QUESTION $tkwidgedprivfilenamebutton($QUESTION,filename)
			}
		}

		DEPEND {

			lassign $args GDN STRUCT QUESTION ACTION VALUE
			if { [info exists tkwidgedprivfilenamebutton($QUESTION,widget)] && \
				[winfo exists $tkwidgedprivfilenamebutton($QUESTION,widget)] } {
				if { $ACTION == "HIDE" } {
					grid remove $tkwidgedprivfilenamebutton($QUESTION,widget)
				} else {
					#RESTORE
					grid $tkwidgedprivfilenamebutton($QUESTION,widget)
				}
			} else {
				}
		}

		CLOSE {

			array unset tkwidgedprivfilenamebutton
			UpdateInfoBar
		}
	}

	#a tkwidget procedure must return "" if Ok or [list ERROR $description] or [list WARNING $description]
	return ""
}

proc GetRecordFilenameCmd { varname entry {tail 0}} {

	set aa [GiD_Info Project]
	set ProjectName [lindex $aa 1]
	global GidProcWin

	set types [list [list [_ "All files"] ".*"]]
	set defaultextension ""
	set title [_ "Select file"]
	set current_value [Browser-ramR file read .gid $title [set ::$varname] $types $defaultextension 0]

	if {$current_value != ""} {

		if { ![info exists GidProcWin(w)] || \
			![winfo exists $GidProcWin(w).listbox#1] } {
			set wbase .gid
			set w ""
		} else {
			set wbase $GidProcWin(w)
			set w $GidProcWin(w).listbox#1
		}
		if { $ProjectName == "UNNAMED" } {
			tk_dialogRAM $wbase.tmpwin [_ "Warning"] [_ "Before using a Record file, you need to save the project" ] \
			warning 0 [_ "OK"]
			set current_value ""
		} else {
			GetProjectDirPath
			global OpenSeesProblemDir GiDProjectDir GiDProjectName
			file mkdir $GiDProjectDir/Records
			file copy -force -- $current_value $GiDProjectDir/Records
		}
	}

	if { $tail } {
		set current_value [file tail $current_value]
	}

	if { $current_value != "" && $entry != "" && [winfo exists $entry] } {
		$entry delete 0 end
		$entry insert end $current_value
	}

	#set variable after change entry, else if variable is the own entry variable then delete 0 end will empty both
	set ::$varname $current_value
	return $current_value
}

proc TK_RayleighLabel { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW

			set label [label $PARENT.rayleighInfo -text [= "Activating global Rayleigh damping will OVERRIDE all Rayleigh damping\nparameters assigned to specific regions. Use global Rayleigh damping to\nassign damping to ALL defined elements and nodes.\n"]  ]
			grid $label -column 1 -row [expr $ROW+0] -sticky nw
		}
	}

	return ""
}

proc TK_Excitation_type { event args } {

	switch $event {

		DEPEND {

			lassign $args GDN STRUCT QUESTION ACTION VALUE
			if { $ACTION == "RESTORE" } {
				set exc_type [DWLocalGetValue $GDN $STRUCT $QUESTION]
				if { $exc_type == "Sine" } {
					set dummy [TK_DWSet $GDN $STRUCT "Excitation_type" "Sine" normal]
				} elseif { $exc_type == "Record" } {
					set dummy [TK_DWSet $GDN $STRUCT "Excitation_type" "Record" normal]
				}
			}
		}
	}
	return ""
}

# Use this procedure instead of DWLocalSetValue if you want to modify the State too

proc TK_DWSet { GDN STRUCT QUESTION VALUE {STATE ""}} {

	upvar #0 $GDN GidData

	if { [catch {set ifld $GidData($STRUCT,LABEL,$QUESTION)}] } {
		set ifld [LabelField $GDN $STRUCT $QUESTION]
	}
	if { $ifld == -1 } {
		error [_ "Invalid question access in DWSetValue for : %s" $QUESTION]
	} else {
		if {$STATE eq ""} {
			set GidData($STRUCT,VALUE,$ifld) $VALUE
		} else {
			array set action {
			normal   DepActionRESTORE
			hidden   DepActionHIDE
			disabled DepActionSET
			}
			# no state checking!!!
			$action($STATE) $GDN $STRUCT $ifld $VALUE
		}
	}
}

proc Bas_mod { x y } {

set ans [expr fmod ($x,$y)]

return $ans
}

proc TK_PMY-ID { event args } {

	switch $event {

		INIT {

			lassign $args PARENT current_row_variable GDN STRUCT QUESTION

			set ChosenMaterial [DWLocalGetValue $GDN $STRUCT "Material"]
			set MatType [GiD_AccessValue get materials $ChosenMaterial "Material:"]

			if { $MatType == "PressureDependMultiYield" || $MatType == "PressureIndependMultiYield" } {
				set matnumber [expr [lsearch [GiD_Info materials] $ChosenMaterial]+1]
				set ok [DWLocalSetValue $GDN $STRUCT $QUESTION $matnumber]

			} else {
				set ok [DWLocalSetValue $GDN $STRUCT $QUESTION 0]
			}

		}

		SYNC {
			lassign $args GDN STRUCT QUESTION
			set ChosenMaterial [DWLocalGetValue $GDN $STRUCT "Material"]
			set MatType [GiD_AccessValue get materials $ChosenMaterial "Material:"]

			if { $MatType == "PressureDependMultiYield" || $MatType == "PressureIndependMultiYield" } {
				set matnumber [expr [lsearch [GiD_Info materials] $ChosenMaterial]+1]
				set ok [DWLocalSetValue $GDN $STRUCT $QUESTION $matnumber]

			} else {
				set ok [DWLocalSetValue $GDN $STRUCT $QUESTION 0]
			}
		}
	}
	return ""
}

proc TK_CheckIntegerIntvNum { event args } {

	switch $event {

		SYNC {
			lassign $args GDN STRUCT QUESTION
			set value [DWLocalGetValue $GDN $STRUCT $QUESTION]
			set intvalue [expr int($value)]

			if {$value != $intvalue} {
				WarnWinText "Interval number must be integer"
				set ok [DWLocalSetValue $GDN $STRUCT $QUESTION $intvalue]
			}
		}
	}
	return ""
}