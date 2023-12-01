# Loads - Uniform Excitation

*set var dummy=tcl(ClearGMFileIDs )
*# 1 GM direction
*if(IntvData(Directions,int)==1)
*if(strcmp(IntvData(Ground_motion_direction),"Ux")==0)
set iGMdirection 1
*elseif(strcmp(IntvData(Ground_motion_direction),"Uy")==0)
set iGMdirection 2
*elseif(strcmp(IntvData(Ground_motion_direction),"Uz")==0)
set iGMdirection 3
*elseif(strcmp(IntvData(Ground_motion_direction),"Rx")==0)
set iGMdirection 4
*elseif(strcmp(IntvData(Ground_motion_direction),"Ry")==0)
set iGMdirection 5
*elseif(strcmp(IntvData(Ground_motion_direction),"Rz")==0)
set iGMdirection 6
*endif
*set var fileID=tcl(FindMaterialNumber *IntvData(Record_file) *DomainNum)
*set var dummy=tcl(AddGMFileID *fileID)
*# 2 GM directions
*elseif(IntvData(Directions,int)==2)
*if(strcmp(IntvData(First_ground_motion_direction),"Ux")==0)
set firstGMdirection 1
*elseif(strcmp(IntvData(First_ground_motion_direction),"Uy")==0)
set firstGMdirection 2
*elseif(strcmp(IntvData(First_ground_motion_direction),"Uz")==0)
set firstGMdirection 3
*elseif(strcmp(IntvData(First_ground_motion_direction),"Rx")==0)
set firstGMdirection 4
*elseif(strcmp(IntvData(First_ground_motion_direction),"Ry")==0)
set firstGMdirection 5
*elseif(strcmp(IntvData(First_ground_motion_direction),"Rz")==0)
set firstGMdirection 6
*endif
*if(strcmp(IntvData(Second_ground_motion_direction),"Ux")==0)
set secondGMdirection 1
*elseif(strcmp(IntvData(Second_ground_motion_direction),"Uy")==0)
set secondGMdirection 2
*elseif(strcmp(IntvData(Second_ground_motion_direction),"Uz")==0)
set secondGMdirection 3
*elseif(strcmp(IntvData(Second_ground_motion_direction),"Rx")==0)
set secondGMdirection 4
*elseif(strcmp(IntvData(Second_ground_motion_direction),"Ry")==0)
set secondGMdirection 5
*elseif(strcmp(IntvData(Second_ground_motion_direction),"Rz")==0)
set secondGMdirection 6
*endif
set iGMdirection "$firstGMdirection $secondGMdirection"
*set var firstFileID=tcl(FindMaterialNumber *IntvData(First_record_file) *DomainNum)
*set var secondFileID=tcl(FindMaterialNumber *IntvData(Second_record_file) *DomainNum)
*set var dummy=tcl(AddGMFileID *firstFileID)
*set var dummy=tcl(AddGMFileID *secondFileID)
*# 3 GM directions
*elseif(IntvData(Directions,int)==3)
*if(strcmp(IntvData(First_ground_motion_direction),"Ux")==0)
set firstGMdirection 1
*elseif(strcmp(IntvData(First_ground_motion_direction),"Uy")==0)
set firstGMdirection 2
*elseif(strcmp(IntvData(First_ground_motion_direction),"Uz")==0)
set firstGMdirection 3
*elseif(strcmp(IntvData(First_ground_motion_direction),"Rx")==0)
set firstGMdirection 4
*elseif(strcmp(IntvData(First_ground_motion_direction),"Ry")==0)
set firstGMdirection 5
*elseif(strcmp(IntvData(First_ground_motion_direction),"Rz")==0)
set firstGMdirection 6
*endif
*if(strcmp(IntvData(Second_ground_motion_direction),"Ux")==0)
set secondGMdirection 1
*elseif(strcmp(IntvData(Second_ground_motion_direction),"Uy")==0)
set secondGMdirection 2
*elseif(strcmp(IntvData(Second_ground_motion_direction),"Uz")==0)
set secondGMdirection 3
*elseif(strcmp(IntvData(Second_ground_motion_direction),"Rx")==0)
set secondGMdirection 4
*elseif(strcmp(IntvData(Second_ground_motion_direction),"Ry")==0)
set secondGMdirection 5
*elseif(strcmp(IntvData(Second_ground_motion_direction),"Rz")==0)
set secondGMdirection 6
*endif
*if(strcmp(IntvData(Third_ground_motion_direction),"Ux")==0)
set thirdGMdirection 1
*elseif(strcmp(IntvData(Third_ground_motion_direction),"Uy")==0)
set thirdGMdirection 2
*elseif(strcmp(IntvData(Third_ground_motion_direction),"Uz")==0)
set thirdGMdirection 3
*elseif(strcmp(IntvData(Third_ground_motion_direction),"Rx")==0)
set thirdGMdirection 4
*elseif(strcmp(IntvData(Third_ground_motion_direction),"Ry")==0)
set thirdGMdirection 5
*elseif(strcmp(IntvData(Third_ground_motion_direction),"Rz")==0)
set thirdGMdirection 6
*endif
set iGMdirection "$firstGMdirection $secondGMdirection $thirdGMdirection"
*set var firstFileID=tcl(FindMaterialNumber *IntvData(First_record_file) *DomainNum)
*set var secondFileID=tcl(FindMaterialNumber *IntvData(Second_record_file) *DomainNum)
*set var thirdFileID=tcl(FindMaterialNumber *IntvData(Third_record_file) *DomainNum)
*set var dummy=tcl(AddGMFileID *firstFileID)
*set var dummy=tcl(AddGMFileID *secondFileID)
*set var dummy=tcl(AddGMFileID *thirdFileID)
*endif
*format "%g"
set DtAnalysis *IntvData(Analysis_time_step,real)
*format "%g"
set TmaxAnalysis *IntvData(Analysis_duration,real)
*set var directions=IntvData(Directions,int)
*# create the necessary procedures
*for(i=1;i<=directions;i=i+1)
*set var currGMID=tcl(ReturnGMFileID *i)
*loop materials *NotUsed
*set var RecordID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*# if record is found
*if(RecordID==currGMID)
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
}
*set var procReadPeerFilePrinted=1

