namespace eval ZeroLength {
	variable auto_x_crit "Any"
	variable auto_y_crit "Any"
	variable auto_z_crit "Any"
	variable auto_x 0.0
	variable auto_y 0.0
	variable auto_z 0.0
	variable auto_min_x 0.0
	variable auto_max_x 0.0
	variable auto_min_y 0.0
	variable auto_max_y 0.0
	variable auto_min_z 0.0
	variable auto_max_z 0.0
	variable auto_x_offset 0.0
	variable auto_y_offset 0.0
	variable auto_z_offset 0.0
	variable auto_activate_ux 1
	variable auto_ux_mat "Elastic"
	variable auto_activate_uy 1
	variable auto_uy_mat "Elastic"
	variable auto_activate_uz 1
	variable auto_uz_mat "Elastic"
	variable auto_activate_rx 1
	variable auto_rx_mat "Elastic"
	variable auto_activate_ry 1
	variable auto_ry_mat "Elastic"
	variable auto_activate_rz 1
	variable auto_rz_mat "Elastic"
	variable counterExtraNodes 0
	variable counterExtraPoints 0
	variable pointPointer; # it is an array that points to the point, that the extra point is connected through autoZL
	variable nodePointer; # array that points to the node, that the extra node is connected through autoZL
	variable autoNodeList [list ]; # in Mesh Mode we cannot create a node in a specific layer, so we need to know which nodes were made by the autoZL function
	variable autoPointList [list ]
	variable autoMode 0; # 1 indicates that last action was : apply autoZL, 0 indicates that last action was clear!
	variable autoOverride 0; # 1 : Override, 0 : Append
}

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

proc ZeroLength::AutoOptionsButton { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW

			set cmd "GidOpenMaterials AutoZL"

			set b [Button $PARENT.btnopenautozl -text [= " Automation Options "] -helptext [= "Open for automation options"] -command $cmd -state normal -compound left]
			grid $b -column 1 -row [expr $ROW+1] -sticky nw -pady 5

			return ""

		}

		SYNC {

		}

		CLOSE {

			UpdateInfoBar

		}

		DEPEND {

		}

	}
	return ""
}

