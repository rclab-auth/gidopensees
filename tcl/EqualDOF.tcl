namespace eval EqualDOF {
	variable source_mode "All"
	variable source_layer "Layer0"
	variable auto_crit
	array set auto_crit [list x Any y Any z Any]
	variable auto_coords
	array set auto_coords [list x 0.0 y 0.0 z 0.0]
	variable auto_min
	array set auto_min [list x 0.0 y 0.0 z 0.0]
	variable auto_max
	array set auto_max [list x 0.0 y 0.0 z 0.0]
	variable auto_offset
	array set auto_offset [list x 0.0 y 0.0 z 0.0]
	variable auto_constraint; # array
	array set auto_constraint [list ux 1 uy 1 uz 1 rx 1 ry 1 rz 1]
	variable pointPointer
	variable nodePointer

	variable autoPointList [list ];
	variable autoNodeList [list ]

	variable auto_master "existed"
	variable autoMode 0; # 1 : last action : apply, 0 : last action : clear
	variable autoOverride 0; # 1 : Override, 0 : Append
	variable counterExtraPoints 0
	variable counterExtraNodes 0
}

proc EqualDOF::AutoOptionsButton { event args } {

	switch $event {

		INIT {

			set PARENT [lindex $args 0]
			upvar [lindex $args 1] ROW

			set cmd "GidOpenMaterials AutoEDOF"

			set b [Button $PARENT.btnOpenAutoEDOF -text [= " Automation Options "] -helptext [= "Open for automation options"] -command $cmd -state normal -compound left]
			grid $b -column 1 -row $ROW -sticky nw -pady 5

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

proc EqualDOF::AutoCreate { event args } {

	switch $event {

		INIT {
			lassign $args PARENT current_row_variable GDN STRUCT QUESTION
			upvar $current_row_variable ROW

			variable source_mode [DWLocalGetValue $GDN $STRUCT "Source:"]
			variable source_layer [DWLocalGetValue $GDN $STRUCT "Layer_name:"]

			variable auto_crit
			array set auto_crit [list x [DWLocalGetValue $GDN $STRUCT "X-Criteria"] \
			y [DWLocalGetValue $GDN $STRUCT "Y-Criteria"] \
			z [DWLocalGetValue $GDN $STRUCT "Z-Criteria"] ]

			variable auto_min
			array set auto_min [list x [DWLocalGetValue $GDN $STRUCT "Min_X-Coordinate"] \
			y [DWLocalGetValue $GDN $STRUCT "Min_Y-Coordinate"] \
			z [DWLocalGetValue $GDN $STRUCT "Min_Z-Coordinate"] ]

			variable auto_max
			array set auto_max [list x [DWLocalGetValue $GDN $STRUCT "Max_X-Coordinate"] \
			y [DWLocalGetValue $GDN $STRUCT "Max_Y-Coordinate"] \
			z [DWLocalGetValue $GDN $STRUCT "Max_Z-Coordinate"] ]

			variable auto_offset
			array set auto_offset [list x [DWLocalGetValue $GDN $STRUCT "X-Offset"] \
			y [DWLocalGetValue $GDN $STRUCT "Y-Offset"] \
			z [DWLocalGetValue $GDN $STRUCT "Z-Offset"] ]

			variable auto_coords
			array set auto_coords [list x [DWLocalGetValue $GDN $STRUCT "X-Coordinate"] \
			y [DWLocalGetValue $GDN $STRUCT "Y-Coordinate"] \
			z [DWLocalGetValue $GDN $STRUCT "Z-Coordinate"] ]

			variable auto_constraint
			array set auto_constraint [list ux [DWLocalGetValue $GDN $STRUCT "X-Translation"] \
			uy [DWLocalGetValue $GDN $STRUCT "Y-Translation"] \
			uz [DWLocalGetValue $GDN $STRUCT "Z-Translation"] \
			rx [DWLocalGetValue $GDN $STRUCT "X-Rotation"] \
			ry [DWLocalGetValue $GDN $STRUCT "X-Rotation"] \
			rz [DWLocalGetValue $GDN $STRUCT "X-Rotation"] ]

			variable auto_master [DWLocalGetValue $GDN $STRUCT "Determine_master_node"]

			set cmd "EqualDOF::AutoCreateCmd 1"

			set b [Button $PARENT.btnCreateZL -text [= " Apply AutoEDOF "] -helptext [= "Create EqualDOF constraints automatically"] -command $cmd -state normal -compound left]
			grid $b -column 1 -row [expr $ROW+1] -sticky nw -pady 5

			return ""
		}

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			variable source_mode [DWLocalGetValue $GDN $STRUCT "Source:"]
			variable source_layer [DWLocalGetValue $GDN $STRUCT "Layer_name:"]

			variable auto_crit
			array set auto_crit [list x [DWLocalGetValue $GDN $STRUCT "X-Criteria"] \
			y [DWLocalGetValue $GDN $STRUCT "Y-Criteria"] \
			z [DWLocalGetValue $GDN $STRUCT "Z-Criteria"] ]

			variable auto_min
			array set auto_min [list x [DWLocalGetValue $GDN $STRUCT "Min_X-Coordinate"] \
			y [DWLocalGetValue $GDN $STRUCT "Min_Y-Coordinate"] \
			z [DWLocalGetValue $GDN $STRUCT "Min_Z-Coordinate"] ]

			variable auto_max
			array set auto_max [list x [DWLocalGetValue $GDN $STRUCT "Max_X-Coordinate"] \
			y [DWLocalGetValue $GDN $STRUCT "Max_Y-Coordinate"] \
			z [DWLocalGetValue $GDN $STRUCT "Max_Z-Coordinate"] ]

			variable auto_offset
			array set auto_offset [list x [DWLocalGetValue $GDN $STRUCT "X-Offset"] \
			y [DWLocalGetValue $GDN $STRUCT "Y-Offset"] \
			z [DWLocalGetValue $GDN $STRUCT "Z-Offset"] ]

			variable auto_coords
			array set auto_coords [list x [DWLocalGetValue $GDN $STRUCT "X-Coordinate"] \
			y [DWLocalGetValue $GDN $STRUCT "Y-Coordinate"] \
			z [DWLocalGetValue $GDN $STRUCT "Z-Coordinate"] ]

			variable auto_constraint
			array set auto_constraint [list ux [DWLocalGetValue $GDN $STRUCT "X-Translation"] \
			uy [DWLocalGetValue $GDN $STRUCT "Y-Translation"] \
			uz [DWLocalGetValue $GDN $STRUCT "Z-Translation"] \
			rx [DWLocalGetValue $GDN $STRUCT "X-Rotation"] \
			ry [DWLocalGetValue $GDN $STRUCT "X-Rotation"] \
			rz [DWLocalGetValue $GDN $STRUCT "X-Rotation"] ]

			variable auto_master [DWLocalGetValue $GDN $STRUCT "Determine_master_node"]

		}
	}

	return ""
}

# pop : != 0 -> pop out dialog if needed, == 0 -> applied in the background
proc EqualDOF::AutoCreateCmd { pop } {

	# arrays
	variable auto_crit
	variable auto_coords
	variable auto_min
	variable auto_max
	variable auto_offset
	variable auto_constraint
	variable pointPointer
	variable nodePointer

	# variables
	variable source_mode
	variable source_layer
	variable autoMode
	variable autoOverride
	variable auto_master
	variable counterExtraPoints
	variable counterExtraNodes

	# lists
	variable autoPointList
	variable autoNodeList

	set response 0
	if { $autoMode == 1 } {

		set w .gid.autoEDOFOverrideDialog
		set response [tk_dialog $w "AutoEDOF" "You have already applied AutoEDOF function. Do you want to overwrite previous assignment or append to it ?\n" question 0 Override Append Cancel]

		if { $response == 0 } {; # override

			set dummy [EqualDOF::AutoClearCmd 0]
			set autoOverride 1

		} elseif { $response == 1 } { ; # append

			set autoOverride 0

		} else {; # cancelled dialog

			return ""
		}
	}

	set status [GiD_Info Project ViewMode]

	set visib_layers [GiD_Info Layers -on]
	set pointsList [GiD_Geometry list point]
	set maxPointNum [GiD_Info Geometry MaxNumPoints]
	set idcounter 0; # in case of append autoedof option, this counter will help for continuous id point/node creation
	set created_points 0
	foreach pointID $pointsList {

		# get the coordinates of each point
		set curr_layer [lindex [GiD_Geometry get point $pointID] 0]
		# do not make extra nodes because of already existed extra nodes!
		if { $curr_layer == "AutoEDOF" } { continue; }
		if { $source_mode == "Layer" && $source_layer != $curr_layer } {
			continue;
		} elseif { $source_mode == "Visible" } {
			set check [lsearch $visib_layers $curr_layer ]
			if { $check == -1 } {
				continue;
			}
		}

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

		set curr_x [format "%1.3f" [lindex [GiD_Geometry get point $pointID] 1]]
		set curr_y [format "%1.3f" [lindex [GiD_Geometry get point $pointID] 2]]
		set curr_z [format "%1.3f" [lindex [GiD_Geometry get point $pointID] 3]]

		if { $auto_crit(x) == "GT" } {
			if {$curr_x <= $auto_coords(x) } { continue; }
		} elseif { $auto_crit(x) == "GET" } {
			if {$curr_x < $auto_coords(x) } { continue; }
		} elseif { $auto_crit(x) == "LT" } {
			if {$curr_x >= $auto_coords(x) } { continue; }
		} elseif { $auto_crit(x) == "LET" } {
			if {$curr_x > $auto_coords(x) } { continue; }
		} elseif { $auto_crit(x) == "Fixed" } {
			if {$curr_x != $auto_coords(x) } { continue; }
		} elseif { $auto_crit(x) == "Between" } {
			if { $curr_x < $auto_min(x) || $curr_x > $auto_max(x) } { continue; }
		}

		if { $auto_crit(y) == "GT" } {
			if {$curr_y <= $auto_coords(y) } { continue; }
		} elseif { $auto_crit(y) == "GET" } {
			if {$curr_y < $auto_coords(y) } { continue; }
		} elseif { $auto_crit(y) == "LT" } {
			if {$curr_y >= $auto_coords(y) } { continue; }
		} elseif { $auto_crit(y) == "LET" } {
			if {$curr_y > $auto_coords(y) } { continue; }
		} elseif { $auto_crit(y) == "Fixed" } {
			if {$curr_y != $auto_coords(y) } { continue; }
		} elseif { $auto_crit(y) == "Between" } {
			if { $curr_y < $auto_min(y) || $curr_y > $auto_max(y) } { continue; }
		}

		if { $auto_crit(z) == "GT" } {
			if {$curr_z <= $auto_coords(z) } { continue; }
		} elseif { $auto_crit(z) == "GET" } {
			if {$curr_z < $auto_coords(z) } { continue; }
		} elseif { $auto_crit(z) == "LT" } {
			if {$curr_z >= $auto_coords(z) } { continue; }
		} elseif { $auto_crit(z) == "LET" } {
			if {$curr_z > $auto_coords(z) } { continue; }
		} elseif { $auto_crit(z) == "Fixed" } {
			if {$curr_z != $auto_coords(z) } { continue; }
		} elseif { $auto_crit(z) == "Between" } {
			if { $curr_z < $auto_min(z) || $curr_z > $auto_max(z) } { continue; }
		}

		#create the AutoEDOF layer if not exists

		set lexists [GiD_Layers exists "AutoEDOF"]

		if { !$lexists } {

			GiD_Layers create "AutoEDOF"

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
		GiD_Geometry create point $curr_id "AutoEDOF" [expr $curr_x+$auto_offset(x)] [expr $curr_y+$auto_offset(y)] [expr $curr_z+$auto_offset(z)]
		lappend autoPointList $curr_id
		set pointPointer($curr_id,point) $pointID
		set pointPointer($pointID,point) $curr_id
		# Assign equaldof constraint
		if { $auto_master == "Existed" } {

			GiD_AssignData condition Point_Equal_constraint_master_node points [list AutoEDOF$curr_id " " " "] [list $pointID]
			GiD_AssignData condition Point_Equal_constraint_slave_nodes points [list AutoEDOF$curr_id $auto_constraint(ux) $auto_constraint(uy) $auto_constraint(uz) $auto_constraint(rx) $auto_constraint(ry) $auto_constraint(rz)] [list $curr_id]

		} else {; # extra

			GiD_AssignData condition Point_Equal_constraint_master_node points [list AutoEDOF$curr_id " " " "] [list $curr_id]
			GiD_AssignData condition Point_Equal_constraint_slave_nodes points [list AutoEDOF$curr_id $auto_constraint(ux) $auto_constraint(uy) $auto_constraint(uz) $auto_constraint(rx) $auto_constraint(ry) $auto_constraint(rz)] [list $pointID]

		}
	}

	set created_nodes 0

	if { ![catch {GiD_Mesh list node} ] } {

	set nodeslist [GiD_Mesh list node]
	set maxNodeNum [GiD_Info Mesh MaxNumNodes]
	set idcounter 0; # in case of append autozl option, this counter will help for continuous id point/node creation
	foreach nodeID $nodeslist {

		set curr_layer [lindex [GiD_Mesh get node $nodeID] 0]
		# do not make extra nodes because of already existed extra nodes!
		if { $curr_layer == "AutoZL" } { continue; }
		if { $source_mode == "Layer" && $source_layer != $curr_layer } {
			continue;
		} elseif { $source_mode == "Visible" } {
			set check [lsearch $visib_layers $curr_layer ]
			if { $check == -1 } {
				continue;
			}
		}

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

		if { $auto_crit(x) == "GT" } {
			if {$curr_x <= $auto_coords(x) } { continue; }
		} elseif { $auto_crit(x) == "GET" } {
			if {$curr_x < $auto_coords(x) } { continue; }
		} elseif { $auto_crit(x) == "LT" } {
			if {$curr_x >= $auto_coords(x) } { continue; }
		} elseif { $auto_crit(x) == "LET" } {
			if {$curr_x > $auto_coords(x) } { continue; }
		} elseif { $auto_crit(x) == "Fixed" } {
			if {$curr_x != $auto_coords(x) } { continue; }
		} elseif { $auto_crit(x) == "Between" } {
			if { $curr_x < $auto_min(x) || $curr_x > $auto_max(x) } { continue; }
		}

		if { $auto_crit(y) == "GT" } {
			if {$curr_y <= $auto_coords(y) } { continue; }
		} elseif { $auto_crit(y) == "GET" } {
			if {$curr_y < $auto_coords(y) } { continue; }
		} elseif { $auto_crit(y) == "LT" } {
			if {$curr_y >= $auto_coords(y) } { continue; }
		} elseif { $auto_crit(y) == "LET" } {
			if {$curr_y > $auto_coords(y) } { continue; }
		} elseif { $auto_crit(y) == "Fixed" } {
			if {$curr_y != $auto_coords(y) } { continue; }
		} elseif { $auto_crit(y) == "Between" } {
			if { $curr_y < $auto_min(y) || $curr_y > $auto_max(y) } { continue; }
		}

		if { $auto_crit(z) == "GT" } {
			if {$curr_z <= $auto_coords(z) } { continue; }
		} elseif { $auto_crit(z) == "GET" } {
			if {$curr_z < $auto_coords(z) } { continue; }
		} elseif { $auto_crit(z) == "LT" } {
			if {$curr_z >= $auto_coords(z) } { continue; }
		} elseif { $auto_crit(z) == "LET" } {
			if {$curr_z > $auto_coords(z) } { continue; }
		} elseif { $auto_crit(z) == "Fixed" } {
			if {$curr_z != $auto_coords(z) } { continue; }
		} elseif { $auto_crit(z) == "Between" } {
			if { $curr_z < $auto_min(z) || $curr_z > $auto_max(z) } { continue; }
		}

		incr counterExtraNodes
		incr created_nodes
		if { $autoOverride == 0} {

			incr idcounter
			set curr_id [expr $maxNodeNum+$idcounter]

		} else {

			set curr_id [expr $maxNodeNum+$counterExtraNodes]

		}

		# create the extra node
		GiD_Mesh create node $curr_id [list [expr $curr_x+$auto_offset(x)] [expr $curr_y+$auto_offset(y)] [expr $curr_z+$auto_offset(z)]]
		lappend autoNodeList $curr_id
		set nodePointer($curr_id,node) $nodeID
		set nodePointer($nodeID,node) $curr_id
		if { $auto_master == "Existed" } {

			GiD_AssignData condition Point_Equal_constraint_master_node nodes [list AutoEDOF$curr_id " " " "] [list $nodeID]
			GiD_AssignData condition Point_Equal_constraint_slave_nodes nodes [list AutoEDOF$curr_id $auto_constraint(ux) $auto_constraint(uy) $auto_constraint(uz) $auto_constraint(rx) $auto_constraint(ry) $auto_constraint(rz)] [list $curr_id]

		} else {; # extra

			GiD_AssignData condition Point_Equal_constraint_master_node nodes [list AutoEDOF$curr_id " " " "] [list $curr_id]
			GiD_AssignData condition Point_Equal_constraint_slave_nodes nodes [list AutoEDOF$curr_id $auto_constraint(ux) $auto_constraint(uy) $auto_constraint(uz) $auto_constraint(rx) $auto_constraint(ry) $auto_constraint(rz)] [list $pointID]

		}
	}
	}

	if { $created_points || $created_nodes } {

		set autoMode 1

	}

	if { $pop && ($created_points || $created_nodes) } {

		set w .gid.autoEDOFApplyInfo
		set ans [tk_dialog $w "Apply AutoEDOF data" "AutoEDOF was applied successfully !\n$created_points extra points and $created_nodes extra nodes were created." info 0 OK]

	} elseif { $pop && !$created_points && !$created_nodes } {

		set w .gid.autoEDOFApplyInfo
		set ans [tk_dialog $w "Apply AutoEDOF data" "No point/node found to meet the desired criteria !" info 0 OK]

	}
	GiD_Redraw
	return ""
}

proc EqualDOF::AutoClear { event args } {

	switch $event {

		INIT {
			lassign $args PARENT current_row_variable GDN STRUCT QUESTION
			upvar $current_row_variable ROW

			set cmd "EqualDOF::AutoClearCmd 1"

			set b [Button $PARENT.btnAutoClear -text [= " Clear AutoEDOF "] -helptext [= "Delete extra nodes from AutoEDOF layer"] -command $cmd -state normal -compound left]
			grid $b -column 1 -row [expr $ROW+1] -sticky nw -pady 5

			return ""

		}

	}
	return ""
}

proc EqualDOF::AutoClearCmd { pop } {

	variable pointPointer
	variable nodePointer
	variable autoPointList
	variable autoNodeList
	variable autoMode

	# number of points / nodes removed
	set removed_points 0
	set removed_nodes 0
	set autoMode 0; # 0 -> last action will be Clear
	set status [GiD_Info Project ViewMode]; # GEOMETRYUSE / MESHUSE
	set lexists [GiD_Layers exists "AutoEDOF"]; # exists -> 1, non existant -> 0

	variable counterExtraNodes 0
	variable counterExtraPoints 0

	if { $lexists } {

		set pointsList [GiD_Geometry list -layer "AutoEDOF" point]

	} else {

		set pointsList [GiD_Geometry list point]

	}

	foreach extraPointID $pointsList {

		set check [lsearch $autoPointList $extraPointID]

		if { $check != -1 } {

			GiD_Geometry delete point $extraPointID
			set exists [info exists pointPointer($extraPointID,point)]
			if { $exists } {

				GiD_UnAssignData condition Point_Equal_constraint_master_node points [list $pointPointer($extraPointID,point)]
				GiD_UnAssignData condition Point_Equal_constraint_slave_nodes points [list $pointPointer($extraPointID,point)]

			}
			incr removed_points

		}
	}

	if { ![catch {GiD_Mesh list node} ] } {

		set nodesList [GiD_Mesh list node]

		foreach extraNodeID $nodesList {

			set check [lsearch $autoNodeList $extraNodeID]
			if { $check != -1 } {

				GiD_Mesh delete node $extraNodeID

				set exists [info exists nodePointer($extraNodeID,node)]
				if { $exists } {

					GiD_UnAssignData condition Point_Equal_constraint_master_node nodes [list $nodePointer($extraNodeID,node)]
					GiD_UnAssignData condition Point_Equal_constraint_slave_nodes nodes [list $nodePointer($extraNodeID,node)]

				}

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
		tk_dialog .gid.autoZLClearInfo "AutoEDOF clear data" "$removed_points points and $removed_nodes nodes were deleted.\nThe corresponding conditions were unassigned." info 0 OK
	} elseif { !$removed_points && !$removed_nodes && $pop } {
		tk_dialog .gid.autoZLClearInfo "AutoEDOF clear data" "Nothing was found to remove !" info 0 OK
	}
	GiD_Redraw
	return ""

}