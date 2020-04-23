namespace eval FBC {}

# check if selected section is valid
# CAUTION: Section aggregator is not invalid for FBC, but it is not considered properly. It uses only its fiber section

proc FBC::CheckSection { event args } {

	switch $event {

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			set ChosenSection [DWLocalGetValue $GDN $STRUCT $QUESTION]

			if {![catch {GiD_AccessValue get materials $ChosenSection "Section:"}]} {
			set SecType [GiD_AccessValue get materials $ChosenSection "Section:"]

			if { $SecType != "Fiber" && $SecType != "SectionAggregator" && $SecType != "ElasticSection" && $SecType != "FiberCustom" && $SecType != "UserMaterial" } {
				WarnWinText "Non-compatible Section $ChosenSection ($SecType section) selected for Force-Based beam-column elements."
				WarnWinText "It has been changed to Fiber section."
				# Change the value of the field "Section:" to Fiber
				DWLocalSetValue $GDN $STRUCT $QUESTION "Fiber"
			}

			} else {
				WarnWinText "Non-compatible Section selected for Force-based Beam Column Element"
				WarnWinText "It has been changed to Fiber Section"
				DWLocalSetValue $GDN $STRUCT $QUESTION "Fiber"
			}
		}
	}

	return ""
}