# 
# GiD to OpenSees Interface
#
# Lab of R/C and Masonry Structures
# School of Civil Engineering, AUTh
#
# Development team
# T. Kartalis-Kaounis, Civil Engineer AUTh
# V. Protopapadakis, Civil Engineer AUTh
# T. Papadopoulos, Civil Engineer AUTh
#
# Project supervisor
# V.K. Papanikolaou, Assistant Professor AUTh
#
#
# TCL macros
#

proc Toolbar2 { dir { type "DEFAULT INSIDELEFT"} } {
    global ToolbarNames2 ToolbarCommands2 ToolbarHelp2 OpenSees2

    set ToolbarNames2(0) "img/Toolbar/btn_Elem_ZeroLength.png img/Toolbar/btn_Elem_Truss.png img/Toolbar/btn_Elem_Beam.png img/Toolbar/btn_Elem_Quad.png img/Toolbar/btn_Elem_Brick.png \
	    img/Toolbar/btn_Separator.png img/Toolbar/btn_Data.png img/Toolbar/btn_Mesh.png img/Toolbar/btn_Calc.png"
    set ToolbarCommands2(0) [list [list -np- GidOpenConditions ZeroLength_Elements] \
	    [list -np- GidOpenMaterials Truss_Elements] \
		[list -np- GidOpenMaterials "Beam-Column_Elements"] \
		[list -np- GidOpenMaterials Quadrilateral_Elements] \
		[list -np- GidOpenMaterials Brick_Elements] "" \
		[list -np- GidOpenProblemData] \
		"Meshing generate" \
		"Utilities calculate" 
             ]
	
	# Mouse hover message
    set ToolbarHelp2(0) { "Assign Zero Length Elements" "Define/Assign Truss Elements" "Define/Assign Beam-Column_Elements" "Define/Assign Quadrilateral_Elements" "Define/Assign Brick Elements" \
		"" "Analysis Settings" "Generate Mesh" "Calculate" 
	    }
    
    # prefix values:
    #          Pre        Only active in the preprocessor
    #          Post       Only active in the postprocessor
    #          PrePost    Active Always

    set prefix Pre

    set OpenSees2(toolbarwin) [CreateOtherBitmaps MyBar "OpenSees Pre-Processor Toolbar 2" \
	    ToolbarNames2 ToolbarCommands2 \
	    ToolbarHelp2 $dir "Toolbar2 [list $dir]" $type $prefix]
    AddNewToolbar "OpenSees 2 toolbar" ${prefix}MyBarWindowGeom \
	    "Toolbar2 [list $dir]"
}

proc EndToolbar2 {} {
    global OpenSees2
    
    ReleaseToolbar "OpenSees 2 toolbar"
    rename Toolbar2 ""
    
    catch { destroy $Caltep2000(toolbarwin) }
}

proc Toolbar { dir { type "DEFAULT INSIDELEFT"} } {
    global ToolbarNames ToolbarCommands ToolbarHelp OpenSees 

    set ToolbarNames(0) "img/Toolbar/btn_Mat_Uni.png img/Toolbar/btn_Mat_UniS.png img/Toolbar/btn_Mat_UniC.png img/Toolbar/btn_Mat_ND.png img/Toolbar/btn_Mat_Section.png \
		img/Toolbar/btn_Separator.png img/Toolbar/btn_Restraints.png img/Toolbar/btn_Constraints.png img/Toolbar/btn_Mass.png img/Toolbar/btn_Loads.png \
		img/Toolbar/btn_Separator.png img/Toolbar/btn_About.png"
    set ToolbarCommands(0) [list [list -np- GidOpenMaterials Standard_Uniaxial_Materials] \
	    [list -np- GidOpenMaterials Uniaxial_Steel_Materials] \
		[list -np- GidOpenMaterials Uniaxial_Concrete_Materials] \
		[list -np- GidOpenMaterials "Multidimensional_(nD)_Materials"] \
		[list -np- GidOpenMaterials "Section_Force-Deformation"] "" \
		[list -np- GidOpenConditions Restraints] \
		[list -np- GidOpenConditions Constraints] \
	    [list -np- GidOpenConditions Masses] \
		[list -np- GidOpenConditions Assign_Loads] "" \
		"-np- VisitWeb http://gidopensees.rclab.civil.auth"
             ]
    set ToolbarHelp(0) { "Define Standard Unixaxial Materials" "Define Steel Uniaxial Materials" \
		"Define Concrete Uniaxial Materials" "Define Multidimensional Materials" "Define Section Force-Deformation" "" \
		"Assign Restraints" "Assign Constraints" "Assign Masses" "Assign Loads" "" \
		"GiD+OpenSees website" }
    
    # prefix values:
    #          Pre        Only active in the preprocessor
    #          Post       Only active in the postprocessor
    #          PrePost    Active Always

    set prefix Pre
	
    set OpenSees(pretoolbarwin) [CreateOtherBitmaps MyPreBar "OpenSees Pre-Processor Toolbar 1" \
	    ToolbarNames ToolbarCommands \
	    ToolbarHelp $dir "Toolbar [list $dir]" $type $prefix]
    AddNewToolbar "OpenSees 1 toolbar" ${prefix}MyBarWindowGeom \
	    "Toolbar [list $dir]"
}


proc EndToolbar {} {
    global OpenSees
    
    ReleaseToolbar "OpenSees 1 toolbar"
    rename Toolbar ""
    
    catch { destroy $OpenSees(pretoolbarwin) }
}



