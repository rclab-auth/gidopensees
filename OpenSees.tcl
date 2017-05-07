# GiD + OpenSees Interface - An Integrated FEA Platform
# Copyright (C) 2016-2017
#
# Lab of R/C and Masonry Structures
# School of Civil Engineering, AUTh
#
# Development team
# T. Kartalis-Kaounis, Civil Engineer AUTh
# V. Protopapadakis, Civil Engineer AUTh
# T. Papadopoulos, Civil Engineer AUTh
#
# Project coordinator
# V.K. Papanikolaou, Assistant Professor AUTh
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

#
# TCL macros
#

set VersionNumber "v2.0.0"

set InfoWin .gid.win_example

#
# Theme settings
#

set ibarBackgroundColor "#F0F0F0"
set ibarTextColor "black"
set ibarLineColor "#CFC5C3"
set GiDtheme "Classic"

proc GetAppDataDir { } {

	global env

	if { [expr [string compare "$::tcl_platform(platform)" "windows" ] == 0] } {

		package require registry 1.0

		set env_home [registry get {HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders} {AppData}]

	} else {

		set env_home $env(HOME)
	}

	return $env_home
}

proc SetImagesAndColors {} {

	global ibarBackgroundColor ibarTextColor ibarLineColor GiDtheme

	set INI [file join [GetAppDataDir] "GiD" "gid.ini"]

	set f [open $INI r]
	set data [read $f]
	close $f

	set lines [split $data "\n"]

	foreach line $lines {
		if { $line == "Theme(Current) GiD_black" } {

			set ibarBackgroundColor "#292929"
			set ibarTextColor "white"
			set ibarLineColor "#1A5B6B"

			set GiDtheme "Black"

			break
		}
	}
}

#
# Toolbar 1 commands
#

proc Opt1_1 { } {

	GidOpenMaterials Standard_Uniaxial_Materials
	HideInfoBar
}

proc Opt1_2 { } {

	GidOpenMaterials Uniaxial_Concrete_Materials
	HideInfoBar
}

proc Opt1_3 { } {

	GidOpenMaterials Uniaxial_Steel_Materials
	HideInfoBar
}

proc Opt1_4 {} {

	GidOpenMaterials "Multidimensional_(nD)_Materials"
	HideInfoBar
}

proc Opt1_5 { } {

	GidOpenMaterials "Section_Force-Deformation"
	HideInfoBar
}

proc Opt1_6 { } {

	GidOpenMaterials "Series/Parallel_Uniaxial_Materials"
	HideInfoBar
}

proc Opt1_7 { } {

	GidOpenMaterials "Records"
	HideInfoBar

}
proc Opt1_8 { } {

	GidOpenConditions Restraints
	HideInfoBar
}

proc Opt1_9 { } {

	GidOpenConditions Constraints
	HideInfoBar
}

proc Opt1_10 { } {

	GidOpenConditions Mass/Damping
	HideInfoBar
}

proc Opt1_11 { } {

	GidOpenConditions Loads
	HideInfoBar
}

