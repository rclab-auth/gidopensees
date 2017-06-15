*if(strcmp(IntvData(Ground_motion_direction),"Ux")==0)
set GMdirection 1
*elseif(strcmp(IntvData(Ground_motion_direction),"Uy")==0)
set GMdirection 2
*elseif(strcmp(IntvData(Ground_motion_direction),"Uz")==0)
set GMdirection 3
*elseif(strcmp(IntvData(Ground_motion_direction),"Rx")==0)
set GMdirection 4
*elseif(strcmp(IntvData(Ground_motion_direction),"Ry")==0)
set GMdirection 5
*elseif(strcmp(IntvData(Ground_motion_direction),"Rz")==0)
set GMdirection 6
*endif
*format "%g"
set DtAnalysis *IntvData(Analysis_time_step,real)
*format "%g"
set TmaxAnalysis *IntvData(Analysis_duration,real)
*set var SelRecord=tcl(FindMaterialNumber *IntvData(Record_file))
*loop materials *NotUsed
*set var RecordID=tcl(FindMaterialNumber *MatProp(0))
*if(RecordID==SelRecord)
set inFile "../Records/*MatProp(Record_file)"
*if(strcmp(MatProp(Record_file_format),"PEER_format")==0)

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
        # values should be read -- ASSUMES DT is on last line
        # of header!!!
        set flag 0

        # Look at each line in the file
        foreach line [split [read $inFileID] \n] {

        if {[llength $line] == 0} {
            # Blank line --> do nothing
            continue
        } elseif {$flag == 1} {
            # Echo ground motion values to output file
            #lappend RecValues [split [string trim $line]]
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
*elseif(strcmp(MatProp(Record_file_format),"Single_value_per_line")==0)

proc LoadRecordValues {filename recordValues} {
    set currentLine 0
    upvar $recordValues RecValues

    if [catch {open $filename r} inFileID] {
        puts stderr "Cannot open $filename for reading"
    } else {
        foreach line [split [read $inFileID] \n] {
        set currentLine [expr $currentLine+1]
            if {[llength $line] == 0 || $line == " " || $currentLine<= *MatProp(Lines_to_skip,int)} {
            continue
            } else {
                lappend RecValues [split [string trim $line]]
            }
        }
        close $inFileID
    }
}
*elseif(strcmp(MatProp(Record_file_format),"Time_and_value_per_line")==0)

proc LoadRecordTimeandValues {filename recordValues recordTimes} {
    set currentLine 0
    upvar $recordValues RecValues
    upvar $recordTimes RecTimes

    if [catch {open $filename r} inFileID] {
        puts stderr "Cannot open $filename for reading"
    } else {
        foreach line [split [read $inFileID] \n] {
            set currentLine [expr $currentLine+1]
            if {[llength $line] == 0 || $line == " " || $currentLine<= *MatProp(Lines_to_skip,int)} {
            continue
            } else {
                lappend RecValues [lindex [join $line " "] *operation(MatProp(Value_column,int)-1) ]
                lappend RecTimes [lindex [join $line " "] *operation(MatProp(Time_column,int)-1) ]
            }
        }
        close $inFileID
    }
}
*endif
*set var IDGMLoadPatternTag=operation(100*IntvNum+50)
*set var GMfact=MatProp(Scale_factor,real)
*if(strcmp(MatProp(Record_file_format),"PEER_format")==0)

ReadPEERfile $inFile recordValues dt;
*#LoadRecordValues $outFile recordValues
*#
*if(strcmp(MatProp(Record_type),"Acceleration")==0)
*format "%g"
set AccelSeries "Path -dt $dt -values {$recordValues} -factor *GMfact"
pattern UniformExcitation *IDGMLoadPatternTag  $GMdirection -accel $AccelSeries -fact 1
*#
*# else :Record type -> Displacement
*else
*format "%g"
set DispSeries "Path -dt $dt -values {$recordValues} -factor *GMfact"
pattern UniformExcitation *IDGMLoadPatternTag  $GMdirection -disp $DispSeries -fact 1
*endif
*elseif(strcmp(MatProp(Record_file_format),"Single_value_per_line")==0)

LoadRecordValues $inFile recordValues
set dt *MatProp(Time_step,real)
*#
*if(strcmp(MatProp(Record_type),"Acceleration")==0)
*format "%g"
set AccelSeries "Path -dt $dt -values {$recordValues} -factor *GMfact"
pattern UniformExcitation *IDGMLoadPatternTag  $GMdirection -accel $AccelSeries -fact 1
*else
*format "%g"
set DispSeries "Path -dt $dt -values {$recordValues} factor *GMfact"
pattern UniformExcitation *IDGMLoadPatternTag  $GMdirection -disp $DispSeries -fact 1
*endif
*#
*elseif(strcmp(MatProp(Record_file_format),"Time_and_value_per_line")==0)

LoadRecordTimeandValues $inFile recordValues recordTimes
*#
*if(strcmp(MatProp(Record_type),"Acceleration")==0)
*format "%g"
set AccelSeries "Path -time {$recordTimes} -values {$recordValues} -factor *GMfact"
pattern UniformExcitation *IDGMLoadPatternTag $GMdirection -accel $AccelSeries -fact 1
*else
*format "%g"
set DispSeries "Path -time {$recordTimes} -values {$recordValues} -factor *GMfact"
pattern UniformExcitation *IDGMLoadPatternTag $GMdirection -disp $DispSeries -fact 1
*endif
*endif
*# break : No need for more loops, Selected record has been found.
*break
*# endif selected record = current record
*endif
*end materials
*#set outFile [file rootname $inFile]
*#append outFile ".acc"
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
    while {$controlTime < $TmaxAnalysis && $AnalOk == 0} {
        set controlTime [getTime]
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
}; # end if ok !

if {$AnalOk == 0} {
    puts "\nAnalysis completed SUCCESSFULLY\n"
} else {
    puts "\nAnalysis FAILED\n"
}