proc TK_CheckMaterialForElasticBeamColumn { event args } {
switch $event {
   INIT {
   #...
    return ""
   }
   SYNC {
   
  set GDN [lindex $args 0]
  set STRUCT [lindex $args 1]
  set QUESTION [lindex $args 2]

  # i.e. ChoosedMaterial can be Elastic_Orthotropic (from combo box "Material" in beam column definition)  
  set ChoosedMaterial [DWLocalGetValue $GDN $STRUCT $QUESTION]
   	
	#GiD_AccessValue get materials : Search the value of a field of a material.
	# $ChoosedMaterial is the material name
   # Material: is the question name of the material $ChoosedMaterial
 set MatType [GiD_AccessValue get materials $ChoosedMaterial "Material:"]
 #MatType is the value of the question: Material: of the chosen material from the combo box!
 
  if { $MatType == "ElasticOrthotropic"} {
		WarnWinText "ERROR : Material $ChoosedMaterial ($MatType material) can not be used for beam-column elements."
		WarnWinText "Use an elastic isotropic material instead."
	 # Change the value of the field "Material:" to Elastic_Isotropic 				  
	 DWLocalSetValue $GDN $STRUCT $QUESTION "Elastic_Isotropic"	
    }	 
     return ""
   }
   DEPEND {
   # ...
    return ""
   }
   CLOSE {
   # ...
    return ""
   }
 }
 return ""
}


proc TK_CheckModelingOptionsForBeamColumnElems { event args } {
switch $event {
   INIT {
   #...
    return ""
   }
   SYNC {
   
  set GDN [lindex $args 0]
  set STRUCT [lindex $args 1]
  set QUESTION [lindex $args 2]


   # Dimensions : the question name 
 set ndm [GiD_AccessValue get gendata "Dimensions"]
 set dof [GiD_AccessValue get gendata "DOF"]
 # ndm : number of dimensions of the project
 # dof : degrees of freedom per node
 
  if { $ndm == "2" && $dof== "2" } {
   WarnWinText "Beam-Column elements require a 2D / 3 DOF or a 3D/6DOF model."
   } elseif {$ndm=="2" && $dof=="6"} {
   WarnWinText "Beam-Column elements require a 2D / 3 DOF or a 3D/6DOF model."
   } elseif {$ndm=="3" && $dof=="3"} {
   WarnWinText "Beam-Column elements require a 2D / 3 DOF or a 3D/6DOF model."
   }
     return ""
   }
   DEPEND {
   # ...
    return ""
   }
   CLOSE {
   # ...
    return ""
   }
 }
 return ""
}


proc TK_CheckModelingOptionsForQuadElems { event args } {
switch $event {
   INIT {
   #...
    return ""
   }
   SYNC {
   
  set GDN [lindex $args 0]
  set STRUCT [lindex $args 1]
  set QUESTION [lindex $args 2]

   	
 
   # Dimensions : the question name 
 set ndm [GiD_AccessValue get gendata "Dimensions"]
 set dof [GiD_AccessValue get gendata "DOF"]
 # ndm : number of dimensions of the project
 # dof : degrees of freedom per node
 
  if { $ndm != "2" || $dof != "2"} {
  WarnWinText "Quad elements require a 2D model with 2 DOFs per node."
  
  #set warn [tk_dialog .warnWin "Warning" "Quad elements require a 2D model with 2 DOFs per node." warning 0 "OK" ]
	
                      }
     return ""
   }
   DEPEND {
   # ...
    return ""
   }
   CLOSE {
   # ...
    return ""
   }
 }
 return ""
}


proc TK_CheckModelingOptionsForBrickElems { event args } {
switch $event {
   INIT {
   #...
    return ""
   }
   SYNC {
   
  set GDN [lindex $args 0]
  set STRUCT [lindex $args 1]
  set QUESTION [lindex $args 2]

   	
 
   # Dimensions : the question name 
 set ndm [GiD_AccessValue get gendata "Dimensions"]
 set dof [GiD_AccessValue get gendata "DOF"]
 # ndm : number of dimensions of the project
 # dof : degrees of freedom per node
 
  if { $ndm != "3" || $dof != "3"} {
  WarnWinText "Standard Brick elements require a 3D model with 3 DOFs per node."
                      }
     return ""
   }
   DEPEND {
   # ...
    return ""
   }
   CLOSE {
   # ...
    return ""
   }
 }
 return ""
}


