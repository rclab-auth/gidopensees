*#----------------------------------------------------
*#------------------  Truss Elements------------------
*#----------------------------------------------------
*# variable to count Truss elements
*set var cntTruss=0
*loop elems 
*if(strcmp(ElemsMatProp(Element_type:),"Truss")==0)
*set var cntTruss=operation(cntTruss+1)
*endif
*end elems
*if(cntTruss!=0)

# --------------------------------------------------------------------------------------------------------------
# T R U S S   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

*Set Var VarCount=1
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Truss")==0)
*if(VarCount==1)
*set var file=2
# Uniaxial Materials Definition

*loop materials
*if(strcmp(MatProp(Element_type:),"Truss")==0)
*# We set the variable oMujMat the IDnumber of the material that user choosed from the Material field , in the element that he/she assigned!
*set Var oMujMat=tcl(FindMaterialNumber *MatProp(Material) )
*set var MaterialExists=tcl(CheckUsedMaterials *oMujMat)
*if(MaterialExists==-1)
*set var dummy=tcl(AddUsedMaterials *oMujMat)
*loop materials *NotUsed
*# We set the variable oMat the IDnumber of each material(NotUsed) and we check which is the material that user choosed in Material field in element definition.
*set var oMat=tcl(FindMaterialNumber *MatProp(0) )
*#we check which is the material that user choosed in Material field in element definition.
*if(oMat==oMujMat)
*if(strcmp(MatProp(1),"Elastic")==0)
*format "%d%g"
uniaxialMaterial Elastic *oMat *MatProp(Elastic_modulus_E,real)
*elseif(strcmp(MatProp(1),"ElasticPerfectlyPlastic")==0)
*format "%d%g"
uniaxialMaterial ElasticPP *oMat *MatProp(Elastic_modulus_E,real) *\
*set var epsyP=MatProp(Strain_epsP,real)
*set var epsyN=MatProp(Strain_epsN,real)
*set var eps0=MatProp(Initial_strain_eps0,real)
*format "%g%g%g"
*epsyP *epsyN *eps0
*elseif(strcmp(MatProp(1),"Steel01")==0)
*format "%d"
uniaxialMaterial Steel01 *oMat *\
*set var Fy=MatProp(Yield_Stress_Fy,real)
*set var E0=MatProp(Initial_elastic_tangent_E0,real)
*set var b=MatProp(Strain-hardening_ratio_b,real)
*format "%g%g%g"
*Fy *E0 *b
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlasticwithGap")==0)
*format "%d%g%g%g"
uniaxialMaterial ElasticPPGap *oMat *MatProp(Elastic_modulus_E,real) *MatProp(Yield_Stress_Fy,real) *MatProp(Gap,real)
*endif
*break
*endif
*end materials
*endif
*endif
*end materials

# Truss Definition : element truss $eleTag $inode $jnode $A $matTag
*set var VarCount=operation(VarCount+1)

*endif
*#
*#-------------Section Properties--------------------
*#
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
element truss *ElemsNum *elemsConec *\
*format "%8.3f"
*A *tcl(FindMaterialNumber *ElemsMatProp(Material) )   -rho *\
*format "%8.3f"
*MassPerLength
*endif
*end elems
*endif