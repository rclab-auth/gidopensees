# Clear the ZeroLengthIDList List , in case user makes multiple calculations

proc ClearZeroLengthLists { } {

	global ZeroLengthIDList
	set ZeroLengthIDList " "

	return 0
}

# Check if ID of the ZeroLength is already assigned to the ZeroLengthIDList List

proc CheckZeroLengthID { IDnum } {

	global ZeroLengthIDList
	set pos [lsearch $ZeroLengthIDList $IDnum]

	return $pos
}

# Add Id number in the corresponding list in case it has not already be done

proc AddZeroLengthID { IDnum } {

	global ZeroLengthIDList
	lappend ZeroLengthIDList $IDnum

	return 0
}

# Procedure that return the number of unique zeroLength ID numbers, to use it in FOR-Loop Statement

proc HowManyZeroLengthID { } {

	global ZeroLengthIDList
	set times [llength $ZeroLengthIDList]

	return $times
}

# This Procedure returns the zeroLength ID number of a specific List index from the ZeroLengthIDList list

proc ZeroLengthIDnumber { index } {

	global ZeroLengthIDList
	set IDnum [lindex $ZeroLengthIDList [expr $index-1]]

	return $IDnum
}



