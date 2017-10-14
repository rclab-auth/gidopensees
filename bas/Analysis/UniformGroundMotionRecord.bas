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
*set var fileID=tcl(FindMaterialNumber *IntvData(Record_file))
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
*set var firstFileID=tcl(FindMaterialNumber *IntvData(First_record_file))
*set var secondFileID=tcl(FindMaterialNumber *IntvData(Second_record_file))
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
*set var firstFileID=tcl(FindMaterialNumber *IntvData(First_record_file))
*set var secondFileID=tcl(FindMaterialNumber *IntvData(Second_record_file))
*set var thirdFileID=tcl(FindMaterialNumber *IntvData(Third_record_file))
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
*set var RecordID=tcl(FindMaterialNumber *MatProp(0))
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
*break
*endif
*end materials
*endfor
*# set the list of record file paths
set iGMfile "*\
*for(i=1;i<=directions;i=i+1)
*set var currGMID=tcl(ReturnGMFileID *i)
*loop materials *NotUsed
*set var RecordID=tcl(FindMaterialNumber *MatProp(0))
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
*set var RecordID=tcl(FindMaterialNumber *MatProp(0))
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
*set var RecordID=tcl(FindMaterialNumber *MatProp(0))
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
*# set the list of record type; accel or disp
set iGMType "*\
*for(i=1;i<=directions;i=i+1)
*set var currGMID=tcl(ReturnGMFileID *i)
*loop materials *NotUsed
*set var RecordID=tcl(FindMaterialNumber *MatProp(0))
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
*set var RecordID=tcl(FindMaterialNumber *MatProp(0))
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
*set var RecordID=tcl(FindMaterialNumber *MatProp(0))
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
*set var RecordID=tcl(FindMaterialNumber *MatProp(0))
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
*set var RecordID=tcl(FindMaterialNumber *MatProp(0))
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
        ReadPEERfile $GMfile recordValues dt;
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

*if(strcmp(IntvData(Convergence_criterion),"Norm_Unbalance")==0)
variable testTypeDynamic NormUnbalance
*elseif(strcmp(IntvData(Convergence_criterion),"Norm_Displacement_Increment")==0)
variable testTypeDynamic NormDispIncr
*elseif(strcmp(IntvData(Convergence_criterion),"Energy_Increment")==0)
variable testTypeDynamic EnergyIncr
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Unbalance")==0)
variable testTypeDynamic RelativeNormUnbalance
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Displacement_Increment")==0)
variable testTypeDynamic RelativeNormDispIncr
*elseif(strcmp(IntvData(Convergence_criterion),"Total_Relative_Norm_Displacement_Increment")==0)
variable testTypeDynamic RelativeTotalNormDispIncr
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Energy_Increment")==0)
variable testTypeDynamic RelativeEnergyIncr
*elseif(strcmp(IntvData(Convergence_criterion),"Fixed_Number_of_Iterations")==0)
variable testTypeDynamic FixedNumIter
*endif
*format "%g"
variable TolDynamic *IntvData(Tolerance,real);
variable maxNumIterDynamic *IntvData(Max_Iterations_per_Step,int);
*if(strcmp(IntvData(Solution_algorithm),"Full_Newton-Raphson")==0)
variable algorithmTypeDynamic Newton
*elseif(strcmp(IntvData(Solution_algorithm),"Modified_Newton-Raphson")==0)
variable algorithmTypeDynamic ModifiedNewton
*elseif(strcmp(IntvData(Solution_algorithm),"Newton-Raphson_with_line_search")==0)
variable algorithmTypeDynamic NewtonLineSearch
*elseif(strcmp(IntvData(Solution_algorithm),"Broyden")==0)
variable algorithmTypeDynamic Broyden
*elseif(strcmp(IntvData(Solution_algorithm),"BFGS")==0)
variable algorithmTypeDynamic BFGS
*elseif(strcmp(IntvData(Solution_algorithm),"KrylovNewton")==0)
variable algorithmTypeDynamic KrylovNewton
*endif
set Nsteps [expr int($TmaxAnalysis/$DtAnalysis)];
set AnalOk [analyze $Nsteps $DtAnalysis]; # perform analysis - returns 0 if analysis was successful

