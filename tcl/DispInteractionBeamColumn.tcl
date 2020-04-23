namespace eval DIBC {}

proc DIBC::CheckSection { event args } {

	switch $event {

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			set ChosenSection [DWLocalGetValue $GDN $STRUCT $QUESTION]

			if {![catch {GiD_AccessValue get materials $ChosenSection "Section:"}]} {
			set SecType [GiD_AccessValue get materials $ChosenSection "Section:"]

			if { $SecType != "FiberInt" && $SecType != "UserMaterial" } {
				WarnWinText "Non-compatible Section $ChosenSection ($SecType section) selected for F-S Interaction Displacement-Based beam-column elements."
				WarnWinText "It has been changed to FiberInt section."

				DWLocalSetValue $GDN $STRUCT $QUESTION "FiberInt"
			}
			} else {
				WarnWinText "Non-compatible Section selected for F-S Interaction Displacement-Based Beam Column Element"
				WarnWinText "It has been changed to FiberInt Section"
				DWLocalSetValue $GDN $STRUCT $QUESTION "FiberInt"
			}
		}
	}

	return ""
}