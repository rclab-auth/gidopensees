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

			if { $MatType == "ElasticOrthotropic"} {
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

proc TK_CheckModelingOptionsForBeamColumnElems { event args } {

	switch $event {

		INIT {

			return ""
		}

		SYNC {
   
			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			set ndm [GiD_AccessValue get gendata "Dimensions"]
			set dof [GiD_AccessValue get gendata "DOF"]
 
			if { $ndm == "2" && $dof== "2" } {
				WarnWinText "Beam-Column elements require a 2D / 3-DOF or a 3D / 6-DOF model."
			} elseif {$ndm=="2" && $dof=="6"} {
				WarnWinText "Beam-Column elements require a 2D / 3-DOF or a 3D / 6-DOF model."
			} elseif {$ndm=="3" && $dof=="3"} {
				WarnWinText "Beam-Column elements require a 2D / 3-DOF or a 3D / 6-DOF model."
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

proc TK_CheckModelingOptionsForQuadElems { event args } {

	switch $event {

		INIT {

			return ""
		}

		SYNC {
   
			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			set ndm [GiD_AccessValue get gendata "Dimensions"]
			set dof [GiD_AccessValue get gendata "DOF"]
 
			if { $ndm != "2" || $dof != "2"} {
				WarnWinText "Quad elements require a 2D / 2-DOF model."
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

proc TK_CheckModelingOptionsForTri31Elems { event args } {

	switch $event {

		INIT {

			return ""
		}

		SYNC {
   
			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			set ndm [GiD_AccessValue get gendata "Dimensions"]
			set dof [GiD_AccessValue get gendata "DOF"]
 
			if { $ndm != "2" || $dof != "2"} {
				WarnWinText "Triangular elements require a 2D / 2-DOF model."
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

proc TK_CheckModelingOptionsForQuadUPElems { event args } {

	switch $event {

		INIT {

			return ""
		}

		SYNC {
   
			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			set ndm [GiD_AccessValue get gendata "Dimensions"]
			set dof [GiD_AccessValue get gendata "DOF"]
 
			if { $ndm != "2" || $dof != "3"} {
				WarnWinText "QuadUP elements require a 2D / 3-DOF model."
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

proc TK_CheckModelingOptionsForBrickElems { event args } {

	switch $event {

		INIT {

			return ""
		}

		SYNC {
   
			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			set ndm [GiD_AccessValue get gendata "Dimensions"]
			set dof [GiD_AccessValue get gendata "DOF"]
 
			if { $ndm != "3" || $dof != "3"} {
				WarnWinText "Standard Brick elements require a 3D / 3-DOF model."
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

proc TK_CheckModelingOptionsForShellElems { event args } {

	switch $event {

		INIT {

			return ""
		}

		SYNC {
   
			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			# Dimensions : the question name 
			set ndm [GiD_AccessValue get gendata "Dimensions"]
			set dof [GiD_AccessValue get gendata "DOF"]
			# ndm : number of dimensions of the project
			# dof : degrees of freedom per node
 
			if { $ndm != "3" || $dof != "6"} {
				WarnWinText "Shell elements require a 3D / 6-DOF model."
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
			set Shape [DWLocalGetValue $GDN $STRUCT "Cross_Section"]
			
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

proc TK_CheckMaterialsForFiber { event args } {

	switch $event {

		INIT {

			return ""
		}

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
 
			if { $BarMatType != "Steel01" } {
				WarnWinText "ERROR : Material $ChoosedBarMaterial ($BarMatType material) can not be used for fiber sections in this version."
				WarnWinText "It has been changed to Steel01 material."

				DWLocalSetValue $GDN $STRUCT "Reinforcing_Bar_material" "Steel01"	
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
			set Class [DWLocalGetValue $GDN $STRUCT "Strength_Class"]
			set format [DWLocalGetValue $GDN $STRUCT "Strength_Type"]
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
						} 
						"C16/20" {
							set fck -16
							set fcm -24
							set fctm 1.9
							set ec1 -1.8e-3
							set ecu1 -3.5e-3
						}
						"C20/25" {
							set fck -20
							set fcm -28
							set fctm 2.2
							set ec1 -2.0e-3
							set ecu1 -3.5e-3
						}
						"C25/30" {
							set fck -25
							set fcm -33
							set fctm 2.6
							set ec1 -2.1e-3
							set ecu1 -3.5e-3
						}
						"C30/37" {
							set fck -30
							set fcm -38
							set fctm 2.9
							set ec1 -2.2e-3
							set ecu1 -3.5e-3
						}
						"C35/45" {
							set fck -35
							set fcm -43
							set fctm 3.2
							set ec1 -2.25e-3
							set ecu1 -3.5e-3
						}
						"C40/50" {
							set fck -40
							set fcm -48
							set fctm 3.5
							set ec1 -2.3e-3
							set ecu1 -3.5e-3
						}
						"C45/55" {
							set fck -45
							set fcm -53
							set fctm 3.8
							set ec1 -2.4e-3
							set ecu1 -3.5e-3
						}
						"C50/60" {
							set fck -50
							set fcm -58
							set fctm 4.1
							set ec1 -2.45e-3
							set ecu1 -3.5e-3
						}
						"C55/67" {
							set fck -55
							set fcm -63
							set fctm 4.2
							set ec1 -2.5e-3
							set ecu1 -3.2e-3
						}
						"C60/75" {
							set fck -60
							set fcm -68
							set fctm 4.4
							set ec1 -2.6e-3
							set ecu1 -3e-3
						}
						"C70/85" {
							set fck -70
							set fcm -78
							set fctm 4.6
							set ec1 -2.7e-3
							set ecu1 -2.8e-3
						}
						"C80/95" {
							set fck -80
							set fcm -88
							set fctm 4.8
							set ec1 -2.8e-3
							set ecu1 -2.8e-3
						}
						"C90/105" {
							set fck -90
							set fcm -24
							set fctm 5.0
							set ec1 -2.8e-3
							set ecu1 -2.8e-3
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
			set Grade [DWLocalGetValue $GDN $STRUCT "Steel_Grade"]
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
					"B500" {
						set Fy 500
						set E 200
					}
					default {
						return ""
					}
				}
				
				set ok [DWLocalSetValue $GDN $STRUCT "Yield_Stress_Fy" $Fy$unit]
				set ok [DWLocalSetValue $GDN $STRUCT "Initial_elastic_tangent_E0" $E$Eunit]
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
			
			switch $matType {
				"Concrete" {
					set Concrete_class [DWLocalGetValue $GDN $STRUCT "Concrete_Class"]
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
					set steelGrade [DWLocalGetValue $GDN $STRUCT "Steel_Grade"]
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
						set strength_type [DWLocalGetValue $GDN $STRUCT "Strength_Type"]
						
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
						set strength_type [DWLocalGetValue $GDN $STRUCT "Strength_Type"]
						
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

		DEPEND {

			return ""
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
					set Concrete_class [DWLocalGetValue $GDN $STRUCT "Concrete_Class"]
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
					set ok [DWLocalSetValue $GDN $STRUCT "Elastic_Modulus_E" $E$Eunit]
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
						set ok [DWLocalSetValue $GDN $STRUCT Reference_Shear_Modulus_Gr $Gr$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_Bulk_Modulus $Bulk$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Apparent_Cohesion $cohesion$kPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Shear_Strain_at_which_maximum_stress_is_reached $gammamax]
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
						set ok [DWLocalSetValue $GDN $STRUCT Reference_Shear_Modulus_Gr $Gr$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_Bulk_Modulus $Bulk$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Apparent_Cohesion $cohesion$kPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Shear_Strain_at_which_maximum_stress_is_reached $gammamax]
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
						set ok [DWLocalSetValue $GDN $STRUCT Reference_Shear_Modulus_Gr $Gr$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_Bulk_Modulus $Bulk$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Apparent_Cohesion $cohesion$kPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Shear_Strain_at_which_maximum_stress_is_reached $gammamax]
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
						set ok [DWLocalSetValue $GDN $STRUCT Reference_Shear_Modulus_Gr $Gr$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_Bulk_Modulus $Bulk$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Shear_Strain_at_which_maximum_stress_is_reached $gammamax]
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
						set ok [DWLocalSetValue $GDN $STRUCT Reference_Shear_Modulus_Gr $Gr$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_Bulk_Modulus $Bulk$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Shear_Strain_at_which_maximum_stress_is_reached $gammamax]
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
						set ok [DWLocalSetValue $GDN $STRUCT Reference_Shear_Modulus_Gr $Gr$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_Bulk_Modulus $Bulk$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Shear_Strain_at_which_maximum_stress_is_reached $gammamax]
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
						set ok [DWLocalSetValue $GDN $STRUCT Reference_Shear_Modulus_Gr $Gr$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Reference_Bulk_Modulus $Bulk$MPaunit]
						set ok [DWLocalSetValue $GDN $STRUCT Shear_Strain_at_which_maximum_stress_is_reached $gammamax]
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
			loadProjectDirPath { "" }

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

		loadProjectDirPath { "" }

		set file [file join $GiDProjectDir "$GiDProjectName.txt"]

		set fp [open $file w]
		puts $fp $Description_text
		close $fp
	}

	return ""
}

proc TK_CheckModelingOptions { event args } {

	switch $event {

		INIT {

			return ""
		}

		SYNC {
			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]
			# Dimensions : the question name 
			set ndm [GiD_AccessValue get gendata "Dimensions"]
			set dof [GiD_AccessValue get gendata "DOF"]
			# ndm : number of dimensions of the project
			# dof : degrees of freedom per node
			if { ($ndm == "3" && $dof == "2") || ($ndm == "2" && $dof== "6") } {
				WarnWinText "You cannot define $dof DOFs in a $ndm-dimension model !"
				WarnWinText "Please check your options."
			}

			return ""
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
			set b [Button $PARENT.btable -text [= "Change Interval"] -helptext [= "Change Interval"] -command $cmd -state normal ]
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

proc TK_EditInterval { event args } {

	switch $event {

		CLOSE {

			UpdateInfoBar

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
			set ElemType [DWLocalGetValue $GDN $STRUCT "Material:"]
			
			switch $ElemType {
			
				"Elastic" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Elastic_Uniaxial_Material"
				} 
				"ElasticPerfectlyPlastic" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Elastic-Perfectly_Plastic_Material"
				}
				"ElasticPerfectlyPlasticwithGap" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Elastic-Perfectly_Plastic_Gap_Material"
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
				"Steel01" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Steel01_Material"
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
		
			}
		
			set b [Button $PARENT.wikiinfo -text [= "Material Info"] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal ]
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
			set ElemType [DWLocalGetValue $GDN $STRUCT "Section:"]
			
			switch $ElemType {
			
				"Fiber" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Fiber_Section"
				} 
				"PlateFiber" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Elastic_Membrane_Plate_Section"
				}
				"ElasticMembranePlate" {
					set cmd "VisitWeb http://opensees.berkeley.edu/wiki/index.php/Plate_Fiber_Section"
				}
			}
		
			set b [Button $PARENT.wikiinfo -text [= "Section Info"] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal ]
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
			
			set b [Button $PARENT.wikiinfo -text [= "More Info"] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal ]
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
			
			set b [Button $PARENT.wikiinfo -text [= "More Info"] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal ]
			grid $b -column 1 -row [expr $ROW+1] -sticky nw -pady 5
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
			
			set b [Button $PARENT.wikiinfo -text [= "More Info"] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal ]
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
			
			set b [Button $PARENT.wikiinfo -text [= "More Info"] -helptext [= "Visit OpenSees Wiki for more information"] -command $cmd -state normal ]
			grid $b -column 1 -row [expr $ROW+2] -sticky nw -pady 5
		}
	}
	return ""
}

proc TK_CheckQuadFieldOptions { event args } {
	switch $event {
		
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
}