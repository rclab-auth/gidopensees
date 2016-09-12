# Clears the list, because in case of multiple calculations lists keep their elements
proc ClearUsedMaterials { } {
global UsedMaterialsList

set UsedMaterialsList " "

return ""
}

#Add to UsedMaterialsList list, so to know that is has been defined(printed)
proc AddUsedMaterials { MatID } {
global UsedMaterialsList

lappend UsedMaterialsList $MatID

return ""
}

# It returns -1 if the materials has been defined before.
proc CheckUsedMaterials { MatID } {
global UsedMaterialsList

set pos [lsearch $UsedMaterialsList $MatID]

return $pos
}

