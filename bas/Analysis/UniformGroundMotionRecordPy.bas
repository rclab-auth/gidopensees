# Loads - Uniform Excitation

*set var dummy=tcl(ClearGMFileIDs )
*# 1 GM direction
*if(IntvData(Directions,int)==1)
*if(strcmp(IntvData(Ground_motion_direction),"Ux")==0)
iGMdirection = 1
*elseif(strcmp(IntvData(Ground_motion_direction),"Uy")==0)
iGMdirection = 2
*elseif(strcmp(IntvData(Ground_motion_direction),"Uz")==0)
iGMdirection = 3
*elseif(strcmp(IntvData(Ground_motion_direction),"Rx")==0)
iGMdirection = 4
*elseif(strcmp(IntvData(Ground_motion_direction),"Ry")==0)
iGMdirection = 5
*elseif(strcmp(IntvData(Ground_motion_direction),"Rz")==0)
iGMdirection = 6
*endif
*set var fileID=tcl(FindMaterialNumber *IntvData(Record_file) *DomainNum)
*set var dummy=tcl(AddGMFileID *fileID)
*# 2 GM directions
*elseif(IntvData(Directions,int)==2)
*if(strcmp(IntvData(First_ground_motion_direction),"Ux")==0)
firstGMdirection = 1
*elseif(strcmp(IntvData(First_ground_motion_direction),"Uy")==0)
firstGMdirection = 2
*elseif(strcmp(IntvData(First_ground_motion_direction),"Uz")==0)
firstGMdirection = 3
*elseif(strcmp(IntvData(First_ground_motion_direction),"Rx")==0)
firstGMdirection = 4
*elseif(strcmp(IntvData(First_ground_motion_direction),"Ry")==0)
firstGMdirection = 5
*elseif(strcmp(IntvData(First_ground_motion_direction),"Rz")==0)
firstGMdirection = 6
*endif
*if(strcmp(IntvData(Second_ground_motion_direction),"Ux")==0)
secondGMdirection = 1
*elseif(strcmp(IntvData(Second_ground_motion_direction),"Uy")==0)
secondGMdirection = 2
*elseif(strcmp(IntvData(Second_ground_motion_direction),"Uz")==0)
secondGMdirection = 3
*elseif(strcmp(IntvData(Second_ground_motion_direction),"Rx")==0)
secondGMdirection = 4
*elseif(strcmp(IntvData(Second_ground_motion_direction),"Ry")==0)
secondGMdirection = 5
*elseif(strcmp(IntvData(Second_ground_motion_direction),"Rz")==0)
secondGMdirection = 6
*endif
iGMdirection = [firstGMdirection, secondGMdirection]
*set var firstFileID=tcl(FindMaterialNumber *IntvData(First_record_file) *DomainNum)
*set var secondFileID=tcl(FindMaterialNumber *IntvData(Second_record_file) *DomainNum)
*set var dummy=tcl(AddGMFileID *firstFileID)
*set var dummy=tcl(AddGMFileID *secondFileID)
*# 3 GM directions
*elseif(IntvData(Directions,int)==3)
*if(strcmp(IntvData(First_ground_motion_direction),"Ux")==0)
firstGMdirection = 1
*elseif(strcmp(IntvData(First_ground_motion_direction),"Uy")==0)
firstGMdirection = 2
*elseif(strcmp(IntvData(First_ground_motion_direction),"Uz")==0)
firstGMdirection = 3
*elseif(strcmp(IntvData(First_ground_motion_direction),"Rx")==0)
firstGMdirection = 4
*elseif(strcmp(IntvData(First_ground_motion_direction),"Ry")==0)
firstGMdirection = 5
*elseif(strcmp(IntvData(First_ground_motion_direction),"Rz")==0)
firstGMdirection = 6
*endif
*if(strcmp(IntvData(Second_ground_motion_direction),"Ux")==0)
secondGMdirection = 1
*elseif(strcmp(IntvData(Second_ground_motion_direction),"Uy")==0)
secondGMdirection = 2
*elseif(strcmp(IntvData(Second_ground_motion_direction),"Uz")==0)
secondGMdirection = 3
*elseif(strcmp(IntvData(Second_ground_motion_direction),"Rx")==0)
secondGMdirection = 4
*elseif(strcmp(IntvData(Second_ground_motion_direction),"Ry")==0)
secondGMdirection = 5
*elseif(strcmp(IntvData(Second_ground_motion_direction),"Rz")==0)
secondGMdirection = 6
*endif
*if(strcmp(IntvData(Third_ground_motion_direction),"Ux")==0)
thirdGMdirection = 1
*elseif(strcmp(IntvData(Third_ground_motion_direction),"Uy")==0)
thirdGMdirection = 2
*elseif(strcmp(IntvData(Third_ground_motion_direction),"Uz")==0)
thirdGMdirection = 3
*elseif(strcmp(IntvData(Third_ground_motion_direction),"Rx")==0)
thirdGMdirection = 4
*elseif(strcmp(IntvData(Third_ground_motion_direction),"Ry")==0)
thirdGMdirection = 5
*elseif(strcmp(IntvData(Third_ground_motion_direction),"Rz")==0)
thirdGMdirection = 6
*endif
iGMdirection = [firstGMdirection, secondGMdirection,  thirdGMdirection]
*set var firstFileID=tcl(FindMaterialNumber *IntvData(First_record_file) *DomainNum)
*set var secondFileID=tcl(FindMaterialNumber *IntvData(Second_record_file) *DomainNum)
*set var thirdFileID=tcl(FindMaterialNumber *IntvData(Third_record_file) *DomainNum)
*set var dummy=tcl(AddGMFileID *firstFileID)
*set var dummy=tcl(AddGMFileID *secondFileID)
*set var dummy=tcl(AddGMFileID *thirdFileID)
*endif
*format "%g"
DtAnalysis = *IntvData(Analysis_time_step,real)
*format "%g"
TmaxAnalysis = *IntvData(Analysis_duration,real)
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

