*#--------------------------------------------------------------------------------
*#                                  Shell Elements
*#--------------------------------------------------------------------------------
*# variable count Shell elements
*set var cntShell=0
*loop elems 
*if(strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*if(ElemsType!=3)
*MessageBox Error: Shell elements must be quadrilateral.
*endif
*set var cntShell=operation(cntShell+1)
*endif
*end elems
*if(cntShell!=0)

# --------------------------------------------------------------------------------------------------------------
# S H E L L   E L E M E N T S
# --------------------------------------------------------------------------------------------------------------

*set var VarCount=1
*if(GenData(Dimensions,int)==3 && GenData(DOF,int)==6)
*loop elems
*if(strcmp(ElemsMatProp(Element_type:),"Shell")==0)
*if(VarCount==1)
# Materials/Sections Definition for shell elements

*loop materials 
*if(strcmp(MatProp(Element_type:),"Shell")==0)
*set var SelectedSection=tcl(FindMaterialNumber *MatProp(Type) )
*loop materials *NotUsed
*set var SectionID=tcl(FindMaterialNumber *MatProp(0) )
*if(SelectedSection==SectionID)
*if(strcmp(MatProp(Section:),"PlateFiber")==0)
*set var PlateThickness=MatProp(Plate_thickness_h,real)
*set var PlateFiberTag=SectionID
*set var SelectedMaterial=tcl(FindMaterialNumber *MatProp(Material) )
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *MatProp(0) )
*if(SelectedMaterial==MaterialID)
*if(strcmp(MatProp(Material:),"ElasticIsotropic")==0)
*format "%d%g%g"
nDMaterial ElasticIsotropic *MaterialID *MatProp(Elastic_Modulus_E,real) *MatProp(Poisson's_ratio,real) *MatProp(Mass_density,real)
*elseif(strcmp(MatProp(Material:),"ElastiOrthotropic")==0)
*format "%d%g%g%g%g%g%g%g%g%g"
nDMaterial ElasticOrthotropic *MaterialID *MatProp(Elastic_Modulus_Ex,real) *MatProp(Elastic_Modulus_Ey,real) *MatProp(Elastic_Modulus_Ez,real) *MatProp(Poisson's_ratio_vxy,real) *MatProp(Poisson's_ratio_vyz,real) *MatProp(Poisson's_ratio_vzy,real) *MatProp(Shear_modulus_Gxy,real) *MatProp(Shear_modulus_Gyz,real) *MatProp(Shear_modulus_Gzx,real) *MatProp(Mass_density,real)
*elseif(strcmp(MatProp(Material:),"PressureIndependMultiYield")==0)
*MessageBox Shell Elements do not support PressureIndependMultiYield Materials
*endif
*format "%d%d%g"
section PlateFiber *PlateFiberTag *SelectedMaterial *PlateThickness
*break
*endif
*end materials
*elseif(strcmp(MatProp(Section:),"ElasticMembranePlate")==0)
*set var ElasticMembranePlateTag=SelectedSection
*format "%d%g%g%g%g"
section ElasticMembranePlateSection *ElasticMembranePlateTag *MatProp(Elastic_Modulus_E,real) *MatProp(Poisson's_ratio,real) *MatProp(Section_depth_h,real) *MatProp(Mass_density,real)
*endif
*endif
*end materials
*endif
*end materials

# Shell Elements Definition: element ShellMITC4 $eleTag $iNode $jNode $kNode $lNode $secTag

*endif
*format "%6d%6d%6d%6d%6d   "
element ShellMITC4 *ElemsNum *ElemsConec *tcl(FindMaterialNumber *ElemsMatProp(Type) )
*set var VarCount=VarCount+1
*endif
*end elems
*else
*MessageBox Error: Shell elements require a 3D / 6-DOF model.
*endif
*endif