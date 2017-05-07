*#--------------------------------------------------------------------------------
*#                                  Quad Elements                                -
*#--------------------------------------------------------------------------------
*# variable to count QuadUP elements
*set var cntcurrQuadUP=0
*loop elems *OnlyInGroup
*if(strcmp(ElemsMatProp(Element_type:),"QuadUP")==0)
*if(ElemsType!=3)
*MessageBox Error: QuadUP elements must be quadrilateral.
*endif
*set var cntQuadUP=operation(cntQuadUP+1)
*set var cntcurrQuadUP=operation(cntcurrQuadUP+1)
*endif
*end elems
*if(cntcurrQuadUP!=0)

# --------------------------------------------------------------------------------------------------------------
# Q U A D U P   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

*set var VarCount=1
*if(ndime==2 && currentDOF==3)
*loop elems *OnlyInGroup
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
*if(strcmp(MatProp(Material:),"ElasticIsotropic")==0)
*format "%d%g%g%g"
nDMaterial ElasticIsotropic *MaterialID *MatProp(Elastic_modulus_E,real) *MatProp(Poisson's_ratio,real) *MatProp(Mass_density,real)
*elseif(strcmp(MatProp(Material:),"ElasticOrthotropic")==0)
*format "%d%g%g%g%g%g%g%g%g%g%g"
nDMaterial ElasticOrthotropic *MaterialID *MatProp(Elastic_modulus_Ex,real) *MatProp(Elastic_modulus_Ey,real) *MatProp(Elastic_modulus_Ez,real) *MatProp(Poisson's_ratio_vxy,real) *MatProp(Poisson's_ratio_vyz,real) *MatProp(Poisson's_ratio_vzy,real) *MatProp(Shear_modulus_Gxy,real) *MatProp(Shear_modulus_Gyz,real) *MatProp(Shear_modulus_Gzx,real) *MatProp(Mass_density,real)
*elseif(strcmp(MatProp(Material:),"PressureIndependMultiYield")==0)
*format "%d%d%g%g%g%g%g%g%g%g%g"
nDMaterial PressureIndependMultiYield *MaterialID *ndime *MatProp(Saturated_soil_mass_density,real) *MatProp(Reference_shear_modulus_Gr,real) *MatProp(Reference_bulk_modulus,real) *MatProp(Apparent_cohesion,real) *MatProp(Shear_strain_at_which_maximum_stress_is_reached,real) *MatProp(Friction_angle,real) *MatProp(Reference_mean_effective_confining_pressure_pr,real) *MatProp(Positive_constant_d,real) *\
*if(MatProp(Automatic_surface_generation,int)==1)
*MatProp(Yield_surfaces,int)
*else
-*MatProp(Yield_surfaces,int) *\
*set var Narray=MatProp(Define_yield_surfaces_based_on_shear_modulus_reduction_curve,int)
*for(i=1;i<=Narray;i=i+2)
*MatProp(Define_yield_surfaces_based_on_shear_modulus_reduction_curve,*i) *MatProp(Define_yield_surfaces_based_on_shear_modulus_reduction_curve,*operation(i+1)) *\
*endfor

*endif
*elseif(strcmp(MatProp(Material:),"PressureDependMultiYield")==0)
*format "%d%d%g%g%g%g%g%g%g%g%g%g%g%g%g%g"
nDMaterial PressureDependMultiYield *MaterialID *ndime *MatProp(Saturated_soil_mass_density,real) *MatProp(Reference_shear_modulus_Gr,real) *MatProp(Reference_bulk_modulus,real) *\
*MatProp(Friction_angle,real) *MatProp(Shear_strain_at_which_maximum_stress_is_reached,real) *MatProp(Reference_mean_effective_confining_pressure_pr,real) *MatProp(Positive_constant_d,real) *\
*MatProp(Phase_transformation_angle,real) *MatProp(Contraction_rate_constant,real) *MatProp(Dilation_rate_constant_1,real) *MatProp(Dilation_rate_constant_2,real) *\
*MatProp(Liquefaction_parameter_1,real) *MatProp(Liquefaction_parameter_2,real) *MatProp(Liquefaction_parameter_3,real) *\
*if(MatProp(Automatic_surface_generation,int)==1)
*format "%d"
*MatProp(Yield_surfaces,int) *\
*else
*format "%d"
-*MatProp(Yield_surfaces,int) *\
*set var Nmatrix=MatProp(Define_yield_surfaces_based_on_shear_modulus_reduction_curve,int)
*for(i=1;i<=Nmatrix;i=i+2)
*format "%g%g"
*MatProp(Define_yield_surfaces_based_on_shear_modulus_reduction_curve,*i) *MatProp(Define_yield_surfaces_based_on_shear_modulus_reduction_curve,*operation(i+1)) *\
*endfor
*endif
*format "%g%g%g%g%g%g"
*MatProp(Initial_void_ratio,real) *MatProp(Critical_straight_line_parameter_cs1,real) *MatProp(Critical_straight_line_parameter_cs2,real) *MatProp(Critical_straight_line_parameter_cs3,real) *\
*MatProp(Atmospheric_pressure_for_normalization,real) *MatProp(Numerical_constant,real)
*elseif(strcmp(MatProp(Material:),"J2Plasticity")==0)
*format "%d%g%g%g%g%g%g"
nDMaterial J2Plasticity *MaterialID *MatProp(Bulk_modulus,real) *MatProp(Shear_modulus,real) *MatProp(Initial_yield_stress,real) *MatProp(Final_saturation_yield_stress,real) *MatProp(Exp._hardening_parameter_delta,real) *MatProp(Linear_hardening_parameter,real)
*endif
*break
*endif
*end materials
*endif
*endif
*end materials

# QuadUP elements Definition : element quadUP $eleTag $iNode $jNode $kNode $lNode $thick $matTag $bulk $fmass $hPerm $vPerm <$b1 $b2 $t>

*endif
*format "%3d%6d%6d%6d%6d%8.3f"
element quadUP *ElemsNum *ElemsConec *thickness  *\
*format "%8.3f%8.3f%8.3f%8.3f%8.3f%8.3f%8.3f"
*tcl(FindMaterialNumber *ElemsMatProp(Material)) *ElemsMatProp(Combined_undrained_bulk_modulus_Bc,real) *ElemsMatProp(Fluid_mass_density,real) *ElemsMatProp(Permeability_coefficient_in_horizontal_direction,real) *ElemsMatProp(Permeability_coefficient_in_vertical_direction,real) *ElemsMatProp(Uniform_normal_traction,real) *ElemsMatProp(X-acceleration,real) *ElemsMatProp(Y-acceleration,real)
*set var VarCount=VarCount+1
*endif
*end elems
*endif
*endif
