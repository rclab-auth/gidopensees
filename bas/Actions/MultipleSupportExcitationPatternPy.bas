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
*set var SelRecordID=tcl(FindMaterialNumber *cond(1) *DomainNum)
*loop materials *NotUsed
*set var matID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelRecordID==matID)
*if(strcmp(MatProp(Record_file_format),"PEER_format")==0)
*if(procReadPeerFilePrinted==0)
def ReadPEERfile(inFilename, scalefactor=None):
    try:
        if not scalefactor:
            scalefactor = 1.0
        with open(inFilename,'r') as f:
            content = f.readlines()
        counter = 0
        desc, row4Val, acc_data = "","",[]
        for x in content:
            if counter == 1:
                desc = x
            elif counter == 3:
                row4Val = x
                if row4Val[0][0] == 'N':
                    val = row4Val.split()
                    npts = float(val[(val.index('NPTS='))+1].rstrip(','))
                    dt = float(val[(val.index('DT='))+1])
                else:
                    val = row4Val.split()
                    npts = float(val[0])
                    dt = float(val[1])
            elif counter > 3:
                data = str(x).split()
                for value in data:
                    a = float(value) * scalefactor
                    acc_data.append(a)
                inp_acc = np.asarray(acc_data)
                time = []
                for i in range (0,len(acc_data)):
                    t = i * dt
                    time.append(t)
            counter = counter + 1
        return inp_acc, dt



*set var procReadPeerFilePrinted=1
*endif
*elseif(strcmp(MatProp(Record_file_format),"Single_value_per_line")==0)
*if(procLoadRecValuesPrinted==0)
def LoadRecordValues(filename, skiplines):
    recordValues = []
    with open(filename, 'r') as file:
        lines = file.readlines()
    file.close()
    strValues = [line.split(' ')[0] for line in lines]
    for i in range(skiplines, len(strValues)):
        recordValues.append(float(strValues[i]))
    return recordValues

*set var procLoadRecValuesPrinted=1
*endif
*elseif(strcmp(MatProp(Record_file_format),"Time_and_value_per_line")==0)
*if(procLoadRecTimeandValuesPrinted==0)
def LoadRecordTimeandValues(filename, skiplines):
    recordValues = []
    recordTimes = []

    with open(filename, 'r') as file:
        for _ in range(skiplines):
            next(file)  # Skip the specified number of lines

        for line in file:
            columns = line.strip().split()
            if len(columns) >= 2:  # Ensure at least 2 columns are present in the line
                recordValues.append(columns[0])
                recordTimes.append(columns[1])

    return recordValues, recordTimes

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
*set var SelRecordID=tcl(FindMaterialNumber *cond(1) *DomainNum)
*loop materials *NotUsed
*set var matID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelRecordID==matID)
{../Records/*MatProp(Record_file)} *\
*endif
*end materials
*end nodes
"
set iGMtype "*\
*loop nodes *OnlyInCond
*set var SelRecordID=tcl(FindMaterialNumber *cond(1) *DomainNum)
*loop materials *NotUsed
*set var matID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
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
*set var SelRecordID=tcl(FindMaterialNumber *cond(1) *DomainNum)
*loop materials *NotUsed
*set var matID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
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
*set var SelRecordID=tcl(FindMaterialNumber *cond(1) *DomainNum)
*loop materials *NotUsed
*set var matID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
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
*set var SelRecordID=tcl(FindMaterialNumber *cond(1) *DomainNum)
*loop materials *NotUsed
*set var matID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
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
*set var SelRecordID=tcl(FindMaterialNumber *cond(1) *DomainNum)
*loop materials *NotUsed
*set var matID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
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
*set var SelRecordID=tcl(FindMaterialNumber *cond(1) *DomainNum)
*loop materials *NotUsed
*set var matID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
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
*set var SelRecordID=tcl(FindMaterialNumber *cond(1) *DomainNum)
*loop materials *NotUsed
*set var matID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
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
set IDgmSeries 500
set IDgmSineSeries 5000

*format "%6d"
pattern MultipleSupport *PatternTag {
*if(cntMultiSupportGMRecordConditions!=0)
    foreach SupportNode $iSupportNodeGMRecord GMfile $iGMfile GMfact $iGMfact GMdirection $iGMdirection GMtype $iGMtype GMformat $iGMformat GMdt $iGMdt GMskip $iGMskip GMvalCol $iGMvalCol GMtimeCol $iGMtimeCol {
        set IDgmSeries [expr $IDgmSeries +1]
        set inFile "$GMfile"
        if {$GMformat=="PEER"} {
            ReadPEERfile $inFile recordValues dt
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
    }
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
