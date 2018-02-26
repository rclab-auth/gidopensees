proc AddEqualConstraintIDList { IDnum } {

	global EqualConstraintIDList

	lappend EqualConstraintIDList $IDnum

	return 0
}

proc HowmanyECID { } {

	global EqualConstraintIDList

	set times [llength $EqualConstraintIDList]

	return $times
}

# Assigns the EqualConstraintIDList(i-1) to the IDnum

proc ECID { index } {

	global EqualConstraintIDList

	set IDnum [lindex $EqualConstraintIDList [expr $index-1]]

	return $IDnum
}

proc IsThisECID { id index } {

global EqualConstraintIDList

	if {$id == [lindex $EqualConstraintIDList [expr $index-1] ] } {

		return 1
	}
	return 0
}

proc exportECConditions { Tx Ty Tz Rx Ry Rz } {
	global EqualConstraintConditions

	set mylist [list $Tx $Ty $Tz $Rx $Ry $Rz]

	foreach myvalue $mylist {

		if {$myvalue!=0} {
			lappend EqualConstraintConditions $myvalue
		} else {
			lappend EqualConstraintConditions " "
		}
	}

	return 0
}

proc importECConditions { } {

	global EqualConstraintConditions

	return $EqualConstraintConditions
}

proc RestartECconditions { } {

	global EqualConstraintConditions

	set EqualConstraintConditions " "

	return 0
}

proc CheckIDequalConstraintList { IDnum } {

	global EqualConstraintIDList

	set pos [lsearch $EqualConstraintIDList $IDnum]
	return $pos
}

proc equalDOFClear { } {

	global EqualConstraintConditions
	global EqualConstraintIDList
	global EqualConstraintSlaveNodesList

	set EqualConstraintSlaveNodesList " "
	set EqualConstraintConditions " "
	set EqualConstraintIDList " "

	return 0
}

proc AddECSlaveNode { NodeNum } {

	global EqualConstraintSlaveNodesList

	lappend EqualConstraintSlaveNodesList $NodeNum
	return 0
}

proc RestartECSlaveNodes { } {

	global EqualConstraintSlaveNodesList

	set EqualConstraintSlaveNodesList " "

	return 0
}

proc CheckECslaveNode { NodeNum } {

	global EqualConstraintSlaveNodesList

	set pos [lsearch $EqualConstraintSlaveNodesList $NodeNum]
	return $pos
}