proc ZeroLength::AutoCreate { event args } {

	switch $event {

			INIT {
				lassign $args PARENT current_row_variable GDN STRUCT QUESTION
				upvar $current_row_variable ROW

				variable auto_x_crit [DWLocalGetValue $GDN $STRUCT "X-Criteria"]
				variable auto_y_crit [DWLocalGetValue $GDN $STRUCT "Y-Criteria"]
				variable auto_z_crit [DWLocalGetValue $GDN $STRUCT "Z-Criteria"]

				variable auto_x [DWLocalGetValue $GDN $STRUCT "X-Coordinate"]
				variable auto_y [DWLocalGetValue $GDN $STRUCT "Y-Coordinate"]
				variable auto_z [DWLocalGetValue $GDN $STRUCT "Z-Coordinate"]

				variable auto_min_x [DWLocalGetValue $GDN $STRUCT "Min_X-Coordinate"]
				variable auto_max_x [DWLocalGetValue $GDN $STRUCT "Max_X-Coordinate"]
				variable auto_min_y [DWLocalGetValue $GDN $STRUCT "Min_Y-Coordinate"]
				variable auto_max_y [DWLocalGetValue $GDN $STRUCT "Max_Y-Coordinate"]
				variable auto_min_z [DWLocalGetValue $GDN $STRUCT "Min_Z-Coordinate"]
				variable auto_max_z [DWLocalGetValue $GDN $STRUCT "Max_Z-Coordinate"]

				variable auto_x_offset [DWLocalGetValue $GDN $STRUCT "X-Offset"]
				variable auto_y_offset [DWLocalGetValue $GDN $STRUCT "Y-Offset"]
				variable auto_z_offset [DWLocalGetValue $GDN $STRUCT "Z-Offset"]

				variable auto_activate_ux [DWLocalGetValue $GDN $STRUCT "Activate_Ux"]
				variable auto_activate_uy [DWLocalGetValue $GDN $STRUCT "Activate_Uy"]
				variable auto_activate_uz [DWLocalGetValue $GDN $STRUCT "Activate_Uz"]
				variable auto_activate_rx [DWLocalGetValue $GDN $STRUCT "Activate_Rx"]
				variable auto_activate_ry [DWLocalGetValue $GDN $STRUCT "Activate_Ry"]
				variable auto_activate_rz [DWLocalGetValue $GDN $STRUCT "Activate_Rz"]

				variable auto_ux_mat [DWLocalGetValue $GDN $STRUCT "Ux_material"]
				variable auto_uy_mat [DWLocalGetValue $GDN $STRUCT "Uy_material"]
				variable auto_uz_mat [DWLocalGetValue $GDN $STRUCT "Uz_material"]
				variable auto_rx_mat [DWLocalGetValue $GDN $STRUCT "Rx_material"]
				variable auto_ry_mat [DWLocalGetValue $GDN $STRUCT "Ry_material"]
				variable auto_rz_mat [DWLocalGetValue $GDN $STRUCT "Rz_material"]

				set cmd "ZeroLength::AutoCreateCmd 1"

				set b [Button $PARENT.btnCreateZL -text [= " Apply AutoZL "] -helptext [= "Create Zero length elements automatically"] -command $cmd -state normal -compound left]
				grid $b -column 1 -row [expr $ROW+1] -sticky nw -pady 5

				return ""

			}

			SYNC {

				set GDN [lindex $args 0]
				set STRUCT [lindex $args 1]
				set QUESTION [lindex $args 2]

				variable auto_x_crit [DWLocalGetValue $GDN $STRUCT "X-Criteria"]
				variable auto_y_crit [DWLocalGetValue $GDN $STRUCT "Y-Criteria"]
				variable auto_z_crit [DWLocalGetValue $GDN $STRUCT "Z-Criteria"]

				variable auto_x [DWLocalGetValue $GDN $STRUCT "X-Coordinate"]
				variable auto_y [DWLocalGetValue $GDN $STRUCT "Y-Coordinate"]
				variable auto_z [DWLocalGetValue $GDN $STRUCT "Z-Coordinate"]

				variable auto_min_x [DWLocalGetValue $GDN $STRUCT "Min_X-Coordinate"]
				variable auto_max_x [DWLocalGetValue $GDN $STRUCT "Max_X-Coordinate"]
				variable auto_min_y [DWLocalGetValue $GDN $STRUCT "Min_Y-Coordinate"]
				variable auto_max_y [DWLocalGetValue $GDN $STRUCT "Max_Y-Coordinate"]
				variable auto_min_z [DWLocalGetValue $GDN $STRUCT "Min_Z-Coordinate"]
				variable auto_max_z [DWLocalGetValue $GDN $STRUCT "Max_Z-Coordinate"]

				variable auto_x_offset [DWLocalGetValue $GDN $STRUCT "X-Offset"]
				variable auto_y_offset [DWLocalGetValue $GDN $STRUCT "Y-Offset"]
				variable auto_z_offset [DWLocalGetValue $GDN $STRUCT "Z-Offset"]

				variable auto_activate_ux [DWLocalGetValue $GDN $STRUCT "Activate_Ux"]
				variable auto_activate_uy [DWLocalGetValue $GDN $STRUCT "Activate_Uy"]
				variable auto_activate_uz [DWLocalGetValue $GDN $STRUCT "Activate_Uz"]
				variable auto_activate_rx [DWLocalGetValue $GDN $STRUCT "Activate_Rx"]
				variable auto_activate_ry [DWLocalGetValue $GDN $STRUCT "Activate_Ry"]
				variable auto_activate_rz [DWLocalGetValue $GDN $STRUCT "Activate_Rz"]

				variable auto_ux_mat [DWLocalGetValue $GDN $STRUCT "Ux_material"]
				variable auto_uy_mat [DWLocalGetValue $GDN $STRUCT "Uy_material"]
				variable auto_uz_mat [DWLocalGetValue $GDN $STRUCT "Uz_material"]
				variable auto_rx_mat [DWLocalGetValue $GDN $STRUCT "Rx_material"]
				variable auto_ry_mat [DWLocalGetValue $GDN $STRUCT "Ry_material"]
				variable auto_rz_mat [DWLocalGetValue $GDN $STRUCT "Rz_material"]

			}

			CLOSE {

			}

			DEPEND {

			}

		}
		return ""
}

proc ZeroLength::createLayer {} {

	set lexists [GiD_Layers exists "AutoZL"]

	if { !$lexists } {

		GiD_Layers create "AutoZL"

	}

}

