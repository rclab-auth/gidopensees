namespace eval OS_Geom {
}

#calculates the center of gravity, returns a list with coordinates
proc OS_Geom::GetCOG { entID { type "line" } { mode "GEOMETRYUSE" } } {

	set cog_coords [list ]

		switch $type {

			"line" {

				if { $mode == "GEOMETRYUSE" } {
					set coordsData [OS_Geom::GetPointCoords $entID "line"]
				} elseif { $mode == "MESHUSE" } {
					set coordsData [OS_Geom::GetNodeCoords $entID "line"]
				}
				set start_x [lindex $coordsData 0]
				set start_y [lindex $coordsData 1]
				set start_z [lindex $coordsData 2]

				set end_x [lindex $coordsData 3]
				set end_y [lindex $coordsData 4]
				set end_z [lindex $coordsData 5]

				lappend cog_coords [expr ($start_x+$end_x)/2.0] [expr ($start_y+$end_y)/2.0] [expr ($start_z+$end_z)/2.0]
			}
			"surface" {

			}

		}
	return $cog_coords
}

# returns a list containing the end coordinates / vertices coordinates
proc OS_Geom::GetPointCoords { entID {type "line"} } {

	set res [list ]

	switch $type {

		"line" {

			set data [GiD_Geometry get line $entID]

			set start [lindex $data 2]
			set end [lindex $data 3]

			set startdata [GiD_Geometry get point $start]
			set enddata [GiD_Geometry get point $end]
			# layer , x, y, z
			lappend res [lindex $startdata 1] [lindex $startdata 2] [lindex $startdata 3]
			lappend res [lindex $enddata 1] [lindex $enddata 2] [lindex $enddata 3]

		}
		"surface" {

			set data [GiD_Geometry get surface $entID]
			set lines [lindex $data 3]
			foreach line $lines {

				lappend res [OS_Geom::GetPointCoords $line "line"]

			}
		}
		"volume" {

			set data [GiD_Geometry get volume $entID]
			set surfaces [lindex $data 2]
			foreach surface $surfaces {

				lappend res [OS_Geom::GetPointCoords $surface "surface"]

			}
		}
	}
	return $res
}

proc OS_Geom::GetNodeCoords { entID {type "line"} } {

	set res [list ]

	switch $type {

		"line" {

			set data [GiD_Mesh get element $entID]

			set start [lindex $data 3]
			set end [lindex $data 4]

			set startdata [GiD_Mesh get node $start]
			set enddata [GiD_Mesh get node $end]
			# layer , x, y, z
			lappend res [lindex $startdata 1] [lindex $startdata 2] [lindex $startdata 3]
			lappend res [lindex $enddata 1] [lindex $enddata 2] [lindex $enddata 3]

		}
		"surface" {

			set data [GiD_Mesh get element $entID]
			set lines [lindex $data 3]
			foreach line $lines {

				lappend res [OS_Geom::GetNodeCoords $line "line"]

			}
		}
		"volume" {

			set data [GiD_Mesh get element $entID]
			set surfaces [lindex $data 2]
			foreach surface $surfaces {

				lappend res [OS_Geom::GetNodeCoords $surface "surface"]

			}
		}
	}
	return $res

}

# returns the number of lines that the surface consists of
proc OS_Geom::GetNumLinesForSurface { surfID } {

	set data [GiD_Geometry get surface $surfID]
	set lines [lindex $data 3]

	return [llength $lines]

}

# returns the number of surfaces that the volume consists of
proc OS_Geom::GetNumSurfacesForVolume { volID } {

	set data [GiD_Geometry get volume $entID]
	set surfaces [lindex $data 2]

	return [llength $surfaces]

}