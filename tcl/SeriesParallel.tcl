namespace eval SeriesParallel {}

proc SeriesParallel::CheckFieldValues { event args } {

	switch $event {

		SYNC {
			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			set thisMatType [DWLocalGetValue $GDN $STRUCT Material:]

			set CompatibleMaterials " \
			Elastic \
			ElasticPerfectlyPlastic \
			ElasticPerfectlyPlasticwithGap \
			Steel01 \
			Steel02 \
			RamberOsgoodSteel \
			ReinforcingSteel \
			Hysteretic \
			Concrete01 \
			Concrete02 \
			Concrete04 \
			Concrete06 \
			ConcreteCM \
			Viscous \
			"

			# count activated materials
			set MatCounter 0

			if { [DWLocalGetValue $GDN $STRUCT Activate_1st_material]==1 } {
			lappend ChosenMaterials [DWLocalGetValue $GDN $STRUCT Material_1]
			incr MatCounter 1
			}
			if { [DWLocalGetValue $GDN $STRUCT Activate_2nd_material]==1 } {
			lappend ChosenMaterials [DWLocalGetValue $GDN $STRUCT Material_2]
			incr MatCounter 1
			}
			if { [DWLocalGetValue $GDN $STRUCT Activate_3rd_material]==1 } {
			lappend ChosenMaterials [DWLocalGetValue $GDN $STRUCT Material_3]
			incr MatCounter 1
			}
			if { [DWLocalGetValue $GDN $STRUCT Activate_4th_material]==1 } {
			lappend ChosenMaterials [DWLocalGetValue $GDN $STRUCT Material_4]
			incr MatCounter 1
			}
			if { [DWLocalGetValue $GDN $STRUCT Activate_5th_material]==1 } {
			lappend ChosenMaterials [DWLocalGetValue $GDN $STRUCT Material_5]
			incr MatCounter 1
			}

			if {$MatCounter} {
			foreach mat $ChosenMaterials {
				set matType [GiD_AccessValue get materials $mat "Material:"]

				if { [lsearch $CompatibleMaterials $matType]==-1 } {

					WarnWinText "Uncompatible Material ($matType) selected for $thisMatType Material"

				}
			}
			}
		}

		CLOSE {

			UpdateInfoBar
		}
	}

	return ""
}

