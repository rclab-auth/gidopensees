iNcycles = []
iDmax = []
iNSteps = []
Nsteps = *steps
committedSteps = 1
IDctrlNode = *IntvData(Control_node,int)
IDctrlDOF = *NodeCtrlDOF
*set var NMatrix=IntvData(Displacement_peaks-cycles,int)

*for(i=1;i<=Nmatrix;i=i+2)
*set var tempratio=IntvData(Displacement_peaks-cycles,*i,real)
*format "%g"
*if(strcmp(IntvData(Control_node_direction),"UX")==0 || strcmp(IntvData(Control_node_direction),"UY")==0 || strcmp(IntvData(Control_node_direction),"UZ")==0)
iDmax.append(*operation(tempratio*(IntvData(Total_displacement,real))))
*# Rotational control direction
*else
iDmax.append(*operation(tempratio*(IntvData(Total_rotation,real))))
*endif
iNcycles.append(*IntvData(Displacement_peaks-cycles,*operation(i+1),int))
*format "%g"
*if(IntvData(Adjust_number_of_steps_according_to_displacement_ratio,int)==1)
iNSteps.append(int(*tempratio ** Nsteps))
*else
iNSteps.append(Nsteps)
*endif
*endfor

strIni = ""
*if(strcmp(IntvData(Convergence_criterion),"Norm_Unbalance")==0)
testTypeStatic = 'NormUnbalance'
*elseif(strcmp(IntvData(Convergence_criterion),"Norm_Displacement_Increment")==0)
testTypeStatic = 'NormDispIncr'
*elseif(strcmp(IntvData(Convergence_criterion),"Energy_Increment")==0)
testTypeStatic = 'EnergyIncr'
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Unbalance")==0)
testTypeStatic = 'RelativeNormUnbalance'
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Norm_Displacement_Increment")==0)
testTypeStatic = 'RelativeNormDispIncr'
*elseif(strcmp(IntvData(Convergence_criterion),"Total_Relative_Norm_Displacement_Increment")==0)
testTypeStatic = 'RelativeTotalNormDispIncr'
*elseif(strcmp(IntvData(Convergence_criterion),"Relative_Energy_Increment")==0)
testTypeStatic = 'RelativeEnergyIncr'
*elseif(strcmp(IntvData(Convergence_criterion),"Fixed_Number_of_Iterations")==0)
testTypeStatic = 'FixedNumIter'
*endif
TolStatic = *IntvData(Tolerance,real)
maxNumIterStatic = *IntvData(Max_Iterations_per_Step,int)
*if(strcmp(IntvData(Solution_algorithm),"Full_Newton-Raphson")==0)
algorithmTypeStatic = 'Newton'
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
strIni = "/Ini"
*endif
*elseif(strcmp(IntvData(Solution_algorithm),"Modified_Newton-Raphson")==0)
algorithmTypeStatic = 'ModifiedNewton'
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
strIni = "/Ini"
*endif
*elseif(strcmp(IntvData(Solution_algorithm),"Newton-Raphson_with_line_search")==0)
algorithmTypeStatic = 'NewtonLineSearch'
*elseif(strcmp(IntvData(Solution_algorithm),"Broyden")==0)
algorithmTypeStatic = 'Broyden'
*elseif(strcmp(IntvData(Solution_algorithm),"BFGS")==0)
algorithmTypeStatic = 'BFGS'
*elseif(strcmp(IntvData(Solution_algorithm),"KrylovNewton")==0)
algorithmTypeStatic = 'KrylovNewton'
*if(IntvData(Use_initial_stiffness_iterations,int)==1)
strIni = "/Ini"
*endif
*endif
for Dmax in iDmax:
    for Ncycles in iNcycles:
        for NumSteps in iNSteps:
            DispIncr = Dmax / NumSteps # the displacement increment for each step
            Dstepvector = []
            Disp = 0
            if Dmax<0: # avoid the divide by zero
                dx = -DispIncr
            else:
                dx = DispIncr
            for i in range(NumSteps):
                Disp += dx
                Dstepvector.append(Disp)
            for i in range(NumSteps):
                Disp -= dx
                Dstepvector.append(Disp)
            for i in range(NumSteps):
                Disp -= dx
                Dstepvector.append(Disp)
            for i in range(NumSteps):
                    Disp += dx
                    Dstepvector.append(Disp)

            for i in range(Ncycles):
                currentPath = 1
                D0 = 0.0
                for Dispstep in Dstepvector:
                    D1 = Dispstep
                    Dincr = D1 - D0
                    ops.integrator("DisplacementControl", IDctrlNode, IDctrlDOF, Dincr)
                    t = ops.getTime()
