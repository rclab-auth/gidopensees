namespace eval InitStressStrain {}

proc InitStressStrain::CheckFieldValues { event args } {

	switch $event {

		SYNC {
			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			set thisMatType [DWLocalGetValue $GDN $STRUCT Material:]
				set SelectedMaterial [DWLocalGetValue $GDN $STRUCT $QUESTION]

			set CompatibleMaterials " \
			Elastic \
			ElasticPerfectlyPlastic \
			ElasticPerfectlyPlasticwithGap \
			Steel01 \
			Steel02 \
			ReinforcingSteel \
			Hysteretic \
			Concrete01 \
			Concrete02 \
			Concrete04 \
			Concrete06 \
			Series \
			Parallel \
			"

			if {![catch {GiD_AccessValue get materials $SelectedMaterial "Material:"}]} {

				set matType [GiD_AccessValue get materials $SelectedMaterial "Material:"]

				if { [lsearch $CompatibleMaterials $matType]==-1 } {

					WarnWinText "Non-compatible Material ($matType) selected for $thisMatType Material"
				}
			} else {

				WarnWinText "Non-compatible material selected for $thisMatType Material"
			}
		}
	}

	return ""
}