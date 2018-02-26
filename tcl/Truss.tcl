namespace eval Truss {}

proc Truss::CheckFieldValues { event args } {

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
		ReinforcingSteel \
		RambergOsgoodSteel \
		Hysteretic \
		HyperbolicGap \
		Viscous \
		ViscousDamper \
		InitStrain \
		InitStress \
		Concrete01 \
		Concrete02 \
		Concrete04 \
		Concrete06 \
		ConcreteCM \
		BondSP01 \
		MinMax \
		"

		set ThisElemType [DWLocalGetValue $GDN $STRUCT Element_type:]
		set ChosenMaterial [DWLocalGetValue $GDN $STRUCT $QUESTION]

		if {![catch {GiD_AccessValue get materials $ChosenMaterial "Material:"}]} {

			set matType [GiD_AccessValue get materials $ChosenMaterial "Material:"]

			if { [lsearch $CompatibleMaterials $matType]==-1 } {

				WarnWinText "Uncompatible Material ($matType) selected for $ThisElemType Element"

			}
		} else {

			WarnWinText "Uncompatible Material selected for $ThisElemType Element"
		}
		}
	}

	return ""
}