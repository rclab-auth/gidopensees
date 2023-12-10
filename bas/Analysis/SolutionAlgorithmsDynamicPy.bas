
committedSteps = 1
Nsteps = int(TmaxAnalysis / DtAnalysis)

strIni = ""
*if(strcmp(IntvData(Convergence_criterion),"Norm_Unbalance")==0)
testTypeDynamic = "NormUnbalance"
*elseif(strcmp(IntvData(Convergence_criterion),"Norm_Displacement_Increment")==0)
testTypeDynamic = "NormDispIncr"
*elseif(strcmp(IntvData(Convergence_criterion),"Energy_Increment")==0)
testTypeDynamic = "EnergyIncr"
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Unbalance")==0)
testTypeDynamic = "RelativeNormUnbalance"
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Displacement_Increment")==0)
testTypeDynamic = "RelativeNormDispIncr"
*elseif(strcmp(IntvData(Convergence_criterion),"Total_Relative_Norm_Displacement_Increment")==0)
testTypeDynamic = "RelativeTotalNormDispIncr"
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Energy_Increment")==0)
testTypeDynamic = "RelativeEnergyIncr"
*elseif(strcmp(IntvData(Convergence_criterion),"Fixed_Number_of_Iterations")==0)
testTypeDynamic = "FixedNumIter"
*endif
*format "%g"
TolDynamic = *IntvData(Tolerance,real)
maxNumIterDynamic = *IntvData(Max_Iterations_per_Step,int)
*if(strcmp(IntvData(Solution_algorithm),"Full_Newton-Raphson")==0)
algorithmTypeDynamic = "Newton"
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
strIni = "/Ini"
*endif
*elseif(strcmp(IntvData(Solution_algorithm),"Modified_Newton-Raphson")==0)
algorithmTypeDynamic = "ModifiedNewton"
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
strIni = "/Ini"
*endif
*elseif(strcmp(IntvData(Solution_algorithm),"Newton-Raphson_with_line_search")==0)
algorithmTypeDynamic = "NewtonLineSearch"
*elseif(strcmp(IntvData(Solution_algorithm),"Broyden")==0)
algorithmTypeDynamic = "Broyden"
*elseif(strcmp(IntvData(Solution_algorithm),"BFGS")==0)
algorithmTypeDynamic = "BFGS"
*elseif(strcmp(IntvData(Solution_algorithm),"KrylovNewton")==0)
algorithmTypeDynamic = "KrylovNewton"
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
strIni = "/Ini"
*endif
*endif

for i in range(Nsteps):
    t = ops.getTime() + DtAnalysis
*if(PrintTime==1)
    print(f"(*IntvNum) {algorithmTypeDynamic}{strIni} Time {t} ")
*endif
    AnalOk = ops.analyze(1, DtAnalysis) # perform analysis - returns 0 if analysis was successful
    if AnalOk == 0:
        committedSteps += 1
    else:
        break


if AnalOk != 0: # if analysis fails, alternative algorithms and substepping is applied
    firstFail = 1
    AnalOk = 0
    controlTime = ops.getTime()
    Nk = 1 # dt = dt/Nk
    returnToInitStepFlag = 0
*if(IntvData(Tolerance_relaxation,int)==1)
    InitialTolFlag = 1
    returnToInitTolFlag = 0
    ChangeToleranceFlag = 0
    SkipFirstLoopForTolRelaxFlag = 1
*endif
    while controlTime < TmaxAnalysis and AnalOk == 0:
        if (Nk == 1 and AnalOk == 0) or (Nk == 2 and AnalOk == 0):
            Nk = 1
            if returnToInitStepFlag:
                print("\nBack to initial step\n")
                returnToInitStepFlag = 0
*if(IntvData(Tolerance_relaxation,int)==1)
            if returnToInitTolFlag:
                if not InitialTolFlag:
                    print("Back to initial error tolerance")
*format "%g"
                    TolDynamic /= *IntvData(Relaxation_factor,real)
                    InitialTolFlag = 1
