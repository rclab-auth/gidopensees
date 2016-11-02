*set var VarCount=1
*# EXTRA ELEMSNUM because it not a geometric element
*set var ExtraElem=0
*set var NumberOfElements=0
*set var IDExists=-1
*loop elems
*set var NumberOfElements=NumberOfElements+1
*end elems
*#--------------------------
*# We save the ID numbers (cond(1) ) on a List
*set var dummy=tcl(ClearZeroLengthLists )
*set var IDExists=-1
*set Cond ZeroLength *nodes
*loop nodes *OnlyInCond
*if(LoopVar!=1)
*set var IDExists=tcl(CheckZeroLengthID *Cond(1,int))
*endif
*if(IDExists==-1)
*set var dummy=tcl(AddZeroLengthID *Cond(1,int))
*endif
*end nodes
*set var HowManyZeroLengthID=tcl(HowManyZeroLengthID)
*if(HowManyZeroLengthID>=1)

# --------------------------------------------------------------------------------------------------------------
# Z E R O   L E N G T H   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

*#--------------------for every zeroLength ID do the following: ----------------------
*for(i=1;i<=HowManyZeroLengthID;i=i+1)
*#---------------------- DEFINING THE MATERIALS THAT ZeroLength ELEMENTS MAY USE-----------------------
*set var ZLActiveDirections=0
*if(VarCount==1)
# Uniaxial materials used by ZeroLength elements

*loop nodes *OnlyInCond
*for(j=2;j<=12;j=j+2)
*if(Cond(*j,int)==1)
*set var SelMatID=tcl(FindMaterialNumber *Cond(*operation(j+1)) )
*set var MaterialExists=tcl(CheckUsedMaterials *SelMatID )
*if(MaterialExists==-1)
*set var dummy=tcl(AddUsedMaterials *SelMatID)
*loop materials *NotUsed
*set Var MaterialID=tcl(FindMaterialNumber *MatProp(0) )
*if(MaterialID==SelMatID)
*if(strcmp(MatProp(Material:),"Elastic")==0)
*format "%d%g"
uniaxialMaterial Elastic *MaterialID *MatProp(Elastic_modulus_E,real) 
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlastic")==0)
*format "%d%g"
uniaxialMaterial ElasticPP *MaterialID *MatProp(Elastic_modulus_E,real) *\
*set var epsyP=MatProp(Strain_epsP,real)
*set var epsyN=MatProp(Strain_epsN,real)
*set var eps0=MatProp(Initial_strain_eps0,real)
*format "%g%g%g"
*epsyP *epsyN *eps0
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlasticwithGap")==0)
*format "%d%g%g%g"
uniaxialMaterial ElasticPPGap *MaterialID *MatProp(Elastic_modulus_E,real) *MatProp(Yield_Stress_Fy,real) *MatProp(Gap,real)
*elseif(strcmp(MatProp(Material:),"Steel01")==0)
*format "%d"
uniaxialMaterial Steel01 *MaterialID *\
*set var Fy=MatProp(Yield_Stress_Fy,real)
*set var E0=MatProp(Initial_elastic_tangent_E0,real)
*set var b=MatProp(Strain-hardening_ratio_b,real)
*format "%g%g%g"
*Fy *E0 *b
*elseif(strcmp(MatProp(Material:),"Concrete01")==0)
*format "%d%g%g%g%g"
uniaxialMaterial Concrete01 *MaterialID *MatProp(Compressive_strength_fpc,real) *MatProp(Strain_at_maximum_strength_epsc0,real) *MatProp(Crushing_strength_fpcu,real) *MatProp(Strain_at_crushing_strength_epscU,real)
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*format "%d%g%g%g%g%g%g"
uniaxialMaterial Concrete02 *MaterialID *MatProp(Compressive_strength_fpc,real) *MatProp(Strain_at_maximum_strength_epsc0,real) *MatProp(Crushing_strength_fpcu,real) *MatProp(Strain_at_crushing_strength_epscU,real) *MatProp(ratio_between_unloading_slope_at_epscU_and_initial_slope_lamdba,real) *MatProp(Tensile_strength_Ft,real) *MatProp(Tension_softening_stiffness_Ets,real)
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*format "%d%g%g%g%g%g%g%g%g"
uniaxialMaterial Concrete06 *MaterialID *MatProp(Concrete_compressive_strength_fc,real) *MatProp(Strain_at_compressive_strength_e0,real) *MatProp(Compressive_shape_factor_n,real) *MatProp(Post-peak_compressive_shape_factor_k,real) *MatProp(Parameter_a1_for_compressive_plastic_strain_definition,real) *MatProp(Tensile_strength_fcr,real) *MatProp(Tensile_strain_at_peak_stress_ecr,real) *MatProp(Exponent_of_the_tension_stiffering_curve_b,real) *MatProp(Parameter_a2_for_tensile_plastic_strain_definition,real)
*else
*MessageBox *MatProp(0) is not ready for ZeroLength elements
*endif
*break
*endif
*end materials
*endif
*endif
*endfor
*end nodes

# ZeroLength Element Definition: element zeroLength $eleTag $iNode $jNode -mat $matTag1 $matTag2 ... -dir $dir1 $dir2 ...

*endif
*#set var ExtraElem=ExtraElem+1
*#set var ZeroLengthElemTag=operation(NumberOfElements+ExtraElem)
*set var ZeroLengthID=tcl(ZeroLengthIDnumber *i)
*set var ZLNodes=0
*loop nodes *OnlyInCond
*if(Cond(1,int)==ZeroLengthID)
*if(ZLNodes==0)
*set var ZeroLengthFirstNode=NodesNum
*endif
*set var ZLNodes=ZLNodes+1
*endif
*end nodes
*# Counting in how many directions current ZeroLength is active
*loop nodes *OnlyInCond
*if(Cond(1,int)==ZeroLengthID)
*for(j=2;j<=12;j=j+2)
*if(Cond(*j,int)==1)
*set var ZLActiveDirections=operation(ZLActiveDirections+1)
*endif
*endfor
*endif
*end nodes
*if(ZLActiveDirections==0)
*MessageBox Error: Assigned ZeroLength Elements without Active Directions.
*endif
*# Defining the second NodeTag in case we assign the condition on more than 2 nodes
*for(k=1;k<=operation(ZLNodes-1);k=k+1)
*set var CountLoop=0
*loop nodes *OnlyInCond
*if(Cond(1,int)==ZeroLengthID)
*if(CountLoop==k)
*set var ExtraElem=ExtraElem+1
*set var ZeroLengthElemTag=operation(NumberOfElements+ExtraElem)
*set var ZeroLengthSecondNode=NodesNum
*endif
*set var CountLoop=CountLoop+1
*endif
*end nodes
*# Printing the ZeroLength Command
*format "%d%d%d"
element zeroLength *ZeroLengthElemTag *ZeroLengthFirstNode *ZeroLengthSecondNode *\
-mat *\
*loop nodes *OnlyInCond
*if(Cond(1,int)==ZeroLengthID)
*for(j=2;j<=12;j=j+2)
*if(Cond(*j,int)==1)
*format "%d"
*tcl(FindMaterialNumber *Cond(*operation(j+1)) ) *\
*endif
*endfor
*break
*endif
*end nodes
-dir *\
*loop nodes *OnlyInCond
*if(Cond(1,int)==ZeroLengthID)
*for(j=2;j<=12;j=j+2)
*if(Cond(*j,int)==1)
*format "%d"
*operation(j/2) *\
*endif
*endfor
*break
*endif
*end nodes
*endfor
*set var VarCount=operation(VarCount+1)
*endfor
*endif