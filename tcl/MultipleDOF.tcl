proc CreateDOFGroups { DOF2exists DOF3exists DOF6exists } {
	global DOF2Elems
	global DOF3Elems
	global DOF6Elems

	set DOF2Elems [list]
	set DOF3Elems [list]
	set DOF6Elems [list]

	if {[GiD_Groups exists 2DOF]==0 && $DOF2exists==1} {
		GiD_Groups create 2DOF
	} elseif { [GiD_Groups exists 2DOF]==1 && $DOF2exists==0 } {
		GiD_Groups delete 2DOF
	}
	if {[GiD_Groups exists 3DOF]==0 && $DOF3exists==1} {
		GiD_Groups create 3DOF
	} elseif { [GiD_Groups exists 3DOF]==1 && $DOF3exists==0 } {
		GiD_Groups delete 3DOF
	}
	if {[GiD_Groups exists 6DOF]==0 && $DOF6exists==1} {
		GiD_Groups create 6DOF
	} elseif { [GiD_Groups exists 6DOF]==1 && $DOF6exists==0 } {
		GiD_Groups delete 6DOF
	}
	return 0
}

proc AssignElemsToDOFGroups { DOF2exists DOF3exists DOF6exists } {
	global DOF2Elems
	global DOF3Elems
	global DOF6Elems

	if {$DOF2exists==1} {
		set ok [GiD_EntitiesGroups assign 2DOF -also_lower_entities elements $DOF2Elems]
	}
	if {$DOF3exists==1} {
		set ok [GiD_EntitiesGroups assign 3DOF -also_lower_entities elements $DOF3Elems]
	}
	if {$DOF6exists==1} {
		set ok [GiD_EntitiesGroups assign 6DOF -also_lower_entities elements $DOF6Elems]
	}
	return 0
}

proc AssignOrphanNodesToDOFGroups { dim } {
	global FreeNodes
	if {[llength $FreeNodes] > 0} {
	if {$dim==3} {
		if {[GiD_Groups exists 6DOF]==0} {

		GiD_Groups create 6DOF
		set ok [GiD_EntitiesGroups assign 6DOF nodes $FreeNodes]

		} else {
		set ok [GiD_EntitiesGroups assign 6DOF nodes $FreeNodes]
		}

	} else {
		if {[GiD_Groups exists 3DOF]==0} {

		GiD_Groups create 3DOF
		set ok [GiD_EntitiesGroups assign 3DOF nodes $FreeNodes]

		} else {
		set ok [GiD_EntitiesGroups assign 3DOF nodes $FreeNodes]
		}

	}
	} else {
		return 0
	}
	return 0
}

proc AssignElemNumToDOFlist { num ndf } {
	global DOF2Elems
	global DOF3Elems
	global DOF6Elems

	if {$ndf==2} {
		lappend DOF2Elems $num
	} elseif {$ndf==3} {
		lappend DOF3Elems $num
	} elseif {$ndf==6} {
		lappend DOF6Elems $num
	}
return 0
}

proc ReturnNodeGroupDOF { nodesnum } {

	if { [lsearch [GiD_EntitiesGroups entity_groups nodes $nodesnum] 2DOF] != -1 } {
		return 2
	}
	if { [lsearch [GiD_EntitiesGroups entity_groups nodes $nodesnum] 3DOF] !=-1 } {
		return 3
	}
	if { [lsearch [GiD_EntitiesGroups entity_groups nodes $nodesnum] 6DOF] !=-1 } {
		return 6
	}
	return 0
}

proc InitOrphanNodesList { } {
	global FreeNodes

	set FreeNodes [list]

	return 0
}

proc AppendOrphanNodeList { nodesnum } {
	global FreeNodes

	lappend FreeNodes $nodesnum

	return 0
}

proc RemoveFromOrphanNodesList { nodesnum } {
	global FreeNodes

	set index [lsearch $FreeNodes $nodesnum]
	set FreeNodes [lreplace $FreeNodes $index $index]

	return 0

}

proc ReturnElemDOF { elemtype ndm } {

	switch $elemtype {

		ElasticBeamColumn {
			if {$ndm==2} {
				return 3
			} elseif {$ndm==3} {
				return 6
			}
		}
		ElasticTimoshenkoBeamColumn {
			if {$ndm==2} {
				return 3
			} elseif {$ndm==3} {
				return 6
			}
		}
		forceBeamColumn {
			if {$ndm==2} {
				return 3
			} elseif {$ndm==3} {
				return 6
			}
		}
		dispBeamColumn {
			if {$ndm==2} {
				return 3
			} elseif {$ndm==3} {
				return 6
			}
		}
		Quad {
			if {$ndm==2} {
				return 2
			} elseif {$ndm==3} {
				WarnWinText "ERROR: Quad Elements require 2D model"
			}
		}
		Shell {
			if {$ndm==2} {
				WarnWinText "ERROR: Shell Elements require 3D model"
			} elseif {$ndm==3} {
				return 6
			}
		}
		Tri31 {
			if {$ndm==2} {
				return 2
			} elseif {$ndm==3} {
				WarnWinText "ERROR: Tri31 Elements require 2D model"
			}
		}
		QuadUP {
			if {$ndm==2} {
				return 3
			} elseif {$ndm==3} {
				WarnWinText "ERROR: QuadUP Elements require 2D model"
			}
		}
		stdBrick {
			if {$ndm==2} {
				WarnWinText "ERROR: Standard Brick Elements require 3D model "
			} elseif {$ndm==3} {
				return 3
			}
		}
		Truss {
			if {$ndm==2} {
				return 2
			} elseif {$ndm==3} {
				return 3
			}
		}
		CorotationalTruss {
			if {$ndm==2} {
				return 2
			} elseif {$ndm==3} {
				return 3
			}
		}
	}
}