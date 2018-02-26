namespace eval Damage2p {
}

proc Damage2p::GenerateDefaultValues { event args } {

	switch $event {

		INIT {

		return ""
		}

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]
			set unit "MPa"
			set Eunit "GPa"
			set AssignDefault [DWLocalGetValue $GDN $STRUCT $QUESTION]

			if {$AssignDefault==1} {

				set fccValueUnit [DWLocalGetValue $GDN $STRUCT "Concrete_compressive_strength"]

				set temp [GidConvertValueUnit $fccValueUnit]
				set temp [ParserNumberUnit $temp fccValue fccUnit]

				set fccValue [ConvertToMPa $fccValue $fccUnit]

				set fct [expr 0.1*abs($fccValue)]
				set E [format "%1.5g" [expr 4.75*sqrt(abs($fccValue)) ]]
				set Gt [format "%1.3e" [expr 1840*$fct*$fct/(1000*$E)/1000]]
				set Gc [format "%1.3e" [expr 6250*$fccValue*$fccValue/(1000*$E)/1000]]
				set rho_bar 0.20
				set H [format "%1.4g" [expr 0.25*$E]]
				set theta 0.50
				set ok [DWLocalSetValue $GDN $STRUCT Concrete_tensile_strength $fct$unit]
				set ok [DWLocalSetValue $GDN $STRUCT Young_Modulus $E$Eunit]
				set ok [DWLocalSetValue $GDN $STRUCT Poisson_coefficient 0.15]
				set ok [DWLocalSetValue $GDN $STRUCT Tension_fracture_energy_density $Gt$Eunit]
				set ok [DWLocalSetValue $GDN $STRUCT Comp._fracture_energy_density $Gc$Eunit]
				set ok [DWLocalSetValue $GDN $STRUCT Parameter_of_plastic_volume_change $rho_bar]
				set ok [DWLocalSetValue $GDN $STRUCT Parameter_of_plastic_volume_change $rho_bar]
				set ok [DWLocalSetValue $GDN $STRUCT Linear_hardening_parameter $H$Eunit]
				set ok [DWLocalSetValue $GDN $STRUCT Isotropic/kinematic_hardening_ratio $theta]
				set ok [DWLocalSetValue $GDN $STRUCT Computational_stiffness_matrix "Computational_tangent"]

				return ""
			}
		}
	}

	return ""
}