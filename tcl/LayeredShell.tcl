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

			set ChosenLongBarMaterial [DWLocalGetValue $GDN $STRUCT "Longitudinal_steel_material"]
			set ChosenTransBarMaterial [DWLocalGetValue $GDN $STRUCT "Transverse_steel_material"]

			set ChosenLongBarMaterialType [GiD_AccessValue get materials $ChosenLongBarMaterial "Material:"]
			set ChosenTransBarMaterialType [GiD_AccessValue get materials $ChosenTransBarMaterial "Material:"]

			if { [lsearch $CompatibleSteelMaterials $ChosenLongBarMaterialType]==-1 } {
					WarnWinText "Non-compatible steel material ($ChosenLongBarMaterialType) selected for LayeredShell Section"
					DWLocalSetValue $GDN $STRUCT "Longitudinal_steel_material" "Steel02"
			}

			if { [lsearch $CompatibleSteelMaterials $ChosenTransBarMaterialType]==-1 } {
					WarnWinText "Non-compatible steel material ($ChosenTransBarMaterialType) selected for LayeredShell Section"
					DWLocalSetValue $GDN $STRUCT "Transverse_steel_material" "Steel02"
			}

			set fcunit [DWLocalGetValue $GDN $STRUCT "Cover_fc"]

			set temp [GidConvertValueUnit $fcunit]
			set temp [ParserNumberUnit $temp fc stressUnit]

			if {$fc < 0 } {
				set fc [expr (-1)*$fc]
				set fcunit $fc$stressUnit
				set ok [DWLocalSetValue $GDN $STRUCT Cover_fc $fcunit]
				WarnWinText "For LayeredShell section, concrete compressive strength is positive"
			}

			set fcunit [DWLocalGetValue $GDN $STRUCT "Core_fc"]

			set temp [GidConvertValueUnit $fcunit]
			set temp [ParserNumberUnit $temp fc stressUnit]

			if {$fc < 0 } {
				set fc [expr (-1)*$fc]
				set fcunit $fc$stressUnit
				set ok [DWLocalSetValue $GDN $STRUCT Core_fc $fcunit]
				WarnWinText "For LayeredShell section, concrete compressive strength is positive"
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

				set WUnit [DWLocalGetValue $GDN $STRUCT Wall_width]
				set nLong [DWLocalGetValue $GDN $STRUCT Longitudinal_bars]
				set nTrans [DWLocalGetValue $GDN $STRUCT Transverse_bars]
				set LongSizeUnit [DWLocalGetValue $GDN $STRUCT Longitudinal_bar_diameter]
				set TransSizeUnit [DWLocalGetValue $GDN $STRUCT Transverse_bar_diameter]
				set LongSpaceUnit [DWLocalGetValue $GDN $STRUCT Longitudinal_reinforcement_spacing]
				set TransSpaceUnit [DWLocalGetValue $GDN $STRUCT Transverse_reinforcement_spacing]

				set temp [GidConvertValueUnit $WUnit]
				set temp [ParserNumberUnit $temp W lengthunit]
				set temp [GidConvertValueUnit $LongSpaceUnit]
				set temp [ParserNumberUnit $temp LongSpace lengthunit]
				set temp [GidConvertValueUnit $TransSpaceUnit]
				set temp [ParserNumberUnit $temp TransSpace lengthunit]
				set temp [GidConvertValueUnit $LongSizeUnit]
				set temp [ParserNumberUnit $temp LongSize barunit]
				set temp [GidConvertValueUnit $TransSizeUnit]
				set temp [ParserNumberUnit $temp TransSize barunit]

				if {$LongSpace != 0} {
					set LongRatio [format "%1.3e" [expr $nLong*$pi*$LongSize*$LongSize/4.0/$LongSpace/$W]]
				} else {
					set LongRatio 0
				}
				
				if {$TransSpace != 0} {
					set TransRatio [format "%1.3e" [expr $nTrans*$pi*$TransSize*$TransSize/4.0/$TransSpace/$W]]
				} else {
					set TransRatio 0
				}

				set ok [DWLocalSetValue $GDN $STRUCT Longitudinal_reinforcement_ratio $LongRatio]
				set ok [DWLocalSetValue $GDN $STRUCT Transverse_reinforcement_ratio $TransRatio]
			}
		}
	}
	return ""
}