*endif
*elseif(strcmp(MatProp(Record_file_format),"Single_value_per_line")==0)
*if(procLoadRecValuesPrinted==0)

proc LoadRecordValues {filename recordValues skiplines} {
    set currentLine 0
    upvar $recordValues RecValues
    # clear list
    set RecValues " "

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

*endif
*elseif(strcmp(MatProp(Record_file_format),"Time_and_value_per_line")==0)
*if(procLoadRecTimeandValuesPrinted==0)

proc LoadRecordTimeandValues {filename recordValues recordTimes skiplines tcol vcol} {
    set currentLine 0
    upvar $recordValues RecValues
    upvar $recordTimes RecTimes
    # clear lists
    set RecValues " "
    set RecTimes " "

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

*endif
*endif
*break
*endif
*end materials
*endfor
*# set the list of record file paths
set iGMfile "*\
*for(i=1;i<=directions;i=i+1)
*set var currGMID=tcl(ReturnGMFileID *i)
*loop materials *NotUsed
*set var RecordID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*# if record is found
*if(RecordID==currGMID)
{../Records/*MatProp(Record_file)} *\
*break
*endif
*end materials
*endfor
"
*# set the list of record scale factors
set iGMfact "*\
*for(i=1;i<=directions;i=i+1)
*set var currGMID=tcl(ReturnGMFileID *i)
*loop materials *NotUsed
*set var RecordID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*# if record is found
*if(RecordID==currGMID)
*format "%1.3f"
{*MatProp(Scale_factor,real)} *\
*break
*endif
*end materials
*endfor
"
*# set the list of the record formats
set iGMFormat "*\
*for(i=1;i<=directions;i=i+1)
*set var currGMID=tcl(ReturnGMFileID *i)
*loop materials *NotUsed
*set var RecordID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*# if record is found
*if(RecordID==currGMID)
*if(strcmp(MatProp(Record_file_format),"PEER_format")==0)
{PEER} *\
*elseif(strcmp(MatProp(Record_file_format),"Single_value_per_line")==0)
{Value} *\
*elseif(strcmp(MatProp(Record_file_format),"Time_and_value_per_line")==0)
{TimeValue} *\
*endif
*break
*endif
*end materials
*endfor
"
*# set the list of record type : accel or disp
set iGMType "*\
*for(i=1;i<=directions;i=i+1)
*set var currGMID=tcl(ReturnGMFileID *i)
*loop materials *NotUsed
*set var RecordID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*# if record is found
*if(RecordID==currGMID)
*if(strcmp(MatProp(Record_type),"Acceleration")==0)
{-accel} *\
*elseif(strcmp(MatProp(Record_type),"Displacement")==0)
{-disp} *\
*else
*MessageBox Error: Use an acceleration record type for uniform excitation
*endif
*break
*endif
*end materials
*endfor
"
set iGMdt "*\
*for(i=1;i<=directions;i=i+1)
*set var currGMID=tcl(ReturnGMFileID *i)
*loop materials *NotUsed
*set var RecordID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*# if record is found
*if(RecordID==currGMID)
*if(strcmp(MatProp(Record_file_format),"PEER_format")==0)
{0} *\
*elseif(strcmp(MatProp(Record_file_format),"Single_value_per_line")==0)
{*MatProp(Time_step,real)} *\
*elseif(strcmp(MatProp(Record_file_format),"Time_and_value_per_line")==0)
{0} *\
*endif
*break
*endif
*end materials
*endfor
"
set iGMskip "*\
*for(i=1;i<=directions;i=i+1)
*set var currGMID=tcl(ReturnGMFileID *i)
*loop materials *NotUsed
*set var RecordID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*# if record is found
*if(RecordID==currGMID)
*if(strcmp(MatProp(Record_file_format),"PEER_format")==0)
{0} *\
*elseif(strcmp(MatProp(Record_file_format),"Single_value_per_line")==0)
{*MatProp(lines_to_skip,int)} *\
*elseif(strcmp(MatProp(Record_file_format),"Time_and_value_per_line")==0)
{*MatProp(lines_to_skip,int)} *\
*endif
*break
*endif
*end materials
*endfor
"
set iGMvalCol "*\
*for(i=1;i<=directions;i=i+1)
*set var currGMID=tcl(ReturnGMFileID *i)
*loop materials *NotUsed
*set var RecordID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*# if record is found
*if(RecordID==currGMID)
*if(strcmp(MatProp(Record_file_format),"PEER_format")==0)
{0} *\
*elseif(strcmp(MatProp(Record_file_format),"Single_value_per_line")==0)
{1} *\
*elseif(strcmp(MatProp(Record_file_format),"Time_and_value_per_line")==0)
{*MatProp(Value_column,int)} *\
*endif
*endif
*end materials
*endfor
"
set iGMtimeCol "*\
*for(i=1;i<=directions;i=i+1)
*set var currGMID=tcl(ReturnGMFileID *i)
*loop materials *NotUsed
*set var RecordID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*# if record is found
*if(RecordID==currGMID)
*if(strcmp(MatProp(Record_file_format),"PEER_format")==0)
{0} *\
*elseif(strcmp(MatProp(Record_file_format),"Single_value_per_line")==0)
{0} *\
*elseif(strcmp(MatProp(Record_file_format),"Time_and_value_per_line")==0)
{*MatProp(Time_column,int)} *\
*endif
*endif
*end materials
*endfor
"
set IDGMLoadPatternTag *operation(100*IntvNum+50)

foreach GMdirection $iGMdirection GMfile $iGMfile GMfact $iGMfact GMtype $iGMType GMformat $iGMFormat GMdt $iGMdt GMskip $iGMskip GMvalCol $iGMvalCol GMtimeCol $iGMtimeCol {
    incr IDGMLoadPatternTag
    if {$GMformat=="PEER"} {
        ReadPEERfile $GMfile recordValues dt
            if {$GMtype == "-accel"} {
            set AccelSeries "Path -dt $dt -values {$recordValues} -factor $GMfact"
            pattern UniformExcitation $IDGMLoadPatternTag $GMdirection -accel $AccelSeries
        } elseif {$GMtype == "-disp"} {
            set DispSeries "Path -dt $dt -values {$recordValues} -factor $GMfact"
            pattern UniformExcitation $IDGMLoadPatternTag $GMdirection -disp $DispSeries
        }

    } elseif {$GMformat == "Value"} {
        LoadRecordValues $GMfile recordValues $GMskip
        set dt $GMdt
        if {$GMtype == "-accel"} {
            set AccelSeries "Path -dt $dt -values {$recordValues} -factor $GMfact"
            pattern UniformExcitation $IDGMLoadPatternTag $GMdirection -accel $AccelSeries
        } elseif {$GMtype == "-disp"} {
            set DispSeries "Path -dt $dt -values {$recordValues} -factor $GMfact"
            pattern UniformExcitation $IDGMLoadPatternTag $GMdirection -disp $DispSeries
        }
    } elseif {$GMformat == "TimeValue"} {
        LoadRecordTimeandValues $GMfile recordValues recordTimes $GMskip $GMtimeCol $GMvalCol
        if {$GMtype == "-accel"} {
                set AccelSeries "Path -time {$recordTimes} -values {$recordValues} -factor $GMfact"
                pattern UniformExcitation $IDGMLoadPatternTag $GMdirection -accel $AccelSeries
        } elseif {$GMtype == "-disp"} {
                set DispSeries "Path -time {$recordTimes} -values {$recordValues} -factor $GMfact"
                pattern UniformExcitation $IDGMLoadPatternTag $GMdirection -disp $DispSeries
        }
    }
}
*include SolutionAlgorithmsDynamic.bas