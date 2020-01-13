proc CompareNodesCoordinates { NodeNum1 NodeNum2 {coordinates "all"} } {

	set xNodeCoord1 [format "%1.3f" [lindex [GiD_Mesh get node $NodeNum1] 1]]
	set yNodeCoord1 [format "%1.3f" [lindex [GiD_Mesh get node $NodeNum1] 2]]
	set zNodeCoord1 [format "%1.3f" [lindex [GiD_Mesh get node $NodeNum1] 3]]
	set xNodeCoord2 [format "%1.3f" [lindex [GiD_Mesh get node $NodeNum2] 1]]
	set yNodeCoord2 [format "%1.3f" [lindex [GiD_Mesh get node $NodeNum2] 2]]
	set zNodeCoord2 [format "%1.3f" [lindex [GiD_Mesh get node $NodeNum2] 3]]

	switch $coordinates {

	"all" {

		if {$xNodeCoord1 == $xNodeCoord2 && $yNodeCoord1 == $yNodeCoord2 && $zNodeCoord1 == $zNodeCoord2} {
		#WarnWinText "$NodeNum1 : $xNodeCoord1 $yNodeCoord1 $zNodeCoord1\n$NodeNum2 : $xNodeCoord2 $yNodeCoord2 $zNodeCoord2\n"
		return 1

		} else {

		return 0

		}
	}
	"x" {

		if {$xNodeCoord1 == $xNodeCoord2} {

		return 1

		} else {

		return 0

		}

	}
	"y" {

		if {$yNodeCoord1 == $yNodeCoord2} {

		return 1

		} else {

		return 0

		}

	}
	"z" {

		if {$zNodeCoord1 == $zNodeCoord2} {

		return 1

		} else {

		return 0

		}

	}

	}

	return 0
}

# GiD_Mesh get node $num --> [list <layer> <x> <y> <z>]

proc ReturnNodeCoordinate { NodeNum { axis "x" } } {

	switch $axis {

		"x" {
			return [ReturnNodeXCoordinate $NodeNum]
		}

		"y" {
			return [ReturnNodeYCoordinate $NodeNum]
		}

		"z" {
			return [ReturnNodeZCoordinate $NodeNum]
		}

	}

	WarnWinText "Invalid axis was given for returning the coordinate of $NodeNum"
	return -1

}

proc ReturnNodeXCoordinate { NodeNum } {

	return [format "%1.3f" [lindex [GiD_Mesh get node $NodeNum] 1]]

}

proc ReturnNodeYCoordinate { NodeNum } {

	return [format "%1.3f" [lindex [GiD_Mesh get node $NodeNum] 2]]

}

proc ReturnNodeZCoordinate { NodeNum } {

	return [format "%1.3f" [lindex [GiD_Mesh get node $NodeNum] 3]]

}

proc ClearGroupNodes { } {

	global NodesList2DOF
	global NodesList3DOF
	global NodesList3PDOF
	global NodesList6DOF

	set NodesList2DOF " "
	set NodesList3DOF " "
	set NodesList3PDOF " "
	set NodesList6DOF " "

	return 0
}

# sort Group node lists by the coordinates

proc SortGroupNodesListsByCoordsSetup { DOF } {

	global NodesList2DOF
	global NodesList3DOF
	global NodesList3PDOF
	global NodesList6DOF

	global NodesList2DOF_Coords
	global NodesList3DOF_Coords
	global NodesList3PDOF_Coords
	global NodesList6DOF_Coords

	global NodesList2DOF_isSorted
	global NodesList3DOF_isSorted
	global NodesList6DOF_isSorted
	global NodesList3PDOF_isSorted

	if {$DOF == 2 && $NodesList2DOF_isSorted == 0} {

		SortGroupNodesListsByCoords NodesList2DOF NodesList2DOF_Coords
		set NodesList2DOF_isSorted 1

	} elseif {$DOF == 3 && $NodesList3DOF_isSorted == 0} {

		SortGroupNodesListsByCoords NodesList3DOF NodesList3DOF_Coords
		set NodesList3DOF_isSorted 1

	} elseif {$DOF == 6 && $NodesList6DOF_isSorted == 0} {

		SortGroupNodesListsByCoords NodesList6DOF NodesList6DOF_Coords
		set NodesList6DOF_isSorted 1

	} elseif {$DOF == 30 && $NodesList3PDOF_isSorted == 0} {

		SortGroupNodesListsByCoords NodesList3PDOF NodesList3PDOF_Coords
		set NodesList3PDOF_isSorted 1

	}

	return 0
}

