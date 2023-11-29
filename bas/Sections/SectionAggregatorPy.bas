*# ----------------------- SECTION AGGREGATOR ------------------
*set var SectionAggregatorTag=SectionID
*set var DefineSection=MatProp(Select_section,int)
*if(DefineSection==1)
*set var SelectedSection=tcl(FindMaterialNumber *MatProp(Section_to_be_aggregated) *DomainNum)
*set var SectionExists=tcl(CheckUsedMaterials *SelectedSection)
*if(SectionExists==-1)
*loop materials *NotUsed
*set var SectionID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SectionID==SelectedSection)
*set var dummy=tcl(AddUsedMaterials *SectionID)
*if(strcmp(MatProp(Section:),"Fiber")==0)
*include FiberPy.bas
*elseif(strcmp(MatProp(Section:),"ElasticSection")==0)
*include ElasticSectionPy.bas
*elseif(strcmp(MatProp(Section:),"FiberCustom")==0)
*include FiberCustomPy.bas
*else
*MessageBox Error: Unsupported Section selected for Section Aggregator
*endif
*break
*endif
*end materials
*endif
*endif
*set var DefinePmaterial=MatProp(Activate_P,int)
*set var DefineMzmaterial=MatProp(Activate_Mz,int)
*set var DefineVymaterial=MatProp(Activate_Vy,int)
*set var DefineMymaterial=MatProp(Activate_My,int)
*set var DefineVzmaterial=MatProp(Activate_Vz,int)
*set var DefineTmaterial=MatProp(Activate_T,int)
*# Axial force-deformation definition
*if(DefinePmaterial==1)
*set var SelectedPmaterial=tcl(FindMaterialNumber *MatProp(Axial_force-deformation) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedPmaterial )
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelectedPmaterial==MaterialID)
*set var dummy=tcl(AddUsedMaterials *MaterialID)
*if(strcmp(MatProp(Material:),"Elastic")==0)
*include ..\Materials\Uniaxial\ElasticPy.bas
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlastic")==0)
*include ..\Materials\Uniaxial\ElasticPPPy.bas
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlasticwithGap")==0)
*include ..\Materials\Uniaxial\ElasticPPwithGapPy.bas
*elseif(strcmp(MatProp(Material:),"Steel01")==0)
*include ..\Materials\Uniaxial\Steel01Py.bas
*elseif(strcmp(MatProp(Material:),"ReinforcingSteel")==0)
*include ..\Materials\Uniaxial\ReinforcingSteelPy.bas
*elseif(strcmp(MatProp(Material:),"RambergOsgoodSteel")==0)
*include ..\Materials\Uniaxial\RambergOsgoodSteelPy.bas
*elseif(strcmp(MatProp(Material:),"Hysteretic")==0)
*include ..\Materials\Uniaxial\HystereticPy.bas
*elseif(strcmp(MatProp(Material:),"RambergOsgoodSteel")==0)
*include ..\Materials\Uniaxial\RambergOsgoodSteelPy.bas
*elseif(strcmp(MatProp(Material:),"Concrete01")==0)
*include ..\Materials\Uniaxial\Concrete01Py.bas
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*include ..\Materials\Uniaxial\Concrete02Py.bas
*elseif(strcmp(MatProp(Material:),"Concrete04")==0)
*include ..\Materials\Uniaxial\Concrete04Py.bas
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*include ..\Materials\Uniaxial\Concrete06Py.bas
*elseif(strcmp(MatProp(Material:),"ConcreteCM")==0)
*include ..\Materials\Uniaxial\ConcreteCMPy.bas
*elseif(strcmp(MatProp(Material:),"Series")==0 || strcmp(MatProp(Material:),"Parallel")==0)
*include ..\Materials\Uniaxial\SeriesParallelPy.bas
*elseif(strcmp(MatProp(Material:),"InitStrain")==0)
*include ..\Materials\Uniaxial\InitialStrainPy.bas
*elseif(strcmp(MatProp(Material:),"InitStress")==0)
*include ..\Materials\Uniaxial\InitialStressPy.bas
*else
*MessageBox Error: Invalid uniaxial P material selected for Section Aggregator
*# end if Material is Elastic ElasticPP etc.
*endif
*break
*# end if selected material is found
*endif
*end materials
*# end if material exists
*endif
*# end of Axial Force-deformation definition
*endif
*#------------------------
*# Moment-curvature about z-z definition (Mz)
*#------------------------
*if(DefineMzmaterial==1)
*set var SelectedMzmaterial=tcl(FindMaterialNumber *MatProp(Moment-curvature_about_local_z-z) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedMzmaterial )
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelectedMzmaterial==MaterialID)
*set var dummy=tcl(AddUsedMaterials *MaterialID)
*if(strcmp(MatProp(Material:),"Elastic")==0)
*include ..\Materials\Uniaxial\ElasticPy.bas
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlastic")==0)
*include ..\Materials\Uniaxial\ElasticPPPy.bas
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlasticwithGap")==0)
*include ..\Materials\Uniaxial\ElasticPPwithGapPy.bas
*elseif(strcmp(MatProp(Material:),"Steel01")==0)
*include ..\Materials\Uniaxial\Steel01Py.bas
*elseif(strcmp(MatProp(Material:),"ReinforcingSteel")==0)
*include ..\Materials\Uniaxial\ReinforcingSteelPy.bas
*elseif(strcmp(MatProp(Material:),"RambergOsgoodSteel")==0)
*include ..\Materials\Uniaxial\RambergOsgoodSteelPy.bas
*elseif(strcmp(MatProp(Material:),"Hysteretic")==0)
*include ..\Materials\Uniaxial\HystereticPy.bas
*elseif(strcmp(MatProp(Material:),"Concrete01")==0)
*include ..\Materials\Uniaxial\Concrete01Py.bas
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*include ..\Materials\Uniaxial\Concrete02Py.bas
*elseif(strcmp(MatProp(Material:),"Concrete04")==0)
*include ..\Materials\Uniaxial\Concrete04Py.bas
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*include ..\Materials\Uniaxial\Concrete06Py.bas
*elseif(strcmp(MatProp(Material:),"ConcreteCM")==0)
*include ..\Materials\Uniaxial\ConcreteCMPy.bas
*elseif(strcmp(MatProp(Material:),"Series")==0 || strcmp(MatProp(Material:),"Parallel")==0)
*include ..\Materials\Uniaxial\SeriesParallelPy.bas
*elseif(strcmp(MatProp(Material:),"InitStrain")==0)
*include ..\Materials\Uniaxial\InitialStrainPy.bas
*elseif(strcmp(MatProp(Material:),"InitStress")==0)
*include ..\Materials\Uniaxial\InitialStressPy.bas
*else
*MessageBox Error: Invalid uniaxial Mz material selected for Section Aggregator
*# end if Material is Elastic ElasticPP etc.
*endif
*break
*# end if selected material is found
*endif
*end materials
*# end if material exists
*endif
*# endif Mz
*endif
*#-----
*# Vy definition
*#-----
*if(DefineVymaterial==1)
*set var SelectedVymaterial=tcl(FindMaterialNumber *MatProp(Shear_force-deformation_along_local_y-y) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedVymaterial )
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelectedVymaterial==MaterialID)
*set var dummy=tcl(AddUsedMaterials *MaterialID)
*if(strcmp(MatProp(Material:),"Elastic")==0)
*include ..\Materials\Uniaxial\ElasticPy.bas
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlastic")==0)
*include ..\Materials\Uniaxial\ElasticPPPy.bas
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlasticwithGap")==0)
*include ..\Materials\Uniaxial\ElasticPPwithGapPy.bas
*elseif(strcmp(MatProp(Material:),"Steel01")==0)
*include ..\Materials\Uniaxial\Steel01Py.bas
*elseif(strcmp(MatProp(Material:),"ReinforcingSteel")==0)
*include ..\Materials\Uniaxial\ReinforcingSteelPy.bas
*elseif(strcmp(MatProp(Material:),"RambergOsgoodSteel")==0)
*include ..\Materials\Uniaxial\RambergOsgoodSteelPy.bas
*elseif(strcmp(MatProp(Material:),"Hysteretic")==0)
*include ..\Materials\Uniaxial\HystereticPy.bas
*elseif(strcmp(MatProp(Material:),"Concrete01")==0)
*include ..\Materials\Uniaxial\Concrete01Py.bas
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*include ..\Materials\Uniaxial\Concrete02Py.bas
*elseif(strcmp(MatProp(Material:),"Concrete04")==0)
*include ..\Materials\Uniaxial\Concrete04Py.bas
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*include ..\Materials\Uniaxial\Concrete06Py.bas
*elseif(strcmp(MatProp(Material:),"ConcreteCM")==0)
*include ..\Materials\Uniaxial\ConcreteCMPy.bas
*elseif(strcmp(MatProp(Material:),"Series")==0 || strcmp(MatProp(Material:),"Parallel")==0)
*include ..\Materials\Uniaxial\SeriesParallelPy.bas
*elseif(strcmp(MatProp(Material:),"InitStrain")==0)
*include ..\Materials\Uniaxial\InitialStrainPy.bas
*elseif(strcmp(MatProp(Material:),"InitStress")==0)
*include ..\Materials\Uniaxial\InitialStressPy.bas
*else
*MessageBox Error: Invalid uniaxial Vy material selected for Section Aggregator
*# end if Material is Elastic ElasticPP etc.
*endif
*break
*# end if selected material is found
*endif
*end materials
*# end if material exists
*endif
*# End Vy
*endif
*#-----
*# My definition
*#-----
*if(DefineMymaterial==1)
*set var SelectedMymaterial=tcl(FindMaterialNumber *MatProp(Moment-curvature_about_local_y-y) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedMymaterial )
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelectedMymaterial==MaterialID)
*set var dummy=tcl(AddUsedMaterials *MaterialID)
*if(strcmp(MatProp(Material:),"Elastic")==0)
*include ..\Materials\Uniaxial\ElasticPy.bas
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlastic")==0)
*include ..\Materials\Uniaxial\ElasticPPPy.bas
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlasticwithGap")==0)
*include ..\Materials\Uniaxial\ElasticPPwithGapPy.bas
*elseif(strcmp(MatProp(Material:),"Steel01")==0)
*include ..\Materials\Uniaxial\Steel01Py.bas
*elseif(strcmp(MatProp(Material:),"ReinforcingSteel")==0)
*include ..\Materials\Uniaxial\ReinforcingSteelPy.bas
*elseif(strcmp(MatProp(Material:),"RambergOsgoodSteel")==0)
*include ..\Materials\Uniaxial\RambergOsgoodSteelPy.bas
*elseif(strcmp(MatProp(Material:),"Hysteretic")==0)
*include ..\Materials\Uniaxial\HystereticPy.bas
*elseif(strcmp(MatProp(Material:),"Concrete01")==0)
*include ..\Materials\Uniaxial\Concrete01Py.bas
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*include ..\Materials\Uniaxial\Concrete02Py.bas
*elseif(strcmp(MatProp(Material:),"Concrete04")==0)
*include ..\Materials\Uniaxial\Concrete04Py.bas
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*include ..\Materials\Uniaxial\Concrete06Py.bas
*elseif(strcmp(MatProp(Material:),"ConcreteCM")==0)
*include ..\Materials\Uniaxial\ConcreteCMPy.bas
*elseif(strcmp(MatProp(Material:),"Series")==0 || strcmp(MatProp(Material:),"Parallel")==0)
*include ..\Materials\Uniaxial\SeriesParallelPy.bas
*elseif(strcmp(MatProp(Material:),"InitStrain")==0)
*include ..\Materials\Uniaxial\InitialStrainPy.bas
*elseif(strcmp(MatProp(Material:),"InitStress")==0)
*include ..\Materials\Uniaxial\InitialStressPy.bas
*else
*MessageBox Error: Invalid uniaxial My material selected for Section Aggregator
*# end if Material is Elastic ElasticPP etc.
*endif
*break
*# end if selected material is found
*endif
*end materials
*# end if material exists
*endif
*# end My
*endif
*#-----
*# Vz definition
*#-----
*if(DefineVzmaterial==1)
*set var SelectedVzmaterial=tcl(FindMaterialNumber *MatProp(Shear_force-deformation_along_local_z-z) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedVzmaterial )
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelectedVzmaterial==MaterialID)
*set var dummy=tcl(AddUsedMaterials *MaterialID)
*if(strcmp(MatProp(Material:),"Elastic")==0)
*include ..\Materials\Uniaxial\ElasticPy.bas
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlastic")==0)
*include ..\Materials\Uniaxial\ElasticPPPy.bas
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlasticwithGap")==0)
*include ..\Materials\Uniaxial\ElasticPPwithGapPy.bas
*elseif(strcmp(MatProp(Material:),"Steel01")==0)
*include ..\Materials\Uniaxial\Steel01Py.bas
*elseif(strcmp(MatProp(Material:),"ReinforcingSteel")==0)
*include ..\Materials\Uniaxial\ReinforcingSteelPy.bas
*elseif(strcmp(MatProp(Material:),"RambergOsgoodSteel")==0)
*include ..\Materials\Uniaxial\RambergOsgoodSteelPy.bas
*elseif(strcmp(MatProp(Material:),"Hysteretic")==0)
*include ..\Materials\Uniaxial\HystereticPy.bas
*elseif(strcmp(MatProp(Material:),"Concrete01")==0)
*include ..\Materials\Uniaxial\Concrete01Py.bas
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*include ..\Materials\Uniaxial\Concrete02Py.bas
*elseif(strcmp(MatProp(Material:),"Concrete04")==0)
*include ..\Materials\Uniaxial\Concrete04Py.bas
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*include ..\Materials\Uniaxial\Concrete06Py.bas
*elseif(strcmp(MatProp(Material:),"ConcreteCM")==0)
*include ..\Materials\Uniaxial\ConcreteCMPy.bas
*elseif(strcmp(MatProp(Material:),"Series")==0 || strcmp(MatProp(Material:),"Parallel")==0)
*include ..\Materials\Uniaxial\SeriesParallelPy.bas
*elseif(strcmp(MatProp(Material:),"InitStrain")==0)
*include ..\Materials\Uniaxial\InitialStrainPy.bas
*elseif(strcmp(MatProp(Material:),"InitStress")==0)
*include ..\Materials\Uniaxial\InitialStressPy.bas
*else
*MessageBox Error: Invalid uniaxial Vz material selected for Section Aggregator
*# end if Material is Elastic ElasticPP etc.
*endif
*break
*# end if selected material is found
*endif
*end materials
*# end if material exists
*endif
*# end Vz
*endif
*#-----
*# T definition
*#-----
*if(DefineTmaterial==1)
*set var SelectedTmaterial=tcl(FindMaterialNumber *MatProp(Torsion_force-deformation) *DomainNum)
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedTmaterial )
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *MatProp(0) *DomainNum)
*if(SelectedTmaterial==MaterialID)
*set var dummy=tcl(AddUsedMaterials *MaterialID)
*if(strcmp(MatProp(Material:),"Elastic")==0)
*include ..\Materials\Uniaxial\ElasticPy.bas
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlastic")==0)
*include ..\Materials\Uniaxial\ElasticPPPy.bas
*elseif(strcmp(MatProp(Material:),"ElasticPerfectlyPlasticwithGap")==0)
*include ..\Materials\Uniaxial\ElasticPPwithGapPy.bas
*elseif(strcmp(MatProp(Material:),"Steel01")==0)
*include ..\Materials\Uniaxial\Steel01Py.bas
*elseif(strcmp(MatProp(Material:),"ReinforcingSteel")==0)
*include ..\Materials\Uniaxial\ReinforcingSteelPy.bas
*elseif(strcmp(MatProp(Material:),"RambergOsgoodSteel")==0)
*include ..\Materials\Uniaxial\RambergOsgoodSteelPy.bas
*elseif(strcmp(MatProp(Material:),"Hysteretic")==0)
*include ..\Materials\Uniaxial\HystereticPy.bas
*elseif(strcmp(MatProp(Material:),"Concrete01")==0)
*include ..\Materials\Uniaxial\Concrete01Py.bas
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*include ..\Materials\Uniaxial\Concrete02Py.bas
*elseif(strcmp(MatProp(Material:),"Concrete04")==0)
*include ..\Materials\Uniaxial\Concrete04Py.bas
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*include ..\Materials\Uniaxial\Concrete06Py.bas
*elseif(strcmp(MatProp(Material:),"ConcreteCM")==0)
*include ..\Materials\Uniaxial\ConcreteCMPy.bas
*elseif(strcmp(MatProp(Material:),"Series")==0 || strcmp(MatProp(Material:),"Parallel")==0)
*include ..\Materials\Uniaxial\SeriesParallelPy.bas
*elseif(strcmp(MatProp(Material:),"InitStrain")==0)
*include ..\Materials\Uniaxial\InitialStrainPy.bas
*elseif(strcmp(MatProp(Material:),"InitStress")==0)
*include ..\Materials\Uniaxial\InitialStressPy.bas
*else
*MessageBox Error: Invalid uniaxial T material selected for Section Aggregator
*# end if Material is Elastic ElasticPP etc.
*endif
*break
*# end if selected material is found
*endif
*end materials
*# end if material exists
*endif
*# end T
*endif
*if(ndime==3)
ops.section("Aggregator", *SectionAggregatorTag, *\
*if(DefinePmaterial==1)
*tcl(FindMaterialNumber *MatProp(Axial_force-deformation) *DomainNum), "P", *\
*endif
*if(DefineMzmaterial==1)
*tcl(FindMaterialNumber *MatProp(Moment-curvature_about_local_z-z) *DomainNum), "Mz", *\
*endif
*if(DefineVymaterial==1)
*tcl(FindMaterialNumber *MatProp(Shear_force-deformation_along_local_y-y) *DomainNum), "Vy", *\
*endif
*if(DefineMymaterial==1)
*tcl(FindMaterialNumber *MatProp(Moment-curvature_about_local_y-y) *DomainNum), "My", *\
*endif
*if(DefineVzmaterial==1)
*tcl(FindMaterialNumber *MatProp(Shear_force-deformation_along_local_z-z) *DomainNum), "Vz", *\
*endif
*if(DefineTmaterial==1)
*tcl(FindMaterialNumber *MatProp(Torsion_force-deformation) *DomainNum), "T" *\
*endif
*if(DefineSection==1)
*# optional
"-section", *SelectedSection)
*else

*endif
*# 2D
*else
ops.section("Aggregator", *SectionAggregatorTag, *\
*if(DefinePmaterial==1)
*tcl(FindMaterialNumber *MatProp(Axial_force-deformation) *DomainNum), "P", *\
*endif
*if(DefineMzmaterial==1)
*tcl(FindMaterialNumber *MatProp(Moment-curvature_about_local_z-z) *DomainNum), "Mz", *\
*endif
*if(DefineVymaterial==1)
*tcl(FindMaterialNumber *MatProp(Shear_force-deformation_along_local_y-y) *DomainNum), "Vy", *\
*endif
*if(DefineSection==1)
*# optional
"-section", *SelectedSection)
*else

*endif
*endif
*# --------------------------- END OF SECTION AGGREGATOR ---------------------------
