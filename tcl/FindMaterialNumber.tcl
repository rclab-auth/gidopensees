proc FindMaterialNumber { matname } {
 set internalmatnum [expr [lsearch [GiD_Info materials] $matname]+1]
 if { $internalmatnum == 0 } {
  WarnWinText "Material $matname does not exist."
  set internalmatnum -1
 }

 return $internalmatnum
}
