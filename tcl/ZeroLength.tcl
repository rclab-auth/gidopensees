namespace eval ZeroLength {}

proc ZeroLength::CheckFieldValues { event args } {

	switch $event {

	SYNC {

		set GDN [lindex $args 0]
		set STRUCT [lindex $args 1]
		set QUESTION [lindex $args 2]

		set CompatibleMaterials " \
		Elastic \
		ElasticPerfectlyPlastic \
		ElasticPerfectlyPlasticwithGap \
		Series \
		Parallel \
		Steel01 \
		Steel02 \
		Hysteretic \
		HyperbolicGap \
		Viscous \
		ViscousDamper \
		InitStrain \
		InitStress \
		PySimple1 \
		TzSimple1 \
		QzSimple1 \
		BondSP01 \
		MinMax \
		"

		# count activated materials
			set MatCounter 0

			if { [DWLocalGetValue $GDN $STRUCT Activate_Ux]==1 } {
			lappend ChosenMaterials [DWLocalGetValue $GDN $STRUCT Ux_material]
			incr MatCounter 1
			}
			if { [DWLocalGetValue $GDN $STRUCT Activate_Uy]==1 } {
			lappend ChosenMaterials [DWLocalGetValue $GDN $STRUCT Uy_material]
			incr MatCounter 1
			}
			if { [DWLocalGetValue $GDN $STRUCT Activate_Uz]==1 } {
			lappend ChosenMaterials [DWLocalGetValue $GDN $STRUCT Uz_material]
			incr MatCounter 1
			}
			if { [DWLocalGetValue $GDN $STRUCT Activate_Rx]==1 } {
			lappend ChosenMaterials [DWLocalGetValue $GDN $STRUCT Rx_material]
			incr MatCounter 1
			}
			if { [DWLocalGetValue $GDN $STRUCT Activate_Ry]==1 } {
			lappend ChosenMaterials [DWLocalGetValue $GDN $STRUCT Ry_material]
			incr MatCounter 1
			}
			if { [DWLocalGetValue $GDN $STRUCT Activate_Rz]==1 } {
			lappend ChosenMaterials [DWLocalGetValue $GDN $STRUCT Rz_material]
			incr MatCounter 1
			}

			if {$MatCounter} {
			foreach mat $ChosenMaterials {
				if {![catch {GiD_AccessValue get materials $mat "Material:"}]} {

				set matType [GiD_AccessValue get materials $mat "Material:"]

				if { [lsearch $CompatibleMaterials $matType]==-1 } {

					WarnWinText "Uncompatible Material ($matType) selected for ZeroLength Element"

				}
				} else {

					WarnWinText "Uncompatible Material selected for ZeroLength Element"

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