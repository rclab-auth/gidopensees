proc loadProjectDirPath { filename } {
  
  set ProjectName 0
  set aa [GiD_Info Project]
  set ProblemType [lindex $aa 0]
  set ProjectName [lindex $aa 1]
  
  if { $ProjectName == "UNNAMED" } {
    set ProjectName $filename
  }

  regsub -all {\\} $ProjectName {/} ProjectName
  

  if { [file extension $ProjectName] == ".gid" } {
     set ProjectName [file root $ProjectName]
   }
 
   set pos [string last / $ProjectName]
   global GiDProjectDir
   global GiDProjectName
   # returns the characters between two points in the string
   set GiDProjectName [string range $ProjectName $pos+1 $pos+150]
   set GiDProjectDir [string range $ProjectName 0 $pos-1]
   
   append GiDProjectDir "/$GiDProjectName.gid"
  
}


proc Create_tcl_file { } {
global GidProcWin
set aa [GiD_Info Project]
set ProjectName [lindex $aa 1]

if { ![info exists GidProcWin(w)] || \
        ![winfo exists $GidProcWin(w).listbox#1] } {
        set wbase .gid
        set w ""
    } else {
        set wbase $GidProcWin(w)
        set w $GidProcWin(w).listbox#1
    }
	
if { $ProjectName == "UNNAMED" } {
    tk_dialogRAM $wbase.tmpwin [_ "Error"] \
                [_ "Before creating .tcl file, a project name is needed. Save project to get it." ] \
                error 0 [_ "OK"]
 } else {
 
 loadProjectDirPath { "" }

global problem_dir GiDProjectDir GiDProjectName
 
file mkdir $GiDProjectDir/OpenSees
GiD_Process escape escape escape escape Files WriteForBAS "$problem_dir/../OpenSees.gid/OpenSees.bas" "$GiDProjectDir/OpenSees/$GiDProjectName.tcl"
}
return ""
}

proc Create_and_open_tcl_file { } {
global problem_dir GiDProjectDir GiDProjectName

Create_tcl_file

exec {*}[auto_execok start] "" "$GiDProjectDir/OpenSees/$GiDProjectName.tcl"
#[file nativename [file normalize $theFilename]]

return ""
}


proc AboutOpenSeesProbType { } {
	global splashdir
	global keepsplash
	# 1!=0 to keep the Splash 
	set keepsplash 1 
	Splash $splashdir
	set keepsplash 0
}


proc OpenSees_Menu { dir } {
# Create the Menu named GiD+OpenSees in PRE processing
	GiDMenu::Create "GiD+OpenSees" PRE -1
	# Tab labes
	set tabs [list [= "OpenSees Analysis"] [= "Create .tcl only"] [= "Create and view .tcl only"] "---" [= "Visit GiD+OpenSees Site"] [= "Visit OpenSees Wiki"] [= "About"] ]
	# Selection commands
	set cmds { {GiD_Process Utilities Calculate} {Create_tcl_file} {Create_and_open_tcl_file} {} {VisitWeb "http://gidopensees.rclab.civil.auth.gr"} \
	{VisitWeb "http://opensees.berkeley.edu/wiki/index.php/Main_Page"} {AboutOpenSeesProbType} }
	# Tab icons
	set icons {mnu_Analysis.png mnu_tcl.png mnu_tcl.png "" mnu_Site.png mnu_Wiki.png mnu_About.png}
	
	set position 0
	foreach tab $tabs command $cmds  icon $icons {
                set full_path_icon [file normalize [file join $dir img Menu $icon]]
                GiDMenu::InsertOption "GiD+OpenSees" [list $tab] $position PRE $command "" $full_path_icon
                incr position
    }
	GiDMenu::UpdateMenus
	}
	
	
	proc roundUp { num } {
		set roundedNum [expr {round($num)}]
	
		if { $roundedNum>=$num} {
			return $roundedNum
		} else {
			return [expr {round($num+1)}]
		}
	
	}

	
	
	
	proc ModelessDialog {w title text bitmap default args} {
    global tcl_platform
    variable ::tk::Priv

    # Check that $default was properly given
    if {[string is integer -strict $default]} {
	if {$default >= [llength $args]} {
	    return -code error "default button index greater than number of\
		    buttons specified for tk_dialog"
	}
    } elseif {"" eq $default} {
	set default -1
    } else {
	set default [lsearch -exact $args $default]
    }

    set windowingsystem [tk windowingsystem]
    if {$windowingsystem eq "aqua"} {
	option add *Dialog*background systemDialogBackgroundActive widgetDefault
	option add *Dialog*Button.highlightBackground \
		systemDialogBackgroundActive widgetDefault
    }

    # 1. Create the top-level window and divide it into top
    # and bottom parts.

    destroy $w
    toplevel $w -class Dialog
    wm title $w $title
    wm iconname $w Dialog
    wm protocol $w WM_DELETE_WINDOW { }

    # Dialog boxes should be transient with respect to their parent,
    # so that they will always stay on top of their parent window.  However,
    # some window managers will create the window as withdrawn if the parent
    # window is withdrawn or iconified.  Combined with the grab we put on the
    # window, this can hang the entire application.  Therefore we only make
    # the dialog transient if the parent is viewable.
    #
    if {[winfo viewable [winfo toplevel [winfo parent $w]]] } {
	wm transient $w [winfo toplevel [winfo parent $w]]
    }

    if {$windowingsystem eq "aqua"} {
	::tk::unsupported::MacWindowStyle style $w moveableModal {}
    } elseif {$windowingsystem eq "x11"} {
	wm attributes $w -type dialog
    }

    frame $w.bot
    frame $w.top
    if {$windowingsystem eq "x11"} {
	$w.bot configure -relief raised -bd 1
	$w.top configure -relief raised -bd 1
    }
    pack $w.bot -side bottom -fill both
    pack $w.top -side top -fill both -expand 1
    grid anchor $w.bot center

    # 2. Fill the top part with bitmap and message (use the option
    # database for -wraplength and -font so that they can be
    # overridden by the caller).

    option add *Dialog.msg.wrapLength 3i widgetDefault
    option add *Dialog.msg.font TkCaptionFont widgetDefault

    label $w.msg -justify left -text $text
    pack $w.msg -in $w.top -side right -expand 1 -fill both -padx 3m -pady 3m
    if {$bitmap ne ""} {
	if {$windowingsystem eq "aqua" && $bitmap eq "error"} {
	    set bitmap "stop"
	}
	label $w.bitmap -bitmap $bitmap
	pack $w.bitmap -in $w.top -side left -padx 3m -pady 3m
    }

    # 3. Create a row of buttons at the bottom of the dialog.

    set i 0
    foreach but $args {
	button $w.button$i -text $but -command [list set ::tk::Priv(button) $i]
	if {$i == $default} {
	    $w.button$i configure -default active
	} else {
	    $w.button$i configure -default normal
	}
	grid $w.button$i -in $w.bot -column $i -row 0 -sticky ew \
		-padx 10 -pady 4
	grid columnconfigure $w.bot $i
	# We boost the size of some Mac buttons for l&f
	if {$windowingsystem eq "aqua"} {
	    set tmp [string tolower $but]
	    if {$tmp eq "ok" || $tmp eq "cancel"} {
		grid columnconfigure $w.bot $i -minsize 90
	    }
	    grid configure $w.button$i -pady 7
	}
	incr i
    }

    # 4. Create a binding for <Return> on the dialog if there is a
    # default button.
    # Convention also dictates that if the keyboard focus moves among the
    # the buttons that the <Return> binding affects the button with the focus.

    if {$default >= 0} {
	bind $w <Return> [list $w.button$default invoke]
    }
    bind $w <<PrevWindow>> [list bind $w <Return> {[tk_focusPrev %W] invoke}]
    bind $w <Tab> [list bind $w <Return> {[tk_focusNext %W] invoke}]

    # 5. Create a <Destroy> binding for the window that sets the
    # button variable to -1;  this is needed in case something happens
    # that destroys the window, such as its parent window being destroyed.

    bind $w <Destroy> {set ::tk::Priv(button) -1}

    # 6. Withdraw the window, then update all the geometry information
    # so we know how big it wants to be, then center the window in the
    # display (Motif style) and de-iconify it.

    #::tk::PlaceWindow $w 
    #tkwait visibility $w

    # 7. Set a grab and claim the focus too.

    #if {$default >= 0} {
     #   set focus $w.button$default
    #} else {
    #    set focus $w
    #}
    #tk::SetFocusGrab $w $focus

    # 8. Wait for the user to respond, then restore the focus and
    # return the index of the selected button.  Restore the focus
    # before deleting the window, since otherwise the window manager
    # may take the focus away so we can't redirect it.  Finally,
    # restore any grab that was in effect.

    #vwait ::tk::Priv(button)

    #catch {
	# It's possible that the window has already been destroyed,
	# hence this "catch".  Delete the Destroy handler so that
	# Priv(button) doesn't get reset by it.

	#bind $w <Destroy> {}
    #}
    #tk::RestoreFocusGrab $w $focus
    #return $Priv(button)
}