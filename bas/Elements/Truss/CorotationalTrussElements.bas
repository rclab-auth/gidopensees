*#----------------------------------------------------------------
*#------------------ Corotational Truss Elements------------------
*#----------------------------------------------------------------
*# variable to count Corotational Truss elements
*set var cntcurrCorotTruss=0
*loop elems *OnlyInGroup
*if(strcmp(ElemsMatProp(Element_type:),"CorotationalTruss")==0)
*set var cntCorotTruss=operation(cntCorotTruss+1)
*set var cntcurrCorotTruss=operation(cntcurrCorotTruss+1)
*endif
*end elems
*if(cntcurrCorotTruss!=0)

# --------------------------------------------------------------------------------------------------------------
# C O R O T A T I O N A L   T R U S S   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

*set var VarCount=1
*if((ndime==2 && currentDOF==2) || (ndime==3 && currentDOF==3))
*loop elems *OnlyInGroup
*if(strcmp(ElemsMatProp(Element_type:),"CorotationalTruss")==0)
*if(VarCount==1)
# Uniaxial Materials definition

*loop materials
*if(strcmp(MatProp(Element_type:),"CorotationalTruss")==0)
*# We set the variable SelectedMaterial the IDnumber of the material that user choosed from the Material field , in the element that he/she assigned!
*set Var SelectedMaterial=tcl(FindMaterialNumber *MatProp(Material) )
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedMaterial)
*if(MaterialExists==-1)
*set var dummy=tcl(AddUsedMaterials *SelectedMaterial)
*loop materials *NotUsed
*# We set the variable MaterialID the IDnumber of each material(NotUsed) and we check which is the material that user choosed in Material field in element definition.
*set var MaterialID=tcl(FindMaterialNumber *MatProp(0) )
*#we check which is the material that user choosed in Material field in element definition.
*if(MaterialID==SelectedMaterial)
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
*elseif(strcmp(MatProp(Material:),"Steel01")==0)
*format "%d%g%g%g"
*if(strcmp(MatProp(Formulation),"Stress-Strain")==0)
uniaxialMaterial Steel01 *MaterialID *MatProp(Yield_Stress_Fy,real) *MatProp(Initial_elastic_tangent_E0,real) *MatProp(Strain-hardening_ratio_b,real)
*elseif(strcmp(MatProp(Formulation),"Force-Deformation")==0)
uniaxialMaterial Steel01 *MaterialID *MatProp(Force_Fy,real) *MatProp(Initial_stiffness_K,real) *MatProp(Strain-hardening_ratio_b,real)
*else
uniaxialMaterial Steel01 *MaterialID *MatProp(Moment_My,real) *MatProp(Moment_per_rotation_unit,real) *MatProp(Strain-hardening_ratio_b,real)
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
*elseif(strcmp(MatProp(Material:),"Viscous")==0)
*format "%d%g%g"
uniaxialMaterial Viscous &MaterialID *MatProp(Damping_coefficient,real) *MatProp(Power_factor,real)
*endif
*break
*endif
*end materials
*endif
*endif
*end materials
# Corotational Truss Definition : element corotTruss $eleTag $iNode $jNode $A $matTag -rho $rho -cMass $cFlag -doRayleigh $rFlag
*set var VarCount=operation(VarCount+1)

*endif
*#
*#-------------Section Properties--------------------
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
element corotTruss *ElemsNum *elemsConec *\
*format "%8.3f"
*A *tcl(FindMaterialNumber *ElemsMatProp(Material) )   -rho *\
*format "%8.3f%d%d"
*MassPerLength -cMass *ElemsMatProp(Consider_consistent_mass_matrix,int) -doRayleigh *ElemsMatProp(Include_Rayleigh_damping,int)
*endif
*end elems
*endif
*endif