proc ZeroLength::AutoCreateCmd { pop } {

	variable auto_x_crit
	variable auto_y_crit
	variable auto_z_crit
	variable auto_x
	variable auto_y
	variable auto_z
	variable auto_min_x
	variable auto_max_x
	variable auto_min_y
	variable auto_max_y
	variable auto_min_z
	variable auto_max_z
	variable auto_x_offset
	variable auto_y_offset
	variable auto_z_offset
	variable counterExtraPoints
	variable counterExtraNodes
	variable auto_activate_ux
	variable auto_ux_mat
	variable auto_activate_uy
	variable auto_uy_mat
	variable auto_activate_uz
	variable auto_uz_mat
	variable auto_activate_rx
	variable auto_rx_mat
	variable auto_activate_ry
	variable auto_ry_mat
	variable auto_activate_rz
	variable auto_rz_mat
	variable pointPointer
	variable nodePointer
	variable autoPointList
	variable autoNodeList
	variable autoOverride
	variable autoMode

	set response 0
	if { $autoMode == 1 } {

		set w .gid.autoZLOverrideDialog
		set response [tk_dialog $w "AutoZL" "You have already applied AutoZL function. Do you want to overwrite previous assignment or append to it ?\n" question 0 Override Append Cancel]

		if { $response == 0 } {; # override

			set dummy [ZeroLength::AutoClearCmd 0]
			set autoOverride 1

		} elseif { $response == 1 } { ; # append

			set autoOverride 0

		} else {; # cancelled dialog

			return ""
		}
	}

	set status [GiD_Info Project ViewMode]

	#create the AutoZL layer if not exists
	createLayer

	set pointsList [GiD_Geometry list point]
	set maxPointNum [GiD_Info Geometry MaxNumPoints]
	set idcounter 0; # in case of append autozl option, this counter will help for continuous id point/node creation
	set created_points 0
	foreach pointID $pointsList {

		set curr_layer [lindex [GiD_Geometry get point $pointID] 0]
		# do not make extra nodes because of already existed extra nodes!
		if { $curr_layer == "AutoZL" } { continue; }

		set check [lsearch $autoPointList $pointID]
		if { $check != -1 } {
			continue;
		}

		set exists [info exists pointPointer($pointID,point)]
		if { $exists } {

			set check [lsearch $autoPointList $pointPointer($pointID,point)]
			if { $check != -1 && $autoOverride == 1} {
				continue;
			}
		}

		# get the coordinates of each point
		set curr_x [format "%1.3f" [lindex [GiD_Geometry get point $pointID] 1]]
		set curr_y [format "%1.3f" [lindex [GiD_Geometry get point $pointID] 2]]
		set curr_z [format "%1.3f" [lindex [GiD_Geometry get point $pointID] 3]]

		if { $auto_x_crit == "GT" } {
			if {$curr_x <= $auto_x } { continue; }
		} elseif { $auto_x_crit == "GET" } {
			if {$curr_x < $auto_x } { continue; }
		} elseif { $auto_x_crit == "LT" } {
			if {$curr_x >= $auto_x } { continue; }
		} elseif { $auto_x_crit == "LET" } {
			if {$curr_x > $auto_x } { continue; }
		} elseif { $auto_x_crit == "Fixed" } {
			if {$curr_x != $auto_x } { continue; }
		} elseif { $auto_x_crit == "Between" } {
			if { $curr_x < $auto_min_x || $curr_x > $auto_max_x } { continue; }
		}

		if { $auto_y_crit == "GT" } {
			if {$curr_y <= $auto_y } { continue; }
		} elseif { $auto_y_crit == "GET" } {
			if {$curr_y < $auto_y } { continue; }
		} elseif { $auto_y_crit == "LT" } {
			if {$curr_y >= $auto_y } { continue; }
		} elseif { $auto_y_crit == "LET" } {
			if {$curr_y > $auto_y } { continue; }
		} elseif { $auto_y_crit == "Fixed" } {
			if {$curr_y != $auto_y } { continue; }
		} elseif { $auto_y_crit == "Between" } {
			if { $curr_y < $auto_min_y || $curr_x > $auto_max_y } { continue; }
		}

		if { $auto_z_crit == "GT" } {
			if {$curr_z <= $auto_z } { continue; }
		} elseif { $auto_z_crit == "GET" } {
			if {$curr_z < $auto_z } { continue; }
		} elseif { $auto_z_crit == "LT" } {
			if {$curr_z >= $auto_z } { continue; }
		} elseif { $auto_z_crit == "LET" } {
			if {$curr_z > $auto_z } { continue; }
		} elseif { $auto_z_crit == "Fixed" } {
			if {$curr_z != $auto_z } { continue; }
		} elseif { $auto_z_crit == "Between" } {
			if { $curr_z < $auto_min_z || $curr_z > $auto_max_z } { continue; }
		}

		incr counterExtraPoints
		incr created_points
		if { $autoOverride == 0 } {

			incr idcounter
			set curr_id [expr $maxPointNum+$idcounter]

		} else {

			set curr_id [expr $maxPointNum+$counterExtraPoints]

		}

		# create the extra point
		GiD_Geometry create point $curr_id "AutoZL" [expr $curr_x+$auto_x_offset] [expr $curr_y+$auto_y_offset] [expr $curr_z+$auto_z_offset]
		lappend autoPointList $curr_id
		set pointPointer($curr_id,point) $pointID
		set pointPointer($pointID,point) $curr_id
		# Assign zerolength element
		GiD_AssignData condition Point_ZeroLength points [list "AutoZL$curr_id" "$auto_activate_ux" "$auto_ux_mat" "$auto_activate_uy" "$auto_uy_mat" "$auto_activate_uz" "$auto_uz_mat" "$auto_activate_rx" "$auto_rx_mat" "$auto_activate_ry" "$auto_ry_mat" "$auto_activate_rz" "$auto_rz_mat" " " ] [list "$pointID" "$curr_id" ]
	}

	set created_nodes 0
	if { ![catch {GiD_Mesh list node} ] } {

	set nodeslist [GiD_Mesh list node]
	set maxNodeNum [GiD_Info Mesh MaxNumNodes]
	set idcounter 0; # in case of append autozl option, this counter will help for continuous id point/node creation
	foreach nodeID $nodeslist {

		# get the coordinates of each node
		set check [lsearch $autoNodeList $nodeID]
		if { $check != -1 } {
			continue;
		}
		set exists [info exists nodePointer($nodeID,node)]
		if { $exists } {

			set check [lsearch $autoNodeList $nodePointer($nodeID,node)]
			if { $check != -1 && $autoOverride == 1 } {
				continue;
			}
		}

		set curr_x [format "%1.3f" [lindex [GiD_Mesh get node $nodeID] 1]]
		set curr_y [format "%1.3f" [lindex [GiD_Mesh get node $nodeID] 2]]
		set curr_z [format "%1.3f" [lindex [GiD_Mesh get node $nodeID] 3]]

		if { $auto_x_crit == "GT" } {
			if {$curr_x <= $auto_x } { continue; }
		} elseif { $auto_x_crit == "GET" } {
			if {$curr_x < $auto_x } { continue; }
		} elseif { $auto_x_crit == "LT" } {
			if {$curr_x >= $auto_x } { continue; }
		} elseif { $auto_x_crit == "LET" } {
			if {$curr_x > $auto_x } { continue; }
		} elseif { $auto_x_crit == "Fixed" } {
			if {$curr_x != $auto_x } { continue; }
		} elseif { $auto_x_crit == "Between" } {
			if { $curr_x < $auto_min_x || $curr_x > $auto_max_x } { continue; }
		}

		if { $auto_y_crit == "GT" } {
			if {$curr_y <= $auto_y } { continue; }
		} elseif { $auto_y_crit == "GET" } {
			if {$curr_y < $auto_y } { continue; }
		} elseif { $auto_y_crit == "LT" } {
			if {$curr_y >= $auto_y } { continue; }
		} elseif { $auto_y_crit == "LET" } {
			if {$curr_y > $auto_y } { continue; }
		} elseif { $auto_y_crit == "Fixed" } {
			if {$curr_y != $auto_y } { continue; }
		} elseif { $auto_y_crit == "Between" } {
			if { $curr_y < $auto_min_y || $curr_x > $auto_max_y } { continue; }
		}

		if { $auto_z_crit == "GT" } {
			if {$curr_z <= $auto_z } { continue; }
		} elseif { $auto_z_crit == "GET" } {
			if {$curr_z < $auto_z } { continue; }
		} elseif { $auto_z_crit == "LT" } {
			if {$curr_z >= $auto_z } { continue; }
		} elseif { $auto_z_crit == "LET" } {
			if {$curr_z > $auto_z } { continue; }
		} elseif { $auto_z_crit == "Fixed" } {
			if {$curr_z != $auto_z } { continue; }
		} elseif { $auto_z_crit == "Between" } {
			if { $curr_z < $auto_min_z || $curr_z > $auto_max_z } { continue; }
		}

		incr created_nodes
		incr counterExtraNodes
		if { $autoOverride == 0} {

			incr idcounter
			set curr_id [expr $maxNodeNum+$idcounter]

		} else {

			set curr_id [expr $maxNodeNum+$counterExtraNodes]

		}

		# create the extra node
		GiD_Mesh create node $curr_id [list [expr $curr_x+$auto_x_offset] [expr $curr_y+$auto_y_offset] [expr $curr_z+$auto_z_offset]]
		lappend autoNodeList $curr_id
		set nodePointer($curr_id,node) $nodeID
		set nodePointer($nodeID,node) $curr_id
		GiD_AssignData condition Point_ZeroLength nodes [list "AutoZL$curr_id" "$auto_activate_ux" "$auto_ux_mat" "$auto_activate_uy" "$auto_uy_mat" "$auto_activate_uz" "$auto_uz_mat" "$auto_activate_rx" "$auto_rx_mat" "$auto_activate_ry" "$auto_ry_mat" "$auto_activate_rz" "$auto_rz_mat" " " ] [list "$nodeID" "$curr_id" ]
	}
	}

	if { $created_points || $created_nodes } {

		set autoMode 1

	}
	if { $pop && ($created_points || $created_nodes) } {

		tk_dialog .gid.autoZLApplyInfo "Apply AutoZL data" "AutoZL was applied successfully !\n$created_points extra points and $created_nodes extra nodes were created." info 0 OK

	} elseif { $pop && !$created_points && !$created_nodes } {

		tk_dialog .gid.autoZLApplyInfo "Apply AutoZL data" "No point/node found to meet the desired criteria !" info 0 OK

	}
	GiD_Redraw
	return ""
}

