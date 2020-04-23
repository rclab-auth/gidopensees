namespace eval Shell {}

proc Shell::CheckFieldValues { event args } {

	switch $event {

		SYNC {
			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			set thisElemType [DWLocalGetValue $GDN $STRUCT Element_type:]
			set ChosenSection [DWLocalGetValue $GDN $STRUCT $QUESTION]

			set CompatibleSections " \
			PlateFiber \
			ElasticMembranePlate \
			LayeredShell \
			UserMaterial \
			"

			if {![catch {GiD_AccessValue get materials $ChosenSection "Section:"}]} {

				set secType [GiD_AccessValue get materials $ChosenSection "Section:"]

				if { [lsearch $CompatibleSections $secType]==-1 } {

				WarnWinText "Non-compatible Section ($secType) selected for $thisElemType Element"

				}
			} else {

				WarnWinText "Non-compatible Material selected for $thisElemType Element"
			}
		}
	}

	return ""
}