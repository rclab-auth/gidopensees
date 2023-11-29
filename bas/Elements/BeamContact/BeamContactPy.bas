*set var dummy=tcl(ClearBeamContactLists )
*set var IDexists =-1
*set cond Line_Beam_contact_master_end_nodes *elems *CanRepeat
*loop elems *OnlyInCond
*if(LoopVar!=1)
*set var IDExists=tcl(CheckIDInBeamContactList *Cond(1))
*endif
*if(IDExists==-1)
*set var nodeDOF=tcl(ReturnNodeGroupDOF *ElemsConec(1))
*if((ndime == 2 && nodeDOF == 3) || (ndime == 3 && nodeDOF == 6))
*set var dummy=tcl(AddToBeamContactIDList *Cond(1) )
*endif
*endif
*end elems
*set var numberOfBeamContactIDs=tcl(GetNumberOfBeamContacts)
*if(numberOfBeamContactIDs>=1)

# --------------------------------------------------------------------------------------------------------------
# B E A M  C O N T A C T S
# --------------------------------------------------------------------------------------------------------------

# Beam Contact 2D elements Definition : element BeamContact2D $eleTag $iNode $jNode $sNode $lNode $matTag $width $gTol $fTol <$cFlag$>
# Beam Contact 3D elements Definition : element BeamContact3D $eleTag $iNode $jNode $sNode $lNode $radius $crdTransf $matTag $gTol $fTol <$cFlag$>

*for(i=1;i<=numberOfBeamContactIDs;i=i+1)
*if(VarCount==1)
# nD materials definition used by Beam Contact elements
# (if they have not already been defined on this model domain)

*set cond Point_Beam_contact_slave_nodes
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if((ndime == 2 && nodeDOF == 2) || (ndime == 3 && nodeDOF == 3))
*set var SelMatID=tcl(FindMaterialNumber *cond(2) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelMatID )
*if(MaterialExists==-1)
*set var dummy=tcl(AddUsedMaterials *SelMatID)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(MaterialID==SelMatID)
*if(strcmp(MatProp(Material:),"Contact")==0)
*include ..\..\Materials\nD\ContactPy.bas
*else
*MessageBox Invalid nDmaterial used for Beam Contact element.
*endif
*break
*endif
*end materials
*endif
*endif
*end nodes
*if(ndime==3)
ops.model('BasicBuilder', '-ndm', 3, '-ndf', 3)
*else
ops.model('BasicBuilder', '-ndm', 2, '-ndf', 2)
*endif
*endif

*set var dummy=tcl(RestartBeamContactSlaveNodes)
*set cond Line_Beam_contact_master_end_nodes *elems *CanRepeat
*loop elems *OnlyInCond
*set var CorrectID=tcl(IsThisBeamContactID *Cond(1) *i)
*if(CorrectID==1)
*# For each linear element, its end-nodes are the master nodes for the beam contact element
*set var MasterLine=ElemsNum
*set var MasterNode1=ElemsConec(1)
*set var MasterNode2=ElemsConec(2)
*set var nodeDOF=tcl(ReturnNodeGroupDOF *MasterNode1)
*if((ndime == 2 && nodeDOF == 3) || (ndime == 3 && nodeDOF == 6))
*break
*endif
*endif
*end elems
*set cond Point_Beam_contact_slave_nodes *nodes
*loop nodes *OnlyInCond
*set var nodeDOF=tcl(ReturnNodeGroupDOF *NodesNum)
*if((ndime == 2 && nodeDOF == 2) || (ndime == 3 && nodeDOF == 3))
*set var CorrectID=tcl(IsThisBeamContactID *Cond(1) *i)
*if(CorrectID==1)
*set var SlaveNode=NodesNum
*set var SlaveNodeExists=tcl(CheckBeamContactSlaveNodes *SlaveNode)
*if(SlaveNodeExists==-1 && SlaveNode!=MasterNode1 && SlaveNode!=MasterNode2)
*set var dummy=tcl(AddToBeamContactSlaveNodeList *SlaveNode)
*set var ExtraElem=ExtraElem+1
*set var BeamContactTag=operation(NumberOfElements+ExtraElem)
*set var dummy=tcl(AddToBeamContactOpenSeesTagList *BeamContactTag)
*set var LagrangeNodeTag=tcl(GetLagrangeNodeTag *MasterLine *SlaveNode)
*if(ndime==3)
ops.node('*LagrangeNodeTag', *tcl(GetLagrangeNodeXCoord *MasterLine), *tcl(GetLagrangeNodeYCoord *MasterLine), *tcl(GetLagrangeNodeZCoord *MasterLine)) #Lagrange node
*format "%d%d%d%d%d%g%g%g"
ops.element('BeamContact3D', *BeamContactTag, *MasterNode1, *MasterNode2, *SlaveNode, *LagrangeNodeTag, *tcl(FindMaterialNumber *cond(2) *DomainNum), *cond(3,real), *cond(4,real), *cond(5,real), *\
*else
ops.node(*LagrangeNodeTag, *tcl(GetLagrangeNodeXCoord *MasterLine), *tcl(GetLagrangeNodeYCoord *MasterLine)) #Lagrange node
*format "%d%d%d%d%d%g%g%g"
ops.element('BeamContact2D', *BeamContactTag, *MasterNode1, *MasterNode2, *SlaveNode, *LagrangeNodeTag, *tcl(FindMaterialNumber *cond(2) *DomainNum), *cond(3,real), *cond(4,real), *cond(5,real), *\
*endif
*format "%d"
*if(strcmp(cond(6),"Contact")==0)
0)
*else
1)
*endif
ops.setParameter('-value', 0, '-ele', *BeamContactTag, friction)
*endif
*endif
*endif
*end nodes
*endfor
*endif