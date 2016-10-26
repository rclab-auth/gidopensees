*#--------------------------------------------------------------------------------
*#                                  Tri31 Elements                                -
*#--------------------------------------------------------------------------------
*# variable to count Quad elements
*set var cntTri31=0
*loop elems 
*if(strcmp(ElemsMatProp(Element_type:),"Tri31")==0)
*if(ElemsType!=2)
*MessageBox Error: Tri31 elements must be triangular.
*endif
*set var cntTri31=operation(cntTri31+1)
*endif
*end elems
*if(cntTri31!=0)

# --------------------------------------------------------------------------------------------------------------
# T R I 3 1   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

*set var VarCount=1
*if(GenData(Dimensions,int)==2 && GenData(DOF,int)==2)
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Tri31")==0)
*set var thickness=ElemsMatProp(Thickness,real)
*if(VarCount==1)
*if(file!=2)
*set var file=4
*endif
# nDMaterial Definition

*loop materials
*if(strcmp(MatProp(Element_type:),"Tri31")==0)
*set Var SelectedMaterial=tcl(FindMaterialNumber *MatProp(Material) )
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedMaterial)
*if(MaterialExists==-1)
*loop materials *NotUsed
*set Var MaterialID=tcl(FindMaterialNumber *MatProp(0) )
*if(MaterialID==SelectedMaterial)
*set var dummy=tcl(AddUsedMaterials *SelectedMaterial)
*if(strcmp(MatProp(1),"ElasticIsotropic")==0)
*format "%d%g%g%g"
nDMaterial ElasticIsotropic *MaterialID *MatProp(Elastic_Modulus_E,real) *MatProp(Poisson's_ratio,real) *MatProp(Mass_density,real)
*elseif(strcmp(MatProp(1),"ElasticOrthotropic")==0)
*format "%d%g%g%g%g%g%g%g%g%g%g"
nDMaterial ElasticOrthotropic *MaterialID *MatProp(Elastic_Modulus_Ex,real) *MatProp(Elastic_Modulus_Ey,real) *MatProp(Elastic_Modulus_Ez,real) *MatProp(Poisson's_ratio_vxy,real) *MatProp(Poisson's_ratio_vyz,real) *MatProp(Poisson's_ratio_vzy,real) *MatProp(Shear_modulus_Gxy,real) *MatProp(Shear_modulus_Gyz,real) *MatProp(Shear_modulus_Gzx,real) *MatProp(Mass_density,real)
*endif
*break
*endif
*end materials
*endif
*endif
*end materials

# Tri31 elements Definition : element tri31 $eleTag $iNode $jNode $kNode $thick $type $matTag <$pressure $rho $b1 $b2>

*endif
*format "%6d%6d%6d%6d%8.3f"
element tri31 *ElemsNum *ElemsConec *thickness  *\
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
*MessageBox Error: Tri31 elements require 2D model and 2 DOFs
*endif
*endif
