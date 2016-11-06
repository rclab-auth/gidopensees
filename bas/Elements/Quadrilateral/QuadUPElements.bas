*#--------------------------------------------------------------------------------
*#                                  Quad Elements                                -
*#--------------------------------------------------------------------------------
*# variable to count QuadUP elements
*set var cntQuadUP=0
*loop elems 
*if(strcmp(ElemsMatProp(Element_type:),"QuadUP")==0)
*if(ElemsType!=3)
*MessageBox Error: QuadUP elements must be quadrilateral.
*endif
*set var cntQuadUP=operation(cntQuadUP+1)
*endif
*end elems
*if(cntQuadUP!=0)

# --------------------------------------------------------------------------------------------------------------
# Q U A D U P   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

*set var VarCount=1
*if(GenData(Dimensions,int)==2 && GenData(DOF,int)==3)
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"QuadUP")==0)
*set var thickness=ElemsMatProp(Thickness,real)
*if(VarCount==1)
# nDMaterial Definition 

*loop materials
*if(strcmp(MatProp(Element_type:),"QuadUP")==0)
*set Var SelectedMaterial=tcl(FindMaterialNumber *MatProp(Material) )
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedMaterial)
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *MatProp(0) )
*if(MaterialID==SelectedMaterial)
*set var dummy=tcl(AddUsedMaterials *SelectedMaterial)
*if(strcmp(MatProp(1),"ElasticIsotropic")==0)
*format "%d%g%g%g"
nDMaterial ElasticIsotropic *MaterialID *MatProp(Elastic_Modulus_E,real) *MatProp(Poisson's_ratio,real) *MatProp(Mass_density,real)
*elseif(strcmp(MatProp(1),"ElasticOrthotropic")==0)
*format "%d%g%g%g%g%g%g%g%g%g%g"
nDMaterial ElasticOrthotropic *MaterialID *MatProp(Elastic_Modulus_Ex,real) *MatProp(Elastic_Modulus_Ey,real) *MatProp(Elastic_Modulus_Ez,real) *MatProp(Poisson's_ratio_vxy,real) *MatProp(Poisson's_ratio_vyz,real) *MatProp(Poisson's_ratio_vzy,real) *MatProp(Shear_modulus_Gxy,real) *MatProp(Shear_modulus_Gyz,real) *MatProp(Shear_modulus_Gzx,real) *MatProp(Mass_density,real)
*elseif(strcmp(MatProp(Material:),"PressureIndependMultiYield")==0)
nDMaterial PressureIndependMultiYield *MaterialID *GenData(Dimensions,int) *MatProp(Saturated_soil_mass_density,real) *MatProp(Reference_Shear_Modulus_Gr,real) *MatProp(Reference_Bulk_Modulus,real) *MatProp(Apparent_Cohesion,real) *MatProp(Shear_Strain_at_which_maximum_stress_is_reached,real) *MatProp(Friction_angle,real) *MatProp(Reference_mean_effective_confining_pressure_pr,real) *MatProp(Positive_constant_d,real) *\
*if(MatProp(Automatic_surface_generation,int)==1)
*MatProp(Yield_Surfaces,int)
*else
-*MatProp(Yield_Surfaces,int) *\
*set var Narray=MatProp(Define_yield_surfaces_based_on_shear_modulus_reduction_curve,int)
*for(i=1;i<=Narray;i=i+2)
*MatProp(Define_yield_surfaces_based_on_shear_modulus_reduction_curve,*i) *MatProp(Define_yield_surfaces_based_on_shear_modulus_reduction_curve,*operation(i+1)) *\
*endfor

*endif
*endif
*break
*endif
*end materials
*endif
*endif
*end materials

# QuadUP elements Definition : element quadUP $eleTag $iNode $jNode $kNode $lNode $thick $matTag $bulk $fmass $hPerm $vPerm <$b1 $b2 $t>

*endif
*format "%6d%6d%6d%6d%6d%8.3f"
element quadUP *ElemsNum *ElemsConec *thickness  *\
*format "%8.3f%8.3f%8.3f%8.3f%8.3f%8.3f%8.3f"
*tcl(FindMaterialNumber *ElemsMatProp(Material)) *ElemsMatProp(Combined_undrained_bulk_modulus_Bc,real) *ElemsMatProp(Fluid_mass_density,real) *ElemsMatProp(Permeability_coefficient_in_horizontal_direction,real) *ElemsMatProp(Permeability_coefficient_in_vertical_direction,real) *ElemsMatProp(Uniform_normal_traction,real) *ElemsMatProp(X-acceleration,real) *ElemsMatProp(Y-acceleration,real)
*set var VarCount=VarCount+1
*endif
*end elems
*else
*MessageBox Error: QuadUP elements require 2D model and 3 DOFs
*endif
*endif
