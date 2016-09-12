*#----------------------------------------------------------------
*#------------------ Corotational Truss Elements------------------
*#----------------------------------------------------------------
*# variable to check Corotational Truss Elements existance : 1 for existance, 0 for not
*set var CorotTrussFound=0
*loop elems 
*if(strcmp(ElemsMatProp(Element_type:),"CorotationalTruss")==0)
*set var CorotTrussFound=1
*break
*endif
*end elems
*if(CorotTrussFound==1)
#
# Corotational Truss Elements
#

*set var VarCount=1
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"CorotationalTruss")==0)
*if(VarCount==1)
*set var file=2

# Uniaxial Materials definition 

*loop materials
*if(strcmp(MatProp(Element_type:),"CorotationalTruss")==0)
*# We set the variable oMujMat the IDnumber of the material that user choosed from the Material field , in the element that he/she assigned!
*Set Var oMujMat=tcl(FindMaterialNumber *MatProp(Material) )
*set var MaterialExists=tcl(CheckUsedMaterials *oMujMat)
*if(MaterialExists==-1)
*tcl(AddUsedMaterials *oMujMat)
uniaxialMaterial  *\
*loop materials *NotUsed
*# We set the variable oMat the IDnumber of each material(NotUsed) and we check which is the material that user choosed in Material field in element definition.
*Set Var oMat=tcl(FindMaterialNumber *MatProp(0) )
*#we check which is the material that user choosed in Material field in element definition.
*if(oMat==oMujMat)
*if(strcmp(MatProp(1),"Elastic")==0)
Elastic *\
*oMat *\
*MatProp(Elastic_modulus_E,real)
*elseif(strcmp(MatProp(1),"ElasticPerfectlyPlastic")==0)
ElasticPP *\
*oMat *\
*set var E=MatProp(Elastic_modulus_E,real)
*E *\
*set var Fyt=MatProp(Yield_Stress_in_tension,real)
*set var Fyc=MatProp(Yield_Stress_in_compression,real)
*set var epsyP=Fyt/E
*set var epsyN=Fyc/E
*set var eps0=MatProp(Initial_strain_eps0,real)
*epsyP *\
*epsyN *\
*eps0
*elseif(strcmp(MatProp(1),"Steel01")==0)
Steel01 *oMat *\
*format "%1.1f%1.1f"
*set var Fy=MatProp(Yield_Stress_Fy,real)
*set var E0=MatProp(Initial_elastic_tangent_E0,real)
*set var b=MatProp(Strain-hardening_ratio_b,real)
*Fy *E0 *b
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
*#--------------------------------------------
*# Create Corotational truss elements - command: element corotTruss $eleTag $iNode $jNode $A $matTag <-rho $rho> <-cMass $cFlag> <-doRayleigh $rFlag>
*#--------------------------------------------
element corotTruss *ElemsNum *elemsConec *\
*format "%1.4f"
*A *tcl(FindMaterialNumber *ElemsMatProp(Material) ) -rho *\
*format "%1.3f"
*MassPerLength
*endif
*end elems
*endif