proc Toolbar1 {{type "DEFAULT INSIDELEFT"}} {

	global ToolbarNames1 ToolbarCommands1 ToolbarHelp1 OpenSees1 OpenSeesProblemDir GiDtheme

	set ToolbarNames1(0) " \
		img/Toolbar/$GiDtheme/btn_Mat_Uni.png \
		img/Toolbar/$GiDtheme/btn_Mat_UniC.png \
		img/Toolbar/$GiDtheme/btn_Mat_UniS.png \
		img/Toolbar/$GiDtheme/btn_Mat_ND.png \
		img/Toolbar/$GiDtheme/btn_Mat_Section.png \
		img/Toolbar/$GiDtheme/btn_Mat_SeriesParallel.png \
		img/Toolbar/$GiDtheme/btn_Separator.png \
		img/Toolbar/$GiDtheme/btn_Records.png \
		img/Toolbar/$GiDtheme/btn_Restraints.png \
		img/Toolbar/$GiDtheme/btn_Constraints.png \
		img/Toolbar/$GiDtheme/btn_Mass.png \
		img/Toolbar/$GiDtheme/btn_Loads.png \
		img/Toolbar/$GiDtheme/btn_Separator.png \
		img/Toolbar/$GiDtheme/btn_About.png \
		"
	set ToolbarCommands1(0) [list \
		[list -np- Opt1_1] \
		[list -np- Opt1_2] \
		[list -np- Opt1_3] \
		[list -np- Opt1_4] \
		[list -np- Opt1_5] \
		[list -np- Opt1_6] \
		"" \
		[list -np- Opt1_7] \
		[list -np- Opt1_8] \
		[list -np- Opt1_9] \
		[list -np- Opt1_10] \
		[list -np- Opt1_11] \
		"" \
		"-np- VisitWeb http://gidopensees.rclab.civil.auth.gr" \
	]

	set ToolbarHelp1(0) { \
		"Define Standard Unixaxial Materials" \
		"Define Concrete Uniaxial Materials" \
		"Define Steel Uniaxial Materials" \
		"Define Multidimensional Materials" \
		"Define Section Force-Deformation" \
		"Define Series/Parallel Uniaxial Materials" \
		"" \
		"Records" \
		"Assign Restraints" \
		"Assign Constraints" \
		"Assign Mass/Damping" \
		"Assign Loads" \
		"" \
		"GiD+OpenSees Website" \
		}

	set prefix Pre

	set OpenSees1(toolbarwin) \
		[CreateOtherBitmaps MyPreBar "OpenSees Pre-Processor Toolbar 1" \
		ToolbarNames1 \
		ToolbarCommands1 \
		ToolbarHelp1 \
		$OpenSeesProblemDir \
		Toolbar1 $type $prefix]
		AddNewToolbar "OpenSees 1 toolbar" ${prefix}MyBarWindowGeom Toolbar1
}

proc EndToolbar1 {} {
	global OpenSees1

	ReleaseToolbar "OpenSees 1 toolbar"
	rename Toolbar1 ""

	catch { destroy $OpenSees1(toolbarwin) }
}

#
# Toolbar 2 commands
#

proc Opt2_1 { } {

	GidOpenConditions ZeroLength_Elements
	HideInfoBar
}

proc Opt2_2 { } {

	GidOpenMaterials Truss_Elements
	HideInfoBar
}

proc Opt2_3 { } {

	GidOpenMaterials "Beam-Column_Elements"
	HideInfoBar
}

proc Opt2_4 { } {

	GidOpenMaterials Surface_Elements
	HideInfoBar
}

proc Opt2_5 { } {

	GidOpenMaterials Solid_Elements
	HideInfoBar
}

proc Opt2_6 { } {

	GidOpenProblemData
	HideInfoBar
}

proc Opt2_7 { } {

	GiD_Process Mescape Data IDataWindow
	HideInfoBar
}

proc Opt2_8 { } {

	GiD_Process Mescape Meshing generate
	HideInfoBar
}

proc Opt2_9 { } {

	Opt1_dialog
}

set NormalsDrawStatus 0

proc Opt2_10 { } {

	global NormalsDrawStatus

	switch $NormalsDrawStatus {

		0 {
			GiD_Process Mescape Utilities DrawNormals lines 1:100000
			set NormalsDrawStatus 1
		}

		1 {
			GiD_Process Mescape
			set NormalsDrawStatus 0
		}
	}
}

set ElemDrawStatus 0

proc Opt2_11 { } { # Switch draw elements

	global ElemDrawStatus

	switch $ElemDrawStatus {

		0 {
			GiD_Process Mescape Data Materials DrawMaterial -DrawAll-
			set ElemDrawStatus 1
		}

		1 {
			GiD_Process Mescape
			set ElemDrawStatus 0
		}
	}
}