proc InitGIDProject { dir } {
    global MenuNames MenuEntries MenuCommands MenuAcceler
    global MenuNamesP MenuEntriesP MenuCommandsP MenuAccelerP
	global InterfaceName
	global GidPriv
	
	foreach filename {FindMaterialNumber.tcl ZeroLength.tcl UsedMaterials.tcl RigidDiaphragm.tcl BodyConstraints.tcl tkWidgets.tcl Utilities.tcl} {
        source [file join $dir tcl $filename]
    }
	
	set InterfaceName [_ "GiD+OpenSees Interface"]
	
    set num [lsearch $MenuNamesP [_ "View results"]]
    if { $num == -1 } {
	WarnWin "OpenSees is not compatible with this GiD version"
	return
    }
	
	global splashdir
    set splashdir 0
	global keepsplash
    set keepsplash 0 
	
	global problem_dir
	set problem_dir $dir
	
    Splash $dir
	set splashdir $dir
	
	OpenSees_Menu $dir

#    foreach i [array names MenuEntriesP $num,*] "unset MenuEntriesP($i)"
#    foreach i [array names MenuCommandsP $num,*] "unset MenuCommandsP($i)"
#    set MenuEntriesP($num) ""
#    set MenuCommandsP($num) "-np- CreatePostProcessMenu %W"

    set ipos [lsearch $MenuNames [_ "Help"]]
    if { $ipos != -1 } {
	set MenuEntries($ipos) [linsert $MenuEntries($ipos) 0 "Help on OpenSees"]
	set MenuCommands($ipos) [linsert $MenuCommands($ipos) 0 \
		[list -np- HelpOnOpenSees $dir]]
	set MenuAcceler($ipos) [linsert $MenuAcceler($ipos) 0 ""]
	CreateTopMenus
    }
    set ipos [lsearch $MenuNamesP Help]
    if { $ipos != -1 } {
	set MenuEntriesP($ipos) [linsert $MenuEntriesP($ipos) 0 "Help on OpenSees"]
	set MenuCommandsP($ipos) [linsert $MenuCommandsP($ipos) 0 \
		[list -np- HelpOnOpenSees $dir]]
	set MenuAccelerP($ipos) [linsert $MenuAccelerP($ipos) 0 ""]
    }

    Toolbar $dir
    Toolbar2 $dir
    
	# Change the Program name shown 
	set GidPriv(ProgName) $InterfaceName
	
    GidChangeDataLabel "Interval" ""
    GidChangeDataLabel "Conditions" ""
    GidChangeDataLabel "Local Axes" ""
	GidChangeDataLabel "Materials" "Materials/Elements Definition" 
    
    
    GidAddUserDataOptions "Assign Loads" "GidOpenConditions Assign_Loads" 2
    GidAddUserDataOptions "Restraints" "GidOpenConditions Restraints" 3
	GidAddUserDataOptions "Constraints" "GidOpenConditions Constraints" 4
	GidAddUserDataOptions "Masses" "GidOpenConditions Masses" 5
	GidAddUserDataOptions "ZeroLength Elements" "GidOpenConditions ZeroLength_Elements" 6
    GidAddUserDataOptions "---" "" 8
    
	
	GiD_DataBehaviour materials Standard_Uniaxial_Materials disable {assign unassign}
	GiD_DataBehaviour materials Uniaxial_Steel_Materials disable {assign unassign}
	GiD_DataBehaviour materials Uniaxial_Concrete_Materials disable {assign unassign}
	GiD_DataBehaviour materials Other_Uniaxial_Materials disable {assign unassign}
	GiD_DataBehaviour materials Multidimensional_(nD)_Materials disable {assign unassign}
	GiD_DataBehaviour materials "Beam-Column_Elements" geomlist {lines}
	GiD_DataBehaviour materials "Truss_Elements" geomlist {lines}
	GiD_DataBehaviour materials Quadrilateral_Elements geomlist {surfaces}
	GiD_DataBehaviour materials Brick_Elements geomlist {volumes}
	GiD_DataBehaviour materials "Section_Force-Deformation" disable {assign unassign}	
	
    GiDMenu::UpdateMenus
}

proc EndGIDProject {} {
    EndToolbar
	EndToolbar2
}

proc HelpOnOpenSees { dir } {

    WarnWin [join [list "To obtain help for OpenSees, check the latest news in " \
                        "http://opensees.berkeley.edu/wiki/index.php/Main_Page "]]

}

proc Splash { dir } {
    global GIDDEFAULT
	global keepsplash
	# Version Number

	set VersionNumber "v1.3.2"

    if { [.gid.central.s disable windows] } { return }

    if { [ winfo exist .splash]} {
	destroy .splash
	update
    }

    toplevel .splash
    
    set im [image create photo -file [ file join $dir img/Toolbar/splash.png]]
    set x [expr [winfo screenwidth .splash]/2-[image width $im]/2]
    set y [expr [winfo screenheight .splash]/2-[image height $im]/2]

    wm geom .splash +$x+$y
    wm transient .splash .gid
    wm overrideredirect .splash 1
    pack [label .splash.l -image $im -bd 0]
    
    label .splash.lv -text $VersionNumber -background #373C3D -foreground #FFFFD4  -font "calibri 11"
    place .splash.lv -x 324 -y 69
    bind .splash <1> "destroy .splash"
    bind .splash <KeyPress> "destroy .splash"
    raise .splash .gid
    grab .splash
    focus .splash
    update

    after 5000 "if { (!$keepsplash) && [ winfo exist .splash] } { 
	destroy .splash
    }"
}

proc getGiDProjectName {} {
  global GiDProjectName
  return $GiDProjectName
}

