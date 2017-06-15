*#--------------------------------------------------------------------------------
*#                                  QuadUP Elements                                -
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
# nDMaterial Definition used by QuadUP Elements. (Only if they have not already been defined on this model domain)

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
*include ..\..\Materials\nD\ElasticIsotropic.bas
*elseif(strcmp(MatProp(Material:),"ElasticOrthotropic")==0)
*include ..\..\Materials\nD\ElasticOrthotropic.bas
*elseif(strcmp(MatProp(Material:),"PressureIndependMultiYield")==0)
*include ..\..\Materials\nD\PIMY.bas
*elseif(strcmp(MatProp(Material:),"PressureDependMultiYield")==0)
*include ..\..\Materials\nD\PDMY.bas
*elseif(strcmp(MatProp(Material:),"J2Plasticity")==0)
*include ..\..\Materials\nD\J2Plasticity.bas
*elseif(strcmp(MatProp(Material:),"Damage2p")==0)
*include ..\..\Materials\nD\Damage2p.bas
*else
*MessageBox Error: Invalid nD Material selected for QuadUP Element.
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
*set var ID=tcl(FindMaterialNumber *ElemsMatProp(Material))
*format "%3d%8.3f%8.3f%8.3f%8.3f%8.3f%8.3f%8.3f"
*ID *ElemsMatProp(Combined_undrained_bulk_modulus_Bc,real) *ElemsMatProp(Fluid_mass_density,real) *ElemsMatProp(Permeability_coefficient_in_horizontal_direction,real) *ElemsMatProp(Permeability_coefficient_in_vertical_direction,real) *ElemsMatProp(Uniform_normal_traction,real) *ElemsMatProp(X-acceleration,real) *ElemsMatProp(Y-acceleration,real)
*set var VarCount=VarCount+1
*endif
*end elems
*endif
*endif