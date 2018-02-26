namespace eval LayeredShell {
}

proc LayeredShell::CheckFieldValues { event args } {

	switch $event {

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			set CompatibleSteelMaterials " \
			Steel01 \
			Steel02 \
			ReinforcingSteel \
			RamberOsgoodSteel \
			Hysteretic \
			"

			set ChosenLongBarMaterial [DWLocalGetValue $GDN $STRUCT "Longitudinal_bar_material"]
			set ChosenTransvBarMaterial [DWLocalGetValue $GDN $STRUCT "Transverse_bar_material"]

			set ChosenLongBarMaterialType [GiD_AccessValue get materials $ChosenLongBarMaterial "Material:"]
			set ChosenTransvBarMaterialType [GiD_AccessValue get materials $ChosenTransvBarMaterial "Material:"]

			if { [lsearch $CompatibleSteelMaterials $ChosenLongBarMaterialType]==-1 } {
					WarnWinText "Uncompatible steel material ($ChosenLongBarMaterialType) selected for LayeredShell Section"
					DWLocalSetValue $GDN $STRUCT "Longitudinal_bar_material" "Steel02"
			}

			if { [lsearch $CompatibleSteelMaterials $ChosenTransvBarMaterialType]==-1 } {
					WarnWinText "Uncompatible steel material ($ChosenTransvBarMaterialType) selected for LayeredShell Section"
					DWLocalSetValue $GDN $STRUCT "Transverse_bar_material" "Steel02"
			}

			set fcunit [DWLocalGetValue $GDN $STRUCT "Concrete_compressive_strength"]

			set temp [GidConvertValueUnit $fcunit]
			set temp [ParserNumberUnit $temp fc stressUnit]

			if {$fc < 0 } {
				set fc [expr (-1)*$fc]
				set fcunit $fc$stressUnit
				set ok [DWLocalSetValue $GDN $STRUCT Concrete_compressive_strength $fcunit]
				WarnWinText "For LayeredShell Section Concrete compressive strength is entered as positive value"
			}
		}
	}
}

proc LayeredShell::CalcBarAreas {event args } {

	switch $event {

		SYNC {

			set pi 3.14159265358979323846
			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			set checked [DWLocalGetValue $GDN $STRUCT $QUESTION]

			if {$checked} {

				set LongSizeUnit [DWLocalGetValue $GDN $STRUCT Longitudinal_bar_size]
				set TransvSizeUnit [DWLocalGetValue $GDN $STRUCT Transverse_bar_size]
				set temp [GidConvertValueUnit $LongSizeUnit]
				set temp [ParserNumberUnit $temp LongSize barunit]

				set temp [GidConvertValueUnit $TransvSizeUnit]
				set temp [ParserNumberUnit $temp TransvSize barunit]

				set LongArea [format "%1.3e" [expr $pi*($LongSize*$LongSize)/4.0]]
				set LongArea $LongArea$barunit^2

				set TransvArea [format "%1.3e" [expr $pi*($TransvSize*$TransvSize)/4.0]]
				set TransvArea $TransvArea$barunit^2

				set ok [DWLocalSetValue $GDN $STRUCT Longitudinal_bar_area $LongArea]
				set ok [DWLocalSetValue $GDN $STRUCT Transverse_bar_area $TransvArea]
			}
		}
	}
	return ""
}