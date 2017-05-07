*set var VarCount=1
*# EXTRA ELEMSNUM because it not a geometric element
*set var ExtraElem=0
*set var NumberOfElements=0
*set var IDExists=-1
*loop elems
*set var NumberOfElements=NumberOfElements+1
*end elems
*# We save the ID numbers (cond(1) ) on a list
*set var dummy=tcl(ClearZeroLengthLists )
*set var IDExists=-1
*set Cond ZeroLength *nodes
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*if(LoopVar!=1)
*set var IDExists=tcl(CheckZeroLengthID *Cond(1,int))
*endif
*if(IDExists==-1)
*set var dummy=tcl(AddZeroLengthID *Cond(1,int))
*endif
*endif
*end nodes
*set var HowManyZeroLengthID=tcl(HowManyZeroLengthID)
*if(HowManyZeroLengthID>=1)

# --------------------------------------------------------------------------------------------------------------
# Z E R O   L E N G T H   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

*#--------------------for every zeroLength ID do the following: ----------------------
*for(i=1;i<=HowManyZeroLengthID;i=i+1)
*#
*#---------------------- DEFINING THE MATERIALS THAT ZeroLength ELEMENTS MAY USE-----------------------
*#
*set var ZLActiveDirections=0
*if(VarCount==1)
# Uniaxial materials used by ZeroLength elements

