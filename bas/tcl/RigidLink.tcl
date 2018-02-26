proc AddRigidLinkConstraintIDList { IDnum } {

	global RigidLinkConstraintIDList

	lappend RigidLinkConstraintIDList $IDnum

	return 0
}

proc HowmanyRLCID { } {

	global RigidLinkConstraintIDList

	set times [llength $RigidLinkConstraintIDList]

	return $times
}

# Assigns the RigidLinkConstraintIDList(i-1) to the IDnum

proc RLID { index } {

	global RigidLinkConstraintIDList

	set IDnum [lindex $RigidLinkConstraintIDList [expr $index-1]]

	return $IDnum
}

proc CheckIDRigidLinkConstraintList { IDnum } {

	global RigidLinkConstraintIDList

	set pos [lsearch $RigidLinkConstraintIDList $IDnum]
	return $pos
}

proc IsThisRLID { id index } {

global RigidLinkConstraintIDList

	if {$id == [lindex $RigidLinkConstraintIDList [expr $index-1] ] } {

		return 1
	}
return 0

}

proc rigidLinkClear { } {

	global RigidLinkConstraintIDList
	global RigidLinkConstraintSlaveNodesList

	set RigidLinkConstraintSlaveNodesList " "
	set RigidLinkConstraintIDList " "

	return 0
}

proc AddRLCSlaveNode { NodeNum } {

	global RigidLinkConstraintSlaveNodesList

	lappend RigidLinkConstraintSlaveNodesList $NodeNum
	return 0
}

proc RestartRLCSlaveNodes { } {

	global RigidLinkConstraintSlaveNodesList

	set RigidLinkConstraintSlaveNodesList " "

	return 0
}

proc CheckRLCslaveNode { NodeNum } {

	global RigidLinkConstraintSlaveNodesList

	set pos [lsearch $RigidLinkConstraintSlaveNodesList $NodeNum]
	return $pos
}
