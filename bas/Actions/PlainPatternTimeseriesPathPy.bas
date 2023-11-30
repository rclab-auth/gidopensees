*set var GMID=tcl(FindMaterialNumber *IntvData(Record_file) *DomainNum)
*loop materials *NotUsed
*set var RecordID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(RecordID==GMID)
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
*if(strcmp(MatProp(Record_file_format),"PEER_format")==0)

recordFile = "../Records/*MatProp(Record_file)"
*format "%1.4f"
ffactor = *MatProp(Scale_factor,real)
recordValues, dt = ReadPEERfile(recordFile)
ops.timeSeries("Path",0, "-dt", dt, "-values", recordValues, "-factor", ffactor)
*elseif(strcmp(MatProp(Record_file_format),"Single_value_per_line")==0)

recordFile = "../Records/*MatProp(Record_file)"
*format "%1.4f"
ffactor = *MatProp(Scale_factor,real)
skiplines = *MatProp(lines_to_skip,int)
recordValues = LoadRecordValues(recordFile, skiplines)
dt = *MatProp(Time_step,real)
ops.timeSeries("Path", 0, "-dt", dt, "-values", recordValues, "-factor", ffactor)
*elseif(strcmp(MatProp(Record_file_format),"Time_and_value_per_line")==0)

recordFile = "../Records/*MatProp(Record_file)"
*format "%1.4f"
ffactor = *MatProp(Scale_factor,real)
skiplines = *MatProp(lines_to_skip,int)
timeCol = *MatProp(Time_column,int)
valCol = *MatProp(Value_column,int)
recordValues, recordTimes = LoadRecordTimeandValues(recordFile, skiplines)
ops.timeSeries("Path", 0, "-time", recordTimes, "-values", recordValues, "-factor", ffactor)
*endif
*break
*endif
*end materials
*set var PatternTag=operation(IntvNum*1000)
ops.pattern("Plain", *PatternTag, 0)
*set cond Point_Forces *nodes *CanRepeat
*add cond Line_Forces *nodes *CanRepeat
*add cond Surface_Forces *nodes *CanRepeat
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==6)
*format "%6d"
ops.load(*NodesNum, *\
*format "%8g%8g%8g%8g%8g%8g"
*cond(1,real), *cond(2,real), *cond(3,real), *cond(4,real), *cond(5,real), *cond(6,real))
*elseif(nodeDOF==3)
*if(ndime==3)
*format "%6d"
ops.load(*NodesNum, *\
*format "%8g%8g%8g"
*cond(1,real), *cond(2,real), *cond(3,real))
*# 2D with 3DOF : Ux Uy Rz --> Fx Fy Mz
*else
*format "%6d"
ops.load(*NodesNum, *\
*format "%8g%8g%8g"
*cond(1,real), *cond(2,real), *cond(6,real))
*endif
*elseif(nodeDOF==2)
*format "%6d"
ops.load(*NodesNum, *\
*format "%8g%8g"
*cond(1,real), *cond(2,real))
*endif
*end nodes
*if(ndime==3)
*set cond Line_Uniform_Forces *elems
*loop elems *OnlyInCond
*format "%6d%8g%8g%8g"
ops.eleLoad("-ele", *ElemsNum, "-type", "-beamUniform", *cond(2,real), *cond(3,real), *cond(1,real))
*end elems
*# if it is 2D..
*else
*set cond Line_Uniform_Forces *elems
*loop elems *OnlyInCond
*format "%6d%8g%8g%8g"
ops.eleLoad("-ele", *ElemsNum, "-type", "-beamUniform", *cond(2,real), *cond(1,real))
*end elems
*endif
*set cond Point_Displacements *nodes
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==6)
*# 3D - 6 Dofs -> Ux Uy Uz Rx Ry Rz
*# If value is zero, it is like a restraint! So a restraint condition can be used instead.
*if(cond(1,real)!=0)
*format "%6d%8g"
ops.sp(*NodesNum, 1, *cond(1,real))
*endif
*if(cond(2,real)!=0)
*format "%6d%8g"
ops.sp(*NodesNum, 2, *cond(2,real))
*endif
*if(cond(3,real)!=0)
*format "%6d%8g"
ops.sp(*NodesNum, 3, *cond(3,real))
*endif
*if(cond(4,real)!=0)
*format "%6d%8g"
ops.sp(*NodesNum, 4, *cond(4,real))
*endif
*if(cond(5,real)!=0)
*format "%6d%8g"
ops.sp(*NodesNum, 5, *cond(5,real))
*endif
*if(cond(6,real)!=0)
*format "%6d%8g"
ops.sp(*NodesNum, 6, *cond(6,real))
*endif
*elseif(nodeDOF==3)
*if(ndime==3)
*# 3D - 3 Dofs -> Ux Uy Uz
*format "%6d%8g"
ops.sp(*NodesNum, 1, *cond(1,real))
*format "%6d%8g"
ops.sp(*NodesNum, 2, *cond(2,real))
*format "%6d%8g"
ops.sp(*NodesNum, 3, *cond(3,real))
*else
*# 2D - 3 Dofs -> 2 Translations (Ux,Uy) 1 Rotation Rz
*if(cond(1,real)!=0)
*format "%6d%8g"
  sp *NodesNum 1 *cond(1,real)
*endif
*if(cond(2,real)!=0)
*format "%6d%8g"
ops.sp(*NodesNumm, 2, *cond(2,real))
*endif
*if(cond(6,real)!=0)
*format "%6d%8g"
ops.sp(*NodesNum, 3, *cond(6,real))
*endif
*endif
*# 2 dofs
*else
*if(cond(1,real)!=0)
*format "%6d%8g"
ops.sp(*NodesNum, 1, *cond(1,real))
*endif
*if(cond(2,real)!=0)
*format "%6d%8g"
ops.sp(*NodesNum, 2, *cond(2,real))
*endif
*endif
*end nodes