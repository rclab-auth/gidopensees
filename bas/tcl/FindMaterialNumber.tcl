proc FindMaterialNumber { matname DomainNum } {

	set MatTag $DomainNum

	set internalmatnum [expr [lsearch [GiD_Info materials] $matname]+1]

	append MatTag $internalmatnum

	if { $internalmatnum == 0 } {
		WarnWinText "Material $matname does not exist."
		set MatTag -1
	}

	return $MatTag
}

#convert id to Domain ID
proc getDomainMatID { matID DomainNum } {

	set ret_val $DomainNum
	append ret_val $matID

	return $ret_val
}