#!/usr/bin/env tclsh
package require gid_graph
package require Plotchart
proc TK_MaterialTester {event args} {

	switch $event {

		INIT {
				source -encoding utf-8 [file join [OpenSees::GetProblemTypePath] tcl/Units_Constants_Metric.tcl]
				global PARENT
				set PARENT [lindex $args 0]
				upvar [lindex $args 1] ROW
				global GDN
				set GDN [lindex $args 2]
				global STRUCT
				set STRUCT [lindex $args 3]
				global QUESTION
				set QUESTION [lindex $args 4]
				global mat
				set mat [DWLocalGetValue $GDN $STRUCT "Material:"]
				global targetc
				global targett
				global loadingtype
				global Mat_desc

				global testmaterial

				switch $mat {
					"Elastic" {
						set testmaterial 1
					}
					"ElasticPerfectlyPlastic" {
						set testmaterial 2
					}
					"ElasticPerfectlyPlasticwithGap" {
						set testmaterial 3
					}
					"Viscous" {
						set testmaterial 4
					}
					"ViscousDamper" {
						set testmaterial 5
					}
					"HyperbolicGap" {
						set testmaterial 6
					}
					"PySimple1" {
						set testmaterial 7
					}
					"TzSimple1" {
						set testmaterial 8
					}
					"QzSimple1" {
						set testmaterial 9
					}
					"BondSP01" {
						set testmaterial 10
					}
					"Concrete01" {
						set testmaterial 11
					}
					"Concrete02" {
						set testmaterial 12
					}
					"Concrete04" {
						set testmaterial 13
					}
					"Concrete06" {
						set testmaterial 14
					}
					"ConcreteCM" {
						set testmaterial 15
					}
					"Steel01" {
						set testmaterial 16
					}
					"Steel02" {
						set testmaterial 17
					}
					"ReinforcingSteel" {
						set testmaterial 18
					}
					"Hysteretic" {
						set testmaterial 19
					}
					"RambergOsgoodSteel" {
						set testmaterial 20
					}
				}

			set cmd {
					if {$testmaterial == 1} {
							DWModifyMat $GDN
							set E [DWLocalGetValue $GDN $STRUCT "Elastic_modulus_E"]
							set Eunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $E {}]
							set E [expr [scan $E %f]*[subst $\{$Eunit\}]]
							set Mat_desc "uniaxialMaterial Elastic 1 $E"
							set targetc -0.005
							set targett 0.005
							set loading [DWLocalGetValue $GDN $STRUCT "Analysis_type"]
							switch $loading {
							"Monotonic" {
								set loadingtype 1
							}
							"Cyclic" {
								set loadingtype 2

							}
							}
					} elseif {$testmaterial == 2} {
							DWModifyMat $GDN
							set E [DWLocalGetValue $GDN $STRUCT "Elastic_modulus_E"]
							set Eunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $E {}]
							set E [expr [scan $E %f]*[subst $\{$Eunit\}]]
							set epsP [DWLocalGetValue $GDN $STRUCT "Strain_epsP"]
							set epsN [DWLocalGetValue $GDN $STRUCT "Strain_epsN"]
							set eps0 [DWLocalGetValue $GDN $STRUCT "Initial_Strain_eps0"]
							set Mat_desc "uniaxialMaterial ElasticPP 1 $E $epsP $epsN $eps0"
							set targetc [expr 2*$epsN]
							set targett [expr 2*$epsP]
							set loading [DWLocalGetValue $GDN $STRUCT "Analysis_type"]
							switch $loading {
							"Monotonic" {
								set loadingtype 1
							}
							"Cyclic" {
								set loadingtype 2
							}
							}
					} elseif {$testmaterial == 3} {
							DWModifyMat $GDN
							set E [DWLocalGetValue $GDN $STRUCT "Elastic_modulus_E"]
							set Eunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $E {}]
							set E [expr [scan $E %f]*[subst $\{$Eunit\}]]
							set Fy [DWLocalGetValue $GDN $STRUCT "Yield_Stress_Fy"]
							set Fyunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $Fy {}]
							set Fy [expr [scan $Fy %f]*[subst $\{$Fyunit\}]]
							set gap [DWLocalGetValue $GDN $STRUCT "Strain_gap"]
							set Mat_desc "uniaxialMaterial ElasticPPGap 1 $E $Fy $gap"
							if {$Fy < 0 } {
								set targetc [expr 2*$Fy/$E - $gap]
								set targett 0.002
							} else {
								set targetc -0.002
								set targett [expr 2*$Fy/$E + $gap]
							}
							set loading [DWLocalGetValue $GDN $STRUCT "Analysis_type"]
							switch $loading {
							"Monotonic" {
								set loadingtype 1
							}
							"Cyclic" {
								set loadingtype 2
							}
							}
					} elseif {$testmaterial == 4} {
							DWModifyMat $GDN
							set C [DWLocalGetValue $GDN $STRUCT "Damping_Coefficient"]
							set Cunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $C {}]
							set C [expr [scan $C %f]*[subst $\{$Cunit\}]]
							set alpha [DWLocalGetValue $GDN $STRUCT "Power_factor_alpha"]
							set Mat_desc "uniaxialMaterial Viscous 1 $C $alpha"
							set targetc -0.005
							set targett 0.005
					} elseif {$testmaterial == 5} {
							DWModifyMat $GDN
							set K [DWLocalGetValue $GDN $STRUCT "Elastic_Stiffness"]
							set Kunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $K {}]
							set K [expr [scan $K %f]*[subst $\{$Kunit\}]]
							set Cd [DWLocalGetValue $GDN $STRUCT "Damping_coefficient_Cd"]
							set Cdunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $Cd {}]
							set Cd [expr [scan $Cd %f]*[subst $\{$Cdunit\}]]
							set alpha [DWLocalGetValue $GDN $STRUCT "Velocity_exponent_alpha"]
							set LGap [DWLocalGetValue $GDN $STRUCT "Activate_gap_length"]
							set targetc -0.005
							set targett 0.005
							if {$LGap != 0 } {
								set gap [DWLocalGetValue $GDN $STRUCT "Gap_length"]
								set gapunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $gap {}]
								set gap [expr [scan $gap %f]*[subst $\{$gapunit\}]]
								set Mat_desc "uniaxialMaterial ViscousDamper 1 $K $Cd $alpha $gap"
								set targetc [expr -0.005-$gap]
								set targett [expr 0.005+$gap]
							} else {
								set Mat_desc "uniaxialMaterial ViscousDamper 1 $K $Cd $alpha"
							}
							set loading [DWLocalGetValue $GDN $STRUCT "Analysis_type"]
							switch $loading {
							"Monotonic" {
								set loadingtype 1
							}
							"Cyclic" {
								set loadingtype 2
							}
							}

					} elseif {$testmaterial == 6} {
							DWModifyMat $GDN
							set Kmax [DWLocalGetValue $GDN $STRUCT "Initial_stiffness"]
							set Kmaxunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $Kmax {}]
							set Kmax [expr [scan $Kmax %f]*[subst $\{$Kmaxunit\}]]
							set Kur [DWLocalGetValue $GDN $STRUCT "Unloading/Reloading_stiffness"]
							set Kurunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $Kur {}]
							set Kur [expr [scan $Kur %f]*[subst $\{$Kurunit\}]]
							set Rf [DWLocalGetValue $GDN $STRUCT "Failure_ratio"]
							set Fult [DWLocalGetValue $GDN $STRUCT "Ultimate_passive_resistance"]
							set Fultunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $Fult {}]
							set Fult [expr [scan $Fult %f]*[subst $\{$Fultunit\}]]
							set gap [DWLocalGetValue $GDN $STRUCT "Initial_gap"]
							set gapunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $gap {}]
							set gap [expr [scan $gap %f]*[subst $\{$gapunit\}]]
							set Mat_desc "uniaxialMaterial HyperbolicGapMaterial 1 $Kmax $Kur $Rf $Fult $gap"
							set targetc [expr -0.1-$gap]
							set targett [expr 0.1]
							set loading [DWLocalGetValue $GDN $STRUCT "Analysis_type"]
							switch $loading {
							"Monotonic" {
								set loadingtype 1
							}
							"Cyclic" {
								set loadingtype 2
							}
							}
					} elseif {$testmaterial == 7} {
							DWModifyMat $GDN
							set pyCurve [DWLocalGetValue $GDN $STRUCT "p-y_backbone_curve"]
							if {$pyCurve == "Soft_clay"} {
									set soilType 1
							} elseif {$pyCurve == "Sand"} {
									set soilType 2
							}
							set pult [DWLocalGetValue $GDN $STRUCT "Ultimate_capacity_pult"]
							set pultunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $pult {}]
							set pult [expr [scan $pult %f]*[subst $\{$pultunit\}]]
							set Y50 [DWLocalGetValue $GDN $STRUCT "Displacement_at_which_the_50%_of_pult_is_mobilized_in_monotonic_loading"]
							set Y50unit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $Y50 {}]
							set Y50 [expr [scan $Y50 %f]*[subst $\{$Y50unit\}]]
							set Cd [DWLocalGetValue $GDN $STRUCT "Coefficient_Cd"]
							set c [DWLocalGetValue $GDN $STRUCT "Viscous_damping_coefficient"]
							set cunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $c {}]
							set c [expr [scan $c %f]*[subst $\{$cunit\}]]
							set Mat_desc "uniaxialMaterial PySimple1 1 $soilType $pult $Y50 $Cd $c"
							set targetc [expr -2*$Y50]
							set targett [expr 2*$Y50]
							set loading [DWLocalGetValue $GDN $STRUCT "Analysis_type"]
							switch $loading {
							"Monotonic" {
								set loadingtype 1
							}
							"Cyclic" {
								set loadingtype 2
							}
							}
					} elseif {$testmaterial == 8} {
							DWModifyMat $GDN
							set tzCurve [DWLocalGetValue $GDN $STRUCT "t-z_backbone_curve"]
							if {$tzCurve == "Reese_and_O'Neill_relation"} {
									set tzType 1
							} elseif {$tzCurve == "Mosher_relation"} {
									set tzType 2
							}
							set tult [DWLocalGetValue $GDN $STRUCT "Ultimate_capacity_tult"]
							set tultunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $tult {}]
							set tult [expr [scan $tult %f]*[subst $\{$tultunit\}]]
							set Z50 [DWLocalGetValue $GDN $STRUCT "Displacement_at_which_the_50%_of_tult_is_mobilized_in_monotonic_loading"]
							set Z50unit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $Z50 {}]
							set Z50 [expr [scan $Z50 %f]*[subst $\{$Z50unit\}]]
							set c [DWLocalGetValue $GDN $STRUCT "Viscous_damping_coefficient"]
							set cunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $c {}]
							set c [expr [scan $c %f]*[subst $\{$cunit\}]]
							set Mat_desc "uniaxialMaterial TzSimple1 1 $tzType $tult $Z50 $c"
							set targetc [expr -2*$Z50]
							set targett [expr 2*$Z50]
							set loading [DWLocalGetValue $GDN $STRUCT "Analysis_type"]
							switch $loading {
							"Monotonic" {
								set loadingtype 1
							}
							"Cyclic" {
								set loadingtype 2
							}
							}
					} elseif {$testmaterial == 9} {
						DWModifyMat $GDN
						set qzCurve [DWLocalGetValue $GDN $STRUCT "q-z_backbone_curve"]
						if {$qzCurve == "Reese_and_O'Neill_relation"} {
								set qzType 1
						} elseif {$qzCurve == "Vijayvergiya_relation"} {
								set qzType 2
						}
						set qult [DWLocalGetValue $GDN $STRUCT "Ultimate_capacity_qult"]
						set qultunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $qult {}]
						set qult [expr [scan $qult %f]*[subst $\{$qultunit\}]]
						set Z50 [DWLocalGetValue $GDN $STRUCT "Displacement_at_which_the_50%_of_qult_is_mobilized_in_monotonic_loading"]
						set Z50unit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $Z50 {}]
						set Z50 [expr [scan $Z50 %f]*[subst $\{$Z50unit\}]]
						set suction [DWLocalGetValue $GDN $STRUCT "Suction"]
						set c [DWLocalGetValue $GDN $STRUCT "Viscous_damping_coefficient"]
						set cunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $c {}]
						set c [expr [scan $c %f]*[subst $\{$cunit\}]]
						set Mat_desc "uniaxialMaterial QzSimple1 1 $qzType $qult $Z50 $suction $c"
						set targetc [expr -2*$Z50]
						set targett [expr 2*$Z50]
						set loading [DWLocalGetValue $GDN $STRUCT "Analysis_type"]
							switch $loading {
							"Monotonic" {
								set loadingtype 1
							}
							"Cyclic" {
								set loadingtype 2
							}
							}
					} elseif {$testmaterial == 10 } {
						DWModifyMat $GDN
						set formulation [DWLocalGetValue $GDN $STRUCT "Formulation"]
						if {$formulation == "Stress-Slip"} {
							set Fy [DWLocalGetValue $GDN $STRUCT "Yield_stress_Fy"]
							set Fyunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $Fy {}]
							set Fy [expr [scan $Fy %f]*[subst $\{$Fyunit\}]]
							set Sy [DWLocalGetValue $GDN $STRUCT "Rebar_slip_at_Fy"]
							set Syunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $Sy {}]
							set Sy [expr [scan $Sy %f]*[subst $\{$Syunit\}]]
							set Fu [DWLocalGetValue $GDN $STRUCT "Ultimate_stress_Fu"]
							set Fuunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $Fu {}]
							set Fu [expr [scan $Fu %f]*[subst $\{$Fuunit\}]]
							set Su [DWLocalGetValue $GDN $STRUCT "Rebar_slip_at_the_loaded_end_at_the_bar_fracture_strength"]
							set Suunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $Su {}]
							set Su [expr [scan $Su %f]*[subst $\{$Suunit\}]]
							set b [DWLocalGetValue $GDN $STRUCT "Initial_hardening"]
							set R [DWLocalGetValue $GDN $STRUCT "Pinching_factor_for_the_cyclic_slip_vs_bar_response"]
							set targetc [expr -2*$Su]
							set targett [expr 2*$Su]
							set loading [DWLocalGetValue $GDN $STRUCT "Analysis_type"]
							switch $loading {
							"Monotonic" {
								set loadingtype 1
							}
							"Cyclic" {
								set loadingtype 2
							}
							}

							set Mat_desc "uniaxialMaterial Bond_SP01 1 $Fy $Sy $Fu $Su $b $R"
						} elseif {$formulation == "Force-Slip"} {
							set Fy [DWLocalGetValue $GDN $STRUCT "Yield_force_Fy"]
							set Fyunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $Fy {}]
							set Fy [expr [scan $Fy %f]*[subst $\{$Fyunit\}]]
							set Sy [DWLocalGetValue $GDN $STRUCT "Rebar_slip_at_Fy"]
							set Syunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $Sy {}]
							set Sy [expr [scan $Sy %f]*[subst $\{$Syunit\}]]
							set Fu [DWLocalGetValue $GDN $STRUCT "Ultimate_force_Fu"]
							set Fuunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $Fu {}]
							set Fu [expr [scan $Fu %f]*[subst $\{$Fuunit\}]]
							set Su [DWLocalGetValue $GDN $STRUCT "Rebar_slip_at_the_loaded_end_at_the_bar_fracture_strength"]
							set Suunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $Su {}]
							set Su [expr [scan $Su %f]*[subst $\{$Suunit\}]]
							set b [DWLocalGetValue $GDN $STRUCT "Initial_hardening"]
							set R [DWLocalGetValue $GDN $STRUCT "Pinching_factor_for_the_cyclic_slip_vs_bar_response"]
							set Mat_desc "uniaxialMaterial Bond_SP01 1 $Fy $Sy $Fu $Su $b $R"
							set targetc [expr -2*$Su]
							set targett [expr 2*$Su]
							set loading [DWLocalGetValue $GDN $STRUCT "Analysis_type"]
							switch $loading {
							"Monotonic" {
								set loadingtype 1
							}
							"Cyclic" {
								set loadingtype 2
							}
							}
						}
					} elseif {$testmaterial == 11} {
						DWModifyMat $GDN
						set fpc [DWLocalGetValue $GDN $STRUCT "Compressive_strength_fpc"]
						set fpcunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $fpc {}]
						set fpc [expr [scan $fpc %f]*[subst $\{$fpcunit\}]]
						set epsc0 [DWLocalGetValue $GDN $STRUCT "Strain_at_maximum_strength_epsc0"]
						set fpcu [DWLocalGetValue $GDN $STRUCT "Crushing_strength_fpcu"]
						set fpcuunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $fpcu {}]
						set fpcu [expr [scan $fpcu %f]*[subst $\{$fpcuunit\}]]
						set epscU [DWLocalGetValue $GDN $STRUCT "Strain_at_crushing_strength_epscU"]
						set Mat_desc "uniaxialMaterial Concrete01 1 $fpc $epsc0 $fpcu $epscU"
						set targetc [expr 2*$epscU]
						set targett [expr -2*$epsc0]
						set loading [DWLocalGetValue $GDN $STRUCT "Analysis_type"]
						switch $loading {
						"Monotonic" {
							set loadingtype 1
						}
						"Cyclic" {
								set loadingtype 2
						}
						}
					} elseif {$testmaterial == 12} {
						DWModifyMat $GDN
						set fpc [DWLocalGetValue $GDN $STRUCT "Compressive_strength_fpc"]
						set fpcunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $fpc {}]
						set fpc [expr [scan $fpc %f]*[subst $\{$fpcunit\}]]
						set epsc0 [DWLocalGetValue $GDN $STRUCT "Strain_at_maximum_strength_epsc0"]
						set fpcu [DWLocalGetValue $GDN $STRUCT "Crushing_strength_fpcu"]
						set fpcuunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $fpcu {}]
						set fpcu [expr [scan $fpcu %f]*[subst $\{$fpcuunit\}]]
						set epsU [DWLocalGetValue $GDN $STRUCT "Strain_at_crushing_strength_epscU"]
						set lambda [DWLocalGetValue $GDN $STRUCT "Ratio_between_unloading_slope_at_epscU_and_initial_slope_lambda"]
						set ft [DWLocalGetValue $GDN $STRUCT "Tensile_strength_ft"]
						set ftunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $ft {}]
						set ft [expr [scan $ft %f]*[subst $\{$ftunit\}]]
						set Ets [DWLocalGetValue $GDN $STRUCT "Tension_softening_stiffness_Ets"]
						set Etsunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $Ets {}]
						set Ets [expr [scan $Ets %f]*[subst $\{$Etsunit\}]]
						set Mat_desc "uniaxialMaterial Concrete02 1 $fpc $epsc0 $fpcu $epsU $lambda $ft $Ets"
						set targetc [expr 2*$epsU]
						set targett [expr 2*$ft/$Ets]
						set loading [DWLocalGetValue $GDN $STRUCT "Analysis_type"]
						switch $loading {
						"Monotonic" {
							set loadingtype 1
						}
						"Cyclic" {
							set loadingtype 2
						}
						}
					} elseif {$testmaterial == 13 } {
						DWModifyMat $GDN
						set fc [DWLocalGetValue $GDN $STRUCT "Compressive_strength"]
						set fcunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $fc {}]
						set fc [expr [scan $fc %f]*[subst $\{$fcunit\}]]
						set ec [DWLocalGetValue $GDN $STRUCT "Strain_at_maximum_strength"]
						set ecu [DWLocalGetValue $GDN $STRUCT "Strain_at_crushing_strength"]
						set Ec [DWLocalGetValue $GDN $STRUCT "Initial_stiffness"]
						set Ecunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $Ec {}]
						set Ec [expr [scan $Ec %f]*[subst $\{$Ecunit\}]]
						set fct [DWLocalGetValue $GDN $STRUCT "Maximum_tensile_strength"]
						set fctunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $fct {}]
						set fct [expr [scan $fct %f]*[subst $\{$fctunit\}]]
						set et [DWLocalGetValue $GDN $STRUCT "Ultimate_tensile_strain"]
						set Mat_desc "uniaxialMaterial Concrete04 1 $fc $ec $ecu $Ec $fct $et"
						set targetc [expr 1.5*$ecu]
						set targett [expr 1.5*$et]
						set loading [DWLocalGetValue $GDN $STRUCT "Analysis_type"]
						switch $loading {
						"Monotonic" {
							set loadingtype 1
						}
						"Cyclic" {
							set loadingtype 2
						}
						}
					} elseif {$testmaterial == 14 } {
						DWModifyMat $GDN
						set fc [DWLocalGetValue $GDN $STRUCT "Concrete_compressive_strength_fc"]
						set fcunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $fc {}]
						set fc [expr [scan $fc %f]*[subst $\{$fcunit\}]]
						set e0 [DWLocalGetValue $GDN $STRUCT "Strain_at_compressive_strength_e0"]
						set n [DWLocalGetValue $GDN $STRUCT "Compressive_shape_factor_n"]
						set k [DWLocalGetValue $GDN $STRUCT "Post-peak_compressive_shape_factor_k"]
						set alpha1 [DWLocalGetValue $GDN $STRUCT "Parameter_a1_for_compressive_plastic_strain_definition"]
						set fcr [DWLocalGetValue $GDN $STRUCT "Tensile_strength_fcr"]
						set fcrunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $fcr {}]
						set fcr [expr [scan $fcr %f]*[subst $\{$fcrunit\}]]
						set ecr [DWLocalGetValue $GDN $STRUCT "Tensile_strain_at_peak_stress_ecr"]
						set b [DWLocalGetValue $GDN $STRUCT "Exponent_of_the_tension_stiffering_curve_b"]
						set alpha2 [DWLocalGetValue $GDN $STRUCT "Parameter_a2_for_tensile_plastic_strain_definition"]
						set Mat_desc "uniaxialMaterial Concrete06 1 $fc $e0 $n $k $alpha1 $fcr $ecr $b $alpha2"
						set targetc [expr 3*$e0]
						set targett [expr 2*$ecr]
						set loading [DWLocalGetValue $GDN $STRUCT "Analysis_type"]
						switch $loading {
						"Monotonic" {
							set loadingtype 1
						}
						"Cyclic" {
							set loadingtype 2
						}
						}
					} elseif {$testmaterial == 15 } {
						DWModifyMat $GDN
						set fpcc [DWLocalGetValue $GDN $STRUCT "Concrete_compressive_strength_fpcc"]
						set fpccunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $fpcc {}]
						set fpcc [expr [scan $fpcc %f]*[subst $\{$fpccunit\}]]
						set epcc [DWLocalGetValue $GDN $STRUCT "Strain_at_compressive_strength_epcc"]
						set Ec [DWLocalGetValue $GDN $STRUCT "Initial_tangent_modulus_Ec"]
						set Ecunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $Ec {}]
						set Ec [expr [scan $Ec %f]*[subst $\{$Ecunit\}]]
						set rc [DWLocalGetValue $GDN $STRUCT "Shape_parameter_rc_in_Tsai's_equation_for_compression"]
						set xcrn [DWLocalGetValue $GDN $STRUCT "Critical_strain_on_compression_envelope"]
						set ft [DWLocalGetValue $GDN $STRUCT "Tensile_strength_ft"]
						set ftunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $ft {}]
						set ft [expr [scan $ft %f]*[subst $\{$ftunit\}]]
						set et [DWLocalGetValue $GDN $STRUCT "Strain_at_tensile_strength_et"]
						set rt [DWLocalGetValue $GDN $STRUCT "Shape_parameter_rc_in_Tsai's_equation_for_tension"]
						set xcrp [DWLocalGetValue $GDN $STRUCT "Critical_strain_on_tension_envelope"]
						set gap [DWLocalGetValue $GDN $STRUCT "Consider_gap_closure"]
						set Mat_desc "uniaxialMaterial ConcreteCM 1 $fpcc $epcc $Ec $rc $xcrn $ft $et $rt $xcrp $gap"
						set targetc [expr -1.5*$xcrn]
						set targett [expr 1.5*$xcrp]
						set loading [DWLocalGetValue $GDN $STRUCT "Analysis_type"]
						switch $loading {
						"Monotonic" {
							set loadingtype 1
						}
						"Cyclic" {
							set loadingtype 2
						}
						}
					} elseif {$testmaterial == 16 } {
						DWModifyMat $GDN
						set formulation [DWLocalGetValue $GDN $STRUCT "Formulation"]
						if {$formulation == "Stress-Strain"} {
							set Fy [DWLocalGetValue $GDN $STRUCT "Yield_Stress_Fy"]
							set Fyunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $Fy {}]
							set Fy [expr [scan $Fy %f]*[subst $\{$Fyunit\}]]
							set E0 [DWLocalGetValue $GDN $STRUCT "Initial_elastic_tangent_E0"]
							set E0unit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $E0 {}]
							set E0 [expr [scan $E0 %f]*[subst $\{$E0unit\}]]
						} elseif {$formulation == "Force-Deformation" } {
							set Fy [DWLocalGetValue $GDN $STRUCT "Force_Fy"]
							set Fyunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $Fy {}]
							set Fy [expr [scan $Fy %f]*[subst $\{$Fyunit\}]]
							set E0 [DWLocalGetValue $GDN $STRUCT "Initial_stiffness_K"]
							set E0unit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $E0 {}]
							set E0 [expr [scan $E0 %f]*[subst $\{$E0unit\}]]
						} elseif {$formulation == "Moment-Rotation"} {
							set Fy [DWLocalGetValue $GDN $STRUCT "Moment_My"]
							set Fyunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $Fy {}]
							set Fy [expr [scan $Fy %f]*[subst $\{$Fyunit\}]]
							set E0 [DWLocalGetValue $GDN $STRUCT "Moment_per_rotation_unit"]
							set E0unit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $E0 {}]
							set E0 [expr [scan $E0 %f]*[subst $\{$E0unit\}]]
						}
						set b [DWLocalGetValue $GDN $STRUCT "Strain-hardening_ratio_b"]
						set a1 [DWLocalGetValue $GDN $STRUCT "Isotropic_hardening_parameter_a1"]
						set a2 [DWLocalGetValue $GDN $STRUCT "Isotropic_hardening_parameter_a2"]
						set a3 [DWLocalGetValue $GDN $STRUCT "Isotropic_hardening_parameter_a3"]
						set a4 [DWLocalGetValue $GDN $STRUCT "Isotropic_hardening_parameter_a4"]
						set Mat_desc "uniaxialMaterial Steel01 1 $Fy $E0 $b $a1 $a2 $a3 $a4"
						set targetc [expr -0.005]
						set targett [expr 0.005]
						set loading [DWLocalGetValue $GDN $STRUCT "Analysis_type"]
						switch $loading {
						"Monotonic" {
							set loadingtype 1
						}
						"Cyclic" {
							set loadingtype 2
						}
						}
					} elseif {$testmaterial == 17} {
						DWModifyMat $GDN
						set formulation [DWLocalGetValue $GDN $STRUCT "Formulation"]
						if {$formulation == "Stress-Strain"} {
							set Fy [DWLocalGetValue $GDN $STRUCT "Yield_Stress_Fy"]
							set Fyunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $Fy {}]
							set Fy [expr [scan $Fy %f]*[subst $\{$Fyunit\}]]
							set E [DWLocalGetValue $GDN $STRUCT "Initial_elastic_tangent_E0"]
							set Eunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $E {}]
							set E [expr [scan $E %f]*[subst $\{$Eunit\}]]
						} elseif {$formulation == "Force-Deformation" } {
							set Fy [DWLocalGetValue $GDN $STRUCT "Force_Fy"]
							set Fyunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $Fy {}]
							set Fy [expr [scan $Fy %f]*[subst $\{$Fyunit\}]]
							set E [DWLocalGetValue $GDN $STRUCT "Initial_stiffness_K"]
							set Eunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $E {}]
							set E [expr [scan $E %f]*[subst $\{$Eunit\}]]
						} elseif {$formulation == "Moment-Rotation"} {
							set Fy [DWLocalGetValue $GDN $STRUCT "Moment_My"]
							set Fyunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $Fy {}]
							set Fy [expr [scan $Fy %f]*[subst $\{$Fyunit\}]]
							set E [DWLocalGetValue $GDN $STRUCT "Moment_per_rotation_unit"]
							set Eunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $E {}]
							set E [expr [scan $E %f]*[subst $\{$Eunit\}]]
						}
						set loading [DWLocalGetValue $GDN $STRUCT "Analysis_type"]
							switch $loading {
							"Monotonic" {
								set loadingtype 1
							}
							"Cyclic" {
								set loadingtype 2
							}
							}
						set b [DWLocalGetValue $GDN $STRUCT "Strain-hardening_ratio_b"]
						set R0 [DWLocalGetValue $GDN $STRUCT "Parameter_R0"]
						set cR1 [DWLocalGetValue $GDN $STRUCT "Parameter_cR1"]
						set cR2 [DWLocalGetValue $GDN $STRUCT "Parameter_cR2"]
						set a1 [DWLocalGetValue $GDN $STRUCT "Isotropic_hardening_parameter_a1"]
						set a2 [DWLocalGetValue $GDN $STRUCT "Isotropic_hardening_parameter_a2"]
						set a3 [DWLocalGetValue $GDN $STRUCT "Isotropic_hardening_parameter_a3"]
						set a4 [DWLocalGetValue $GDN $STRUCT "Isotropic_hardening_parameter_a4"]
						set sigInit [DWLocalGetValue $GDN $STRUCT "Initial_stress"]
						set sigInitunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $sigInit {}]
						set sigInit [expr [scan $sigInit %f]*[subst $\{$sigInitunit\}]]
						set Mat_desc "uniaxialMaterial Steel02 1 $Fy $E $b $R0 $cR1 $cR2 $a1 $a2 $a3 $a4 $sigInit"
						set targetc [expr -0.01]
						set targett [expr 0.01]
						set loading [DWLocalGetValue $GDN $STRUCT "Analysis_type"]
							switch $loading {
							"Monotonic" {
								set loadingtype 1
							}
							"Cyclic" {
								set loadingtype 2
							}
							}
					} elseif {$testmaterial == 18} {
						DWModifyMat $GDN
						set fy [DWLocalGetValue $GDN $STRUCT "Yield_Stress_fy"]
						set fyunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $fy {}]
						set fy [expr [scan $fy %f]*[subst $\{$fyunit\}]]
						set fu [DWLocalGetValue $GDN $STRUCT "Ultimate_stress_fsu"]
						set fuunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $fu {}]
						set fu [expr [scan $fu %f]*[subst $\{$fuunit\}]]
						set Es [DWLocalGetValue $GDN $STRUCT "Initial_elastic_tangent_Es"]
						set Esunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $Es {}]
						set Es [expr [scan $Es %f]*[subst $\{$Esunit\}]]
						set Esh [DWLocalGetValue $GDN $STRUCT "Tangent_at_initial_strain_hardening_Esh"]
						set Eshunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $Esh {}]
						set Esh [expr [scan $Esh %f]*[subst $\{$Eshunit\}]]
						set esh [DWLocalGetValue $GDN $STRUCT "Strain_corresponding_to_initial_strain_hardening_esh"]
						set eult [DWLocalGetValue $GDN $STRUCT "Strain_at_peak_stress_esu"]
						set Mat_desc "uniaxialMaterial ReinforcingSteel 1 $fy $fu $Es $Esh $esh $eult"
						set targetc [expr -0.001]
						set targett [expr $eult]
						set loading [DWLocalGetValue $GDN $STRUCT "Analysis_type"]
							switch $loading {
							"Monotonic" {
								set loadingtype 1
							}
							"Cyclic" {
								set loadingtype 2
							}
							}
					} elseif {$testmaterial == 19 } {
						DWModifyMat $GDN
						set formulation [DWLocalGetValue $GDN $STRUCT "Formulation"]
						if {$formulation == "Stress-Strain"} {
							set s1p [DWLocalGetValue $GDN $STRUCT "Stress_s1p"]
							set s1punit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $s1p {}]
							set s1p [expr [scan $s1p %f]*[subst $\{$s1punit\}]]
							set e1p [DWLocalGetValue $GDN $STRUCT "Strain_e1p"]
							set s2p [DWLocalGetValue $GDN $STRUCT "Stress_s2p"]
							set s2punit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $s2p {}]
							set s2p [expr [scan $s2p %f]*[subst $\{$s2punit\}]]
							set e2p [DWLocalGetValue $GDN $STRUCT "Strain_e2p"]
							set s3p [DWLocalGetValue $GDN $STRUCT "Stress_s3p"]
							set s3punit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $s3p {}]
							set s3p [expr [scan $s3p %f]*[subst $\{$s3punit\}]]
							set e3p [DWLocalGetValue $GDN $STRUCT "Strain_e3p"]
							set s1n [DWLocalGetValue $GDN $STRUCT "Stress_s1n"]
							set s1nunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $s1n {}]
							set s1n [expr [scan $s1n %f]*[subst $\{$s1nunit\}]]
							set e1n [DWLocalGetValue $GDN $STRUCT "Strain_e1n"]
							set s2n [DWLocalGetValue $GDN $STRUCT "Stress_s2n"]
							set s2nunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $s2n {}]
							set s2n [expr [scan $s2n %f]*[subst $\{$s2nunit\}]]
							set e2n [DWLocalGetValue $GDN $STRUCT "Strain_e2n"]
							set s3n [DWLocalGetValue $GDN $STRUCT "Stress_s3n"]
							set s3nunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $s3n {}]
							set s3n [expr [scan $s3n %f]*[subst $\{$s3nunit\}]]
							set e3n [DWLocalGetValue $GDN $STRUCT "Strain_e3n"]
						} elseif {$formulation == "Force-Deformation"} {
							set s1p [DWLocalGetValue $GDN $STRUCT "Force_s1p"]
							set s1punit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $s1p {}]
							set s1p [expr [scan $s1p %f]*[subst $\{$s1punit\}]]
							set e1p [DWLocalGetValue $GDN $STRUCT "Displacement_e1p"]
							set e1punit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $e1p {}]
							set e1p [expr [scan $e1p %f]*[subst $\{$e1punit\}]]
							set s2p [DWLocalGetValue $GDN $STRUCT "Force_s2p"]
							set s2punit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $s2p {}]
							set s2p [expr [scan $s2p %f]*[subst $\{$s2punit\}]]
							set e2p [DWLocalGetValue $GDN $STRUCT "Displacement_e2p"]
							set e2punit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $e2p {}]
							set e2p [expr [scan $e2p %f]*[subst $\{$e2punit\}]]
							set s3p [DWLocalGetValue $GDN $STRUCT "Force_s3p"]
							set s3punit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $s3p {}]
							set s3p [expr [scan $s3p %f]*[subst $\{$s3punit\}]]
							set e3p [DWLocalGetValue $GDN $STRUCT "Displacement_e3p"]
							set e3punit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $e3p {}]
							set e3p [expr [scan $e3p %f]*[subst $\{$e3punit\}]]
							set s1n [DWLocalGetValue $GDN $STRUCT "Force_s1n"]
							set s1nunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $s1n {}]
							set s1n [expr [scan $s1n %f]*[subst $\{$s1nunit\}]]
							set e1n [DWLocalGetValue $GDN $STRUCT "Displacement_e1n"]
							set e1nunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $e1n {}]
							set e1n [expr [scan $e1n %f]*[subst $\{$e1nunit\}]]
							set s2n [DWLocalGetValue $GDN $STRUCT "Force_s2n"]
							set s2nunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $s2n {}]
							set s2n [expr [scan $s2n %f]*[subst $\{$s2nunit\}]]
							set e2n [DWLocalGetValue $GDN $STRUCT "Displacement_e2n"]
							set e2nunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $e2n {}]
							set e2n [expr [scan $e2n %f]*[subst $\{$e2nunit\}]]
							set s3n [DWLocalGetValue $GDN $STRUCT "Force_s3n"]
							set s3nunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $s3n {}]
							set s3n [expr [scan $s3n %f]*[subst $\{$s3nunit\}]]
							set e3n [DWLocalGetValue $GDN $STRUCT "Displacement_e3n"]
							set e3nunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $e3n {}]
							set e3n [expr [scan $e3n %f]*[subst $\{$e3nunit\}]]
						} elseif {$formulation == "Moment-Rotation"} {
							set s1p [DWLocalGetValue $GDN $STRUCT "Moment_s1p"]
							set s1punit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $s1p {}]
							set s1p [expr [scan $s1p %f]*[subst $\{$s1punit\}]]
							set e1p [DWLocalGetValue $GDN $STRUCT "Rotation_e1p"]
							set e1punit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $e1p {}]
							set e1p [expr [scan $e1p %f]*[subst $\{$e1punit\}]]
							set s2p [DWLocalGetValue $GDN $STRUCT "Moment_s2p"]
							set s2punit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $s2p {}]
							set s2p [expr [scan $s2p %f]*[subst $\{$s2punit\}]]
							set e2p [DWLocalGetValue $GDN $STRUCT "Rotation_e2p"]
							set e2punit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $e2p {}]
							set e2p [expr [scan $e2p %f]*[subst $\{$e2punit\}]]
							set s3p [DWLocalGetValue $GDN $STRUCT "Moment_s3p"]
							set s3punit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $s3p {}]
							set s3p [expr [scan $s3p %f]*[subst $\{$s3punit\}]]
							set e3p [DWLocalGetValue $GDN $STRUCT "Rotation_e3p"]
							set e3punit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $e3p {}]
							set e3p [expr [scan $e3p %f]*[subst $\{$e3punit\}]]
							set s1n [DWLocalGetValue $GDN $STRUCT "Moment_s1n"]
							set s1nunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $s1n {}]
							set s1n [expr [scan $s1n %f]*[subst $\{$s1nunit\}]]
							set e1n [DWLocalGetValue $GDN $STRUCT "Rotation_e1n"]
							set e1nunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $e1n {}]
							set e1n [expr [scan $e1n %f]*[subst $\{$e1nunit\}]]
							set s2n [DWLocalGetValue $GDN $STRUCT "Moment_s2n"]
							set s2nunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $s2n {}]
							set s2n [expr [scan $s2n %f]*[subst $\{$s2nunit\}]]
							set e2n [DWLocalGetValue $GDN $STRUCT "Rotation_e2n"]
							set e2nunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $e2n {}]
							set e2n [expr [scan $e2n %f]*[subst $\{$e2nunit\}]]
							set s3n [DWLocalGetValue $GDN $STRUCT "Moment_s3n"]
							set s3nunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $s3n {}]
							set s3n [expr [scan $s3n %f]*[subst $\{$s3nunit\}]]
							set e3n [DWLocalGetValue $GDN $STRUCT "Rotation_e3n"]
							set e3nunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $e3n {}]
							set e3n [expr [scan $e3n %f]*[subst $\{$e3nunit\}]]
						}
						set pinchX [DWLocalGetValue $GDN $STRUCT "Pinching_factor_for_strain-deformation"]
						set pinchY [DWLocalGetValue $GDN $STRUCT "Pinching_factor_for_stress-force"]
						set damage1 [DWLocalGetValue $GDN $STRUCT "Damage_due_to_ductility"]
						set damage2 [DWLocalGetValue $GDN $STRUCT "Damage_due_to_energy"]
						set beta [DWLocalGetValue $GDN $STRUCT "Beta_power"]
						set Mat_desc "uniaxialMaterial Hysteretic 1 $s1p $e1p $s2p $e2p $s3p $e3p $s1n $e1n $s2n $e2n $s3n $e3n $pinchX $pinchY $damage1 $damage2 $beta"
						set targetc [expr $e3n]
						set targett [expr $e3p]
						set loading [DWLocalGetValue $GDN $STRUCT "Analysis_type"]
							switch $loading {
							"Monotonic" {
								set loadingtype 1
							}
							"Cyclic" {
								set loadingtype 2
							}
							}
					} elseif {$testmaterial == 20 } {
						DWModifyMat $GDN
						set fy [DWLocalGetValue $GDN $STRUCT "Yield_Stress_fy"]
						set fyunit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $fy {}]
						set fy [expr [scan $fy %f]*[subst $\{$fyunit\}]]
						set E0 [DWLocalGetValue $GDN $STRUCT "Initial_elastic_tangent_E0"]
						set E0unit [regsub -all {[-+]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][-+]?[0-9]+)?} $E0 {}]
						set E0 [expr [scan $E0 %f]*[subst $\{$E0unit\}]]
						set a [DWLocalGetValue $GDN $STRUCT "Yield_offset"]
						set n [DWLocalGetValue $GDN $STRUCT "Parameter_n_to_control_transition_from_elastic_to_plastic_branches"]
						set Mat_desc "uniaxialMaterial RambergOsgoodSteel 1 $fy $E0 $a $n"
						set targetc [expr -0.001]
						set targett [expr $a*$fy/$E0+$fy/$E0+0.001]
						set loading [DWLocalGetValue $GDN $STRUCT "Analysis_type"]
							switch $loading {
							"Monotonic" {
								set loadingtype 1
							}
							"Cyclic" {
								set loadingtype 2
							}
							}
					}
					global tmpdir
					set tmpdir [pwd]
					if {[file exists /tmp]} {set tmpdir /tmp}
					catch {set tmpdir $::env(TMP)}
					catch {set tmpdir $::env(TEMP)}
					set path [OpenSees::GetOpenSeesEXE]
					set fp [open "$tmpdir\\MatDvr.tcl" w+]
					if {$loadingtype == 1} {
						puts $fp {
						model BasicBuilder -ndm 2 -ndf 2

						node 1 0 0
						node 2 1 0

						fix 1 1 1
						fix 2 0 1

						}
						puts $fp $Mat_desc
						puts $fp "element truss 1 1 2 1 1"
						puts $fp "recorder Element -file {$tmpdir\\compression_stress.out} -time -ele 1 axialForce"
						puts $fp "recorder Element -file {$tmpdir\\compression_strain.out} -time -ele 1 deformations"
						puts $fp "set interval 1"
						puts $fp "set target $targetc"
						puts $fp {
						set steps 100
						set LF [expr 1.0/$steps]

						pattern Plain $interval Linear {sp 2 1 $target}

						record
						system UmfPack
						numberer RCM
						constraints Transformation
						integrator LoadControl $LF
						test NormDispIncr 1e-09 100 2
						algorithm Newton
						analysis Static
						analyze $steps
						reset
						remove recorder 0
						remove recorder 1

						set interval 2
						}

						puts $fp "recorder Element -file {$tmpdir\\tension_stress.out} -time -ele 1 axialForce"
						puts $fp "recorder Element -file {$tmpdir\\tension_strain.out} -time -ele 1 deformations"
						puts $fp "set target $targett"
						puts $fp {
						set steps 100
						set LF [expr 1.0/$steps]

						pattern Plain $interval Linear {sp 2 1 $target}

						record
						system UmfPack
						numberer RCM
						constraints Transformation
						integrator LoadControl $LF
						test NormDispIncr 1e-09 100 2
						algorithm Newton
						analysis Static
						analyze $steps
						reset
						}
					} elseif {$loadingtype == 2 } {
						set matrim [regexp -all -inline {\S+} $Mat_desc]
						set material [lindex $matrim 1]
						set cydata [GiD_AccessValue get materials $material "Cyclic_data"]
						puts $fp $cydata
						set maxc [list]
						set maxt [list]
						set numcy [list]
						for {set i 2} {$i < [llength $cydata]} {incr i  3} {
							lappend maxc [lindex $cydata $i]
							lappend maxt [lindex $cydata [expr $i+1]]
							lappend numcy [lindex $cydata [expr $i+2]]
						}
							puts $fp {

								model BasicBuilder -ndm 2 -ndf 2
								set Analysis_type cyclic

								node 1 0 0
								node 2 1 0

								fix 1 1 1
								fix 2 0 1
							}
							puts $fp $Mat_desc
							puts $fp "element truss 1 1 2 1 1"
							puts $fp "recorder Element -file {$tmpdir\\Material_stress.out} -time -ele 1 axialForce"
							puts $fp "recorder Element -file {$tmpdir\\Material_strain.out} -time -ele 1 deformations"
							puts $fp "set interval 1"
							puts $fp "set targett [list $maxt]"
							puts $fp "set targetc [list $maxc]"
							puts $fp "set numcy [list $numcy]"
							puts $fp {

								set strains [list]
								set cyc [list]
								foreach {cutc} $targetc {cutt} $targett {cy} $numcy {
									for { set c 1}  {$c <= $cy} {incr c} {
										lappend strains $cutc
										lappend strains $cutt
										lappend cyc $c

									}
								}
								pattern Plain 2 Linear {
									load 2 1.0 0.0
								}

								constraints Transformation
								numberer RCM
								system UmfPack
								test NormDispIncr 1e-09 1000 2
								algorithm KrylovNewton
								set steps 40
								set committedSteps 1
								analysis Static
								foreach {cDmax tDmax} $strains Ncycles $cyc {
									set cDispIncr [expr $cDmax/$steps]; # the displacement increment for each step
									set tDispIncr [expr $tDmax/$steps]
									set Dstepvector ""
									set Disp 0
									for {set i 1} {$i <= $steps} {incr i 1} {; # zero to one
										set Disp [expr $Disp + $tDispIncr]
										lappend Dstepvector $Disp
									}
									for {set i 1} {$i <= $steps} {incr i 1} {; # one to zero
										set Disp [expr $Disp - $tDispIncr]
										lappend Dstepvector $Disp
									}
									for {set i 1} {$i <= $steps} {incr i 1} {; # zero to minus one
										set Disp [expr $Disp + $cDispIncr]
										lappend Dstepvector $Disp
									}
									for {set i 1} {$i <= $steps} {incr i 1} {; # minus one to zero
											set Disp [expr $Disp - $cDispIncr]
											lappend Dstepvector $Disp
									}
									for {set i 1} {$i <= $Ncycles} {incr i 1} {
										set currentPath 1
										set D0 0.0
										foreach Dispstep $Dstepvector {
											set D1 $Dispstep
											set Dincr [expr $D1 - $D0]
											integrator DisplacementControl 2 1 $Dincr
											set t [getTime]
											set AnalOk [analyze 1];
											set D0 $D1; # move to next step
										}
									}
								}
								wipe
							}
					}

					close $fp

					if {$loadingtype == 1} {
						DWModifyMat $GDN
						TestMat $path $tmpdir
						reversecompressionlist "$tmpdir\\" "compression_stress.out"
						reversecompressionlist "$tmpdir\\" "compression_strain.out"
						mergefiles "$tmpdir\\" "compression_stress.out" "tension_stress.out" "Material_stress.out"
						mergefiles "$tmpdir\\" "compression_strain.out" "tension_strain.out" "Material_strain.out"
						set p "$tmpdir\\"
						set ess "Material_stress.out"
						set ain "Material_strain.out"
						set points [getxy [getcol $p $ain] [getcol $p $ess]]
						GidGraph::Window $points [_ "$mat"] [_ "Strain"] [_ "Stress"] {} "normal"
					} elseif {$loadingtype == 2} {
						DWModifyMat $GDN
						TestMat $path $tmpdir
						set p "$tmpdir\\"
						set ess "Material_stress.out"
						set ain "Material_strain.out"
						set points [getxy [getcol $p $ain] [getcol $p $ess]]
						GidGraph::Window $points [_ "$mat"] [_ "Strain"] [_ "Stress"] {} "normal"
					}

				}
				image create photo Test -format PNG -file [file join [OpenSees::GetProblemTypePath] img/Menu/mnu_Analysis.png]
				set clickButton [Button $PARENT.tester -image Test -text " Material Tester " -command $cmd -state normal -compound left]
				grid $clickButton -column 1 -row [expr $ROW+1] -sticky nw  -pady 5
		}
	}

	return  ""

}


