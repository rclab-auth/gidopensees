*set var VarCount=1
*# EXTRA ELEMSNUM because it not a geometric element
*set var ExtraElem=0
*set var NumberOfElements=0
*set var IDExists=-1
*loop elems
*set var NumberOfElements=NumberOfElements+1
*end elems
*# We save the ID numbers (cond) on a list
*set var dummy=tcl(ClearZeroLengthLists )
*set var IDExists=-1
*set cond Point_ZeroLength *nodes
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*if(LoopVar!=1)
*set var IDExists=tcl(CheckZeroLengthID *Cond(1))
*endif
*if(IDExists==-1)
*set var dummy=tcl(AddZeroLengthID *Cond(1))
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
# Uniaxial materials definition used by ZeroLength elements
# (if they have not already been defined on this model domain)

*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*for(ii=2;ii<=12;ii=ii+2)
*if(Cond(*ii,int)==1)
*set var SelMatID=tcl(FindMaterialNumber *Cond(*operation(ii+1)) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelMatID )
*if(MaterialExists==-1)
*set var dummy=tcl(AddUsedMaterials *SelMatID)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(MaterialID==SelMatID)
*if(strcmp(MatProp(Material:),"Elastic")==0)
*include ..\..\Materials\Uniaxial\Elastic.bas
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlastic")==0)
*include ..\..\Materials\Uniaxial\ElasticPP.bas
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlasticwithGap")==0)
*include ..\..\Materials\Uniaxial\ElasticPPwithGap.bas
*elseif(strcmp(MatProp(Material:),"Steel01")==0)
*include ..\..\Materials\Uniaxial\Steel01.bas
*elseif(strcmp(MatProp(Material:),"Steel02")==0)
*include ..\..\Materials\Uniaxial\Steel02.bas
*elseif(strcmp(MatProp(Material:),"Concrete01")==0)
*include ..\..\Materials\Uniaxial\Concrete01.bas
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*include ..\..\Materials\Uniaxial\Concrete02.bas
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*include ..\..\Materials\Uniaxial\Concrete06.bas
*elseif(strcmp(MatProp(Material:),"ConcreteCM")==0)
*include ..\..\Materials\Uniaxial\ConcreteCM.bas
*elseif(strcmp(MatProp(Material:),"Viscous")==0)
*include ..\..\Materials\Uniaxial\Viscous.bas
*elseif(strcmp(MatProp(Material:),"ViscousDamper")==0)
*include ..\..\Materials\Uniaxial\ViscousDamper.bas
*elseif(strcmp(MatProp(Material:),"InitStrain")==0)
*include ..\..\Materials\Uniaxial\InitialStrain.bas
*elseif(strcmp(MatProp(Material:),"InitStress")==0)
*include ..\..\Materials\Uniaxial\InitialStress.bas
*elseif(strcmp(MatProp(Material:),"HyperbolicGap")==0)
*include ..\..\Materials\Uniaxial\HyperbolicGap.bas
*elseif(strcmp(MatProp(Material:),"PySimple1")==0)
*include ..\..\Materials\Uniaxial\PySimple1.bas
*elseif(strcmp(MatProp(Material:),"TzSimple1")==0)
*include ..\..\Materials\Uniaxial\TzSimple1.bas
*elseif(strcmp(MatProp(Material:),"QzSimple1")==0)
*include ..\..\Materials\Uniaxial\QzSimple1.bas
*elseif(strcmp(MatProp(Material:),"BondSP01")==0)
*include ..\..\Materials\Uniaxial\BondSP01.bas
*#
*# ------------------- Start of Series/Parallel Uniaxial Material Definition ---------------------
*#
*elseif(strcmp(MatProp(Material:),"Parallel")==0 || strcmp(MatProp(Material:),"Series")==0)
*include ..\..\Materials\Uniaxial\SeriesParallel.bas
*elseif(strcmp(MatProp(Material:),"Hysteretic")==0)
*include ..\..\Materials\Uniaxial\Hysteretic.bas
*else
*MessageBox Invalid uniaxial materials used for ZeroLength element.
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
*#set var ZeroLengthID=tcl(ZeroLengthIDnumber *i)
*set var ZLNodes=0
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*set var CorrectID=tcl(IsThisZeroLengthID *Cond(1) *i)
*if(CorrectID==1)
*if(ZLNodes==0)
*set var ZeroLengthFirstNode=NodesNum
*endif
*set var ZLNodes=ZLNodes+1
*endif
*endif
*end nodes
*if(ZLNodes==1)
*MessageBox Error: ZeroLength Element with only 1 node. ZeroLength elements must be assigned to at least 2 nodes. Also check if you have assigned ZeroLength between nodes with different DOFs. ZeroLength Element's nodes MUST have the same number of DOFs.
*endif
*# Counting in how many directions current ZeroLength is active
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*set var CorrectID=tcl(IsThisZeroLengthID *Cond(1) *i)
*if(CorrectID==1)
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
*set var CorrectID=tcl(IsThisZeroLengthID *Cond(1) *i)
*if(CorrectID==1)
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
*format "%6d%6d%6d"
element zeroLength *ZeroLengthElemTag *ZeroLengthFirstNode *ZeroLengthSecondNode *\
-mat *\
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*set var CorrectID=tcl(IsThisZeroLengthID *Cond(1) *i)
*if(CorrectID==1)
*for(ii=2;ii<=12;ii=ii+2)
*if(Cond(*ii,int)==1)
*format "%6d"
*tcl(FindMaterialNumber *Cond(*operation(ii+1)) *DomainNum) *\
*endif
*endfor
*break
*endif
*endif
*end nodes
-dir*\
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if(nodeDOF==currentDOF)
*set var CorrectID=tcl(IsThisZeroLengthID *Cond(1) *i)
*if(CorrectID==1)
*for(ii=2;ii<=12;ii=ii+2)
*if(Cond(*ii,int)==1)
*format "%d"
 *operation(ii/2)*\
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