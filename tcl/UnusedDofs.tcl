proc ClearUnusedDofLists { } {
global FixedNodes stdBrickUnfixedNodes EBCUnfixedNodes ETBUnfixedNodes ShellUnfixedNodes stdBrickUnusedDofsNodes

set FixedNodes ""
set stdBrickUnfixedNodes ""
set EBCUnfixedNodes ""
set ETBUnfixedNodes ""
set ShellUnfixedNodes ""
set stdBrickUnusedDofsNodes ""
return 0
}

proc AddFixedNode { num } {
global FixedNodes

	lappend FixedNodes $num

return 0
}

proc CheckIfNodeIsFixed { num } {
global FixedNodes

	set index [lsearch $FixedNodes $num]
	
return $index
}

proc AddstdBrickUnfixedNode { num } {
global stdBrickUnfixedNodes

	lappend stdBrickUnfixedNodes $num 
	
return 0
}

proc CheckStdBrickUnfixedNodes { num } {
global stdBrickUnfixedNodes
	
	set index [lsearch $stdBrickUnfixedNodes $num] 
	
return $index
}
proc AddEBCUnfixedNode { num } {
global EBCUnfixedNodes

	lappend EBCUnfixedNodes $num 
	
return 0
}

proc AddETBUnfixedNode { num } {
global ETBUnfixedNodes

	lappend ETBUnfixedNodes $num 
	
return 0
}

proc AddShellUnfixedNode { num } {
global ShellUnfixedNodes

	lappend ShellUnfixedNodes $num 
	
return 0
}

proc AddstdBrickUnusedDofsNodes { } {
global FixedNodes stdBrickUnfixedNodes EBCUnfixedNodes ETBUnfixedNodes ShellUnfixedNodes stdBrickUnusedDofsNodes

	foreach node $stdBrickUnfixedNodes {
	
	# $ok==0 : Node Belongs only on Brick Elements and is not fixed by user, $ok==-1 : Node Belongs to more than one element type
	set ok 0
	
	set l [list $FixedNodes $EBCUnfixedNodes $ETBUnfixedNodes $ShellUnfixedNodes $stdBrickUnusedDofsNodes]
		foreach lista $l {
		
			set nodeExists [lsearch $lista $node]
			
			if {$nodeExists!=-1} { set ok -1 }
		}
		if {$ok==0} {
			lappend stdBrickUnusedDofsNodes $node
		}
	}
return 0
}

proc stdBrickUnusedDofsNodeLength { } {
global stdBrickUnusedDofsNodes

	set length [llength $stdBrickUnusedDofsNodes]

	return $length
}

proc FixstdBrickUnusedDofs { index } {
global stdBrickUnusedDofsNodes

	set node [lindex $stdBrickUnusedDofsNodes $index]
	
return [format %6d $node]
}