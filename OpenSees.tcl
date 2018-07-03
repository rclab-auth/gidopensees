# GiD + OpenSees Interface - An Integrated FEA Platform
# Copyright (C) 2016-2018
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
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

#
# TCL macros
#

namespace eval OpenSees {

	variable VersionNumber "v2.6.0"
	variable InterfaceName [_ "GiD+OpenSees Interface v2.6.0"]
	variable OpenSeesProblemTypePath
	variable OpenSeesPath
	variable GiDPath
	variable GiDProjectName
	variable GiDProjectDir
}

proc OpenSees::InitGIDProject { dir } {

	global MenuNames MenuEntries MenuCommands MenuAcceler
	global MenuNamesP MenuEntriesP MenuCommandsP MenuAccelerP
	variable OpenSeesProblemTypePath; # OpenSees problem type directory
	variable OpenSeesPath; # OpenSees.exe path

	set OpenSeesProblemTypePath $dir

	OpenSees::SetOpenSeesPath
	OpenSees::SetProjectNameAndPath

	SetImagesAndColors

	global splashdir
	set splashdir 0
	global keepsplash
	set keepsplash 0
	OpenSees::Splash $dir
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

	OpenSees::Toolbar1
	OpenSees::Toolbar2
	OpenSees::Toolbar3

	OpenSees::ChangeData

	after 1000 "{UpdateInfoBar}"

	cd "$OpenSeesProblemTypePath/exe"

	after 2000 exec {*}[auto_execok start] "CheckForUpdate.exe" "/q" &
}

proc OpenSees::ChangeData {} {

	global GidPriv
	variable InterfaceName
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
	GiD_DataBehaviour materials "Combined_Materials" hide {assign draw unassign impexp}
	GiD_DataBehaviour materials "Records" hide {assign draw unassign impexp}
	GiD_DataBehaviour materials "Beam-Column_Elements" geomlist {lines}
	GiD_DataBehaviour materials "Truss_Elements" geomlist {lines}
	GiD_DataBehaviour materials Surface_Elements geomlist {surfaces}
	GiD_DataBehaviour materials Solid_Elements geomlist {volumes}

	GiDMenu::UpdateMenus
}

# Get ProblemType path

proc OpenSees::GetProblemTypePath {} {

	variable OpenSeesProblemTypePath
	return $OpenSeesProblemTypePath
}

# Set/Get project name and path

proc OpenSees::SetProjectNameAndPath {} {

	set lines [GiD_Info Project]
	set ProblemType [lindex $lines 0]
	set ProjectName [lindex $lines 1]

	variable GiDProjectDir
	variable GiDProjectName

	# GiD_Info Project returns a list with project information { ProblemType ModelName .. .. .. }

	if { $ProjectName == "UNNAMED" } {

		set GiDProjectName "NONE"
		set GiDProjectDir "NONE"

	} else {

		regsub -all {\\} $ProjectName {/} ProjectName

		if { [file extension $ProjectName] == ".gid" } {
			set ProjectName [file root $ProjectName]
		}

		set pos [string last / $ProjectName]

		# returns the characters between two points in the string

		set GiDProjectName [string range $ProjectName $pos+1 $pos+100]
		set GiDProjectDir [string range $ProjectName 0 $pos-1]

		append GiDProjectDir "/$GiDProjectName.gid"
	}
}

proc OpenSees::GetProjectPath {} {

	variable GiDProjectDir
	return $GiDProjectDir
}

proc OpenSees::GetProjectName {} {

	variable GiDProjectName
	return $GiDProjectName
}

# Set/Get OpenSees path