proc ZeroLength::AutoClear { event args } {

	switch $event {

		INIT {
			lassign $args PARENT current_row_variable GDN STRUCT QUESTION
			upvar $current_row_variable ROW

			set cmd "ZeroLength::AutoClearCmd 1"

			set b [Button $PARENT.btnAutoClear -text [= " Clear AutoZL "] -helptext [= "Delete extra nodes from AutoZL layer"] -command $cmd -state normal -compound left]
			grid $b -column 1 -row [expr $ROW+1] -sticky nw -pady 5

			return ""

		}
	}
		return ""
}

proc ZeroLength::AutoClearCmd { pop } {

	variable pointPointer
	variable nodePointer
	variable autoNodeList
	variable autoPointList
	variable autoMode

	# number of points / nodes removed
	set removed_points 0
	set removed_nodes 0
	set autoMode 0; # 0 -> last action will be Clear
	set status [GiD_Info Project ViewMode]; # GEOMETRYUSE / MESHUSE
	set lexists [GiD_Layers exists "AutoZL"]; # exists -> 1, non existant -> 0

	variable counterExtraNodes 0
	variable counterExtraPoints 0

	if { $lexists } {

		set pointsList [GiD_Geometry list -layer "AutoZL" point]

	} else {

		set pointsList [GiD_Geometry list point]

	}

	foreach extraPointID $pointsList {

		set check [lsearch $autoPointList $extraPointID]

		if { $check != -1 } {

			GiD_Geometry delete point $extraPointID
			GiD_UnAssignData condition Point_ZeroLength points [list $pointPointer($extraPointID,point)]
			incr removed_points

		}
	}

	if { ![catch {GiD_Mesh list node} ] } {

		set nodesList [GiD_Mesh list node]

		foreach extraNodeID $nodesList {

			set check [lsearch $autoNodeList $extraNodeID]
			# if this node is a node made from autoZL function, delete it, and unassign the zerolength condition from the node it was connected with
			if { $check != -1 } {

				GiD_Mesh delete node $extraNodeID
				GiD_UnAssignData condition Point_ZeroLength nodes [list $nodePointer($extraNodeID,node)]
				incr removed_nodes

			}
		}
	} else {
		set nodesList ""
	}

	array unset pointPointer
	array unset nodePointer
	set autoNodeList [list ]
	set autoPointList [list ]

	if { ($removed_points || $removed_nodes) && $pop} {
		tk_dialog .gid.autoZLClearInfo "AutoZL clear data" "$removed_points points and $removed_nodes nodes were deleted.\nThe corresponding conditions were unassigned." info 0 OK
	} elseif { !$removed_points &&!$removed_nodes && $pop } {
		tk_dialog .gid.autoZLClearInfo "AutoZL clear data" "Nothing was found to remove !" info 0 OK
	}
	GiD_Redraw
	return ""
}