*if(PrintTime==1)
                    print(f"(*IntvNum) {algorithmTypeStatic}{strIni} LF {t} ")
*endif
                    AnalOk = ops.analyze(1)
                    D0 = D1 # move to next step
                    tempexpr1 = abs(D0 - Dmax)
                    tempexpr2 = abs(D0 + Dmax)
                    tempexpr3 = abs(D0)
                    if (tempexpr1 < 0.0000001) or (tempexpr2 < 0.0000001) or (tempexpr3 < 0.0000001):
                        currentPath += 1

                    if AnalOk != 0:
                        break
                    else:
                        committedSteps += 1
                if AnalOk != 0: # if analysis fails, alternative algorithms and substepping is applied
                    firstFail = 1
                    Dstep = 0.0
                    AnalOk = 0
                    Nk = 1
                    returnToInitStepFlag = 0
*if(IntvData(Tolerance_relaxation,int)==1)
                    InitialTolFlag = 1
                    returnToInitTolFlag = 0
                    ChangeToleranceFlag = 0
                    SkipFirstLoopForTolRelaxFlag = 1
*endif
                    tempexpr = abs(Dstep)
                    while (AnalOk == 0 and currentPath<=3) or (tempexpr > 0.000001 and AnalOk == 0 and currentPath==4):
                        controlDisp = ops.nodeDisp(IDctrlNode, IDctrlDOF)
                        Dstep = controlDisp / Dmax
                        if (Nk==2 and AnalOk==0) or (Nk==1 and AnalOk==0):
                            Nk = 1
                            if returnToInitStepFlag:
                                print("Back to initial step")
                                returnToInitStepFlag = 0
*if(IntvData(Tolerance_relaxation,int)==1)
                            if returnToInitTolFlag:
                                if not InitialTolFlag:
                                    print("Back to initial error tolerance")