proc OpenSees::SetOpenSeesPath {} {

	variable OpenSeesPath
	variable OpenSeesProblemTypePath

	global GidProcWin

	set file "$OpenSeesProblemTypePath/OpenSees.path"
	set fexists [file exist $file]

	if { $fexists == 1 } {
		set fp [open $file r]
		set file_data [read $fp]
		close $fp
		set data [split $file_data \n]
		set OpenSeesPath [lindex $data 0]
		regsub -all {\\} $OpenSeesPath {/} OpenSeesPath

	} else {

		if { ![info exists GidProcWin(w)] || \
			![winfo exists $GidProcWin(w).listbox#1] } {
			set wbase .gid
			set w ""
		} else {
			set wbase $GidProcWin(w)
			set w $GidProcWin(w).listbox#1
		}

		tk_dialogRAM $wbase.tmpwin [_ "Error"] [_ "OpenSees.path file was not found. Please re-install interface." ] error 0 [_ "Close"]
	}
}

proc OpenSees::GetOpenSeesPath {} {

	variable OpenSeesPath
	return $OpenSeesPath
}

# Get OpenSees version

proc OpenSees::GetVersion {} {
	variable VersionNumber
	return $VersionNumber
}

proc OpenSees::Toolbar1 {{type "DEFAULT INSIDELEFT"}} {

	global ToolbarBitmaps1 ToolbarCommands1 ToolbarHelp1 OpenSees1
	variable OpenSeesProblemTypePath
	global GiDtheme

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

		GidOpenMaterials "Combined_Materials"
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

	set ToolbarBitmaps1(0) " \
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
		[list -np- OpenSees::Opt1_1] \
		[list -np- OpenSees::Opt1_2] \
		[list -np- OpenSees::Opt1_3] \
		[list -np- OpenSees::Opt1_4] \
		[list -np- OpenSees::Opt1_5] \
		[list -np- OpenSees::Opt1_6] \
		"" \
		[list -np- OpenSees::Opt1_7] \
		[list -np- OpenSees::Opt1_8] \
		[list -np- OpenSees::Opt1_9] \
		[list -np- OpenSees::Opt1_10] \
		[list -np- OpenSees::Opt1_11] \
		"" \
		"-np- VisitWeb http://gidopensees.rclab.civil.auth.gr" \
	]

	set ToolbarHelp1(0) { \
		"Define Standard Unixaxial Materials" \
		"Define Concrete Uniaxial Materials" \
		"Define Steel Uniaxial Materials" \
		"Define Multidimensional Materials" \
		"Define Section Force-Deformation" \
		"Define Combined Materials" \
		"" \
		"Records" \
		"Assign Restraints" \
		"Assign Constraints" \
		"Assign Mass/Damping" \
		"Assign Loads" \
		"" \
		"GiD+OpenSees Website" \
		}

	set OpenSees1(toolbarwin) \
		[CreateOtherBitmaps PreBar1 "OpenSees Pre-Processor Toolbar 1" \
		ToolbarBitmaps1 \
		ToolbarCommands1 \
		ToolbarHelp1 \
		$OpenSeesProblemTypePath \
		OpenSees::Toolbar1 $type Pre]
		AddNewToolbar "OpenSees 1 Toolbar" WindowGeom1 Toolbar1
}

