namespace eval EBC {}

proc EBC::CheckMaterial { event args } {

	switch $event {

		INIT {

			return ""
		}

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			set ChosenMaterial [DWLocalGetValue $GDN $STRUCT $QUESTION]
			set MatType [GiD_AccessValue get materials $ChosenMaterial "Material:"]

			if { $MatType != "ElasticIsotropic" && $MatType != "UserMaterial" } {
				WarnWinText "Material $ChosenMaterial ($MatType material) can not be used for beam-column elements."
				WarnWinText "Use an elastic isotropic material instead."

				# Change the value of the field "Material:" to Elastic_Isotropic

				DWLocalSetValue $GDN $STRUCT $QUESTION "Elastic_Isotropic"
			}

			return ""
		}

		DEPEND {

			return ""
		}

		CLOSE {

			return ""
		}
	}

	return ""
}