proc TK_CheckModelingOptionsForShellElems { event args } {
switch $event {
   INIT {
   #...
    return ""
   }
   SYNC {
   
  set GDN [lindex $args 0]
  set STRUCT [lindex $args 1]
  set QUESTION [lindex $args 2]

   	
 
   # Dimensions : the question name 
 set ndm [GiD_AccessValue get gendata "Dimensions"]
 set dof [GiD_AccessValue get gendata "DOF"]
 # ndm : number of dimensions of the project
 # dof : degrees of freedom per node
 
  if { $ndm != "3" || $dof != "6"} {
  WarnWinText "Shell elements require a 3D model with 6 DOFs per node."
                      }
     return ""
   }
   DEPEND {
   # ...
    return ""
   }
   CLOSE {
   # ...
    return ""
   }
 }
 return ""
}

proc Calculate_Reinf_Areas_for_Fiber { event args } {
 switch $event {
 INIT {
  # do nothing 
 }
 SYNC {
	set pi 3.14159265358979323846
	set GDN  [lindex $args 0]
	set STRUCT [lindex $args 1]
	set QUESTION [lindex $args 2]
	
	set check [DWLocalGetValue $GDN $STRUCT $QUESTION]
	set Shape [DWLocalGetValue $GDN $STRUCT "Cross_Section"]
	
	if { $check==1 } {
	
	if { $Shape=="Rectangular" } {
	set CornerSizeUnit [DWLocalGetValue $GDN $STRUCT Corner_Bar_size]
	set InterSizeUnit [DWLocalGetValue $GDN $STRUCT Middle_Bar_size]
	
	set temp1 [GidConvertValueUnit $CornerSizeUnit]
	set temp1 [ParserNumberUnit $temp1 CornerSize CornerUnit]
	
	set temp2 [GidConvertValueUnit $InterSizeUnit]
	set temp2 [ParserNumberUnit $temp2 InterSize InterUnit]
	
	set CornerArea [format "%1.3e" [expr $pi*($CornerSize*$CornerSize)/4.0]]
	set CornerArea $CornerArea$CornerUnit^2
	
	set InterArea [format "%1.3e" [expr $pi*($InterSize*$InterSize)/4.0]]
	set InterArea $InterArea$InterUnit^2
	
	set ok [DWLocalSetValue $GDN $STRUCT Corner_Bar_Area $CornerArea]
	set ok [DWLocalSetValue $GDN $STRUCT Middle_Bar_Area $InterArea]
	return ""
	
	} elseif { $Shape=="Circular" } {
	set SizeUnit [DWLocalGetValue $GDN $STRUCT Bar_size]
	
	set temp [GidConvertValueUnit $SizeUnit]
	set temp [ParserNumberUnit $temp Size Unit]
	
	set Area [format "%1.3e" [expr $pi*($Size*$Size)/4.0]]
	set Area $Area$Unit^2
	set ok [DWLocalSetValue $GDN $STRUCT Bar_Area $Area]
	return ""
	}
	
	} else {
	return ""
	}
 }
 DEPEND {
 # do nothing
 }
 CLOSE {
  # do nothing 
 }
 }
}