proc OpenSees::Toolbar2 {{type "DEFAULT INSIDELEFT"}} {

	global ToolbarBitmaps2 ToolbarCommands2 ToolbarHelp2 OpenSees2
	variable OpenSeesProblemTypePath
	global GiDtheme

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

		GidOpenProblemData "General_Data"
		HideInfoBar
	}

	proc Opt2_7 { } {

		GidOpenProblemData "Output_Options"
		HideInfoBar
	}

	proc Opt2_8 { } {

		GiD_Process Mescape Data IDataWindow
		HideInfoBar
	}

	proc Opt2_9 { } {

		GiD_Process Mescape Meshing generate
		HideInfoBar
	}

	proc Opt2_10 { } {

		Opt1_dialog
	}

	variable NormalsDrawStatus 0

	proc Opt2_11 { } {

		variable ElemDrawStatus
		variable NormalsDrawStatus
		variable ConditionsDrawStatus

		switch $NormalsDrawStatus {

		0 {
			GiD_Process Mescape Utilities DrawNormals lines 1:100000
			set NormalsDrawStatus 1
			set ElemDrawStatus 0
			set ConditionsDrawStatus 0
		}

		1 {
			GiD_Process Mescape
			set NormalsDrawStatus 0
		}
	}
	}

	variable ElemDrawStatus 0

	proc Opt2_12 { } {; # Switch draw elements

		variable ElemDrawStatus
		variable NormalsDrawStatus
		variable ConditionsDrawStatus

		switch $ElemDrawStatus {

			0 {
				GiD_Process Mescape
				GiD_Process Mescape Data Materials DrawMaterial -DrawAll-
				set ElemDrawStatus 1
				set ConditionsDrawStatus 0
				set NormalsDrawStatus 0
			}

			1 {
				GiD_Process Mescape
				set ElemDrawStatus 0
			}
		}
	}

	variable ConditionsDrawStatus 0

	proc Opt2_13 { } {; # Switch draw conditions

		variable ElemDrawStatus
		variable NormalsDrawStatus
		variable ConditionsDrawStatus

		switch $ConditionsDrawStatus {

			0 {
				GiD_Process Mescape
				GiD_Process Mescape Data Conditions DrawCond -DrawAll-
				set ConditionsDrawStatus 1
				set ElemDrawStatus 0
				set NormalsDrawStatus 0
			}

			1 {
				GiD_Process Mescape
				set ConditionsDrawStatus 0
			}
		}
	}

	proc Opt2_14 { } {

		GiD_Process Mescape Data Intervals ChangeInterval
		UpdateInfoBar
	}

	set ToolbarBitmaps2(0) " \
		img/Toolbar/$GiDtheme/btn_Elem_ZeroLength.png \
		img/Toolbar/$GiDtheme/btn_Elem_Truss.png \
		img/Toolbar/$GiDtheme/btn_Elem_Beam.png \
		img/Toolbar/$GiDtheme/btn_Elem_Quad.png \
		img/Toolbar/$GiDtheme/btn_Elem_Brick.png \
		img/Toolbar/$GiDtheme/btn_Separator.png \
		img/Toolbar/$GiDtheme/btn_Data.png \
		img/Toolbar/$GiDtheme/btn_Output.png \
		img/Toolbar/$GiDtheme/btn_Interval.png \
		img/Toolbar/$GiDtheme/btn_Mesh.png \
		img/Toolbar/$GiDtheme/btn_Calc.png \
		img/Toolbar/$GiDtheme/btn_Separator.png \
		img/Toolbar/$GiDtheme/btn_tcl.png \
		img/Toolbar/$GiDtheme/btn_Separator.png \
		img/Toolbar/$GiDtheme/btn_LocalAxes.png \
		img/Toolbar/$GiDtheme/btn_ViewElem.png \
		img/Toolbar/$GiDtheme/btn_ViewCond.png \
		img/Toolbar/$GiDtheme/btn_ActiveInterval.png \
		"
	set ToolbarCommands2(0) [list \
		[list -np- OpenSees::Opt2_1] \
		[list -np- OpenSees::Opt2_2] \
		[list -np- OpenSees::Opt2_3] \
		[list -np- OpenSees::Opt2_4] \
		[list -np- OpenSees::Opt2_5] \
		"" \
		[list -np- OpenSees::Opt2_6] \
		[list -np- OpenSees::Opt2_7] \
		[list -np- OpenSees::Opt2_8] \
		[list -np- OpenSees::Opt2_9] \
		[list -np- OpenSees::Opt2_10] \
		"" \
		[list -np- btn_Open_tcl] \
		"" \
		[list -np- OpenSees::Opt2_11] \
		[list -np- OpenSees::Opt2_12] \
		[list -np- OpenSees::Opt2_13] \
		[list -np- OpenSees::Opt2_14] \
	]

	set ToolbarHelp2(0) { \
		"Define Zero Length Elements" \
		"Define Truss Elements" \
		"Define Beam-Column Elements" \
		"Define Surface Elements" \
		"Define Solid Elements" \
		"" \
		"Set General Data" \
		"Set Output Options" \
		"Set Interval Data" \
		"Generate Mesh" \
		"Create .tcl, run analysis and postprocess" \
		"" \
		"Open .tcl file" \
		"" \
		"Show/Hide Line Local Axes" \
		"Show/Hide Elements" \
		"Show/Hide All Conditions for Active Interval" \
		"Select Active Interval" \
		}

	set OpenSees2(toolbarwin) \
		[CreateOtherBitmaps PreBar2 "OpenSees Pre-Processor Toolbar 2" \
		ToolbarBitmaps2 \
		ToolbarCommands2 \
		ToolbarHelp2 \
		$OpenSeesProblemTypePath \
		OpenSees::Toolbar2 $type Pre]
		AddNewToolbar "OpenSees 2 Toolbar" WindowGeom2 Toolbar2
}

