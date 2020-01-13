namespace eval OS_Octree {

}

namespace eval BeamContact {

}

proc BeamContact::CheckFieldValues { event args } {

	switch $event {

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			set ChosenMaterial [DWLocalGetValue $GDN $STRUCT Contact_material]

				if {![catch {GiD_AccessValue get materials $ChosenMaterial "Material:"}]} {

					set matType [GiD_AccessValue get materials $ChosenMaterial "Material:"]

					if { $matType != "Contact" } {

						WarnWinText "Uncompatible Material ($matType) selected for BeamContact Element"

					}
				}
		}
		CLOSE {

			UpdateInfoBar

		}
	}

	return ""
}