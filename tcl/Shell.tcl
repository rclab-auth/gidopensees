namespace eval Shell {}

proc Shell::CheckFieldValues { event args } {

	switch $event {

		SYNC {
			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			set thisElemType [DWLocalGetValue $GDN $STRUCT Element_type:]
			set ChosenSection [DWLocalGetValue $GDN $STRUCT $QUESTION]

			set CompatibeSections " \
			PlateFiber \
			ElasticMembranePlate \
			LayeredShell \
			"

			if {![catch {GiD_AccessValue get materials $ChosenSection "Section:"}]} {

				set secType [GiD_AccessValue get materials $ChosenSection "Section:"]

				if { [lsearch $CompatibeSections $secType]==-1 } {

				WarnWinText "Uncompatible Section ($secType) selected for $thisElemType Element"

				}
			} else {

				WarnWinText "Uncompatible Material selected for $thisElemType Element"
			}
		}
	}

	return ""
}