proc OpenSees::Toolbar3 {{type "DEFAULT INSIDELEFT"}} {

	global ToolbarBitmaps3 ToolbarCommands3 ToolbarHelp3 OpenSees3
	variable OpenSeesProblemTypePath
	global GiDtheme

	set ToolbarBitmaps3(0) " \
		img/Toolbar/$GiDtheme-Macros/btn_EM.png \
		img/Toolbar/$GiDtheme-Macros/btn_ES.png \
		img/Toolbar/$GiDtheme-Macros/btn_small_X.png \
		img/Toolbar/$GiDtheme-Macros/btn_small_Y.png \
		img/Toolbar/$GiDtheme-Macros/btn_small_Z.png \
		img/Toolbar/$GiDtheme-Macros/btn_small_RX.png \
		img/Toolbar/$GiDtheme-Macros/btn_small_RY.png \
		img/Toolbar/$GiDtheme-Macros/btn_small_RZ.png \
		img/Toolbar/$GiDtheme-Macros/btn_Separator.png \
		img/Toolbar/$GiDtheme-Macros/btn_RM.png \
		img/Toolbar/$GiDtheme-Macros/btn_RS.png \
		img/Toolbar/$GiDtheme-Macros/btn_Separator.png \
		img/Toolbar/$GiDtheme-Macros/btn_DM.png \
		img/Toolbar/$GiDtheme-Macros/btn_DS.png \
		img/Toolbar/$GiDtheme-Macros/btn_Separator.png \
		img/Toolbar/$GiDtheme-Macros/btn_ZL.png \
		img/Toolbar/$GiDtheme-Macros/btn_small_X.png \
		img/Toolbar/$GiDtheme-Macros/btn_small_Y.png \
		img/Toolbar/$GiDtheme-Macros/btn_small_Z.png \
		img/Toolbar/$GiDtheme-Macros/btn_small_RX.png \
		img/Toolbar/$GiDtheme-Macros/btn_small_RY.png \
		img/Toolbar/$GiDtheme-Macros/btn_small_RZ.png \
		img/Toolbar/$GiDtheme-Macros/btn_Separator.png \
		img/Toolbar/$GiDtheme-Macros/btn_M.png \
		img/Toolbar/$GiDtheme-Macros/btn_Separator.png \
		img/Toolbar/$GiDtheme-Macros/btn_DV.png \
		img/Toolbar/$GiDtheme-Macros/btn_L.png \
		img/Toolbar/$GiDtheme-Macros/btn_Separator.png \
		img/Toolbar/$GiDtheme-Macros/btn_C.png \
		"

	set ToolbarCommands3(0) [list \
		[list -np- GiD_Process Mescape Data Conditions DrawCond Point_Equal_constraint_master_node Equal_constraint_ID] \
		[list -np- GiD_Process Mescape Data Conditions DrawCond Point_Equal_constraint_slave_node Equal_constraint_ID] \
		[list -np- GiD_Process Mescape Data Conditions DrawCond -ByColor- Point_Equal_constraint_slave_nodes X-Translation] \
		[list -np- GiD_Process Mescape Data Conditions DrawCond -ByColor- Point_Equal_constraint_slave_nodes Y-Translation] \
		[list -np- GiD_Process Mescape Data Conditions DrawCond -ByColor- Point_Equal_constraint_slave_nodes Z-Translation] \
		[list -np- GiD_Process Mescape Data Conditions DrawCond -ByColor- Point_Equal_constraint_slave_nodes X-Rotation] \
		[list -np- GiD_Process Mescape Data Conditions DrawCond -ByColor- Point_Equal_constraint_slave_nodes Y-Rotation] \
		[list -np- GiD_Process Mescape Data Conditions DrawCond -ByColor- Point_Equal_constraint_slave_nodes Z-Rotation] \
		"" \
		[list -np- GiD_Process Mescape Data Conditions DrawCond Point_Rigid_link_master_node Rigid_link_ID] \
		[list -np- GiD_Process Mescape Data Conditions DrawCond Point_Rigid_link_slave_node Rigid_link_ID] \
		"" \
		[list -np- GiD_Process Mescape Data Conditions DrawCond Point_Rigid_diaphragm_master_node Rigid_diaphragm_ID] \
		[list -np- GiD_Process Mescape Data Conditions DrawCond Point_Rigid diaphragm_slave_node Rigid_diaphragm_ID] \
		"" \
		[list -np- GiD_Process Mescape Data Conditions DrawCond Point_ZeroLength ZeroLength_ID] \
		[list -np- GiD_Process Mescape Data Conditions DrawCond Point_ZeroLength Ux_material] \
		[list -np- GiD_Process Mescape Data Conditions DrawCond Point_ZeroLength Uy_material] \
		[list -np- GiD_Process Mescape Data Conditions DrawCond Point_ZeroLength Uz_material] \
		[list -np- GiD_Process Mescape Data Conditions DrawCond Point_ZeroLength Rx_material] \
		[list -np- GiD_Process Mescape Data Conditions DrawCond Point_ZeroLength Ry_material] \
		[list -np- GiD_Process Mescape Data Conditions DrawCond Point_ZeroLength Rz_material] \
		"" \
		[list -np- GiD_Process Mescape Data Conditions DrawCond Point_Mass -draw-] \
		"" \
		[list -np- GiD_Process Mescape Meshing DrawNumOfDivisions Lines] \
		[list -np- GiD_Process Mescape Meshing DrawSizes Lines ] \
		"" \
		[list -np- GiD_Process Mescape] \
	]

	set ToolbarHelp3(0) { \
		"Equal constraint master node IDs" \
		"Equal constraint slave node IDs" \
		"Equal constraint slave X state" \
		"Equal constraint slave Y state" \
		"Equal constraint slave Z state" \
		"Equal constraint slave RX state" \
		"Equal constraint slave RY state" \
		"Equal constraint slave RZ state" \
		"" \
		"Rigid link master node IDs" \
		"Rigid link slave node IDs" \
		"" \
		"Rigid diaphragm master node IDs" \
		"Rigid diaprhagm slave node IDs" \
		"" \
		"Zerolength elements IDs" \
		"ZeroLength Ux material" \
		"ZeroLength Uy material" \
		"ZeroLength Uz material" \
		"ZeroLength Rx material" \
		"ZeroLength Ry material" \
		"ZeroLength Rz material" \
		"" \
		"Point masses" \
		"" \
		"Line mesh divisions" \
		"Line mesh sizes" \
		"" \
		"Clear" \
		}

	set OpenSees3(toolbarwin) \
		[CreateOtherBitmaps PreBar3 "OpenSees Pre-Processor Toolbar 3" \
		ToolbarBitmaps3 \
		ToolbarCommands3 \
		ToolbarHelp3 \
		$OpenSeesProblemTypePath \
		OpenSees::Toolbar3 $type Pre]
		AddNewToolbar "OpenSees 3 Toolbar" WindowGeom3 Toolbar3
}

