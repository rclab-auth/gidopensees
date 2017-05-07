# Clear lists

proc ClearRegionsIDLists { } {
	global RegionElemIDList RegionNodeIDList

	set RegionElemIDList ""
	set RegionNodeIDList ""

	return 0
}

# procedurec to check the ID existance. If it does not exist, it is added to the corresponding list

proc CheckElemRegionID { IDnum } {
	global RegionElemIDList

	set pos [lsearch $RegionElemIDList $IDnum]

	return $pos
}

proc CheckNodeRegionID { IDnum } {
	global RegionNodeIDList

	set pos [lsearch $RegionNodeIDList $IDnum]

	return $pos
}
# Append Region ID number to lists
proc AddElemRegionID { IDnum } {
	global RegionElemIDList
	lappend RegionElemIDList $IDnum

	return 0
}

proc AddNodeRegionID { IDnum } {
	global RegionNodeIDList
	lappend RegionNodeIDList $IDnum

	return 0
}

proc NNodeRegions { } {
	global RegionNodeIDList
	set nregions [llength $RegionNodeIDList]

	return $nregions
}

proc NElemRegions { } {
	global RegionElemIDList
	set nregions [llength $RegionElemIDList]

	return $nregions
}

proc RegionNodeID { index } {
	global RegionNodeIDList
	set IDnum [lindex $RegionNodeIDList [expr $index-1]]

	return $IDnum
}

proc RegionElemID { index } {
	global RegionElemIDList
	set IDnum [lindex $RegionElemIDList [expr $index-1]]

	return $IDnum
}