set ConditionsDrawStatus 0

proc Opt2_12 { } { # Switch draw conditions

	global ConditionsDrawStatus

	switch $ConditionsDrawStatus {

		0 {
			GiD_Process Mescape Data Conditions DrawCond -DrawAll-
			set ConditionsDrawStatus 1
		}

		1 {
			GiD_Process Mescape
			set ConditionsDrawStatus 0
		}
	}
}

proc Opt2_13 { } {

	GiD_Process Mescape Data Intervals ChangeInterval
	UpdateInfoBar
}

proc Toolbar2 {{type "DEFAULT INSIDELEFT"}} {

	global ToolbarNames2 ToolbarCommands2 ToolbarHelp2 OpenSees2 OpenSeesProblemDir GiDtheme

	set ToolbarNames2(0) " \
		img/Toolbar/$GiDtheme/btn_Elem_ZeroLength.png \
		img/Toolbar/$GiDtheme/btn_Elem_Truss.png \
		img/Toolbar/$GiDtheme/btn_Elem_Beam.png \
		img/Toolbar/$GiDtheme/btn_Elem_Quad.png \
		img/Toolbar/$GiDtheme/btn_Elem_Brick.png \
		img/Toolbar/$GiDtheme/btn_Separator.png \
		img/Toolbar/$GiDtheme/btn_Data.png \
		img/Toolbar/$GiDtheme/btn_Interval.png \
		img/Toolbar/$GiDtheme/btn_Mesh.png \
		img/Toolbar/$GiDtheme/btn_Calc.png \
		img/Toolbar/$GiDtheme/btn_Separator.png \
		img/Toolbar/$GiDtheme/btn_LocalAxes.png \
		img/Toolbar/$GiDtheme/btn_ViewElem.png \
		img/Toolbar/$GiDtheme/btn_ViewCond.png \
		img/Toolbar/$GiDtheme/btn_ActiveInterval.png \
		"
	set ToolbarCommands2(0) [list \
		[list -np- Opt2_1] \
		[list -np- Opt2_2] \
		[list -np- Opt2_3] \
		[list -np- Opt2_4] \
		[list -np- Opt2_5] \
		"" \
		[list -np- Opt2_6] \
		[list -np- Opt2_7] \
		[list -np- Opt2_8] \
		[list -np- Opt2_9] \
		"" \
		[list -np- Opt2_10] \
		[list -np- Opt2_11] \
		[list -np- Opt2_12] \
		[list -np- Opt2_13] \
	]

	set ToolbarHelp2(0) { \
		"Define Zero Length Elements" \
		"Define Truss Elements" \
		"Define Beam-Column Elements" \
		"Define Surface Elements" \
		"Define Solid Elements" \
		"" \
		"Set Problem Data" \
		"Set Interval Data" \
		"Generate Mesh" \
		"Create .tcl, run analysis and postprocess" \
		"" \
		"Show/Hide Line Local Axes" \
		"Show/Hide Elements" \
		"Show/Hide All Conditions for Active Interval" \
		"Select Active Interval" \
		}

	set prefix Pre

	set OpenSees2(toolbarwin) \
		[CreateOtherBitmaps MyBar "OpenSees Pre-Processor Toolbar 2" \
		ToolbarNames2 \
		ToolbarCommands2 \
		ToolbarHelp2 \
		$OpenSeesProblemDir \
		Toolbar2 $type $prefix]
		AddNewToolbar "OpenSees 2 toolbar" ${prefix}MyBarWindowGeom Toolbar2
}

proc EndToolbar2 {} {
	global OpenSees2

	ReleaseToolbar "OpenSees 2 toolbar"
	rename Toolbar2 ""

	catch { destroy $OpenSees2(toolbarwin) }
}

