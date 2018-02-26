namespace eval IntvData {}

proc IntvData::MotionDirections { event args } {

	switch $event {

		DEPEND {

			lassign $args GDN STRUCT QUESTION ACTION VALUE
			set Dirs [DWLocalGetValue $GDN $STRUCT Directions]
			if { $ACTION == "RESTORE" } {
				set exc_type [DWLocalGetValue $GDN $STRUCT Excitation_type]
				if { $exc_type == "Sine" } {

					set dummy [TK_DWSet $GDN $STRUCT Directions 1 disabled]
					set dummy [TK_DWSet $GDN $STRUCT "Ground_motion_direction" "#CURRENT#" normal]
					set dummy [TK_DWSet $GDN $STRUCT "First_record_file" "#CURRENT#" hidden]
					set dummy [TK_DWSet $GDN $STRUCT "Second_record_file" "#CURRENT#" hidden]
					set dummy [TK_DWSet $GDN $STRUCT "Third_record_file" "#CURRENT#" hidden]
					set dummy [TK_DWSet $GDN $STRUCT "First_ground_motion_direction" "#CURRENT#" hidden]
					set dummy [TK_DWSet $GDN $STRUCT "Second_ground_motion_direction" "#CURRENT#" hidden]
					set dummy [TK_DWSet $GDN $STRUCT "Third_ground_motion_direction" "#CURRENT#" hidden]
					set dummy [TK_DWSet $GDN $STRUCT "Record_file" "#CURRENT#" hidden]

				} elseif { $exc_type == "Record" } {

					if { $Dirs == 1 } {

						set dummy [TK_DWSet $GDN $STRUCT "Record_file" "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT "Ground_motion_direction" "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT "First_record_file" "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT "Second_record_file" "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT "Third_record_file" "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT "First_ground_motion_direction" "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT "Second_ground_motion_direction" "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT "Third_ground_motion_direction" "#CURRENT#" hidden]

					} elseif { $Dirs == 2} {

						set dummy [TK_DWSet $GDN $STRUCT "Record_file" "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT "Ground_motion_direction" "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT "First_record_file" "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT "Second_record_file" "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT "Third_record_file" "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT "First_ground_motion_direction" "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT "Second_ground_motion_direction" "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT "Third_ground_motion_direction" "#CURRENT#" hidden]

					} else {

						set dummy [TK_DWSet $GDN $STRUCT "Record_file" "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT "Ground_motion_direction" "#CURRENT#" hidden]
						set dummy [TK_DWSet $GDN $STRUCT "First_record_file" "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT "Second_record_file" "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT "Third_record_file" "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT "First_ground_motion_direction" "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT "Second_ground_motion_direction" "#CURRENT#" normal]
						set dummy [TK_DWSet $GDN $STRUCT "Third_ground_motion_direction" "#CURRENT#" normal]

					}
				}
			}
		}

	}

	return ""
}

proc IntvData::ExcitationType { event args } {

	switch $event {

		DEPEND {

			lassign $args GDN STRUCT QUESTION ACTION VALUE
			if { $ACTION == "RESTORE" } {
				set exc_type [DWLocalGetValue $GDN $STRUCT $QUESTION]
				if { $exc_type == "Sine" } {
					set dummy [TK_DWSet $GDN $STRUCT "Excitation_type" "Sine" normal]
				} elseif { $exc_type == "Record" } {
					set dummy [TK_DWSet $GDN $STRUCT "Excitation_type" "Record" normal]
				}
			} elseif { $ACTION == "HIDE" } {

				set dummy [TK_DWSet $GDN $STRUCT Directions "#CURRENT#" hidden]
				set dummy [TK_DWSet $GDN $STRUCT "Ground_motion_direction" "#CURRENT#" hidden]
				set dummy [TK_DWSet $GDN $STRUCT "First_record_file" "#CURRENT#" hidden]
				set dummy [TK_DWSet $GDN $STRUCT "Second_record_file" "#CURRENT#" hidden]
				set dummy [TK_DWSet $GDN $STRUCT "Third_record_file" "#CURRENT#" hidden]
				set dummy [TK_DWSet $GDN $STRUCT "First_ground_motion_direction" "#CURRENT#" hidden]
				set dummy [TK_DWSet $GDN $STRUCT "Second_ground_motion_direction" "#CURRENT#" hidden]
				set dummy [TK_DWSet $GDN $STRUCT "Third_ground_motion_direction" "#CURRENT#" hidden]
				set dummy [TK_DWSet $GDN $STRUCT "Record_file" "#CURRENT#" hidden]
			}
		}
	}

	return ""
}

proc IntvData::Integrator { event args } {

	switch $event {

		DEPEND {

		lassign $args GDN STRUCT QUESTION ACTION VALUE
		if { $ACTION == "RESTORE" } {
				set integrator_type [DWLocalGetValue $GDN $STRUCT $QUESTION]
				set analysis_type [DWLocalGetValue $GDN $STRUCT Analysis_type]

				set StaticIntegratorTypes " \
				Load_control \
				Displacement_control \
				"

				set TransientIntegratorTypes " \
				Newmark \
				Hilber-Hughes-Taylor \
				"

				if { $analysis_type == "Static" } {
					if { [lsearch $StaticIntegratorTypes $integrator_type] == -1 } {
						set dummy [TK_DWSet $GDN $STRUCT $QUESTION Load_control normal]
					}

				} elseif { $analysis_type == "Transient" } {

					if { [lsearch $TransientIntegratorTypes $integrator_type] == -1 } {
						set dummy [TK_DWSet $GDN $STRUCT $QUESTION Newmark normal]
					}
				}
			}
		}
	}

	return ""
}

proc IntvData::LoadingPath { event args } {

	switch $event {

	DEPEND {

	lassign $args GDN STRUCT QUESTION ACTION VALUE
		if { $ACTION == "SET" } {

				set dummy [TK_DWSet $GDN $STRUCT $QUESTION $VALUE normal]
				set dummy [TK_DWSet $GDN $STRUCT $QUESTION $VALUE disabled]

			}
		}
	}

	return ""
}

proc IntvData::LoadingType { event args } {

	switch $event {

		DEPEND {

		lassign $args GDN STRUCT QUESTION ACTION VALUE
		if { $ACTION == "RESTORE" } {
				set loading_type [DWLocalGetValue $GDN $STRUCT $QUESTION]
				set integrator_type [DWLocalGetValue $GDN $STRUCT Integrator_type]

				set StaticIntegratorTypes " \
				Load_control \
				Displacement_control \
				"

				set StaticLoadingTypes " \
				Constant \
				Linear \
				"

				set TransientIntegratorTypes " \
				Newmark \
				Hilber-Hughes-Taylor \
				"

				set TransientLoadingTypes " \
				Uniform_excitation \
				Multiple_support_excitation \
				Function \
				"
				if { [lsearch $StaticIntegratorTypes $integrator_type] == -1 && [lsearch $StaticLoadingTypes $loading_type] != -1 } {
					set dummy [TK_DWSet $GDN $STRUCT $QUESTION Uniform_excitation normal]
				}

				if { [lsearch $TransientIntegratorTypes $integrator_type] == -1 && [lsearch $TransientLoadingTypes $loading_type] != -1 } {
					set dummy [TK_DWSet $GDN $STRUCT $QUESTION Linear normal]
				}
			}
		}
	}

	return ""
}

proc IntvData::CtrlNodeDirection {event args } {

	switch $event {

		DEPEND {

			lassign $args GDN STRUCT QUESTION ACTION VALUE
			if { $ACTION == "RESTORE" } {
				set CtrlNodeDir [DWLocalGetValue $GDN $STRUCT $QUESTION]
				if { $CtrlNodeDir == "UX" } {
					set dummy [TK_DWSet $GDN $STRUCT "Total_displacement" "#CURRENT#" normal]
				} elseif { $CtrlNodeDir == "UY" } {
					set dummy [TK_DWSet $GDN $STRUCT "Total_displacement" "#CURRENT#" normal]
				} elseif { $CtrlNodeDir == "UZ" } {
					set dummy [TK_DWSet $GDN $STRUCT "Total_displacement" "#CURRENT#" normal]
				} elseif { $CtrlNodeDir == "RX" } {
					set dummy [TK_DWSet $GDN $STRUCT "Total_rotation" "#CURRENT#" normal]
				} elseif { $CtrlNodeDir == "RY" } {
					set dummy [TK_DWSet $GDN $STRUCT "Total_rotation" "#CURRENT#" normal]
				} elseif { $CtrlNodeDir == "RZ" } {
					set dummy [TK_DWSet $GDN $STRUCT "Total_rotation" "#CURRENT#" normal]
				}
			}
		}
	}

	return ""
}

proc IntvData::ToleranceRelaxation {event args} {

	switch $event {

		DEPEND {

			lassign $args GDN STRUCT QUESTION ACTION VALUE
			if { $ACTION == "RESTORE" } {
				set Checked [DWLocalGetValue $GDN $STRUCT $QUESTION]
				if { $Checked } {

					set dummy [TK_DWSet $GDN $STRUCT $QUESTION 1 normal]
				}

			} elseif {$ACTION == "HIDE" } {

				set dummy [TK_DWSet $GDN $STRUCT Tolerance_relaxation_after_failed_substepping_of "#CURRENT#" hidden]
				set dummy [TK_DWSet $GDN $STRUCT Relaxation_factor "#CURRENT#" hidden]
			}
		}
	}
	return ""

}