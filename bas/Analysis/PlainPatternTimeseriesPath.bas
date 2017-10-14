*set var GMID=tcl(FindMaterialNumber *IntvData(Record_file))
*loop materials *NotUsed
*set var RecordID=tcl(FindMaterialNumber *MatProp(0))
*if(RecordID==GMID)
*if(strcmp(MatProp(Record_file_format),"PEER_format")==0)
*if(procReadPeerFilePrinted==0)

proc ReadPEERfile {inFilename recordValues dt} {

    upvar $recordValues RecValues
    # read gm input format

    # Pass dt by reference
    upvar $dt DT

    # Open the input file and catch the error if it can't be read

    if [catch {open $inFilename r} inFileID] {
        puts stderr "Cannot open $inFilename for reading"
    } else {

    # Flag indicating dt is found and that ground motion
    # values should be read -- ASSUMES dt is on last header line !

    set flag 0

    # Look at each line in the file
    foreach line [split [read $inFileID] \n] {

        if {[llength $line] == 0} {
            # Blank line --> do nothing
            continue
        } elseif {$flag == 1} {
            # Echo ground motion values to output file
            foreach value [split $line] {
                if {$value!=""} {
                    lappend RecValues $value
                }
            }
        } else {
            # Search header lines for dt
            foreach word [split $line] {
                # Read in the time step
                if {$flag == 1} {
                set DT $word
                break
                }
                # Find the desired token and set the flag
                if {[string match $word "DT="] == 1} {set flag 1}
            }
        }
    }

    # Close the input file
    close $inFileID
    }
};
*set var procReadPeerFilePrinted=1

set recordFile "../Records/*MatProp(Record_file)"
*format "%1.4f"
set ffactor *MatProp(Scale_factor,real)
ReadPEERfile $recordFile recordValues dt;
set mSeries "Path -dt $dt -values {$recordValues} -factor $ffactor"
*endif
*elseif(strcmp(MatProp(Record_file_format),"Single_value_per_line")==0)
*if(procLoadRecValuesPrinted==0)

proc LoadRecordValues {filename recordValues skiplines} {
    set currentLine 0
    upvar $recordValues RecValues

    if [catch {open $filename r} inFileID] {
        puts stderr "Cannot open $filename for reading"
    } else {
        foreach line [split [read $inFileID] \n] {
            set currentLine [expr $currentLine+1]
            if {[llength $line] == 0 || $line == " " || $currentLine<= $skiplines} {
                continue
            } else {
                lappend RecValues [split [string trim $line]]
            }
        }
        close $inFileID
    }
}
*set var procLoadRecValuesPrinted=1

set recordFile "../Records/*MatProp(Record_file)"
*format "%1.4f"
set ffactor *MatProp(Scale_factor,real)
set skiplines *MatProp(lines_to_skip,int)
LoadRecordValues $recordFile recordValues $skiplines
set dt *MatProp(Time_step,real)
set mSeries "Path -dt $dt -values {$recordValues} -factor $ffactor"
*endif
*elseif(strcmp(MatProp(Record_file_format),"Time_and_value_per_line")==0)
*if(procLoadRecTimeandValuesPrinted==0)

proc LoadRecordTimeandValues {filename recordValues recordTimes skiplines tcol vcol} {
    set currentLine 0
    upvar $recordValues RecValues
    upvar $recordTimes RecTimes

    if [catch {open $filename r} inFileID] {
        puts stderr "Cannot open $filename for reading"
    } else {
        foreach line [split [read $inFileID] \n] {
            set currentLine [expr $currentLine+1]
            if {[llength $line] == 0 || $line == " " || $currentLine<= $skiplines} {
            continue
            } else {
                set valueColumnIndex [expr $vcol-1]
                set timeColumnIndex [expr $tcol-1]
                lappend RecValues [lindex [join $line " "] $valueColumnIndex ]
                lappend RecTimes [lindex [join $line " "] $timeColumnIndex ]
            }
        }
        close $inFileID
    }
}
*set var procLoadRecTimeandValuesPrinted=1

set recordFile "../Records/*MatProp(Record_file)"
*format "%1.4f"
set ffactor *MatProp(Scale_factor,real)
set skiplines *MatProp(lines_to_skip,int)
set timeCol *MatProp(Time_column,int)
set valCol *MatProp(Value_column,int)
LoadRecordTimeandValues $recordFile recordValues recordTimes $skiplines $timeCol $valCol
set mSeries "Path -time {$recordTimes} -values {$recordValues} -factor $ffactor"
*endif
*endif
*break
*endif
*end materials
*set var PatternTag=operation(IntvNum*1000)
pattern Plain *PatternTag $mSeries {
*set cond Point_Forces *nodes *CanRepeat
*add cond Line_Forces *nodes *CanRepeat
*add cond Surface_Forces *nodes *CanRepeat
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==6)
*format "%6d"
  load *NodesNum *\
*format "%8.3f%8.3f%8.3f%8.3f%8.3f%8.3f"
*cond(1,real) *cond(2,real) *cond(3,real) *cond(4,real) *cond(5,real) *cond(6,real)
*elseif(nodeDOF==3)
*if(ndime==3)
*format "%6d"
  load *NodesNum *\
*format "%8.3f%8.3f%8.3f"
*cond(1,real) *cond(2,real) *cond(3,real)
*# 2D with 3DOF : Ux Uy Rz --> Fx Fy Mz
*else
*format "%6d"
  load *NodesNum *\
*format "%8.3f%8.3f%8.3f"
*cond(1,real) *cond(2,real) *cond(6,real)
*endif
*elseif(nodeDOF==2)
*format "%6d"
  load *NodesNum *\
*format "%8.3f%8.3f"
*cond(1,real) *cond(2,real)
*endif
*end nodes
*if(ndime==3)
*set cond Line_Uniform_Forces *elems
*loop elems *OnlyInCond
  eleLoad -ele *ElemsNum -type -beamUniform *cond(2,real) *cond(3,real) *cond(1,real)
*end elems
*# if it is 2D..
*else
*set cond Line_Uniform_Forces *elems
*loop elems *OnlyInCond
  eleLoad -ele *ElemsNum -type -beamUniform *cond(2,real) *cond(1,real)
*end elems
*endif
}