*format "%g"
                                    set TolStatic [expr $TolStatic/*IntvData(Relaxation_factor,real)]
                                    set InitialTolFlag 1
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
                                    TolStatic **=*IntvData(Relaxation_factor,real)
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
                                    if Dmax > 0:
                                        if currentPath == 1 or currentPath == 4:
                                            ops.integrator("DisplacementControl", IDctrlNode, IDctrlDOF, DispIncr) # bring back to original increment
                                        else:
                                            ops.integrator("DisplacementControl", IDctrlNode, IDctrlDOF, -DispIncr)

                                    else:
                                        if currentPath == 1 or currentPath == 4:
                                            ops.integrator("DisplacementControl", IDctrlNode, IDctrlDOF, -DispIncr) # bring back to original increment
                                        else:
                                            ops.integrator("DisplacementControl", IDctrlNode, IDctrlDOF, DispIncr)
                                    t = ops.getTime()
*if(PrintTime==1)
                                    print(f"(*IntvNum) {algorithmTypeStatic}{strIni} LF {t} ")
*endif
                                    AnalOk = ops.analyze(1) # zero for convergence
                                else:
                                    AnalOk = 1
                                    firstFail = 0
                                if AnalOk == 0:
                                    committedSteps += 1
                            # end if Nk=1
                            # substepping /2
                            if (AnalOk !=0 and Nk==1) or (AnalOk==0 and Nk==4):
                                Nk = 2 # reduce step size
                                continueFlag = 1
                                print("Initial step is divided by 2")
                                DincrReduced = DispIncr / Nk
                                if Dmax > 0:
                                    if currentPath == 1 or currentPath == 4:
                                        ops.integrator("DisplacementControl", IDctrlNode, IDctrlDOF, DincrReduced) # bring back to original increment
                                    else:
                                        ops.integrator("DisplacementControl", IDctrlNode, IDctrlDOF, -DincrReduced)
                                else:
                                    if currentPath == 1 or currentPath == 4:
                                        ops.integrator("DisplacementControl", IDctrlNode, IDctrlDOF, -DincrReduced) # bring back to original increment
                                    else:
                                        ops.integrator("DisplacementControl", IDctrlNode, IDctrlDOF, DincrReduced)
                                for ik in range(Nk):
                                    if continueFlag==0:
                                        break

                                    t = ops.getTime()
*if(PrintTime==1)
                                    print("(*IntvNum) {algorithmTypeStatic}{strIni} LF {t} ")
*endif
                                    AnalOk = ops.analyze(1) # zero for convergence
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
                            if (AnalOk !=0 and Nk==2) or (AnalOk==0 and Nk==8):
                                Nk = 4 # reduce step size
                                continueFlag = 1
                                print("Initial step is divided by 4")
                                DincrReduced = DispIncr / Nk
                                if Dmax > 0:
                                    if currentPath == 1 or currentPath == 4:
                                        ops.integrator("DisplacementControl", IDctrlNode, IDctrlDOF, DincrReduced) # bring back to original increment
                                    else:
                                        ops.integrator("DisplacementControl", IDctrlNode, IDctrlDOF, -DincrReduced)
                                else:
                                    if currentPath == 1 or currentPath == 4:
                                        ops.integrator("DisplacementControl", IDctrlNode, IDctrlDOF, -DincrReduced) # bring back to original increment
                                    else:
                                        ops.integrator("DisplacementControl", IDctrlNode, IDctrlDOF, DincrReduced)
                                for ik in range(Nk)
                                    if continueFlag==0:
                                        break

                                    t = ops.getTime()
*if(PrintTime==1)
                                    print("(*IntvNum) {algorithmTypeStatic}{strIni} LF {t} ")
*endif
                                    AnalOk = ops.analyze(1) # zero for convergence
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
                            if (AnalOk !=0 and Nk==4) or (AnalOk==0 and Nk==16):
                                Nk = 8 # reduce step size
                                continueFlag = 1
                                print("Initial step is divided by 8")
                                DincrReduced = DispIncr / Nk
                                if Dmax > 0:
                                    if currentPath == 1 or currentPath == 4:
                                        ops.integrator("DisplacementControl", IDctrlNode, IDctrlDOF, DincrReduced) # bring back to original increment
                                    else:
                                        ops.integrator("DisplacementControl", IDctrlNode, IDctrlDOF, -DincrReduced)
                                else:
                                    if currentPath == 1 or currentPath == 4:
                                        ops.integrator("DisplacementControl", IDctrlNode, IDctrlDOF, -DincrReduced) # bring back to original increment
                                    else:
                                        ops.integrator("DisplacementControl", IDctrlNode, IDctrlDOF, DincrReduced)
                                for ik in range(Nk)
                                    if continueFlag==0:
                                        break

                                    t = ops.getTime()
*if(PrintTime==1)
                                    print("(*IntvNum) {algorithmTypeStatic}{strIni} LF {t} ")
*endif
                                    AnalOk = ops.analyze(1) # zero for convergence
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
                            if (AnalOk !=0 and Nk==8):
                                Nk = 4 # reduce step size
                                continueFlag = 1
                                print("Initial step is divided by 16")
                                DincrReduced = DispIncr / Nk
                                if Dmax > 0:
                                    if currentPath == 1 or currentPath == 4:
                                        ops.integrator("DisplacementControl", IDctrlNode, IDctrlDOF, DincrReduced) # bring back to original increment
                                    else:
                                        ops.integrator("DisplacementControl", IDctrlNode, IDctrlDOF, -DincrReduced)
                                else:
                                    if currentPath == 1 or currentPath == 4:
                                        ops.integrator("DisplacementControl", IDctrlNode, IDctrlDOF, -DincrReduced) # bring back to original increment
                                    else:
                                        ops.integrator("DisplacementControl", IDctrlNode, IDctrlDOF, DincrReduced)
                                for ik in range(Nk)
                                    if continueFlag==0:
                                        break

                                    t = ops.getTime()
*if(PrintTime==1)
                                    print("(*IntvNum) {algorithmTypeStatic}{strIni} LF {t} ")
*endif
                                    AnalOk = ops.analyze(1) # zero for convergence
                                    if AnalOk == 0:
                                        committedSteps += 1
                                    else:
                                        continueFlag = 0
                                if AnalOk == 0:
                                    returnToInitStepFlag = 1

                            # end if Nk=16
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
                            controlDisp = ops.nodeDisp(IDctrlNode, IDctrlDOF)
                            Dstep = controlDisp / Dmax
                            tempexpr1 = abs(Dstep - 1)
                            tempexpr2 = abs(Dstep + 1)
                            tempexpr3 = abs(Dstep)
                            if tempexpr1 < 0.0000001 or tempexpr2 < 0.0000001 or tempexpr3 < 0.0000001:
                                currentPath += 1
                            tempexpr = abs(Dstep)
                        # end while loop
                    # end if $AnalOk !=0
                    if AnalOk != 0:
                        break

                # end i
            # end of iDmax

if AnalOk == 0:
    print("Analysis completed SUCCESSFULLY")
    print(f"Committed steps : {committedSteps}")
else
    print("Analysis FAILED")
    print(f"Committed steps : {committedSteps}")