def ReadPEERfile(inFilename):
    try:
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
                    a = float(value)
                    acc_data.append(a)
                inp_acc = np.asarray(acc_data)
                time = []
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
*break
*endif
*end materials
*endfor


*# set the list of record file paths
*for(i=1;i<=directions;i=i+1)
*set var currGMID=tcl(ReturnGMFileID *i)
*loop materials *NotUsed
*set var RecordID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*# if record is found
*if(directions==1)
*if(RecordID==currGMID)
iGMfile = ["../Records/*MatProp(Record_file)"]
*break
*endif
*elseif(directions==2)
*if(i==1)
*if(RecordID==currGMID)
iGMfile = ["../Records/*MatProp(Record_file)", *\
*break
*endif
*elseif(i==2)
*if(RecordID==currGMID)
"../Records/*MatProp(Record_file)"]
*break
*endif
*endif
*elseif(directions==3)
*if(i==1)
*if(RecordID==currGMID)
iGMfile = ["../Records/*MatProp(Record_file)", *\
*break
*endif
*elseif(i==2)
*if(RecordID==currGMID)
"../Records/*MatProp(Record_file)", *\
*break
*endif
*elseif(i==3)
*if(RecordID==currGMID)
"../Records/*MatProp(Record_file)"]
*break
*endif
*endif
*endif
*end materials
*endfor

*# set the list of record scale factors
*for(i=1;i<=directions;i=i+1)
*set var currGMID=tcl(ReturnGMFileID *i)
*loop materials *NotUsed
*set var RecordID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*# if record is found
*if(directions==1)
*if(RecordID==currGMID)
iGMfact = [*MatProp(Scale_factor,real)]
*break
*endif
*elseif(directions==2)
*if(i==1)
*if(RecordID==currGMID)
iGMfile = [*MatProp(Scale_factor,real), *\
*break
*endif
*elseif(i==2)
*if(RecordID==currGMID)
*MatProp(Scale_factor,real)]
*break
*endif
*endif
*elseif(directions==3)
*if(i==1)
*if(RecordID==currGMID)
iGMfile = [*MatProp(Scale_factor,real), *\
*break
*endif
*elseif(i==2)
*if(RecordID==currGMID)
*MatProp(Scale_factor,real), *\
*break
*endif
*elseif(i==3)
*if(RecordID==currGMID)
*MatProp(Scale_factor,real)]
*break
*endif
*endif
*endif
*end materials
*endfor


*# set the list of the record formats
set iGMFormat *\
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
*include SolutionAlgorithmsDynamicPy.bas