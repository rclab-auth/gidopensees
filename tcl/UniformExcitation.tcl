proc AddGMFileID { IDnum } {

	global GMFileIDList

	lappend GMFileIDList $IDnum

	return 0
}

proc ReturnGMFileID { index } {

	global GMFileIDList

	set IDnum [lindex $GMFileIDList [expr $index-1]]

	return $IDnum
}

proc ClearGMFileIDs { } {

	global GMFileIDList

	set GMFileIDList " "

	return 0
}