proc InitGIDProject { dir } {

	global MenuNames MenuEntries MenuCommands MenuAcceler
	global MenuNamesP MenuEntriesP MenuCommandsP MenuAccelerP
	global InterfaceName
	global GidPriv
	global OpenSeesProblemDir OpenSeesPath

	set OpenSeesProblemDir $dir

	foreach filename {FindMaterialNumber.tcl ZeroLength.tcl UsedMaterials.tcl RigidDiaphragm.tcl BodyConstraints.tcl tkWidgets.tcl Utilities.tcl Fibers.tcl MultipleDOF.tcl Regions.tcl} {
		source [file join $dir tcl $filename]
	}

	set InterfaceName [_ "GiD+OpenSees Interface"]

	set num [lsearch $MenuNamesP [_ "View results"]]

	if { $num == -1 } {
		WarnWin "OpenSees is not compatible with this GiD version"
		return
	}

	LoadOpenSeesPath

	global splashdir
	set splashdir 0
	global keepsplash
	set keepsplash 0

	SetImagesAndColors

	Splash $dir
	set splashdir $dir

	OpenSees_Menu $dir

	set ipos [lsearch $MenuNames [_ "Help"]]

	if { $ipos != -1 } {
		set MenuEntries($ipos) [linsert $MenuEntries($ipos) 0 "Help on OpenSees"]
		set MenuCommands($ipos) [linsert $MenuCommands($ipos) 0 [list -np- HelpOnOpenSees $dir]]
		set MenuAcceler($ipos) [linsert $MenuAcceler($ipos) 0 ""]

		CreateTopMenus
	}

	set ipos [lsearch $MenuNamesP Help]

	if { $ipos != -1 } {
		set MenuEntriesP($ipos) [linsert $MenuEntriesP($ipos) 0 "Help on OpenSees"]
		set MenuCommandsP($ipos) [linsert $MenuCommandsP($ipos) 0 [list -np- HelpOnOpenSees $dir]]
		set MenuAccelerP($ipos) [linsert $MenuAccelerP($ipos) 0 ""]
	}

	Toolbar1
	Toolbar2

	set GidPriv(ProgName) $InterfaceName

	GidChangeDataLabel "Conditions" ""
	GidChangeDataLabel "Local Axes" ""
	GidChangeDataLabel "Materials" "Materials/Elements Definition"

	GidAddUserDataOptions "Loads" "GidOpenConditions Loads" 2
	GidAddUserDataOptions "Restraints" "GidOpenConditions Restraints" 3
	GidAddUserDataOptions "Constraints" "GidOpenConditions Constraints" 4
	GidAddUserDataOptions "Mass/Damping" "GidOpenConditions Mass/Damping" 5
	GidAddUserDataOptions "ZeroLength Elements" "GidOpenConditions ZeroLength_Elements" 6
	GidAddUserDataOptions "---" "" 8

	GiD_DataBehaviour materials Standard_Uniaxial_Materials hide {assign draw unassign impexp}
	GiD_DataBehaviour materials Uniaxial_Steel_Materials hide {assign draw unassign impexp}
	GiD_DataBehaviour materials Uniaxial_Concrete_Materials hide {assign draw unassign impexp}
	GiD_DataBehaviour materials Other_Uniaxial_Materials hide {assign draw unassign impexp}
	GiD_DataBehaviour materials Multidimensional_(nD)_Materials hide {assign draw unassign impexp}
	GiD_DataBehaviour materials "Section_Force-Deformation" hide {assign draw unassign impexp}
	GiD_DataBehaviour materials "Series/Parallel_Uniaxial_Materials" hide {assign draw unassign impexp}
	GiD_DataBehaviour materials "Records" hide {assign draw unassign impexp}
	GiD_DataBehaviour materials "Beam-Column_Elements" geomlist {lines}
	GiD_DataBehaviour materials "Truss_Elements" geomlist {lines}
	GiD_DataBehaviour materials Surface_Elements geomlist {surfaces}
	GiD_DataBehaviour materials Solid_Elements geomlist {volumes}

	GiDMenu::UpdateMenus

	after 1000 "{UpdateInfoBar}"
}

