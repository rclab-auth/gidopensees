*#----------------------------------------------------
*#------------------  Truss Elements------------------
*#----------------------------------------------------
*# variable to count Truss elements
*set var cntcurrTruss=0
*loop elems *OnlyInGroup
*if(strcmp(ElemsMatProp(Element_type:),"Truss")==0)
*set var cntTruss=operation(cntTruss+1)
*set var cntcurrTruss=operation(cntcurrTruss+1)
*endif
*end elems
*if(cntcurrTruss!=0)

# --------------------------------------------------------------------------------------------------------------
# T R U S S   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

*set var VarCount=1
*if((ndime==2 && currentDOF==2) || (ndime==3 && currentDOF==3))
*loop elems *OnlyInGroup
*if(strcmp(ElemsMatProp(Element_type:),"Truss")==0)
*if(VarCount==1)
# Uniaxial Materials definition used by Truss Elements. (Only if they have not been already defined on this model domain)

*loop materials
*if(strcmp(MatProp(Element_type:),"Truss")==0)
*# We set the variable SelectedMaterial the IDnumber of the material that user choosed from the Material field , in the element that he/she assigned!
*set var SelectedMaterial=tcl(FindMaterialNumber *MatProp(Material) )
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedMaterial)
*if(MaterialExists==-1)
*loop materials *NotUsed
*# We set the variable MaterialID the IDnumber of each material(NotUsed) and we check which is the material that user choosed in Material field in element definition.
*set var MaterialID=tcl(FindMaterialNumber *MatProp(0) )
*#we check which is the material that user choosed in Material field in element definition.
*if(MaterialID==SelectedMaterial)
*set var dummy=tcl(AddUsedMaterials *SelectedMaterial)
*if(strcmp(MatProp(Material:),"Elastic")==0)
*include ..\..\Materials\Uniaxial\Elastic.bas
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlastic")==0)
*include ..\..\Materials\Uniaxial\ElasticPP.bas
*elseif(strcmp(MatProp(Material:),"Steel01")==0)
*include ..\..\Materials\Uniaxial\Steel01.bas
*elseif(strcmp(MatProp(Material:),"Steel02")==0)
*include ..\..\Materials\Uniaxial\Steel02.bas
*elseif(strcmp(MatProp(Material:),"ReinforcingSteel")==0)
*include ..\..\Materials\Uniaxial\ReinforcingSteel.bas
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlasticwithGap")==0)
*include ..\..\Materials\Uniaxial\ElasticPPwithGap.bas
*elseif(strcmp(MatProp(Material:),"Viscous")==0)
*include ..\..\Materials\Uniaxial\Viscous.bas
*elseif(strcmp(MatProp(Material:),"ViscousDamper")==0)
*include ..\..\Materials\Uniaxial\ViscousDamper.bas
*elseif(strcmp(MatProp(Material:),"Hysteretic")==0)
*include ..\..\Materials\Uniaxial\Hysteretic.bas
*elseif(strcmp(MatProp(Material:),"InitStrain")==0)
*include ..\..\Materials\Uniaxial\InitialStrain.bas
*elseif(strcmp(MatProp(Material:),"InitStress")==0)
*include ..\..\Materials\Uniaxial\InitialStress.bas
*elseif(strcmp(MatProp(Material:),"HyperbolicGap")==0)
*include ..\..\Materials\Uniaxial\HyperbolicGap.bas
*elseif(strcmp(MatProp(Material:),"Parallel")==0 || strcmp(MatProp(Material:),"Series")==0)
*include ..\..\Materials\Uniaxial\SeriesParallel.bas
*else
*MessageBox Error: Invalid uniaxial material selected for truss element
*endif
*break
*endif
*end materials
*endif
*endif
*end materials

# Truss Definition : element truss $eleTag $inode $jnode $A $matTag -rho $rho -cMass $cFlag -doRayleigh $rFlag
*set var VarCount=operation(VarCount+1)

*endif
*#
*#-------------Section Properties--------------------
*#
*if(strcmp(elemsMatProp(Cross_section),"Rectangular")==0)
*set var height=ElemsMatProp(Height_H,real)
*set var width=ElemsMatProp(Width_B,real)
*set var A=operation(height*width)
*elseif(strcmp(elemsMatProp(Cross_section),"Tee")==0)
*set var height=elemsMatProp(Height_H,real)
*set var Bf=elemsMatProp(Width_Bf,real)
*set var tf=elemsMatProp(Height_Hf,real)
*set var tw=elemsMatProp(Width_Bw,real)
*set var A=operation(Bf*tf+(height-tf)*tw)
*elseif(strcmp(elemsMatProp(Cross_section),"Circular")==0)
*set var D=elemsMatProp(Diameter_D,real)
*set var A=operation(3.14*D*D/4)
*elseif(strcmp(elemsMatProp(Cross_section),"General")==0)
*set var A=ElemsMatProp(Area_A,real)
*endif
*set var MassDens=ElemsMatProp(Mass_density,real)
*set var MassPerLength=operation(A*MassDens)
*# Cross Section Area Modification Factor
*if(ElemsMatProp(Set_modification_factors,int)==1)
*set var Amod=ElemsMatProp(mod._A,real)
*set var A=operation(A*Amod)
*endif
*#--------------------------------------------
*format "%6d%6d%6d"
element truss *ElemsNum *elemsConec *\
*format "%8.3f"
*A *tcl(FindMaterialNumber *ElemsMatProp(Material) )   -rho *\
*format "%8.3f%d%d"
*MassPerLength -cMass *ElemsMatProp(Consider_consistent_mass_matrix,int) -doRayleigh *ElemsMatProp(Include_Rayleigh_damping,int)
*endif
*end elems
*endif
*endif