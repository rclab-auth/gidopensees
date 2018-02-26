namespace eval Quad {}

proc Quad::CheckFieldValues { event args } {

	switch $event {

		CLOSE {

			UpdateInfoBar
		}

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]
			set SelMat [DWLocalGetValue $GDN $STRUCT Material]
			set Behavior [DWLocalGetValue $GDN $STRUCT Plane_behavior]
			set MatType [GiD_AccessValue get materials $SelMat "Material:"]

			if { $MatType=="PressureDependMultiYield" || $MatType=="PressureIndependMultiYield" } {

				if { $Behavior=="PlaneStress" } {

					WarnWinText "For PressureDependMultiYield or PressureIndependMultiYield Material use PlaneStrain behavior"
				}
			}
		}
	}

	return ""
}