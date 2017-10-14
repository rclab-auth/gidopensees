*# Count how many conditions for multiple support excitation has been assigned to the model
*set var cntMultiSupportGMRecordConditions=0
*set var cntMultiSupportSineGMConditions=0
*set cond Point_Ground_Motion_from_Record *nodes
*loop nodes *OnlyInCond
*set var cntMultiSupportGMRecordConditions=operation(cntMultiSupportGMRecordConditions+1)
*end nodes
*set cond Point_Sine_Ground_Motion *nodes
*loop nodes *OnlyInCond
*set var cntMultiSupportSineGMConditions=operation(cntMultiSupportSineGMConditions+1)
*end nodes
*if(cntMultiSupportGMRecordConditions!=0)
*set cond Point_Ground_Motion_from_Record *nodes
*loop nodes *OnlyInCond
*set var SelRecordID=tcl(FindMaterialNumber *cond(1))
*loop materials *NotUsed
*set var matID=tcl(FindMaterialNumber *MatProp(0))
*if(SelRecordID==matID)
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
*endif
*endif
*endif
*end materials
*end nodes

set iSupportNodeGMRecord "*\
*loop nodes *OnlyInCond
*format "%d"
*NodesNum *\
*end nodes
"
set iGMfile "*\
*loop nodes *OnlyInCond
*set var SelRecordID=tcl(FindMaterialNumber *cond(1))
*loop materials *NotUsed
*set var matID=tcl(FindMaterialNumber *MatProp(0))
*if(SelRecordID==matID)
{../Records/*MatProp(Record_file)} *\
*endif
*end materials
*end nodes
"
set iGMtype "*\
*loop nodes *OnlyInCond
*set var SelRecordID=tcl(FindMaterialNumber *cond(1))
*loop materials *NotUsed
*set var matID=tcl(FindMaterialNumber *MatProp(0))
*if(SelRecordID==matID)
*if(strcmp(MatProp(Record_type),"Acceleration")==0)
{-accel} *\
*elseif(strcmp(MatProp(Record_type),"Displacement")==0)
{-disp} *\
*elseif(strcmp(MatProp(Record_type),"Velocity")==0)
*MessageBox Error: Use Acceleration or Displacement record type for Multiple Support Excitation
*endif
*endif
*end materials
*end nodes
"
set iGMdirection "*\
*loop nodes *OnlyInCond
*if(strcmp(cond(2),"Ux")==0)
1 *\
*elseif(strcmp(cond(2),"Ux")==0)
2 *\
*elseif(strcmp(cond(2),"Ux")==0)
3 *\
*elseif(strcmp(cond(2),"Ux")==0)
4 *\
*elseif(strcmp(cond(2),"Ux")==0)
5 *\
*elseif(strcmp(cond(2),"Ux")==0)
6 *\
*endif
*end nodes
"
set iGMfact "*\
*loop nodes *OnlyInCond
*set var SelRecordID=tcl(FindMaterialNumber *cond(1))
*loop materials *NotUsed
*set var matID=tcl(FindMaterialNumber *MatProp(0))
*if(SelRecordID==matID)
*format "%1.3f"
{*MatProp(Scale_factor,real)} *\
*break
*endif
*end materials
*end nodes
"
set iGMformat "*\
*loop nodes *OnlyInCond
*set var SelRecordID=tcl(FindMaterialNumber *cond(1))
*loop materials *NotUsed
*set var matID=tcl(FindMaterialNumber *MatProp(0))
*if(SelRecordID==matID)
*if(strcmp(MatProp(Record_file_format),"PEER_format")==0)
{PEER} *\
*elseif(strcmp(MatProp(Record_file_format),"Single_value_per_line")==0)
{Value} *\
*elseif(strcmp(MatProp(Record_file_format),"Time_and_value_per_line")==0)
{TimeValue} *\
*endif
*endif
*end materials
*end nodes
"
set iGMdt "*\
*loop nodes *OnlyInCond
*set var SelRecordID=tcl(FindMaterialNumber *cond(1))
*loop materials *NotUsed
*set var matID=tcl(FindMaterialNumber *MatProp(0))
*if(SelRecordID==matID)
*if(strcmp(MatProp(Record_file_format),"PEER_format")==0)
{0} *\
*elseif(strcmp(MatProp(Record_file_format),"Single_value_per_line")==0)
{*MatProp(Time_step,real)} *\
*elseif(strcmp(MatProp(Record_file_format),"Time_and_value_per_line")==0)
{0} *\
*endif
*endif
*end materials
*end nodes
"
set iGMskip "*\
*loop nodes *OnlyInCond
*set var SelRecordID=tcl(FindMaterialNumber *cond(1))
*loop materials *NotUsed
*set var matID=tcl(FindMaterialNumber *MatProp(0))
*if(SelRecordID==matID)
*if(strcmp(MatProp(Record_file_format),"PEER_format")==0)
{0} *\
*elseif(strcmp(MatProp(Record_file_format),"Single_value_per_line")==0)
{*MatProp(lines_to_skip,int)} *\
*elseif(strcmp(MatProp(Record_file_format),"Time_and_value_per_line")==0)
{*MatProp(lines_to_skip,int)} *\
*endif
*endif
*end materials
*end nodes
"
set iGMvalCol "*\
*loop nodes *OnlyInCond
*set var SelRecordID=tcl(FindMaterialNumber *cond(1))
*loop materials *NotUsed
*set var matID=tcl(FindMaterialNumber *MatProp(0))
*if(SelRecordID==matID)
*if(strcmp(MatProp(Record_file_format),"PEER_format")==0)
{0} *\
*elseif(strcmp(MatProp(Record_file_format),"Single_value_per_line")==0)
{1} *\
*elseif(strcmp(MatProp(Record_file_format),"Time_and_value_per_line")==0)
{*MatProp(Value_column,int)} *\
*endif
*endif
*end materials
*end nodes
"
set iGMtimeCol "*\
*loop nodes *OnlyInCond
*set var SelRecordID=tcl(FindMaterialNumber *cond(1))
*loop materials *NotUsed
*set var matID=tcl(FindMaterialNumber *MatProp(0))
*if(SelRecordID==matID)
*if(strcmp(MatProp(Record_file_format),"PEER_format")==0)
{0} *\
*elseif(strcmp(MatProp(Record_file_format),"Single_value_per_line")==0)
{0} *\
*elseif(strcmp(MatProp(Record_file_format),"Time_and_value_per_line")==0)
{*MatProp(Time_column,int)} *\
*endif
*endif
*end materials
*end nodes
"
*# end if cntMultiSupportGMRecordConditions!=0
*endif
*if(cntMultiSupportSineGMConditions!=0)
*set cond Point_Sine_Ground_Motion *nodes
set iSupportNodeGMSine "*\
*loop nodes *OnlyInCond
*format "%d"
*NodesNum *\
*end nodes
"
set iGMSinetype "*\
*loop nodes *OnlyInCond
*if(strcmp(cond(1),"Acceleration")==0)
{-accel} *\
*elseif(strcmp(cond(1),"Displacement")==0)
{-disp} *\
*endif
*end nodes
"
set iGMSinedirection "*\
*loop nodes *OnlyInCond
*if(strcmp(cond(2),"Ux")==0)
1 *\
*elseif(strcmp(cond(2),"Uy")==0)
2 *\
*elseif(strcmp(cond(2),"Uz")==0)
3 *\
*elseif(strcmp(cond(2),"Rx")==0)
4 *\
*elseif(strcmp(cond(2),"Ry")==0)
5 *\
*elseif(strcmp(cond(2),"Rz")==0)
6 *\
*endif
*end nodes
"
set iGMSineAmpl "*\
*loop nodes *OnlyInCond
*if(strcmp(cond(1),"Acceleration")==0)
*format "%g"
{*cond(3,real)} *\
*elseif(strcmp(cond(1),"Displacement")==0)
*format "%g"
{*cond(4,real)} *\
*endif
*end nodes
"
set iGMSinePeriod "*\
*loop nodes *OnlyInCond
*format "%g"
{*cond(5,real)} *\
*end nodes
"
set iGMSineDuration "*\
*loop nodes *OnlyInCond
*format "%g"
{*cond(6,real)} *\
*end nodes
"
set iGMSineShift "*\
*loop nodes *OnlyInCond
*format "%g"
{*cond(7,real)} *\
*end nodes
"
*# end if SineGM !=0
*endif
*if(cntMultiSupportGMRecordConditions!=0 || cntMultiSupportSineGMConditions!=0)
set IDgmSeries 500;
set IDgmSineSeries 5000;

*format "%6d"
pattern MultipleSupport *PatternTag {
*if(cntMultiSupportGMRecordConditions!=0)
    foreach SupportNode $iSupportNodeGMRecord GMfile $iGMfile GMfact $iGMfact GMdirection $iGMdirection GMtype $iGMtype GMformat $iGMformat GMdt $iGMdt GMskip $iGMskip GMvalCol $iGMvalCol GMtimeCol $iGMtimeCol {
        set IDgmSeries [expr $IDgmSeries +1]
        set inFile "$GMfile"
        if {$GMformat=="PEER"} {
            ReadPEERfile $inFile recordValues dt;
            if {$GMtype == "-accel"} {
                set AccelSeries "Path -dt $dt -values {$recordValues} -factor $GMfact"; # time series information
                groundMotion $IDgmSeries Plain -accel $AccelSeries
                imposedMotion $SupportNode  $GMdirection $IDgmSeries
            } elseif {$GMtype == "-disp"} {
                set DispSeries "Path -dt $dt -values {$recordValues} -factor $GMfact"; # time series information
                groundMotion $IDgmSeries Plain -disp  $DispSeries
                imposedMotion $SupportNode  $GMdirection $IDgmSeries
            }
        } elseif {$GMformat == "Value"} {
            LoadRecordValues $inFile recordValues $GMskip
            set dt $GMdt
            if {$GMtype == "-accel"} {
                set AccelSeries "Path -dt $dt -values {$recordValues} -factor $GMfact"; # time series information
                groundMotion $IDgmSeries Plain -accel $AccelSeries
                imposedMotion $SupportNode  $GMdirection $IDgmSeries
            } elseif {$GMtype == "-disp"} {
                set DispSeries "Path -dt $dt -values {$recordValues} -factor $GMfact"; # time series information
                groundMotion $IDgmSeries Plain -disp  $DispSeries
                imposedMotion $SupportNode  $GMdirection $IDgmSeries
            }
        } elseif {$GMformat == "TimeValue"} {
            LoadRecordTimeandValues $inFile recordValues recordTimes $GMskip $GMtimeCol $GMvalCol
            if {$GMtype == "-accel"} {
                set AccelSeries "Path -time {$recordTimes} -values {$recordValues} -factor $GMfact"; # time series information
                groundMotion $IDgmSeries Plain -accel $AccelSeries
                imposedMotion $SupportNode  $GMdirection $IDgmSeries
            } elseif {$GMtype == "-disp"} {
                set DispSeries "Path -time {$recordTimes} -values {$recordValues} -factor $GMfact"; # time series information
                groundMotion $IDgmSeries Plain -disp  $DispSeries
                imposedMotion $SupportNode  $GMdirection $IDgmSeries
            }
        }
    };
*endif
*if(cntMultiSupportSineGMConditions!=0)
    foreach SupportNode $iSupportNodeGMSine GMSinetype $iGMSinetype GMSinedirection $iGMSinedirection GMSineAmpl $iGMSineAmpl GMSinePeriod $iGMSinePeriod GMSineDuration $iGMSineDuration GMSineShift $iGMSineShift {
        set IDgmSineSeries [expr $IDgmSineSeries+1]
        if {$GMSinetype == "-accel"} {
            set AccelSeries "Trig 0. $GMSineDuration $GMSinePeriod -factor $GMSineAmpl -shift $GMSineShift"
            groundMotion $IDgmSineSeries Plain -accel $AccelSeries
            imposedMotion $SupportNode $GMSinedirection $IDgmSineSeries
        } elseif {$GMSinetype == "-disp"} {
            set DispSeries "Trig 0. $GMSineDuration $GMSinePeriod -factor $GMSineAmpl -shift $GMSineShift"
            groundMotion $IDgmSineSeries Plain -disp $DispSeries
            imposedMotion $SupportNode $GMSinedirection $IDgmSineSeries
        }
    }
*endif
}
*endif