*if(strcmp(IntvData(Convergence_criterion),"Norm_Unbalance")==0)
*format "%d"
                    ops.test("NormUnbalance", TolStatic, *IntvData(Max_Iterations_per_Step,int), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Norm_Displacement_Increment")==0)
*format "%d"
                    ops.test("NormDispIncr", TolStatic, *IntvData(Max_Iterations_per_Step,int), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Energy_Increment")==0)
*format "%d"
                    ops.test("EnergyIncr", TolStatic, *IntvData(Max_Iterations_per_Step,int), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Unbalance")==0)
*format "%d"
                    ops.test("RelativeNormUnbalance", TolStatic, *IntvData(Max_Iterations_per_Step,int), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Displacement_Increment")==0)
*format "%d"
                    ops.test("RelativeNormDispIncr", TolStatic, *IntvData(Max_Iterations_per_Step,int), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Total_Relative_Norm_Displacement_Increment")==0)
*format "%d"
                    ops.test("RelativeTotalNormDispIncr", TolStatic, *IntvData(Max_Iterations_per_Step,int), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Energy_Increment")==0)
*format "%d"
                    ops.test("RelativeEnergyIncr", TolStatic, *IntvData(Max_Iterations_per_Step,int), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Fixed_Number_of_Iterations")==0)
*format "%d"
                    ops.test("FixedNumIter", *IntvData(Max_Iterations_per_Step,int), *LoggingFlag)
*endif

            else:
                if InitialTolFlag and ChangeToleranceFlag and not SkipFirstLoopForTolRelaxFlag:
*format "%g"
                    print("Tolerance is multiplied by *IntvData(Relaxation_factor,real)")
*format "%g"
                    TolDynamic **= *IntvData(Relaxation_factor,real)
                    InitialTolFlag = 0
*if(strcmp(IntvData(Convergence_criterion),"Norm_Unbalance")==0)
*format "%d"
                    ops.test("NormUnbalance", TolStatic, *IntvData(Max_Iterations_per_Step,int), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Norm_Displacement_Increment")==0)
*format "%d"
                    ops.test("NormDispIncr", TolStatic, *IntvData(Max_Iterations_per_Step,int), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Energy_Increment")==0)
*format "%d"
                    ops.test("EnergyIncr", TolStatic, *IntvData(Max_Iterations_per_Step,int), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Unbalance")==0)
*format "%d"
                    ops.test("RelativeNormUnbalance", TolStatic, *IntvData(Max_Iterations_per_Step,int), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Displacement_Increment")==0)
*format "%d"
                    ops.test("RelativeNormDispIncr", TolStatic, *IntvData(Max_Iterations_per_Step,int), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Total_Relative_Norm_Displacement_Increment")==0)
*format "%d"
                    ops.test("RelativeTotalNormDispIncr", TolStatic, *IntvData(Max_Iterations_per_Step,int), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Energy_Increment")==0)
*format "%d"
                    ops.test("RelativeEnergyIncr", TolStatic, *IntvData(Max_Iterations_per_Step,int), *LoggingFlag)
*elseif(strcmp(IntvData(Convergence_criterion),"Fixed_Number_of_Iterations")==0)
*format "%d"
                    ops.test("FixedNumIter", *IntvData(Max_Iterations_per_Step,int), *LoggingFlag)
*endif

            SkipFirstLoopForTolRelaxFlag = 0
*endif
            if firstFail == 0: # for the first time only, do not repeat previous failed step
                t = ops.getTime() + DtAnalysis
*if(PrintTime==1)
                print(f"(*IntvNum) {algorithmTypeDynamic}{strIni} Time {t} ")
*endif
                AnalOk = ops.analyze(1, DtAnalysis)
            else:
                AnalOk = 1
                firstFail = 0

            if AnalOk == 0:
                committedSteps += 1

        # end if Nk=1
        # substepping /2
        if (Nk == 1 and AnalOk!=0) or (Nk == 4 and AnalOk==0):
            Nk = 2
            continueFlag = 1
            print("Initial step is divided by 2")
            currTime1 = ops.getTime()
            curStep = int(currTime1/DtAnalysis)
            remStep1 = int((Nsteps-curStep)**2.0)
            ReducedDtAnalysis = DtAnalysis/2.0
            for ik in range(Nk):
                if continueFlag==0:
                    break
                t = ops.getTime() + ReducedDtAnalysis
*if(PrintTime==1)
                print(f"(*IntvNum) {algorithmTypeDynamic}{strIni} Time {t} ")
*endif
                AnalOk = ops.analyze(1, ReducedDtAnalysis)
                if AnalOk == 0:
                    committedSteps += 1
                else:
                    continueFlag = 0

            if AnalOk == 0:
                returnToInitStepFlag = 1

        # end if Nk=2
*if(IntvData(Tolerance_relaxation,int)==1)
*if(strcmp(IntvData(Tolerance_relaxation_after_failed_substepping_of),"/2")==0)
        if AnalOk != 0:
            if InitialTolFlag:
                Nk = 1 # back to initial step - tolerance relaxation
                AnalOk = 0
                returnToInitStepFlag = 1
                ChangeToleranceFlag = 1
                returnToInitTolFlag = 0

        else:
            if not InitialTolFlag:
                Nk = 1
                returnToInitTolFlag = 1
*endif
*endif
        # substepping /4
        if (Nk == 2 and AnalOk!=0) or (Nk == 8 and AnalOk==0):
            Nk = 4
            continueFlag = 1
            print("Initial step is divided by 4")
            currTime2 = ops.getTime()
            curStep = (currTime2-currTime1)/ReducedDtAnalysis
            remStep2 = int((remStep1-curStep)**2.0)
            ReducedDtAnalysis = ReducedDtAnalysis/2.0
            for ik in range(Nk):
                if continueFlag==0:
                    break
                t = ops.getTime() + ReducedDtAnalysis
*if(PrintTime==1)
                print(f"(*IntvNum) {algorithmTypeDynamic}{strIni} Time {t} ")
*endif
                AnalOk = ops.analyze(1, ReducedDtAnalysis)
                if AnalOk == 0:
                    committedSteps += 1
                else:
                    continueFlag = 0

            if AnalOk == 0:
                returnToInitStepFlag = 1

        # end if Nk=4
*if(IntvData(Tolerance_relaxation,int)==1)
*if(strcmp(IntvData(Tolerance_relaxation_after_failed_substepping_of),"/4")==0)
        if AnalOk != 0:
            if InitialTolFlag:
                Nk = 1 # back to initial step - tolerance relaxation
                AnalOk = 0
                returnToInitStepFlag = 1
                ChangeToleranceFlag = 1
                returnToInitTolFlag = 0

        else:
            if not InitialTolFlag:
                Nk = 1
                returnToInitTolFlag = 1
*endif
*endif
        # substepping /8
        if (Nk == 4 and AnalOk!=0) or (Nk == 16 and AnalOk==0):
            Nk = 8
            continueFlag = 1
            print("Initial step is divided by 8")
            currTime3 = ops.getTime()
            curStep = (currTime3-currTime2)/ReducedDtAnalysis
            remStep3 = int((remStep2-curStep)**2.0)
            ReducedDtAnalysis = ReducedDtAnalysis/2.0
            for ik in range(Nk):
                if continueFlag==0:
                    break
                t = ops.getTime() + ReducedDtAnalysis
*if(PrintTime==1)
                print(f"(*IntvNum) {algorithmTypeDynamic}{strIni} Time {t} ")
*endif
                AnalOk = ops.analyze(1, ReducedDtAnalysis)
                if AnalOk == 0:
                    committedSteps += 1
                else:
                    continueFlag = 0

            if AnalOk == 0:
                returnToInitStepFlag = 1

        # end if Nk=8
*if(IntvData(Tolerance_relaxation,int)==1)
*if(strcmp(IntvData(Tolerance_relaxation_after_failed_substepping_of),"/8")==0)
        if AnalOk != 0:
            if InitialTolFlag:
                Nk = 1 # back to initial step - tolerance relaxation
                AnalOk = 0
                returnToInitStepFlag = 1
                ChangeToleranceFlag = 1
                returnToInitTolFlag = 0

        else:
            if not InitialTolFlag:
                Nk = 1
                returnToInitTolFlag = 1
*endif
*endif
        # substepping /16
        if (Nk == 8 and AnalOk!=0):
            Nk = 16
            continueFlag = 1
            print("Initial step is divided by 16")
            currTime4 = ops.getTime()
            curStep = (currTime4-currTime3)/ReducedDtAnalysis
            remStep4 = int((remStep3-curStep)**2.0)
            ReducedDtAnalysis = ReducedDtAnalysis/2.0
            for ik in range(Nk):
                if continueFlag==0:
                    break
                t = ops.getTime() + ReducedDtAnalysis
*if(PrintTime==1)
                print(f"(*IntvNum) {algorithmTypeDynamic}{strIni} Time {t} ")
*endif
                AnalOk = ops.analyze(1, ReducedDtAnalysis)
                if AnalOk == 0:
                    committedSteps += 1
                else:
                    continueFlag = 0

            if AnalOk == 0:
                returnToInitStepFlag = 1

        # end if Nk=8
*if(IntvData(Tolerance_relaxation,int)==1)
*if(strcmp(IntvData(Tolerance_relaxation_after_failed_substepping_of),"/16")==0)
        if AnalOk != 0:
            if InitialTolFlag:
                Nk = 1 # back to initial step - tolerance relaxation
                AnalOk = 0
                returnToInitStepFlag = 1
                ChangeToleranceFlag = 1
                returnToInitTolFlag = 0

        else:
            if not InitialTolFlag:
                Nk = 1
                returnToInitTolFlag = 1
*endif
*endif
*if(IntvData(Tolerance_relaxation,int)==1)
        if AnalOk != 0:
            if not InitialTolFlag:
                break
*endif
        controlTime = ops.getTime()


if AnalOk == 0:
    print("Analysis completed SUCCESSFULLY")
    print(f"Committed steps : {committedSteps}")
else:
    print("Analysis FAILED")
    print(f"Committed steps : {committedSteps}")