proc SortGroupNodesListsByCoords { list1 list2 } {

	#	list1 : list of nodes with same dof
	#	list2 : list containing the coordinates of the nodes of mylist

	#	sort by x-coordinate, if x the same, sort by y-coordinate, if y the same, sort by z-coordinate

	global NodesList2DOF
	global NodesList3DOF
	global NodesList3PDOF
	global NodesList6DOF

	global NodesList2DOF_Coords
	global NodesList3DOF_Coords
	global NodesList3PDOF_Coords
	global NodesList6DOF_Coords

	upvar #0 $list1 mylist
	upvar #0 $list2 mylistcoords

	set n [llength $mylist]

	if { $n < 2 } return;

	# i starts from the second node of the list
	set i 1

	while {$i < $n} {

		set j [expr $i-1]; # for each i, set j the previous one; starts from the first node of the list

		set x [lindex $mylist $i]
		set xcoords [lindex $mylistcoords $i]

		set val [lindex [lindex $mylistcoords $i] 0]
		set comp [lindex [lindex $mylistcoords $j] 0]

		while {$j >= 0 && $comp >= $val } {

			if { $comp > $val } {

				set temp [lindex $mylist $j]
				set mylist [lreplace $mylist [expr $j+1] [expr $j+1] $temp]
				set temp [lindex $mylistcoords $j]
				set mylistcoords [lreplace $mylistcoords [expr $j+1] [expr $j+1] $temp]

				set j [expr $j -1]
				set comp [lindex [lindex $mylistcoords $j] 0]
				continue;

			} else {
				# sort by y-coordinate
				set val [lindex [lindex $mylistcoords $i] 1]; # y-coordinate
				set comp [lindex [lindex $mylistcoords $j] 1]; # y-coordinate

				if { $comp > $val } {

					set val [lindex [lindex $mylistcoords $i] 0]

					set temp [lindex $mylist $j]
					set mylist [lreplace $mylist [expr $j+1] [expr $j+1] $temp]
					set temp [lindex $mylistcoords $j]
					set mylistcoords [lreplace $mylistcoords [expr $j+1] [expr $j+1] $temp]

					set j [expr $j -1]
					set comp [lindex [lindex $mylistcoords $j] 0]
					continue;

				} elseif { $comp == $val } {
					# sort by z-coordinate
					set val [lindex [lindex $mylistcoords $i] 2]; # z-coordinate
					set comp [lindex [lindex $mylistcoords $j] 2]

					if { $comp > $val } {

						set val [lindex [lindex $mylistcoords $i] 0]

						set temp [lindex $mylist $j]
						set mylist [lreplace $mylist [expr $j+1] [expr $j+1] $temp]
						set temp [lindex $mylistcoords $j]
						set mylistcoords [lreplace $mylistcoords [expr $j+1] [expr $j+1] $temp]

						set j [expr $j -1]
						set comp [lindex [lindex $mylistcoords $j] 0]
						continue;

					} else {
						break;
					}

				} else {
					break;
				}

			}
			break;
		}

		set mylist [lreplace $mylist [expr $j+1] [expr $j+1] $x]
		set mylistcoords [lreplace $mylistcoords [expr $j+1] [expr $j+1] $xcoords]

		set i [expr $i+1]
	}
}

proc AssignToGroupNodeList { NodeNum DOF } {

	global NodesList2DOF
	global NodesList3DOF
	global NodesList6DOF
	global NodesList3PDOF

	switch $DOF {

		"2" {
			lappend NodesList2DOF $NodeNum
		}
		"3" {
			lappend NodesList3DOF $NodeNum
		}
		"6" {
			lappend NodesList6DOF $NodeNum
		}
		"30" {
			lappend NodesList3PDOF $NodeNum
		}
	}
	return 0
}

proc ReturnGroupNodes { DOF } {

	global NodesList2DOF
	global NodesList3DOF
	global NodesList3PDOF
	global NodesList6DOF

	switch $DOF {

		"2" {
			return [llength $NodesList2DOF]
		}
		"3" {
			return [llength $NodesList3DOF]
		}
		"6" {
			return [llength $NodesList6DOF]
		}
		"30" {
			return [llength $NodesList3PDOF]
		}
	}
	return 0
}

# return the Node ID of the index $index-1 of the $DOF group node list

proc ReturnGroupNodeTag { DOF index } {

	global NodesList2DOF
	global NodesList3DOF
	global NodesList3PDOF
	global NodesList6DOF

	switch $DOF {

		"2" {
			return [lindex $NodesList2DOF [expr $index-1]]
		}
		"3" {
			return [lindex $NodesList3DOF [expr $index-1]]
		}
		"6" {
			return [lindex $NodesList6DOF [expr $index-1]]
		}
		"30" {
			return [lindex $NodesList3PDOF [expr $index-1]]
		}
	}
	return 0

}

proc AddToQuadMasterNodeList { NodeNum } {

	global equalDOF_QuadMasterNodeList

	lappend equalDOF_QuadMasterNodeList $NodeNum

	return 0
}

proc ExistsToQuadMasterNodeList { NodeNum } {

	global equalDOF_QuadMasterNodeList

	set pos [lsearch $equalDOF_QuadMasterNodeList $NodeNum]

	return $pos
}

proc ClearQuadMasterNodeList { } {

	global equalDOF_QuadMasterNodeList

	set equalDOF_QuadMasterNodeList [list]

	return 0
}

proc AddToQuadUPMasterNodeList { NodeNum } {

	global equalDOF_QuadUPMasterNodeList

	lappend equalDOF_QuadUPMasterNodeList $NodeNum

	return 0
}

proc ExistsToQuadUPMasterNodeList { NodeNum } {

	global equalDOF_QuadUPMasterNodeList

	set pos [lsearch $equalDOF_QuadUPMasterNodeList $NodeNum]

	return $pos
}

proc ClearQuadUPMasterNodeList { } {

	global equalDOF_QuadUPMasterNodeList

	set equalDOF_QuadUPMasterNodeList [list]

	return 0
}