proc TestMat {OpenSeespath Driverdir} {

	set tcl_file [file join $Driverdir "Matdvr.tcl"]
	eval exec [auto_execok start] \"\" [list [file attributes $OpenSeespath -shortname]] \"$tcl_file\"
	}

proc reversecompressionlist {path name} {
	set fp [open $path$name r]
	set values [read $fp]
	set rows [split $values "\n" ]
	foreach {one} $rows {
		lappend comp $one
	}
	close $fp
	set asd [lreverse $comp]
	set fp [open $path$name w+]
	foreach {one} $asd {
		puts $fp $one
	}
	close $fp
	}
proc mergefiles {path name1 name2 name} {
	set fp1 [open $path$name1 r]
	set fp2 [open $path$name2 r]
	set values1 [read $fp1]
	set values2 [read $fp2]
	set final [open $path$name w]
	puts $final $values1
	puts $final $values2
	close $fp1
	close $fp2
	close $final
	}
#Getting stress or strain values without time steps
proc getcol { path name } {
	set fp [open $path$name r]
	set values [read $fp]
	set rows [split $values "\n" ]
	foreach {one} $rows {
		lappend cols [lindex $one 1]
	}
	return [join $cols]
	close $fp
	}
#Creating the Stress-strain list,xy values in plotchart
proc getxy {l1 l2} {
	set diag [list [lmap x $l1 y $l2 {list $x $y}] \n]
	return  [join $diag]
	}
