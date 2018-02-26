namespace eval SteelUniaxMaterial {}

proc SteelUniaxMaterial::GenerateValues { event args } {

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
					"Steel02" {
					set ok [DWLocalSetValue $GDN $STRUCT "Yield_Stress_Fy" $Fy$unit]
					set ok [DWLocalSetValue $GDN $STRUCT "Initial_elastic_tangent_E0" $E$Eunit]
					return ""
					}
					"ReinforcingSteel" {
					set ok [DWLocalSetValue $GDN $STRUCT "Yield_stress_fy" $Fy$unit]
					set ok [DWLocalSetValue $GDN $STRUCT "Initial_elastic_tangent_Es" $E$Eunit]
					return ""
					}
					"RambergOsgoodSteel" {
					set ok [DWLocalSetValue $GDN $STRUCT "Yield_stress_fy" $Fy$unit]
					set ok [DWLocalSetValue $GDN $STRUCT "Initial_elastic_tangent_E0" $E$Eunit]
					}
				}
		}
	}

	return ""
}