*set var VarCount=1
*# EXTRA ELEMSNUM because it not an geometric element
*set var ExtraElem=0
*set var NumberOfElements=0
*set var IDExists=-1
*loop elems
*set var NumberOfElements=NumberOfElements+1
*end elems
*#--------------------------
*# We save the ID numbers (cond(1) ) on a List
*tcl(ClearZeroLengthLists )
*set var IDExists=-1
*set Cond ZeroLength *nodes
*loop nodes *OnlyInCond
*if(LoopVar!=1)
*set var IDExists=tcl(CheckZeroLengthID *Cond(1,int) )
*endif
*if(IDExists==-1)
*tcl(AddZeroLengthID *Cond(1,int) )
*endif
*end nodes
*set var HowManyZeroLengthID=tcl(HowManyZeroLengthID  )
*if(HowManyZeroLengthID>=1)
#
# Zero Length Elements
#

*#--------------------for every zeroLength ID do the following: ----------------------
*for(i=1;i<=HowManyZeroLengthID;i=i+1)
*#---------------------- DEFINING THE MATERIALS THAT ZeroLength ELEMENTS MAY USE-----------------------
*if(VarCount==1)
# Uniaxial materials that may be used by ZeroLength elements
*loop nodes *OnlyInCond
*for(k=3;k<=8;k=k+1)
*set var SelMatID=tcl(FindMaterialNumber *Cond(*k) )
*set var MaterialExists=tcl(CheckUsedMaterials *SelMatID )
*if(MaterialExists==-1)
*tcl(AddUsedMaterials *SelMatID )
*loop materials *NotUsed
*set Var MaterialID=tcl(FindMaterialNumber *MatProp(0) )
*if(MaterialID==SelMatID)
*if(strcmp(MatProp(1),"Elastic")==0)
uniaxialMaterial Elastic *MaterialID *MatProp(Elastic_modulus_E,real) 
*endif
*break
*endif
*end materials
*endif
*endfor
*end nodes

