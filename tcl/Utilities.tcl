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

proc View_version_history { } {
global problem_dir

exec {*}[auto_execok start] "" "$problem_dir/VersionHistory.txt"
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
	set tabs [list [= "OpenSees Analysis"] [= "Create .tcl only"] [= "Create and view .tcl only"] "---" [= "Visit GiD+OpenSees Site"] [= "Visit OpenSees Wiki"] "---" [= "View version history"] [= "About"] ]
	# Selection commands
	set cmds { {GiD_Process Utilities Calculate} {Create_tcl_file} {Create_and_open_tcl_file} {} {VisitWeb "http://gidopensees.rclab.civil.auth"} \
	{VisitWeb "http://opensees.berkeley.edu/wiki/index.php/Main_Page"} {} {View_version_history} {AboutOpenSeesProbType} }
	# Tab icons
	set icons {mnu_Analysis.png mnu_tcl.png mnu_tcl.png "" mnu_Site.png mnu_Wiki.png "" mnu_VersionHistory.png mnu_About.png}
	
	set position 0
	foreach tab $tabs command $cmds  icon $icons {
                set full_path_icon [file normalize [file join $dir img Menu $icon]]
                GiDMenu::InsertOption "GiD+OpenSees" [list $tab] $position PRE $command "" $full_path_icon
                incr position
    }
	GiDMenu::UpdateMenus
	}
