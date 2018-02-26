namespace eval PIMY {}

proc PIMY::TK_GenerateRecommendedValues { event args } {

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

proc PIMY::CheckIntvNum { event args } {

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