# ZeroLength Element Definition: element zeroLength $eleTag $iNode $jNode -mat $matTag1 $matTag2 ... -dir $dir1 $dir2 ...
*endif
*#--------------------------------------------
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
*#-----------------------Defining the second NodeTag in case we assign the condition on more than 2 nodes!-------------
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
*#-------------------------------
*#-----------------------Printing the ZeroLength Command-----------------
element zeroLength *ZeroLengthElemTag *ZeroLengthFirstNode *ZeroLengthSecondNode *\
*loop nodes *OnlyInCond
*if(Cond(1,int)==ZeroLengthID)
*set var HowManyDirectionsOfZeroLength=Cond(2,int)
*set var ZeroLengthMatTag1=tcl(FindMaterialNumber *Cond(3) )
*set var ZeroLengthMatTag2=tcl(FindMaterialNumber *Cond(4) )
*set var ZeroLengthMatTag3=tcl(FindMaterialNumber *Cond(5) )
*set var ZeroLengthMatTag4=tcl(FindMaterialNumber *Cond(6) )
*set var ZeroLengthMatTag5=tcl(FindMaterialNumber *Cond(7) )
*set var ZeroLengthMatTag6=tcl(FindMaterialNumber *Cond(8) )
*if(strcmp(Cond(10),"Translation_along_global_X")==0)
*set var ZeroLengthDir1=1
*elseif(strcmp(Cond(10),"Translation_along_global_Y")==0)
*set var ZeroLengthDir1=2
*elseif(strcmp(Cond(10),"Translation_along_global_Z")==0)
*set var ZeroLengthDir1=3
*elseif(strcmp(Cond(10),"Rotation_about_global_X")==0)
*set var ZeroLengthDir1=4
*elseif(strcmp(Cond(10),"Rotation_about_global_Y")==0)
*set var ZeroLengthDir1=5
*elseif(strcmp(Cond(10),"Rotation_about_global_Z")==0)
*set var ZeroLengthDir1=6
*endif
*if(strcmp(Cond(11),"Translation_along_global_X")==0)
*set var ZeroLengthDir2=1
*elseif(strcmp(Cond(11),"Translation_along_global_Y")==0)
*set var ZeroLengthDir2=2
*elseif(strcmp(Cond(11),"Translation_along_global_Z")==0)
*set var ZeroLengthDir2=3
*elseif(strcmp(Cond(11),"Rotation_about_global_X")==0)
*set var ZeroLengthDir2=4
*elseif(strcmp(Cond(11),"Rotation_about_global_Y")==0)
*set var ZeroLengthDir2=5
*elseif(strcmp(Cond(11),"Rotation_about_global_Z")==0)
*set var ZeroLengthDir2=6
*endif
*if(strcmp(Cond(12),"Translation_along_global_X")==0)
*set var ZeroLengthDir3=1
*elseif(strcmp(Cond(12),"Translation_along_global_Y")==0)
*set var ZeroLengthDir3=2
*elseif(strcmp(Cond(12),"Translation_along_global_Z")==0)
*set var ZeroLengthDir3=3
*elseif(strcmp(Cond(12),"Rotation_about_global_X")==0)
*set var ZeroLengthDir3=4
*elseif(strcmp(Cond(12),"Rotation_about_global_Y")==0)
*set var ZeroLengthDir3=5
*elseif(strcmp(Cond(12),"Rotation_about_global_Z")==0)
*set var ZeroLengthDir3=6
*endif
*if(strcmp(Cond(13),"Translation_along_global_X")==0)
*set var ZeroLengthDir4=1
*elseif(strcmp(Cond(13),"Translation_along_global_Y")==0)
*set var ZeroLengthDir4=2
*elseif(strcmp(Cond(13),"Translation_along_global_Z")==0)
*set var ZeroLengthDir4=3
*elseif(strcmp(Cond(13),"Rotation_about_global_X")==0)
*set var ZeroLengthDir4=4
*elseif(strcmp(Cond(13),"Rotation_about_global_Y")==0)
*set var ZeroLengthDir4=5
*elseif(strcmp(Cond(13),"Rotation_about_global_Z")==0)
*set var ZeroLengthDir4=6
*endif
*if(strcmp(Cond(14),"Translation_along_global_X")==0)
*set var ZeroLengthDir5=1
*elseif(strcmp(Cond(14),"Translation_along_global_Y")==0)
*set var ZeroLengthDir5=2
*elseif(strcmp(Cond(14),"Translation_along_global_Z")==0)
*set var ZeroLengthDir5=3
*elseif(strcmp(Cond(14),"Rotation_about_global_X")==0)
*set var ZeroLengthDir5=4
*elseif(strcmp(Cond(14),"Rotation_about_global_Y")==0)
*set var ZeroLengthDir5=5
*elseif(strcmp(Cond(14),"Rotation_about_global_Z")==0)
*set var ZeroLengthDir5=6
*endif
*if(strcmp(Cond(15),"Translation_along_global_X")==0)
*set var ZeroLengthDir6=1
*elseif(strcmp(Cond(15),"Translation_along_global_Y")==0)
*set var ZeroLengthDir6=2
*elseif(strcmp(Cond(15),"Translation_along_global_Z")==0)
*set var ZeroLengthDir6=3
*elseif(strcmp(Cond(15),"Rotation_about_global_X")==0)
*set var ZeroLengthDir6=4
*elseif(strcmp(Cond(15),"Rotation_about_global_Y")==0)
*set var ZeroLengthDir6=5
*elseif(strcmp(Cond(15),"Rotation_about_global_Z")==0)
*set var ZeroLengthDir6=6
*endif
*endif
*break
*end nodes
*if(HowManyDirectionsOfZeroLength==1)
-mat *ZeroLengthMatTag1 *\
-dir *ZeroLengthDir1
*elseif(HowManyDirectionsOfZeroLength==2)
-mat *ZeroLengthMatTag1 *ZeroLengthMatTag2 *\
-dir *ZeroLengthDir1 *ZeroLengthDir2 
*elseif(HowManyDirectionsOfZeroLength==3)
-mat *ZeroLengthMatTag1 *ZeroLengthMatTag2 *ZeroLengthMatTag3 *\
-dir *ZeroLengthDir1 *ZeroLengthDir2 *ZeroLengthDir3
*elseif(HowManyDirectionsOfZeroLength==4)
-mat *ZeroLengthMatTag1 *ZeroLengthMatTag2 *ZeroLengthMatTag3 *ZeroLengthMatTag4 *\
-dir *ZeroLengthDir1 *ZeroLengthDir2 *ZeroLengthDir3 *ZeroLengthDir4
*elseif(HowManyDirectionsOfZeroLength==5)
-mat *ZeroLengthMatTag1 *ZeroLengthMatTag2 *ZeroLengthMatTag3 *ZeroLengthMatTag4 *ZeroLengthMatTag5 *\
-dir *ZeroLengthDir1 *ZeroLengthDir2 *ZeroLengthDir3 *ZeroLengthDir4 *ZeroLengthDir5
*elseif(HowManyDirectionsOfZeroLength==6)
-mat *ZeroLengthMatTag1 *ZeroLengthMatTag2 *ZeroLengthMatTag3 *ZeroLengthMatTag4 *ZeroLengthMatTag5 *ZeroLengthMatTag6 *\
-dir *ZeroLengthDir1 *ZeroLengthDir2 *ZeroLengthDir3 *ZeroLengthDir4 *ZeroLengthDir5 *ZeroLengthDir6
*endif
*endfor
*endfor
*endif