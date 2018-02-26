namespace eval ConcreteUniaxMaterial {}

proc ConcreteUniaxMaterial::GenerateValues { event args } {

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
					"ConcreteCM" {
						if {$format == "Mean" } {
							set ok [DWLocalSetValue $GDN $STRUCT "Concrete_compressive_strength_fpcc" $fcm$unit]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_at_compressive_strength_epcc" $ec1]
							set ok [DWLocalSetValue $GDN $STRUCT "Initial_tangent_modulus_Ec" $E$Eunit]
							set ok [DWLocalSetValue $GDN $STRUCT "Tensile_strength_ft" $fctm$unit]
						} elseif {$format == "Characteristic"} {
							set ok [DWLocalSetValue $GDN $STRUCT "Concrete_compressive_strength_fpcc" $fck$unit]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_at_compressive_strength_epcc" $ec1]
							set ok [DWLocalSetValue $GDN $STRUCT "Initial_tangent_modulus_Ec" $E$Eunit]
							set ok [DWLocalSetValue $GDN $STRUCT "Tensile_strength_ft" $fctm$unit]
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