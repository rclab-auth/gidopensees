namespace eval MinMax {}

proc MinMax::CheckFieldValues { event args } {

	switch $event {

	SYNC {

		set GDN [lindex $args 0]
		set STRUCT [lindex $args 1]
		set QUESTION [lindex $args 2]

		set CompatibleMaterials " \
		Elastic \
		ElasticPerfectlyPlastic \
		ElasticPerfectlyPlasticwithGap \
		Steel01 \
		Steel02 \
		Hysteretic \
		RamberOsgoodSteel \
		Concrete01 \
		Concrete02 \
		Concrete04 \
		Concrete06 \
		ConcreteCM \
		"

	set formulation [DWLocalGetValue $GDN $STRUCT $QUESTION]

	if {$formulation == "Stress-Strain"} {

		set mat [DWLocalGetValue $GDN $STRUCT "Material_for_defining_stress-strain_behaviour"]

	} elseif {$formulation == "Force-Deformation"} {

		set mat [DWLocalGetValue $GDN $STRUCT "Material_for_defining_force-deformation_behaviour"]

	} elseif {$formulation == "Moment-Rotation"} {

		set mat [DWLocalGetValue $GDN $STRUCT "Material_for_defining_moment-rotation_behaviour"]

	}

	set mattype [GiD_AccessValue get materials $mat "Material:"]

	if { [lsearch $CompatibleMaterials $mattype]==-1 } {

		WarnWinText "Non-compatible Material ($mattype) selected for MinMax Material"

	}
	}

	}
	return ""
}