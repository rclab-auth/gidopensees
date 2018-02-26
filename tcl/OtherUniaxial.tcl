namespace eval OtherUniaxMaterials {}

proc OtherUniaxMaterials::GenerateValues { event args } {

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
					set dummy [TK_DWSet $GDN $STRUCT $QUESTION "Steel" normal]
				} elseif { $mat_type == "Concrete" } {
					set dummy [TK_DWSet $GDN $STRUCT $QUESTION "Concrete" normal]
				}
			}
		}

		CLOSE {

			return ""
		}
	}

	return ""
}