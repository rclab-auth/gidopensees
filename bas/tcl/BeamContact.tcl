namespace eval BeamContact {
	variable p_lagrange; # $p_lagrange(slavePoint) -> lagrange point ID connected to $slavePoint
	variable p_slave
	variable p_master
	variable created; # created
}

proc ClearBeamContactLists { } {

	global BeamContactIDList
	global LagrangeNodeList
	global BeamContactOpenSeesTagList
	set BeamContactIDList [list ]
	set LagrangeNodeList [list ]
	set BeamContactOpenSeesTagList [list ]
	return 1
}

proc CheckIDInBeamContactList { IDnum } {

	global BeamContactIDList
	set pos [lsearch $BeamContactIDList $IDnum]

	return $pos; # -1 if not found, otherwise the index
}

proc AddToBeamContactIDList { IDnum } {

	global BeamContactIDList
	lappend BeamContactIDList $IDnum

	return 1
}

proc AddToBeamContactOpenSeesTagList { Tag } {

	global BeamContactOpenSeesTagList
	lappend BeamContactOpenSeesTagList $Tag

	return 0
}

proc getBeamContactTag { index } {

	global BeamContactOpenSeesTagList
	return [lindex $BeamContactOpenSeesTagList $index]

}

proc CompareBeamContactIDs { id index } {

	global BeamContactIDList
	set runID [lindex $BeamContactIDList $index]
	if { $runID == $id } {

		return 1

	}

	return 0
}

proc GetNumberOfBeamContacts { } {

	global BeamContactIDList
	set num_ids [llength $BeamContactIDList]

	return $num_ids
}

proc GetNumberOfBeamContactTags { } {
	global BeamContactOpenSeesTagList
	set num_tags [llength $BeamContactOpenSeesTagList]

	return $num_tags
}

proc getBeamContactID { index } {
	global BeamContactIDList
	return [lindex $BeamContactIDList $index]
}

proc RestartBeamContactSlaveNodes { } {

	global BeamContactSlaveNodes
	set BeamContactSlaveNodes [list ]

	return 1
}

proc IsThisBeamContactID { id index } {

	global BeamContactIDList

	if { $id == [lindex $BeamContactIDList [expr $index-1] ] } {

		return 1

	}
	return 0
}

proc CheckBeamContactSlaveNodes { NodeNum } {

	global BeamContactSlaveNodes

	set pos [lsearch $BeamContactSlaveNodes $NodeNum]
	return $pos

}

proc AddToBeamContactSlaveNodeList { NodeNum } {

	global BeamContactSlaveNodes

	lappend BeamContactSlaveNodes $NodeNum
	return 1

}

proc CreateLagrangeNode { masterLine slavePoint } {

	global LagrangeNodeList
	set maxPointNum [GiD_Info Geometry MaxNumPoints]
	set lexists [GiD_Layers exists "Lagrange"]

	if { !$lexists } {

		GiD_Layers create "Lagrange"

	}
	set exists [info exists BeamContact::created($slavePoint)]
	if { $exists } {

		if { !$BeamContact::created($slavePoint) } {
			set coords [OS_Geom::GetCOG $masterLine "line"]
			GiD_Geometry create point [expr $maxPointNum+1] "Lagrange" $coords
			set BeamContact::created($slavePoint) 1
			set BeamContact::p_lagrange($slavePoint,slave)
			set BeamContact::p_lagrange($masterLine,master)
		}

	} else {
		set coords [OS_Geom::GetCOG $masterLine "line"]
		GiD_Geometry create point [expr $maxPointNum+1] "Lagrange" $coords
		set BeamContact::created($slavePoint) 1
		set BeamContact::p_lagrange($slavePoint,slave)
		set BeamContact::p_lagrange($masterLine,master)
	}
}

proc GetLagrangeNodeTag { masterNode slaveNode } {

	global LagrangeNodeList
	set maxNodeNum [GiD_Info Mesh MaxNumNodes]
	set tag [expr $maxNodeNum + 1 + [llength $LagrangeNodeList]]
	lappend LagrangeNodeList $tag
	return $tag

}

proc GetLagrangeNodeXCoord { masterLine } {

	set coords [OS_Geom::GetCOG $masterLine "line" "MESHUSE"]
	return [lindex $coords 0]

}

proc GetLagrangeNodeYCoord { masterLine } {

	set coords [OS_Geom::GetCOG $masterLine "line" "MESHUSE"]
	return [lindex $coords 1]

}

proc GetLagrangeNodeZCoord { masterLine } {

	set coords [OS_Geom::GetCOG $masterLine "line" "MESHUSE"]
	return [lindex $coords 2]

}