proc TK_CheckSectionForFBC { event args } {
switch $event {
   INIT {
   #...
    return ""
   }
   SYNC {
   
  set GDN [lindex $args 0]
  set STRUCT [lindex $args 1]
  set QUESTION [lindex $args 2]

  # i.e. ChoosedSection can be Plate_fiber (from combo box "Section" in force based beam column definition)  
  set ChoosedSection [DWLocalGetValue $GDN $STRUCT $QUESTION]
   	
	#GiD_AccessValue get materials : Search the value of a field of a material.
	# $ChoosedSection is the material name
   # Section: is the question name of the Section $ChoosedSection
 set SecType [GiD_AccessValue get materials $ChoosedSection "Section:"]
 #SecType is the value of the question: Section: of the chosen Section from the combo box!
 
  if { $SecType == "PlateFiber" || $SecType == "ElasticMembranePlate" } {
  WarnWinText "ERROR : Section $ChoosedSection ($SecType section) can not be used for Force-Based beam-column elements."
  WarnWinText "It has been changed to Fiber section."
	 # Change the value of the field "Section:" to Fiber 				  
	 DWLocalSetValue $GDN $STRUCT $QUESTION "Fiber"	
    }	 
     return ""
   }
   DEPEND {
   # ...
    return ""
   }
   CLOSE {
   # ...
    return ""
   }
 }
 return ""
}

proc TK_CheckMaterialsForFiber { event args } {
switch $event {
   INIT {
   #...
    return ""
   }
   SYNC {
   
  set GDN [lindex $args 0]
  set STRUCT [lindex $args 1]
  set QUESTION [lindex $args 2]

  # i.e. ChoosedSection can be Elastic_Orthotropic (from combo box "Material" in beam column definition)  
  set ChoosedCoreMaterial [DWLocalGetValue $GDN $STRUCT "Core_material"]
  set ChoosedCoverMaterial [DWLocalGetValue $GDN $STRUCT "Cover_material"]
  set ChoosedBarMaterial [DWLocalGetValue $GDN $STRUCT "Reinforcing_Bar_material"]
  
	#GiD_AccessValue get materials : Search the value of a field of a material.
	# $ChoosedSection is the material name
   # Section: is the question name of the Section $ChoosedSection
 set CoreMatType [GiD_AccessValue get materials $ChoosedCoreMaterial "Material:"]
 set CoverMatType [GiD_AccessValue get materials $ChoosedCoverMaterial "Material:"]
 set BarMatType [GiD_AccessValue get materials $ChoosedBarMaterial "Material:"]
 
 #CoreMatType is the value of the field: material: of the chosen material from the combo box!
 
	if { $BarMatType != "Steel01" } {
	WarnWinText "ERROR : Material $ChoosedBarMaterial ($BarMatType material) can not be used for fiber sections in this version."
	WarnWinText "It has been changed to Steel01 material."
	 			  
	 DWLocalSetValue $GDN $STRUCT "Reinforcing_Bar_material" "Steel01"	
    }
	
     return ""
   }
   DEPEND {
   # ...
    return ""
   }
   CLOSE {
   # ...
    return ""
   }
 }
 return ""
}


