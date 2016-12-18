*#----------------------------------------------------------------
*#------------------ Corotational Truss Elements------------------
*#----------------------------------------------------------------
*# variable to count Corotational Truss elements
*set var cntCorotTruss=0
*loop elems 
*if(strcmp(ElemsMatProp(Element_type:),"CorotationalTruss")==0)
*set var cntCorotTruss=operation(cntCorotTruss+1)
*endif
*end elems
*if(cntCorotTruss!=0)

# --------------------------------------------------------------------------------------------------------------
# C O R O T A T I O N A L   T R U S S   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

*set var VarCount=1
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"CorotationalTruss")==0)
*if(VarCount==1)
*set var file=2
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
*if(strcmp(MatProp(1),"Elastic")==0)
uniaxialMaterial Elastic *MaterialID *MatProp(Elastic_modulus_E,real)
*elseif(strcmp(MatProp(1),"ElasticPerfectlyPlastic")==0)
uniaxialMaterial ElasticPP *\
*format "%d"
*MaterialID *\
*set var E=MatProp(Elastic_modulus_E,real)
*format "%g"
*E *\
*set var epsyP=MatProp(Strain_epsP,real)
*set var epsyN=MatProp(Strain_epsN,real)
*set var eps0=MatProp(Initial_strain_eps0,real)
*format "%g%g%g"
*epsyP *epsyN *eps0
*elseif(strcmp(MatProp(1),"Steel01")==0)
*format "%d"
uniaxialMaterial Steel01 *MaterialID *\
*set var Fy=MatProp(Yield_Stress_Fy,real)
*set var E0=MatProp(Initial_elastic_tangent_E0,real)
*set var b=MatProp(Strain-hardening_ratio_b,real)
*format "%g%g%g"
*Fy *E0 *b
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlasticwithGap")==0)
*format "%d%g%g%g"
uniaxialMaterial ElasticPPGap *MaterialID *MatProp(Elastic_modulus_E,real) *MatProp(Yield_Stress_Fy,real) *MatProp(Gap,real)
*endif
*break
*endif
*end materials
*endif
*endif
*end materials

# Corotational Truss Definition : element corotTruss $eleTag $iNode $jNode $A $matTag <-rho $rho> <-cMass $cFlag> <-doRayleigh $rFlag>
*set var VarCount=operation(VarCount+1)

*endif
*#
*#-------------Section Properties--------------------
*if(strcmp(elemsMatProp(Cross_Section),"Rectangular")==0)
*set var height=ElemsMatProp(Height_H,real)
*set var width=ElemsMatProp(Width_B,real)
*set var A=operation(height*width)
*elseif(strcmp(elemsMatProp(Cross_Section),"Tee")==0)
*set var height=elemsMatProp(Height_H,real)
*set var Bf=elemsMatProp(Width_Bf,real)
*set var tf=elemsMatProp(Height_Hf,real)
*set var tw=elemsMatProp(Width_Bw,real)
*set var A=operation(Bf*tf+(height-tf)*tw)
*elseif(strcmp(elemsMatProp(Cross_Section),"Circular")==0)
*set var D=elemsMatProp(Diameter_D,real)
*set var A=operation(3.14*D*D/4)
*elseif(strcmp(elemsMatProp(Cross_Section),"General")==0)
*set var A=ElemsMatProp(Area_A,real)
*endif
*set var MassDens=ElemsMatProp(Mass_density,real)
*set var MassPerLength=operation(A*MassDens)
*# Cross Section Area Modification Factor
*if(ElemsMatProp(Set_Modification_Factors,int)==1)
*set var Amod=ElemsMatProp(mod._A,real)
*set var A=operation(A*Amod)
*endif
*#--------------------------------------------
*format "%6d%6d%6d"
element corotTruss *ElemsNum *elemsConec *\
*format "%8.3f"
*A *tcl(FindMaterialNumber *ElemsMatProp(Material) )   -rho *\
*format "%8.3f"
*MassPerLength
*endif
*end elems
*endif