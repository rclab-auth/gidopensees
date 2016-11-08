*#--------------------------------------------------------------------------------
*#                                  Quad Elements                                -
*#--------------------------------------------------------------------------------
*# variable to count Quad elements
*set var cntQuad=0
*loop elems 
*if(strcmp(ElemsMatProp(Element_type:),"Quad")==0)
*if(ElemsType!=3)
*MessageBox Error: Quad elements must be quadrilateral.
*endif
*set var cntQuad=operation(cntQuad+1)
*endif
*end elems
*if(cntQuad!=0)

# --------------------------------------------------------------------------------------------------------------
# Q U A D   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

*set var VarCount=1
*if(GenData(Dimensions,int)==2 && GenData(DOF,int)==2)
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Quad")==0)
*set var thickness=ElemsMatProp(Thickness,real)
*if(VarCount==1)
# nDMaterial Definition

*loop materials
*if(strcmp(MatProp(Element_type:),"Quad")==0)
*set var SelectedMaterial=tcl(FindMaterialNumber *MatProp(Material) )
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedMaterial)
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *MatProp(0) )
*if(MaterialID==SelectedMaterial)
*set var dummy=tcl(AddUsedMaterials *SelectedMaterial)
*if(strcmp(MatProp(Material:),"ElasticIsotropic")==0)
*format "%d%g%g%g"
nDMaterial ElasticIsotropic *MaterialID *MatProp(Elastic_Modulus_E,real) *MatProp(Poisson's_ratio,real) *MatProp(Mass_density,real)
*elseif(strcmp(MatProp(Material:),"ElasticOrthotropic")==0)
*format "%d%g%g%g%g%g%g%g%g%g%g"
nDMaterial ElasticOrthotropic *MaterialID *MatProp(Elastic_Modulus_Ex,real) *MatProp(Elastic_Modulus_Ey,real) *MatProp(Elastic_Modulus_Ez,real) *MatProp(Poisson's_ratio_vxy,real) *MatProp(Poisson's_ratio_vyz,real) *MatProp(Poisson's_ratio_vzy,real) *MatProp(Shear_modulus_Gxy,real) *MatProp(Shear_modulus_Gyz,real) *MatProp(Shear_modulus_Gzx,real) *MatProp(Mass_density,real)
*elseif(strcmp(MatProp(Material:),"PressureIndependMultiYield")==0)
*format "%d%d%g%g%g%g%g%g%g%g%g"
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
*elseif(strcmp(MatProp(Material:),"PressureDependMultiYield")==0)
*format "%d%d%g%g%g%g%g%g%g%g%g%g%g%g%g%g"
nDMaterial PressureDependMultiYield *MaterialID *GenData(Dimensions,int) *MatProp(Saturated_soil_mass_density,real) *MatProp(Reference_Shear_Modulus_Gr,real) *MatProp(Reference_Bulk_Modulus,real) *\
*MatProp(Friction_angle,real) *MatProp(Shear_Strain_at_which_maximum_stress_is_reached,real) *MatProp(Reference_mean_effective_confining_pressure_pr,real) *MatProp(Positive_constant_d,real) *\
*MatProp(Phase_transformation_angle,real) *MatProp(Contraction_rate_constant,real) *MatProp(Dilation_rate_constant_1,real) *MatProp(Dilation_rate_constant_2,real) *\
*MatProp(Liquefaction_parameter_1,real) *MatProp(Liquefaction_parameter_2,real) *MatProp(Liquefaction_parameter_3,real) *\
*if(MatProp(Automatic_surface_generation,int)==1)
*format "%d"
*MatProp(Yield_Surfaces,int) *\
*else
*format "%d"
-*MatProp(Yield_Surfaces,int) *\
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
nDMaterial J2Plasticity *MaterialID *MatProp(Bulk_Modulus,real) *MatProp(Shear_Modulus,real) *MatProp(Initial_Yield_Stress,real) *MatProp(Final_Saturation_Yield_Stress,real) *MatProp(Exp._hardening_parameter_delta,real) *MatProp(Linear_hardening_parameter,real)
*elseif(strcmp(MatProp(Material:),"Damage2p")==0)
*format "%d%g%g%g%g%g%g%g%g%g"
nDMaterial Damage2p *MaterialID *MatProp(Concrete_compressive_strength,real) -fct *MatProp(Concrete_tensile_strength,real) -E *MatProp(Young_Modulus,real) -ni *MatProp(Poisson_coefficient,real) -Gt *MatProp(Tension_fracture_energy_density,real) -Gc *MatProp(Comp._fracture_energy_density,real) -rho_bar *MatProp(Parameter_of_plastic_volume_change,real) -H *MatProp(Linear_hardening_parameter,real) -theta *MatProp(Isotropic/kinematic_hardening_ratio,real) *\
*if(strcmp(MatProp(Computational_stiffness_matrix),"Computational_tangent")==0)
-tangent 0
*else
-tangent 1
*endif
*endif
*break
*endif
*end materials
*endif
*endif
*end materials

# Quad elements Definition : element quad $EleTag $Nodei $Nodej Nodek $Nodel $thick $type $MatTag

*endif
*format "%6d%6d%6d%6d%6d%8.3f"
element quad *ElemsNum *ElemsConec *thickness  *\
*if(strcmp(ElemsMatProp(Plane_behavior),"PlaneStrain")==0)
*format "%8.3f%8.3f%8.3f%8.3f"
PlaneStrain   *tcl(FindMaterialNumber *ElemsMatProp(Material)) *ElemsMatProp(Surface_pressure) *ElemsMatProp(Mass_density) *ElemsMatProp(X-Direction) *ElemsMatProp(Y-Direction)
*elseif(strcmp(ElemsMatProp(Plane_behavior),"PlaneStress")==0)
*format "%8.3f%8.3f%8.3f%8.3f"
PlaneStress   *tcl(FindMaterialNumber *ElemsMatProp(Material)) *ElemsMatProp(Surface_pressure) *ElemsMatProp(Mass_density) *ElemsMatProp(X-Direction) *ElemsMatProp(Y-Direction)
*endif
*set var VarCount=VarCount+1
*endif
*end elems
*else
*MessageBox Error: Quad elements require a 2D / 2-DOF model.
*endif
*endif