proc EndGIDProject {} {

	bind .gid <Configure>	{}
	bind .gid <Activate>	{}
	bind .gid <Deactivate>	{}
	bind .gid <Map>			{}

	if {[winfo exist .ibar]} {destroy .ibar}

	EndToolbar1
	EndToolbar2
}

proc HelpOnOpenSees { dir } {

	WarnWin [join [list "To get help for OpenSees, check the latest news in " \
						"http://opensees.berkeley.edu/wiki/index.php/Main_Page "]]
}

proc Splash { dir } {

	global VersionNumber ibarBackgroundColor ibarTextColor GiDtheme

	if { [.gid.central.s disable windows] } { return }

	if { [winfo exist .splash]} {
		destroy .splash
		update
	}

	toplevel .splash

	set im [image create photo -file [file join $dir img/Toolbar/$GiDtheme/Splash.png]]

	set x [expr [winfo rootx .gid.central.s] + [winfo width .gid.central.s] / 2 - [image width $im] / 2]
	set y [expr [winfo rooty .gid.central.s] + [winfo height .gid.central.s] / 2 - [image height $im] / 2 ]

	wm geom .splash +$x+$y

	wm transient .splash .gid.central.s

	wm overrideredirect .splash 1

	pack [label .splash.l -image $im -bd 0]

	label .splash.lv -text $VersionNumber -background $ibarBackgroundColor -foreground $ibarTextColor  -font "calibri 11"
	place .splash.lv -x 316 -y 72

	raise .splash
	focus .splash

	#bind .splash <ButtonRelease> "{raise .gid}"
	#bind .splash <ButtonRelease> "{focus .gid}"
	#bind .splash <ButtonRelease> "if {[winfo exist .splash]} {destroy .splash}"

	after 3000 "if {[winfo exist .splash]} {destroy .splash}"
	after 3000 "if {[winfo exist .splash]} {raise .gid}"
	after 3000 "if {[winfo exist .splash]} {focus .gid}"

	update
}

proc UpdateInfoBar { } {

	# remove bindings

	bind .gid <Configure>	{}
	bind .gid <Activate>	{}
	bind .gid <Deactivate>	{}
	bind .gid <Map>			{}

	global ibarBackgroundColor ibarTextColor ibarLineColor
	global OpenSeesProblemDir
	global VersionNumber

	if { [winfo exist .ibar] } {
		destroy .ibar
	}

	# create toplevel

	toplevel .ibar

	wm attributes .ibar -topmost 1
	wm overrideredirect .ibar 1

	wm transient .ibar .gid

	.ibar configure -background #292929
	.ibar configure -bd 0

	# set infobar geometry

	set x [winfo rootx .gid.central.s]
	set y [winfo rooty .gid.central.s]
	set w [winfo width .gid.central.s]

	set geom "[winfo width .gid.central.s]x25+$x+$y"

	wm geometry .ibar $geom

	# set infobar rext

	set dim "[ReturnProjectDimensions]D"

	set n [GiD_Info intvdata num]
	set act "Active Interval : [format "%2d" [lindex $n 0]]"

	# create infobar canvas

	canvas .ibar.c -width $w -height 25 -background $ibarBackgroundColor

	.ibar.c create line  0  24  $w 24 -fill $ibarLineColor
	.ibar.c create line  60  0  60 52 -fill $ibarLineColor
	.ibar.c create line 100  0 100 24 -fill $ibarLineColor
	.ibar.c create line 240  0 240 24 -fill $ibarLineColor

	.ibar.c create text  30 12 -text $VersionNumber	-font "calibri 12" -fill $ibarTextColor -anchor center
	.ibar.c create text  80 12 -text $dim			-font "calibri 12" -fill $ibarTextColor -anchor center
	.ibar.c create text 170 12 -text $act			-font "calibri 12" -fill $ibarTextColor -anchor center

	set off 10
	.ibar.c create text [expr $w-$off] 12 -text "Lab of R/C and Masonry Structures, AUTh" -font "calibri 10" -fill $ibarLineColor -anchor e

	pack .ibar.c
	raise .ibar .gid

	# add bindings

	bind .gid <Configure>	{RefreshInfoBar}
	bind .gid <Activate>	{RefreshInfoBar}
	bind .gid <Deactivate>	{HideInfoBar}
	bind .gid <Map>			{UpdateInfoBar}

	focus .gid.central.s
	update
}

