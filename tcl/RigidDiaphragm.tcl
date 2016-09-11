proc RigidDiaphragmClear { } {
global RDIDList

set RDIDList " "
return ""
}

proc CheckrigidDiaphragmID { IDnum } {
global RDIDList

set pos [lsearch $RDIDList $IDnum]
return $pos
}

proc AddRigidDiaphragmID { IDnum } {
global RDIDList

lappend RDIDList $IDnum
return ""
}

proc RDID { index } {
global RDIDList

set IDnum [lindex $RDIDList [expr $index-1]]
return $IDnum

}


proc HowmanyRD { } {
global RDIDList

set quantity [llength $RDIDList]

return $quantity
}

proc RDMasterNodeNumber { index } {
global RDIDList

set MNodeNumber [lindex $RDIDList [expr $index-1]]
return $MNodeNumber
}


