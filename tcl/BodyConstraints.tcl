proc AddbodyconstraintIDList { IDnum } {

	global BodyConstraintIDList

	lappend BodyConstraintIDList $IDnum

	return 0
}

proc HowmanyBCID { } {

	global BodyConstraintIDList

	set times [llength $BodyConstraintIDList]

	return $times
}

# Assigns the BodyConstraintIDList(i-1) to the IDnum

proc BCIDnumber { index } {

	global BodyConstraintIDList

	set IDnum [lindex $BodyConstraintIDList [expr $index-1]]

	return $IDnum
}

proc exportBCConditions { Tx Ty Tz Rx Ry Rz } {
	global BodyConstraintConditions

	set mylist [list $Tx $Ty $Tz $Rx $Ry $Rz]

	foreach myvalue $mylist {

		if {$myvalue!=0} {
			lappend BodyConstraintConditions $myvalue
		}
	}

	return 0
}

proc importBCConditions { } {

	global BodyConstraintConditions

	return $BodyConstraintConditions
}

proc RestartBCconditions { } {

	global BodyConstraintConditions

	set BodyConstraintConditions " "

	return 0
}

proc CheckIDbodyconstraintList { IDnum } {

	global BodyConstraintIDList

	set pos [lsearch $BodyConstraintIDList $IDnum]
	return $pos
}

proc equalDOFClear { } {

	global BodyConstraintConditions
	global BodyConstraintIDList
	global BodyConstraintSlaveNodesList

	set BodyConstraintSlaveNodesList " "
	set BodyConstraintConditions " "
	set BodyConstraintIDList " "

	return 0
}

proc AddBCSlaveNode { NodeNum } {

	global BodyConstraintSlaveNodesList

	lappend BodyConstraintSlaveNodesList $NodeNum
	return 0
}

proc RestartBCSlaveNodes { } {

	global BodyConstraintSlaveNodesList

	set BodyConstraintConditions " "

	return 0
}

proc CheckSlaveNode { NodeNum } {

	global BodyConstraintSlaveNodesList

	set pos [lsearch $BodyConstraintSlaveNodesList $NodeNum]
	return $pos
}