*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*for(ii=2;ii<=12;ii=ii+2)
*if(Cond(*ii,int)==1)
*set var SelMatID=tcl(FindMaterialNumber *Cond(*operation(ii+1)) )
*set var MaterialExists=tcl(CheckUsedMaterials *SelMatID )
*if(MaterialExists==-1)
*set var dummy=tcl(AddUsedMaterials *SelMatID)
*loop materials *NotUsed
*set Var MaterialID=tcl(FindMaterialNumber *MatProp(0) )
*if(MaterialID==SelMatID)
*if(strcmp(MatProp(Material:),"Elastic")==0)
*format "%d%g"
*if(strcmp(MatProp(Formulation),"Stress-Strain")==0)
uniaxialMaterial Elastic *MaterialID *MatProp(Elastic_modulus_E,real)
*elseif(strcmp(MatProp(Formulation),"Force-Deformation")==0)
uniaxialMaterial Elastic *MaterialID *MatProp(Stiffness_K,real)
*else
uniaxialMaterial Elastic *MaterialID *MatProp(Moment_per_rotation_unit,real)
*endif
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlastic")==0)
*format "%d%g%g%g%g"
*if(strcmp(MatProp(Formulation),"Stress-Strain")==0)
uniaxialMaterial ElasticPP *MaterialID *MatProp(Elastic_modulus_E,real) *MatProp(Strain_epsP,real) *MatProp(Strain_epsN,real) *MatProp(Initial_strain_eps0,real)
*elseif(strcmp(MatProp(Formulation),"Force-Deformation")==0)
uniaxialMaterial ElasticPP *MaterialID *MatProp(Stiffness_K,real) *MatProp(Deformation_epsP,real) *MatProp(Deformation_epsN,real) *MatProp(Initial_deformation_eps0,real)
*else
uniaxialMaterial ElasticPP *MaterialID *MatProp(Moment_per_rotation_unit,real) *MatProp(Rotation_epsP,real) *MatProp(Rotation_epsN,real) *MatProp(Initial_rotation_eps0,real)
*endif
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlasticwithGap")==0)
*format "%d%g%g%g"
*if(strcmp(MatProp(Formulation),"Stress-Strain")==0)
uniaxialMaterial ElasticPPGap *MaterialID *MatProp(Elastic_modulus_E,real) *MatProp(Yield_Stress_Fy,real) *MatProp(Strain_gap,real)
*elseif(strcmp(MatProp(Formulation),"Force-Deformation")==0)
uniaxialMaterial ElasticPPGap *MaterialID *MatProp(Stiffness_K,real) *MatProp(Force_Fy,real) *MatProp(Deformation_gap,real)
*else
uniaxialMaterial ElasticPPGap *MaterialID *MatProp(Moment_per_rotation_unit,real) *MatProp(Moment_My,real) *MatProp(Rotation_gap,real)
*endif
*elseif(strcmp(MatProp(Material:),"Steel01")==0)
*format "%d%g%g%g"
*if(strcmp(MatProp(Formulation),"Stress-Strain")==0)
uniaxialMaterial Steel01 *MaterialID *MatProp(Yield_Stress_Fy,real) *MatProp(Initial_elastic_tangent_E0,real) *MatProp(Strain-hardening_ratio_b,real)
*elseif(strcmp(MatProp(Formulation),"Force-Deformation")==0)
uniaxialMaterial Steel01 *MaterialID *MatProp(Force_Fy,real) *MatProp(Initial_stiffness_K,real) *MatProp(Strain-hardening_ratio_b,real)
*else
uniaxialMaterial Steel01 *MaterialID *MatProp(Moment_My,real) *MatProp(Moment_per_rotation_unit,real) *MatProp(Strain-hardening_ratio_b,real)
*endif
*elseif(strcmp(MatProp(Material:),"Concrete01")==0)
*format "%d%g%g%g%g"
uniaxialMaterial Concrete01 *MaterialID *MatProp(Compressive_strength_fpc,real) *MatProp(Strain_at_maximum_strength_epsc0,real) *MatProp(Crushing_strength_fpcu,real) *MatProp(Strain_at_crushing_strength_epscU,real)
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*format "%d%g%g%g%g%g%g"
uniaxialMaterial Concrete02 *MaterialID *MatProp(Compressive_strength_fpc,real) *MatProp(Strain_at_maximum_strength_epsc0,real) *MatProp(Crushing_strength_fpcu,real) *MatProp(Strain_at_crushing_strength_epscU,real) *MatProp(ratio_between_unloading_slope_at_epscU_and_initial_slope_lamdba,real) *MatProp(Tensile_strength_Ft,real) *MatProp(Tension_softening_stiffness_Ets,real)
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*format "%d%g%g%g%g%g%g%g%g"
uniaxialMaterial Concrete06 *MaterialID *MatProp(Concrete_compressive_strength_fc,real) *MatProp(Strain_at_compressive_strength_e0,real) *MatProp(Compressive_shape_factor_n,real) *MatProp(Post-peak_compressive_shape_factor_k,real) *MatProp(Parameter_a1_for_compressive_plastic_strain_definition,real) *MatProp(Tensile_strength_fcr,real) *MatProp(Tensile_strain_at_peak_stress_ecr,real) *MatProp(Exponent_of_the_tension_stiffering_curve_b,real) *MatProp(Parameter_a2_for_tensile_plastic_strain_definition,real)
*elseif(strcmp(MatProp(Material:),"Viscous")==0)
*format "%d%g%g"
uniaxialMaterial Viscous &MaterialID *MatProp(Damping_coefficient,real) *MatProp(Power_factor,real)
*#
*# ------------------- Start of Series/Parallel Uniaxial Material Definition ---------------------
*#
*elseif(strcmp(MatProp(Material:),"Parallel")==0 || strcmp(MatProp(Material:),"Series")==0)
*set var Nuniax=0
*for(k=2;k<=10;k=k+2)
*if(MatProp(*k,int)==1)
*set var Nuniax=operation(Nuniax+1)
*set var SelUniaxMatID=tcl(FindMaterialNumber *MatProp(*operation(k+1)) )
*set var MaterialExists=tcl(CheckUsedMaterials *SelUniaxMatID )
*if(MaterialExists==-1)
*set var dummy=tcl(AddUsedMaterials *SelUniaxMatID)
*loop materials *NotUsed
*set Var uniaxMaterialID=tcl(FindMaterialNumber *MatProp(0) )
*if(uniaxMaterialID==SelUniaxMatID)
*if(strcmp(MatProp(Material:),"Elastic")==0)
*format "%d%g"
*if(strcmp(MatProp(Formulation),"Stress-Strain")==0)
uniaxialMaterial Elastic *uniaxMaterialID *MatProp(Elastic_modulus_E,real)
*elseif(strcmp(MatProp(Formulation),"Force-Deformation")==0)
uniaxialMaterial Elastic *uniaxMaterialID *MatProp(Stiffness_K,real)
*else
uniaxialMaterial Elastic *uniaxMaterialID *MatProp(Moment_per_rotation_unit,real)
*endif
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlastic")==0)
*format "%d%g%g%g%g"
*if(strcmp(MatProp(Formulation),"Stress-Strain")==0)
uniaxialMaterial ElasticPP *uniaxMaterialID *MatProp(Elastic_modulus_E,real) *MatProp(Strain_epsP,real) *MatProp(Strain_epsN,real) *MatProp(Initial_strain_eps0,real)
*elseif(strcmp(MatProp(Formulation),"Force-Deformation")==0)
uniaxialMaterial ElasticPP *uniaxMaterialID *MatProp(Stiffness_K,real) *MatProp(Deformation_epsP,real) *MatProp(Deformation_epsN,real) *MatProp(Initial_deformation_eps0,real)
*else
uniaxialMaterial ElasticPP *uniaxMaterialID *MatProp(Moment_per_rotation_unit,real) *MatProp(Rotation_epsP,real) *MatProp(Rotation_epsN,real) *MatProp(Initial_rotation_eps0,real)
*endif
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlasticwithGap")==0)
*format "%d%g%g%g"
*if(strcmp(MatProp(Formulation),"Stress-Strain")==0)
uniaxialMaterial ElasticPPGap *uniaxMaterialID *MatProp(Elastic_modulus_E,real) *MatProp(Yield_Stress_Fy,real) *MatProp(Strain_gap,real)
*elseif(strcmp(MatProp(Formulation),"Force-Deformation")==0)
uniaxialMaterial ElasticPPGap *uniaxMaterialID *MatProp(Stiffness_K,real) *MatProp(Force_Fy,real) *MatProp(Deformation_gap,real)
*else
uniaxialMaterial ElasticPPGap *uniaxMaterialID *MatProp(Moment_per_rotation_unit,real) *MatProp(Moment_My,real) *MatProp(Rotation_gap,real)
*endif
*elseif(strcmp(MatProp(Material:),"Steel01")==0)
*format "%d%g%g%g"
*if(strcmp(MatProp(Formulation),"Stress-Strain")==0)
uniaxialMaterial Steel01 *uniaxMaterialID *MatProp(Yield_Stress_Fy,real) *MatProp(Initial_elastic_tangent_E0,real) *MatProp(Strain-hardening_ratio_b,real)
*elseif(strcmp(MatProp(Formulation),"Force-Deformation")==0)
uniaxialMaterial Steel01 *uniaxMaterialID *MatProp(Force_Fy,real) *MatProp(Initial_stiffness_K,real) *MatProp(Strain-hardening_ratio_b,real)
*else
uniaxialMaterial Steel01 *uniaxMaterialID *MatProp(Moment_My,real) *MatProp(Moment_per_rotation_unit,real) *MatProp(Strain-hardening_ratio_b,real)
*endif
*elseif(strcmp(MatProp(Material:),"Concrete01")==0)
*format "%d%g%g%g%g"
uniaxialMaterial Concrete01 *uniaxMaterialID *MatProp(Compressive_strength_fpc,real) *MatProp(Strain_at_maximum_strength_epsc0,real) *MatProp(Crushing_strength_fpcu,real) *MatProp(Strain_at_crushing_strength_epscU,real)
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*format "%d%g%g%g%g%g%g"
uniaxialMaterial Concrete02 *uniaxMaterialID *MatProp(Compressive_strength_fpc,real) *MatProp(Strain_at_maximum_strength_epsc0,real) *MatProp(Crushing_strength_fpcu,real) *MatProp(Strain_at_crushing_strength_epscU,real) *MatProp(ratio_between_unloading_slope_at_epscU_and_initial_slope_lamdba,real) *MatProp(Tensile_strength_Ft,real) *MatProp(Tension_softening_stiffness_Ets,real)
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*format "%d%g%g%g%g%g%g%g%g"
uniaxialMaterial Concrete06 *uniaxMaterialID *MatProp(Concrete_compressive_strength_fc,real) *MatProp(Strain_at_compressive_strength_e0,real) *MatProp(Compressive_shape_factor_n,real) *MatProp(Post-peak_compressive_shape_factor_k,real) *MatProp(Parameter_a1_for_compressive_plastic_strain_definition,real) *MatProp(Tensile_strength_fcr,real) *MatProp(Tensile_strain_at_peak_stress_ecr,real) *MatProp(Exponent_of_the_tension_stiffering_curve_b,real) *MatProp(Parameter_a2_for_tensile_plastic_strain_definition,real)
*endif
*endif
*end materials
*endif
*endif
*endfor
*if(Nuniax==0)
*MessageBox Error: Parallel uniaxialMaterial material without Uniaxial materials
*else
uniaxialMaterial *\
*if(strcmp(MatProp(Material:),"Parallel")==0)
Parallel *\
*else
Series *\
*endif
*MaterialID *\
*for(k=2;k<=10;k=k+2)
*if(MatProp(*k,int)==1)
*tcl(FindMaterialNumber *MatProp(*operation(k+1))) *\
*endif
*endfor