proc OpenSees::TransformAndClose { } {

	global InfoWin

	destroy $InfoWin

	GiD_Process Mescape data defaults TransfProblem OpenSees
}

set ::InfoWin .gid.transform

proc GetAppDataDir {} {

	global env

	if { [expr [string compare "$::tcl_platform(platform)" "windows" ] == 0] } {

		package require registry 1.0

		set env_home [registry get {HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders} {AppData}]

	} else {

		set env_home $env(HOME)
	}

	return $env_home
}

#
# GiD TCL events
#

proc InitGIDProject { dir } {

	foreach filename {FindMaterialNumber.tcl ZeroLength.tcl UsedMaterials.tcl RigidDiaphragm.tcl equalDOF.tcl RigidLink.tcl Utilities.tcl Fibers.tcl MultipleDOF.tcl Regions.tcl UniformExcitation.tcl Nodes.tcl} {
		source [file join $dir bas tcl $filename]
	}

	foreach filename {Various.tcl MinMax.tcl Records.tcl GenData.tcl Damage2p.tcl ElasticSection.tcl LayeredShell.tcl InitStressStrain.tcl ElasticBeamColumn.tcl Fiber.tcl FiberInt.tcl ForceBeamColumn.tcl DispBeamColumn.tcl DispInteractionBeamColumn.tcl PIMY.tcl PDMY.tcl IntvData.tcl nDmaterials.tcl Quad.tcl Shell.tcl Truss.tcl UniaxialConcrete.tcl UniaxialSteel.tcl OtherUniaxial.tcl ZeroLength.tcl SeriesParallel.tcl SecAggregator.tcl} {
		source [file join $dir tcl $filename]
	}

	OpenSees::InitGIDProject $dir
}

proc EndGIDProject {} {

	bind .gid <Configure>		{}
	bind .gid <Activate>		{}
	bind .gid <Deactivate>		{}
	bind .gid <Map>				{}

	if {[winfo exist .ibar]} {destroy .ibar}

	EndToolbar1
	EndToolbar2
	EndToolbar3
}

# check problemtype version mismatch

