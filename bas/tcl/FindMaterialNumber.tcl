proc FindMaterialNumber { matname {DomainNum 0} } {

	if {$DomainNum!=0} {

		set MatTag $DomainNum
	}

	set internalmatnum [expr [lsearch [GiD_Info materials] $matname]+1]

	append MatTag $internalmatnum

	if { $internalmatnum == 0 } {
		WarnWinText "Material $matname does not exist."
		set MatTag -1
	}

	return $MatTag
}