*endif
*#
*# ------------------- End of Series/Parallel Uniaxial Material Definition ---------------------
*#
*else
*MessageBox *MatProp(0) is not used for ZeroLength elements
*endif
*break
*endif
*end materials
*endif
*endif
*endfor
*endif
*end nodes

# ZeroLength Element Definition: element zeroLength $eleTag $iNode $jNode -mat $matTag1 $matTag2 ... -dir $dir1 $dir2 ...

*endif
*#set var ExtraElem=ExtraElem+1
*#set var ZeroLengthElemTag=operation(NumberOfElements+ExtraElem)
*set var ZeroLengthID=tcl(ZeroLengthIDnumber *i)
*set var ZLNodes=0
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*if(Cond(1,int)==ZeroLengthID)
*if(ZLNodes==0)
*set var ZeroLengthFirstNode=NodesNum
*endif
*set var ZLNodes=ZLNodes+1
*endif
*endif
*end nodes
*if(ZLNodes==1)
*MessageBox Error: ZeroLength Element with only 1 node. ZeroLength elements must be assigned to at least 2 nodes. Also check if you assigned ZeroLength between nodes with different dof. ZeroLength Element's nodes MUST have same dof.
*endif
*# Counting in how many directions current ZeroLength is active
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*if(Cond(1,int)==ZeroLengthID)
*for(ii=2;ii<=12;ii=ii+2)
*if(Cond(*ii,int)==1)
*set var ZLActiveDirections=operation(ZLActiveDirections+1)
*endif
*endfor
*endif
*endif
*end nodes
*if(ZLActiveDirections==0)
*MessageBox Error: Assigned ZeroLength Elements without Active Directions.
*endif
*# Defining the second NodeTag in case we assign the condition on more than 2 nodes
*for(k=1;k<=operation(ZLNodes-1);k=k+1)
*set var CountLoop=0
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*if(Cond(1,int)==ZeroLengthID)
*if(CountLoop==k)
*set var ExtraElem=ExtraElem+1
*set var ZeroLengthElemTag=operation(NumberOfElements+ExtraElem)
*set var ZeroLengthSecondNode=NodesNum
*endif
*set var CountLoop=CountLoop+1
*endif
*endif
*end nodes
*# Printing the ZeroLength Command
*format "%d%d%d"
element zeroLength *ZeroLengthElemTag *ZeroLengthFirstNode *ZeroLengthSecondNode *\
-mat *\
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*if(Cond(1,int)==ZeroLengthID)
*for(ii=2;ii<=12;ii=ii+2)
*if(Cond(*ii,int)==1)
*format "%d"
*tcl(FindMaterialNumber *Cond(*operation(ii+1)) ) *\
*endif
*endfor
*break
*endif
*endif
*end nodes
-dir *\
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*if(Cond(1,int)==ZeroLengthID)
*for(ii=2;ii<=12;ii=ii+2)
*if(Cond(*ii,int)==1)
*format "%d"
*operation(ii/2) *\
*endif
*endfor
*break
*endif
*endif
*end nodes

*endfor
*set var VarCount=operation(VarCount+1)
*endfor
*endif