proc LoadGIDProject { filespd } {

	set VersionNumber [OpenSees::GetVersion]
	global InfoWin
	variable GiDProjectDir

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

			if { [winfo exist .splash]} {
				destroy .splash
				update
			}

			InitWindow $InfoWin [= "Version mismatch"] ErrorInfo "" "" 1
			if { ![winfo exists $InfoWin] } return
			ttk::frame $InfoWin.top
			ttk::label $InfoWin.top.title_text -text [= ""]
			ttk::frame $InfoWin.information -relief raised
			ttk::label $InfoWin.information.errormessage -text [= "Current problemtype version ($VersionNumber) is different than saved model version ($spd_data). Please transform your model first."]
			ttk::frame $InfoWin.bottom
			ttk::button $InfoWin.bottom.continue -text [= "Transform"] -command "OpenSees::TransformAndClose"
			ttk::button $InfoWin.bottom.readlog -text [= "Keep old version"] -command "destroy $InfoWin"
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

proc AfterLoadGIDProject { filespd } {

	# Project name is set after complete load

	OpenSees::SetProjectNameAndPath
}

proc SaveGIDProject { filespd } {

	variable OldGiDProjectDir; # current project dir
	variable OldGiDProjectName; # current project dir

	set OldGiDProjectDir [OpenSees::GetProjectPath]
	set OldGiDProjectName [OpenSees::GetProjectName]

	set data [GiD_Info Project]
	set NewFullPath [lindex $data 1]

	regsub -all {\\} $NewFullPath {/} NewFullPath

	if { [file extension $NewFullPath] == ".gid" } {
		set NewFullPath [file root $NewFullPath]
	}

	set pos [string last / $NewFullPath]

	set NewGiDProjectName [string range $NewFullPath $pos+1 $pos+100]; # New Project Name
	set NewGiDProjectDir [string range $NewFullPath 0 $pos-1]; # New project dir

	append NewGiDProjectDir "/$NewGiDProjectName.gid"

	OpenSees::SetProjectNameAndPath; # Change old project dir to the new one

	if { $OldGiDProjectDir != $NewGiDProjectDir} {; # If project names are different

		set fexists [file exists "$OldGiDProjectDir/Records"]
		if {$fexists} {

			file copy -force "$OldGiDProjectDir/Records" "$NewGiDProjectDir"
		}

		set fexists [file exists "$OldGiDProjectDir/Scripts"]
		if {$fexists} {

			file copy -force "$OldGiDProjectDir/Scripts" "$NewGiDProjectDir"
		}

		set fexists [file exists "$OldGiDProjectDir/$OldGiDProjectName.txt"]
		if {$fexists} {

			file copy -force "$OldGiDProjectDir/$OldGiDProjectName.txt" "$NewGiDProjectDir/$NewGiDProjectName.txt"
		}
	}

	set VersionNumber [OpenSees::GetVersion]

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

proc AfterTransformProblemType { file oldproblemtype newproblemtype messages } {

	# if version earlier than v2.5.0, change some conditions of compatibility
	# Body Constraint -> Equal Constraint

	set cond_points [GiD_Info conditions ovpnt]
	set cond_lines [GiD_Info conditions ovline]

	# Point body constraint master node -> Point equal constraint master node

	set old_cond_name "Point_Body_constraint_master_node"
	set new_cond_name "Point_Equal_constraint_master_node"
	set exists [lsearch $cond_points $old_cond_name]
	set points ""
	set Ids ""
	if {$exists > -1 } {
	set count [GiD_Info conditions $old_cond_name geometry -count]
		if {$count} {
			set condition [GiD_Info conditions $old_cond_name geometry]

			foreach data $condition {

				lappend points [lindex $data 1]

				lappend Ids [lindex $data 3]
			}

			foreach point $points ID $Ids {

				set values [list $ID ""]
				GiD_AssignData condition $new_cond_name points $values $point
			}

			GiD_UnAssignData condition $old_cond_name points "all"
		}
	}

	# Point body constraint slave nodes -> Point equal constraint slave nodes

	set old_cond_name "Point_Body_constraint_slave_nodes"
	set new_cond_name "Point_Equal_constraint_slave_nodes"
	set exists [lsearch $cond_points $old_cond_name]
	set points ""
	set Ids ""
	set dofs ""

	if {$exists > -1 } {
	set count [GiD_Info conditions $old_cond_name geometry -count]
		if {$count} {
			set condition [GiD_Info conditions $old_cond_name geometry]

			foreach data $condition {

				lappend points [lindex $data 1]

				lappend Ids [lindex $data 3]

				lappend dofs [list [lindex $data 4] [lindex $data 5] [lindex $data 6] [lindex $data 7] [lindex $data 8] [lindex $data 9]]
			}

			foreach point $points ID $Ids dof $dofs {

				set values [list $ID [lindex $dof 0] [lindex $dof 1] [lindex $dof 2] [lindex $dof 3] [lindex $dof 4] [lindex $dof 5] ]
				GiD_AssignData condition $new_cond_name points $values $point
			}

			GiD_UnAssignData condition $old_cond_name points "all"
		}
	}

	# Line body constraint slave nodes -> Line equal constraint slave nodes

	set old_cond_name "Line_Body_constraint_slave_nodes"
	set new_cond_name "Line_Equal_constraint_slave_nodes"
	set exists [lsearch $cond_lines $old_cond_name]
	set lines ""
	set Ids ""
	set dofs ""

	if {$exists > -1 } {
	set count [GiD_Info conditions $old_cond_name geometry -count]

		if {$count} {
			set condition [GiD_Info conditions $old_cond_name geometry]

			foreach data $condition {

				lappend lines [lindex $data 1]

				lappend Ids [lindex $data 3]

				lappend dofs [list [lindex $data 4] [lindex $data 5] [lindex $data 6] [lindex $data 7] [lindex $data 8] [lindex $data 9]]
			}

			foreach line $lines ID $Ids dof $dofs {

				set values [list $ID [lindex $dof 0] [lindex $dof 1] [lindex $dof 2] [lindex $dof 3] [lindex $dof 4] [lindex $dof 5] ]
				GiD_AssignData condition $new_cond_name lines $values $line
			}

			GiD_UnAssignData condition $old_cond_name lines "all"
		}
	}

	# Diaphragm_ID_number field changed to : Rigid_diaphragm_ID

	set old_cond_name "Point_Rigid_diaphragm_master_node"
	set new_cond_name "Point_Rigid_diaphragm_master_node"
	set exists [lsearch $cond_points $old_cond_name]
	set points ""
	set Idold ""
	set Idnew ""

	if {$exists > -1 } {
	set count [GiD_Info conditions $old_cond_name geometry -count]
		if {$count} {
			set condition [GiD_Info conditions $old_cond_name geometry]

			foreach data $condition {

				lappend points [lindex $data 1]

				lappend Idold [lindex $data 3]

				lappend Idnew [lindex $data 3]
	}

			#GiD_UnAssignData condition $old_cond_name points "all"

			foreach point $points IDold $Idold IDnew $Idnew {

				if { $IDold == "-" } {

						break

				} else {

					set values [list $IDold $IDold ""]
					GiD_AssignData condition $new_cond_name points $values $point
				}
			}
		}
	}

	set old_cond_name "Point_Rigid_diaphragm_slave_nodes"
	set new_cond_name "Point_Rigid_diaphragm_slave_nodes"
	set exists [lsearch $cond_points $old_cond_name]
	set points ""
	set Idold ""
	set Idnew ""
	set Planes ""

	if {$exists > -1 } {
	set count [GiD_Info conditions $old_cond_name geometry -count]
		if {$count} {
			set condition [GiD_Info conditions $old_cond_name geometry]

			foreach data $condition {

				lappend points [lindex $data 1]

				lappend Idold [lindex $data 3]

				lappend Idnew [lindex $data 4]

				lappend Planes [lindex $data 5]
			}

			#GiD_UnAssignData condition $old_cond_name points "all"

			foreach point $points IDold $Idold IDnew $Idnew plane $Planes {

				# - means new user v2.5.0 and later
				if {$IDold == "-"} {

						break

				} else {

						set values [list $IDold $IDold $plane ""]
						GiD_AssignData condition $new_cond_name points $values $point
				}
			}
		}
	}

	set old_cond_name "Line_Rigid_diaphragm_slave_nodes"
	set new_cond_name "Line_Rigid_diaphragm_slave_nodes"
	set exists [lsearch $cond_lines $old_cond_name]
	set lines ""
	set Idold ""
	set Idnew ""
	set Planes ""

	if {$exists > -1 } {
	set count [GiD_Info conditions $old_cond_name geometry -count]
		if {$count} {
			set condition [GiD_Info conditions $old_cond_name geometry]

			foreach data $condition {

				lappend lines [lindex $data 1]

				lappend Idold [lindex $data 3]

				lappend Idnew [lindex $data 4]

				lappend Planes [lindex $data 5]
			}

			#GiD_UnAssignData condition $old_cond_name lines "all"

			foreach line $lines IDold $Idold IDnew $Idnew plane $Planes {

				# - means new user v2.5.0 and later
				if {$IDold == "-"} {

					break

				} else {

					set values [list $IDold $IDold $plane ""]
					GiD_AssignData condition $new_cond_name lines $values $line
				}
			}
		}
	}

	set old_cond_name "ZeroLength"
	set new_cond_name "Point_ZeroLength"
	set exists [lsearch $cond_points $old_cond_name]
	set points ""
	set Idold ""
	set options ""

	if {$exists > -1 } {
	set count [GiD_Info conditions $old_cond_name geometry -count]
		if {$count} {

			set condition [GiD_Info conditions $old_cond_name geometry]
			WarnWinText "$condition"
			foreach data $condition {
				WarnWinText "$data"
				lappend points [lindex $data 1]

				lappend Idold [lindex $data 3]

				lappend options [list [lindex $data 4] [lindex $data 5] [lindex $data 6] [lindex $data 7] [lindex $data 8] [lindex $data 9] [lindex $data 10] [lindex $data 11] [lindex $data 12] [lindex $data 13] [lindex $data 14] [lindex $data 15] ]
			}

			GiD_UnAssignData condition $old_cond_name points "all"

			foreach point $points IDold $Idold opt $options {

				# means new user v2.5.0 and later

				set values [list $IDold [lindex $opt 0] [lindex $opt 1] [lindex $opt 2] [lindex $opt 3] [lindex $opt 4] [lindex $opt 5] [lindex $opt 6] [lindex $opt 7] [lindex $opt 8] [lindex $opt 9] [lindex $opt 10] [lindex $opt 11] ]
				GiD_AssignData condition $new_cond_name points $values $point
			}
		}
	}

	GiD_Process Mescape Meshing generate Yes 1 MeshingParametersFrom=Preferences
}

proc EndGIDPostProcess {} {

	after 2000 "{UpdateInfoBar}"
}

proc EndToolbar1 {} {
	global OpenSees1

	ReleaseToolbar "OpenSees 1 Toolbar"
	rename OpenSees::Toolbar1 ""

	catch { destroy $OpenSees1(toolbarwin) }
}

proc EndToolbar2 {} {
	global OpenSees2

	ReleaseToolbar "OpenSees 2 Toolbar"
	rename OpenSees::Toolbar2 ""

	catch { destroy $OpenSees2(toolbarwin) }
}

proc EndToolbar3 {} {
	global OpenSees3

	ReleaseToolbar "OpenSees 3 Toolbar"
	rename OpenSees::Toolbar3 ""

	catch { destroy $OpenSees3(toolbarwin) }
}

proc HelpOnOpenSees { dir } {

	WarnWin [join [list "To get help for OpenSees, check the latest news in " \
						"http://opensees.berkeley.edu/wiki/index.php/Main_Page "]]
}

# Returns the project dimensions. Checking if there is any point outside the X-Y Plane. If so, the model is considered as 3D

proc OpenSees::ReturnProjectDimensions { } {

	set ndm 2
	foreach layername [GiD_Info layers] {
		foreach i [GiD_Info layers -entities points $layername] {
			set zcoord [lindex [GiD_Geometry get point $i] 3]
				if {$zcoord!=0} {
					set ndm 3
					break
				}
			}
		}
	return $ndm
}

proc OpenSees::Splash { dir } {

	variable VersionNumber
	global ibarBackgroundColor
	global ibarTextColor
	global GiDtheme

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

#
# Theme Settings
#

set ::ibarBackgroundColor "#F0F0F0"
set ::ibarTextColor "black"
set ::ibarLineColor "#CFC5C3"
set ::GiDtheme "Classic"

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

proc UpdateInfoBar { } {

	# remove bindings

	bind .gid <Configure>				{}
	bind .gid <Activate>				{}
	bind .gid <Deactivate>				{}
	bind .gid <Map>												{}

	global ibarBackgroundColor ibarTextColor ibarLineColor
	set OpenSeesProblemTypePath [OpenSees::GetProblemTypePath]
	set VersionNumber [OpenSees::GetVersion]

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
	set h [winfo height .gid.central.s]

	set geom "[winfo width .gid.central.s]x25+$x+$y"

	wm geometry .ibar $geom

	# set infobar text

	set dim "[OpenSees::ReturnProjectDimensions]D"

	set n [GiD_Info intvdata num]
	set act "Active Interval : [format "%2d" [lindex $n 0]]"

	# create infobar canvas

	canvas .ibar.c -width $w -height 25 -background $ibarBackgroundColor

	.ibar.c create line  0  24  $w 24 -fill $ibarLineColor
	.ibar.c create line  60  0  60 52 -fill $ibarLineColor
	.ibar.c create line 100  0 100 24 -fill $ibarLineColor
	.ibar.c create line 240  0 240 24 -fill $ibarLineColor

	#.ibar.c create line  [expr $w-1] 0 [expr $w-1] 24 -fill $ibarLineColor

	.ibar.c create text  30 12 -text $VersionNumber		-font "calibri 12" -fill $ibarTextColor -anchor center
	.ibar.c create text  80 12 -text $dim				-font "calibri 12" -fill $ibarTextColor -anchor center
	.ibar.c create text 170 12 -text $act				-font "calibri 12" -fill $ibarTextColor -anchor center

	set GiDProjectDir [OpenSees::GetProjectPath]
	set GiDProjectName [OpenSees::GetProjectName]

	if {[file exists "$GiDProjectDir/$GiDProjectName.post.res"]} {

		.ibar.c create text 252 12 -text "Ready to postprocess" -font "calibri 12" -fill $ibarTextColor -anchor w

	} elseif {[file exists "$GiDProjectDir/OpenSees/$GiDProjectName.log"]} {

		.ibar.c create text 252 12 -text "Solved" -font "calibri 12" -fill $ibarTextColor -anchor w

	} elseif {[file exists "$GiDProjectDir/OpenSees/$GiDProjectName.tcl"]} {

		.ibar.c create text 252 12 -text "Created" -font "calibri 12" -fill $ibarTextColor -anchor w

	} else {

		.ibar.c create text 252 12 -text "Not created" -font "calibri 12" -fill $ibarTextColor -anchor w

	}

	set off 10
	.ibar.c create text [expr $w-$off] 12 -text "Lab of R/C and Masonry Structures, AUTh" -font "calibri 10" -fill $ibarLineColor -anchor e

	pack .ibar.c
	raise .ibar .gid

	# add bindings

	bind .gid <Configure>	{RefreshInfoBar}
	bind .gid <Activate>	{RefreshInfoBar}
	bind .gid <Deactivate>	{HideInfoBar}
	bind .gid <Map>			{RefreshInfoBar}

	focus .gid.central.s
	update
}

proc RefreshInfoBar { } {

	if { [winfo exists .ibar] } {

		set x [winfo rootx .gid.central.s]
		set y [winfo rooty .gid.central.s]

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