proc RefreshInfoBar { } {

	if { [winfo exists .ibar] } {
		set x [winfo rootx .gid.central.s]
		set y [winfo rooty .gid.central.s]
		set w [winfo width .gid.central.s]

		set geom "[winfo width .gid.central.s]x25+$x+$y"

		wm geometry .ibar $geom

		raise .ibar
		update
	}
}

proc HideInfoBar { } {

	lower .ibar
	update
}

# check problemtype version mismatch

proc LoadGIDProject { filespd } {

	global VersionNumber
	global InfoWin

	if { [file join {*}[lrange [file split $filespd] end-1 end]] == "OpenSees.gid/OpenSees.spd" } {

	# loading the problemtype itself, not a model

	} else {

		set spd_exist [file exist $filespd]

		if {$spd_exist} {

			set spd [open $filespd r]

			set spd_data [read $spd]
			set spd_data [string trim $spd_data]

			close $spd

		} else {

			set spd_data "Unknown"
		}

		set cmp [string compare "$spd_data" "$VersionNumber"]

		if { $cmp != 0 } {

			InitWindow $InfoWin [= "Version mismatch"] ErrorInfo "" "" 1
			if { ![winfo exists $InfoWin] } return ;
			ttk::frame $InfoWin.top
			ttk::label $InfoWin.top.title_text -text [= ""]
			ttk::frame $InfoWin.information -relief raised
			ttk::label $InfoWin.information.errormessage -text [= "Current problemtype version ($VersionNumber) is newer than saved model version ($spd_data). Please transform your model first."]
			ttk::frame $InfoWin.bottom
			ttk::button $InfoWin.bottom.continue -text [= "Transform"] -command "TransformAndClose"
			ttk::button $InfoWin.bottom.readlog -text [= "Ignore"] -command "destroy $InfoWin"
			grid $InfoWin.top.title_text -sticky ew
			grid $InfoWin.top -sticky new
			grid $InfoWin.information.errormessage -sticky w -padx 10 -pady 10
			grid $InfoWin.information -sticky new
			grid $InfoWin.bottom.continue $InfoWin.bottom.readlog -padx 10
			grid $InfoWin.bottom -sticky sew -padx 10 -pady 10
			if { $::tcl_version >= 8.5 } { grid anchor $InfoWin.bottom center }
			grid rowconfigure $InfoWin 1 -weight 1
			grid columnconfigure $InfoWin 0 -weight 1
		}
	}
}

proc TransformAndClose { } {

	global InfoWin

	destroy $InfoWin

	GiD_Process Mescape data defaults TransfProblem OpenSees
}

proc SaveGIDProject { filespd } {

	global VersionNumber

	set spd [open $filespd w]
	puts $spd $VersionNumber
	close $spd
}

proc BeforeInitGIDPostProcess {} {

	# remove bindings

	bind .gid <Configure>	{}
	bind .gid <Activate>	{}
	bind .gid <Deactivate>	{}
	bind .gid <Map>			{}

	if { [winfo exist .ibar]} {
		destroy .ibar
	}
}

proc EndGIDPostProcess {} {

	after 2000 "{UpdateInfoBar}"
}