if {$AnalOk != 0} { ; # analysis was not successful
    # --------------------------------------------------------------------------------------------------
    # change some analysis parameters to achieve convergence
    # performance is slower inside this loop
    # Time-controlled analysis
    set AnalOk 0;
    set controlTime [getTime];
	set Nk 1; # dt = dt/Nk
    while {$controlTime < $TmaxAnalysis && $AnalOk == 0} {
        set controlTime [getTime]
        if { ($Nk == 1 && $AnalOk == 0) || ($Nk == 2 && $AnalOk == 0) } {
        set Nk 1
        set AnalOk [analyze 1 $DtAnalysis]
            if {$AnalOk != 0} {
                puts "\nTrying Newton with Initial Tangent\n"
                test NormDispIncr $TolDynamic 1000  *LoggingFlag
                algorithm Newton -initial
                set AnalOk [analyze 1 $DtAnalysis]
                test $testTypeDynamic $TolDynamic $maxNumIterDynamic *LoggingFlag
                algorithm $algorithmTypeDynamic
			}
			if {$AnalOk != 0} {
                puts "\nTrying Broyden\n"
                algorithm Broyden 8
                set AnalOk [analyze 1 $DtAnalysis]
                algorithm $algorithmTypeDynamic
            }
            if {$AnalOk != 0} {
                puts "\nTrying NewtonWithLineSearch\n"
                algorithm NewtonLineSearch .8
                set AnalOk [analyze 1 $DtAnalysis]
                algorithm $algorithmTypeDynamic
            }
        }
		
		if {($Nk == 1 && $AnalOk!=0) || ($Nk == 4 && $AnalOk==0)} {
			set Nk 2.0
            set curTime [getTime]
            set curStep [expr int($curTime/$DtAnalysis)]
            set remStep [expr int(($Nsteps-$curStep)**2.0)]
            set ReducedDtAnalysis [expr $DtAnalysis/2.0]
            for {set ik 1} {$ik <= $Nk} {incr ik 1} {
            set AnalOk [analyze 1 $ReducedDtAnalysis]
                if {$AnalOk != 0} {
                    puts "\nTrying Newton with Initial Tangent\n"
                    test NormDispIncr $TolDynamic 1000  *LoggingFlag
                    algorithm Newton -initial
                    set AnalOk [analyze 1 $ReducedDtAnalysis]
                    test $testTypeDynamic $TolDynamic $maxNumIterDynamic *LoggingFlag
                    algorithm $algorithmTypeDynamic
                }
                if {$AnalOk != 0} {
                    puts "\nTrying Broyden\n"
                    algorithm Broyden 8
                    set AnalOk [analyze 1 $ReducedDtAnalysis]
                    algorithm $algorithmTypeDynamic
                }
                if {$AnalOk != 0} {
                    puts "\nTrying NewtonWithLineSearch\n"
                    algorithm NewtonLineSearch .8
                    set AnalOk [analyze 1 $ReducedDtAnalysis]
                    algorithm $algorithmTypeDynamic
                }
            }
        }
		
        if {($Nk == 2 && $AnalOk!=0)} {
            set Nk 4.0
            set currTime [getTime]
            set curStep [expr ($currTime-$curTime)/$ReducedDtAnalysis]
            set remainStep [expr int(($remStep-$curStep)**2.0)]
            set ReducedDtAnalysis [expr $ReducedDtAnalysis/2.0]
            for {set ik 1} {$ik <= $Nk} {incr ik 1} {
                set AnalOk [analyze 1 $ReducedDtAnalysis]
                if {$AnalOk != 0} {
                    puts "\nTrying Newton with Initial Tangent\n"
                    test NormDispIncr $TolDynamic 1000  *LoggingFlag
                    algorithm Newton -initial
                    set AnalOk [analyze 1 $ReducedDtAnalysis]
                    test $testTypeDynamic $TolDynamic $maxNumIterDynamic *LoggingFlag
                    algorithm $algorithmTypeDynamic
				}
                if {$AnalOk != 0} {
                    puts "\nTrying Broyden\n"
                    algorithm Broyden 8
                    set AnalOk [analyze 1 $ReducedDtAnalysis]
                    algorithm $algorithmTypeDynamic
				}
                if {$AnalOk != 0} {
                    puts "\nTrying NewtonWithLineSearch\n"
                    algorithm NewtonLineSearch .8
                    set AnalOk [analyze 1 $ReducedDtAnalysis]
                    algorithm $algorithmTypeDynamic
                }
            }
        }
    }
}; # end if ok !

if {$AnalOk == 0} {
    puts "\nAnalysis completed SUCCESSFULLY\n"
} else {
    puts "\nAnalysis FAILED\n"
}