# The number of fibers assigned to the cover material should be proportional to the cover size

proc NumofCoverFibers { depth Totaldepth Fibers } {

	# depth : the cover depth
	# Totaldepth: The total cross section length parallel to cover depth
	# Fibers: The number of fibers along the cover depth direction

	set ratio [expr $depth/$Totaldepth]
	set coverFibers [roundUp [expr $ratio*$Fibers]]
	return $coverFibers
}