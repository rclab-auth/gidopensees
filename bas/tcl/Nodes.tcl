proc CompareNodesCoordinates { NodeNum1 NodeNum2 {coordinates "all"} } {
	set xNodeCoord1 [format "%1.3f" [lindex [GiD_Mesh get node $NodeNum1] 1]]
	set yNodeCoord1 [format "%1.3f" [lindex [GiD_Mesh get node $NodeNum1] 2]]
	set zNodeCoord1 [format "%1.3f" [lindex [GiD_Mesh get node $NodeNum1] 3]]
	set xNodeCoord2 [format "%1.3f" [lindex [GiD_Mesh get node $NodeNum2] 1]]
	set yNodeCoord2 [format "%1.3f" [lindex [GiD_Mesh get node $NodeNum2] 2]]
	set zNodeCoord2 [format "%1.3f" [lindex [GiD_Mesh get node $NodeNum2] 3]]
	switch $coordinates {
	"all" {
		if {$xNodeCoord1==$xNodeCoord2 && $yNodeCoord1==$yNodeCoord2 && $zNodeCoord1==$zNodeCoord2} {
		#WarnWinText "$NodeNum1 : $xNodeCoord1 $yNodeCoord1 $zNodeCoord1\n$NodeNum2 : $xNodeCoord2 $yNodeCoord2 $zNodeCoord2\n"
		return 1
			} else {
		return 0
		}
	}
	"x" {
			if {$xNodeCoord1==$xNodeCoord2} {
			return 1
			} else {
		return 0
			}
	}
	"y" {
			if {$yNodeCoord1==$yNodeCoord2} {
			return 1
			} else {
		return 0
		}
	}
	"z" {
		if {$zNodeCoord1==$zNodeCoord2} {

		return 1
			} else {
		return 0
			}
	}
	}
	return 0
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