proc TK_GenerateUniaxialConcreteProperties { event args } {
switch $event {
	INIT {
	return ""
	}
	SYNC {
		set GDN [lindex $args 0]
		set STRUCT [lindex $args 1]
		set QUESTION [lindex $args 2]
		
		set matType [DWLocalGetValue $GDN $STRUCT "Material:"]
		set Class [DWLocalGetValue $GDN $STRUCT "Strength_Class"]
		set format [DWLocalGetValue $GDN $STRUCT "Strength_Type"]
		set unit "MPa"
		set Eunit "GPa"
		
		if {$Class != "Custom"} {
				switch $Class {
					"C12/15" {
					set fck -12
					set fctm 1.6
					set fcm -20
					set ec1 -1.8e-3
					set ecu1 -3.5e-3
					} 
					"C16/20" {
					set fck -16
					set fcm -24
					set fctm 1.9
					set ec1 -1.8e-3
					set ecu1 -3.5e-3
					}
					"C20/25" {
					set fck -20
					set fcm -28
					set fctm 2.2
					set ec1 -2.0e-3
					set ecu1 -3.5e-3
					}
					"C25/30" {
					set fck -25
					set fcm -33
					set fctm 2.6
					set ec1 -2.1e-3
					set ecu1 -3.5e-3
					}
					"C30/37" {
					set fck -30
					set fcm -38
					set fctm 2.9
					set ec1 -2.2e-3
					set ecu1 -3.5e-3
					}
					"C35/45" {
					set fck -35
					set fcm -43
					set fctm 3.2
					set ec1 -2.25e-3
					set ecu1 -3.5e-3
					}
					"C40/50" {
					set fck -40
					set fcm -48
					set fctm 3.5
					set ec1 -2.3e-3
					set ecu1 -3.5e-3
					}
					"C45/55" {
					set fck -45
					set fcm -53
					set fctm 3.8
					set ec1 -2.4e-3
					set ecu1 -3.5e-3
					}
					"C50/60" {
					set fck -50
					set fcm -58
					set fctm 4.1
					set ec1 -2.45e-3
					set ecu1 -3.5e-3
					}
					"C55/67" {
					set fck -55
					set fcm -63
					set fctm 4.2
					set ec1 -2.5e-3
					set ecu1 -3.2e-3
					}
					"C60/75" {
					set fck -60
					set fcm -68
					set fctm 4.4
					set ec1 -2.6e-3
					set ecu1 -3e-3
					}
					"C70/85" {
					set fck -70
					set fcm -78
					set fctm 4.6
					set ec1 -2.7e-3
					set ecu1 -2.8e-3
					}
					"C80/95" {
					set fck -80
					set fcm -88
					set fctm 4.8
					set ec1 -2.8e-3
					set ecu1 -2.8e-3
					}
					"C90/105" {
					set fck -90
					set fcm -24
					set fctm 5.0
					set ec1 -2.8e-3
					set ecu1 -2.8e-3
					}
				}
				
				switch $matType {
					"Concrete06" {
						if {$format == "Mean" } {
							set fpcu [expr 0.85*$fcm]
							set ok [DWLocalSetValue $GDN $STRUCT "Concrete_compressive_strength_fc" $fcm$unit]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_at_compressive_strength_e0" $ec1]
							set ok [DWLocalSetValue $GDN $STRUCT "Tensile_strength_fcr" $fctm$unit]
							set a1 [format "%1.3e" [expr $ecu1-$fcm/(2*$fcm/$ec1)]]
							set ok [DWLocalSetValue $GDN $STRUCT "Parameter_a1_for_compressive_plastic_strain_definition" $a1]
							set ecr [format "%1.3e" [expr $fctm/(2*$fcm/$ec1)]]
							set ok [DWLocalSetValue $GDN $STRUCT "Tensile_strain_at_peak_stress_ecr" $ecr]
							set a2 [format "%1.3e" [expr 7*$ecr]]
							set ok [DWLocalSetValue $GDN $STRUCT "Parameter_a2_for_tensile_plastic_strain_definition" $a2]
							
						} elseif {$format == "Characteristic"} {
							set fpcu [expr 0.85*$fck]
							set ok [DWLocalSetValue $GDN $STRUCT "Concrete_compressive_strength_fc" $fck$unit]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_at_compressive_strength_e0" $ec1]
							set ok [DWLocalSetValue $GDN $STRUCT "Tensile_strength_fcr" $fctm$unit]
							set a1 [format "%1.3e" [expr $ecu1-$fck/(2*$fck/$ec1)]]
							set ok [DWLocalSetValue $GDN $STRUCT "Parameter_a1_for_compressive_plastic_strain_definition" $a1]
							set ecr [format "%1.3e" [expr $fctm/(2*$fck/$ec1)]]
							set ok [DWLocalSetValue $GDN $STRUCT "Tensile_strain_at_peak_stress_ecr" $ecr]
							set a2 [format "%1.3e" [expr 7*$ecr]]
							set ok [DWLocalSetValue $GDN $STRUCT "Parameter_a2_for_tensile_plastic_strain_definition" $a2]
						}
					}
					"Concrete01" {
						if {$format == "Mean" } {
							set fpcu [expr 0.85*$fcm]
							set ok [DWLocalSetValue $GDN $STRUCT "Compressive_strength_fpc" $fcm$unit]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_at_maximum_strength_epsc0" $ec1]
							set ok [DWLocalSetValue $GDN $STRUCT "Crushing_strength_fpcu" $fpcu$unit]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_at_crushing_strength_epscU" $ecu1]
						} elseif {$format == "Characteristic"} {
							set fpcu [expr 0.85*$fck]
							set ok [DWLocalSetValue $GDN $STRUCT "Compressive_strength_fpc" $fck$unit]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_at_maximum_strength_epsc0" $ec1]
							set ok [DWLocalSetValue $GDN $STRUCT "Crushing_strength_fpcu" $fpcu$unit]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_at_crushing_strength_epscU" $ecu1]
						}
					} 
					"Concrete02" {
						if {$format == "Mean" } {
							set fpcu [expr 0.85*$fcm]
							set ok [DWLocalSetValue $GDN $STRUCT "Compressive_strength_fpc" $fcm$unit]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_at_maximum_strength_epsc0" $ec1]
							set ok [DWLocalSetValue $GDN $STRUCT "Crushing_strength_fpcu" $fpcu$unit]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_at_crushing_strength_epscU" $ecu1]
							set ok [DWLocalSetValue $GDN $STRUCT "Tensile_strength_ft" $fctm$unit]
							set Ets [format "%g" [expr (2*$fcm/$ec1)/10000]]
							set ok [DWLocalSetValue $GDN $STRUCT "Tension_softening_stiffness_Ets" $Ets$Eunit]
						} elseif {$format == "Characteristic"} {
							set fpcu [expr 0.85*$fck]
							set ok [DWLocalSetValue $GDN $STRUCT "Compressive_strength_fpc" $fck$unit]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_at_maximum_strength_epsc0" $ec1]
							set ok [DWLocalSetValue $GDN $STRUCT "Crushing_strength_fpcu" $fpcu$unit]
							set ok [DWLocalSetValue $GDN $STRUCT "Strain_at_crushing_strength_epscU" $ecu1]
							set ok [DWLocalSetValue $GDN $STRUCT "Tensile_strength_ft" $fctm$unit]
							set Ets [format "%g" [expr (2*$fck/$ec1)/10000]]
							set ok [DWLocalSetValue $GDN $STRUCT "Tension_softening_stiffness_Ets" $Ets$Eunit]
						}
					}
				}		
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
}

proc TK_GenerateUniaxialSteelProperties { event args } {
switch $event {
	INIT {
	return ""
	}
	SYNC {
		set GDN [lindex $args 0]
		set STRUCT [lindex $args 1]
		set QUESTION [lindex $args 2]
		
		set matType [DWLocalGetValue $GDN $STRUCT "Material:"]
		set Grade [DWLocalGetValue $GDN $STRUCT "Steel_Grade"]
		set unit "MPa"
		set Eunit "GPa"
			switch $Grade {
				"S235" {
				set Fy 235
				set E 200
				}
				"S275" {
				set Fy 275
				set E 200
				}
				"S355" {
				set Fy 355
				set E 200
				}
				"S450" {
				set Fy 450
				set E 200
				}
				"B500" {
				set Fy 500
				set E 200
				}
				default {
				return ""
				}
			}
			
			set ok [DWLocalSetValue $GDN $STRUCT "Yield_Stress_Fy" $Fy$unit]
			set ok [DWLocalSetValue $GDN $STRUCT "Initial_elastic_tangent_E0" $E$Eunit]
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


proc TK_GenerateUniaxialMaterialsProperties { event args } {
switch $event {
	SYNC {
		set GDN [lindex $args 0]
		set STRUCT [lindex $args 1]
		set QUESTION [lindex $args 2]
		set unit "MPa"
		set Eunit "GPa"
		set matType [DWLocalGetValue $GDN $STRUCT $QUESTION]
		set mat [DWLocalGetValue $GDN $STRUCT "Material:"]
		
		switch $matType {
			"Concrete" {
				set Concrete_class [DWLocalGetValue $GDN $STRUCT "Concrete_Class"]
				switch $Concrete_class {
					"C12/15" {
					set fck -12
					set fctm 1.6
					set fcm -20
					set E 27
					set ec1 -1.8e-3
					set ecu1 -3.5e-3
					} 
					"C16/20" {
					set fck -16
					set fcm -24
					set fctm 1.9
					set E 29
					set ec1 -1.8e-3
					set ecu1 -3.5e-3
					}
					"C20/25" {
					set fck -20
					set fcm -28
					set fctm 2.2
					set E 30
					set ec1 -2.0e-3
					set ecu1 -3.5e-3
					}
					"C25/30" {
					set fck -25
					set fcm -33
					set fctm 2.6
					set E 31
					set ec1 -2.1e-3
					set ecu1 -3.5e-3
					}
					"C30/37" {
					set fck -30
					set fcm -38
					set fctm 2.9
					set E 33
					set ec1 -2.2e-3
					set ecu1 -3.5e-3
					}
					"C35/45" {
					set fck -35
					set fcm -43
					set fctm 3.2
					set E 34
					set ec1 -2.25e-3
					set ecu1 -3.5e-3
					}
					"C40/50" {
					set fck -40
					set fcm -48
					set fctm 3.5
					set E 35
					set ec1 -2.3e-3
					set ecu1 -3.5e-3
					}
					"C45/55" {
					set fck -45
					set fcm -53
					set fctm 3.8
					set E 36
					set ec1 -2.4e-3
					set ecu1 -3.5e-3
					}
					"C50/60" {
					set fck -50
					set fcm -58
					set fctm 4.1
					set E 37
					set ec1 -2.45e-3
					set ecu1 -3.5e-3
					}
					"C55/67" {
					set fck -55
					set fcm -63
					set fctm 4.2
					set E 38
					set ec1 -2.5e-3
					set ecu1 -3.2e-3
					}
					"C60/75" {
					set fck -60
					set fcm -68
					set fctm 4.4
					set E 39
					set ec1 -2.6e-3
					set ecu1 -3e-3
					}
					"C70/85" {
					set fck -70
					set fcm -78
					set fctm 4.6
					set E 41
					set ec1 -2.7e-3
					set ecu1 -2.8e-3
					}
					"C80/95" {
					set fck -80
					set fcm -88
					set fctm 4.8
					set E 42
					set ec1 -2.8e-3
					set ecu1 -2.8e-3
					}
					"C90/105" {
					set fck -90
					set fcm -24
					set fctm 5.0
					set E 44
					set ec1 -2.8e-3
					set ecu1 -2.8e-3
					}
					default {
					return ""
					}
				}
			}
			"Steel" {
				set steelGrade [DWLocalGetValue $GDN $STRUCT "Steel_Grade"]
				switch $steelGrade {
					"S235" {
					set Fy 235
					set E 200
					set epsP 1.175e-3
					set epsN -1.175e-3
					}
					"S275" {
					set Fy 275
					set E 200
					set epsP 1.375e-3
					set epsN -1.375e-3
					}
					"S355" {
					set Fy 355
					set E 200
					set epsP 1.775e-3
					set epsN -1.775e-3
					}
					"S450" {
					set Fy 450
					set E 200
					set epsP 2.25e-3
					set epsN -2.25e-3
					}
					"B500" {
					set Fy 500
					set E 200
					set epsP 2.5e-3
					set epsN -2.5e-3
					}
					default {
					return ""
					}
				}
			}
			default {
			return ""
			}
		}
		switch $mat {
			"Elastic" {
				set ok [DWLocalSetValue $GDN $STRUCT "Elastic_modulus_E" $E$Eunit]
			}
			"ElasticPerfectlyPlastic" {
				if { $matType == "Concrete"} {
					set strength_type [DWLocalGetValue $GDN $STRUCT "Strength_Type"]
					
					if { $strength_type=="Mean" } {
						set Ec [format "%g" [expr (2*$fcm/$ec1)/1000]]
					} elseif { $strength_type=="Characteristic" } {
						set Ec [format "%g" [expr (2*$fck/$ec1)/1000]]
					}
					set epsP [format "%e" [expr $fctm/(1000*$Ec)]]
					set ok [DWLocalSetValue $GDN $STRUCT "Elastic_modulus_E" $Ec$Eunit]
					set ok [DWLocalSetValue $GDN $STRUCT "Strain_epsP" $epsP]
					set ok [DWLocalSetValue $GDN $STRUCT "Strain_epsN" $ec1]
				} elseif { $matType == "Steel" } {
					set ok [DWLocalSetValue $GDN $STRUCT "Elastic_modulus_E" $E$Eunit]
					set ok [DWLocalSetValue $GDN $STRUCT "Strain_epsP" $epsP]
					set ok [DWLocalSetValue $GDN $STRUCT "Strain_epsN" $epsN]
				}
			}
			"ElasticPerfectlyPlasticwithGap" {
				if { $matType == "Concrete"} {
				set strength_type [DWLocalGetValue $GDN $STRUCT "Strength_Type"]
				
				if { $strength_type=="Mean" } {
					set Ec [format "%g" [expr (2*$fcm/$ec1)/1000]]
					set ok [DWLocalSetValue $GDN $STRUCT "Yield_Stress_Fy" $fcm$unit]
				} elseif { $strength_type=="Characteristic" } {
					set Ec [format "%g" [expr (2*$fck/$ec1)/1000]]
					set ok [DWLocalSetValue $GDN $STRUCT "Yield_Stress_Fy" $fck$unit]
				}
				set ok [DWLocalSetValue $GDN $STRUCT "Elastic_modulus_E" $Ec$Eunit]
				
				} elseif { $matType == "Steel" } {
				set ok [DWLocalSetValue $GDN $STRUCT "Yield_Stress_Fy" $Fy$unit]
				set ok [DWLocalSetValue $GDN $STRUCT "Elastic_modulus_E" $E$Eunit]
				} 
			}
		}
		
	}
return ""
}
return ""
}

proc TK_GenerateNDMaterialsProperties { event args } {
switch $event {
	SYNC {
		set GDN [lindex $args 0]
		set STRUCT [lindex $args 1]
		set QUESTION [lindex $args 2]
		set unit "MPa"
		set Eunit "GPa"
		set matType [DWLocalGetValue $GDN $STRUCT $QUESTION]
		set mat [DWLocalGetValue $GDN $STRUCT "Material:"]
	
		switch $matType {
			"Concrete" {
				set Concrete_class [DWLocalGetValue $GDN $STRUCT "Concrete_Class"]
				switch $Concrete_class {
					"C12/15" {
					set E 27
					set poisson 0.20
					} 
					"C16/20" {
					set E 29
					set poisson 0.20
					}
					"C20/25" {
					set E 30
					set poisson 0.20
					}
					"C25/30" {
					set E 31
					set poisson 0.20
					}
					"C30/37" {
					set E 33
					set poisson 0.20
					}
					"C35/45" {
					set E 34
					set poisson 0.20
					}
					"C40/50" {
					set E 35
					set poisson 0.20
					}
					"C45/55" {
					set E 36
					set poisson 0.20
					}
					"C50/60" {
					set E 37
					set poisson 0.20
					}
					"C55/67" {

					set E 38
					set poisson 0.20
					}
					"C60/75" {
					set E 39
					set poisson 0.20
					}
					"C70/85" {
					set E 41
					set poisson 0.20
					}
					"C80/95" {
					set E 42
					set poisson 0.20
					}
					"C90/105" {
					set E 44
					set poisson 0.20
					}
					default {
					return ""
					}
				}
			
			}
			"Steel" {
				set E 200
				set poisson 0.30
			}
			default {
			return ""
			}
		}
			switch $mat {
				"ElasticIsotropic" {
					set ok [DWLocalSetValue $GDN $STRUCT "Elastic_Modulus_E" $E$Eunit]
					set ok [DWLocalSetValue $GDN $STRUCT "Poisson's_ratio" $poisson]
				}
				default {
					return ""
				} 
			}
	return ""
	}
return ""
}
return ""
}

global Description_text
set Description_text ""
proc TK_DescriptionField { event args } {
			global Description_text 
			global Description_Parent GiDProjectDir GiDProjectName
	switch $event {
		INIT {
			set data [GiD_Info Project]
			set ProjectName [lindex $data 1]
		
			if { $ProjectName != "UNNAMED" } {
			loadProjectDirPath { "" }

			set filename [file join $GiDProjectDir "$GiDProjectName.txt"]
			set fexist [file exist $filename]
			
			if { $fexist == 1 } {
			set fp [open $filename r]
			set Description_text [read $fp]
			close $fp
			}
			}
			set PARENT [lindex $args 0]
			set Description_Parent $PARENT
			upvar [lindex $args 1] ROW
			set GDN [lindex $args 2]
			set STRUCT [lindex $args 3]
			set QUESTION [lindex $args 4]
			grid [text $PARENT.description -width 70 -height 13 -font {Calibri -14} ] -column 1 -row [expr $ROW+1]
			$PARENT.description delete 1.0 end
			$PARENT.description insert 1.0 "$Description_text"
			return ""
		}
		SYNC { 
			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]
			set Description_text [$Description_Parent.description get 1.0 end]
			set ok [SaveProjectDescriptionFile]
		}
	}
return ""
}

proc SaveProjectDescriptionFile { } {
set data [GiD_Info Project]
set ProjectName [lindex $data 1]
global GiDProjectDir GiDProjectName
global Description_text

	set Description_text [string trim $Description_text]	
	if { $ProjectName != "UNNAMED" } {
	loadProjectDirPath { "" }


	set file [file join $GiDProjectDir "$GiDProjectName.txt"]

	set fp [open $file w]
	puts $fp $Description_text
	close $fp
	}

return ""
}



proc TK_CheckModelingOptions { event args } {

	switch $event {

		INIT {

			return ""
		}

		SYNC {
			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]
			# Dimensions : the question name 
			set ndm [GiD_AccessValue get gendata "Dimensions"]
			set dof [GiD_AccessValue get gendata "DOF"]
			# ndm : number of dimensions of the project
			# dof : degrees of freedom per node
			if { ($ndm == "3" && $dof == "2") || ($ndm == "2" && $dof== "6") } {
				WarnWinText "You cannot define $dof DOFs in a $ndm-dimension model !"
				WarnWinText "Please check your options."
			}

			return ""
		}

		DEPEND {

			return ""
		}

		CLOSE {

			UpdateInfoBar

			return ""
		}
	}

	return ""
}


proc TK_ActiveIntervalinLoads { event args } {

	switch $event {

		INIT {
			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW
			set GDN [lindex $args 2]
			set STRUCT [lindex $args 3]
			set QUESTION [lindex $args 4]
			set data [GiD_Info intvdata num]
			set activeInterval [lindex $data 0]
			#set ok [DWLocalSetValue $GDN $STRUCT "Active_Interval:" $activeInterval]
			set cmd "GiD_Process Mescape Data Intervals ChangeInterval"
			set b [Button $PARENT.btable -text [= "Change Interval"] -helptext [= "Change Interval"] -command $cmd -state normal ]
			#set b [button $PARENT.changeintvbutton -image .actvintv -command $cmd -state normal -height 32 -width 32]
			grid $b -column 1 -row [expr $ROW+1] -sticky nw -pady 5 

			return  ""
		}

		SYNC {
			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]
			set data [GiD_Info intvdata num]
			set activeInterval [lindex $data 0]
			#set ok [DWLocalSetValue $GDN $STRUCT "Active_Interval:" $activeInterval]

			return ""
		}

		DEPEND {

			return ""
		}

		CLOSE {

			UpdateInfoBar

			return ""
		}
	}

	return ""
}

proc TK_EditInterval { event args } {

	switch $event {

		CLOSE {

			UpdateInfoBar

			return ""
		}
	}

	return ""
}
