*set var FiberIntTag=SectionID
*if(ndime==2)
*# uniaxial materials selected
*set var SelectedCoreMaterial=tcl(FindMaterialNumber *MatProp(Core_material) *DomainNum)
*set var SelectedCoverMaterial=tcl(FindMaterialNumber *MatProp(Cover_material) *DomainNum)
*set var SelectedRBMaterial=tcl(FindMaterialNumber *MatProp(Reinforcing_Bar_material) *DomainNum)
*set var SelectedRBMaterial=operation(SelectedRBMaterial+1000)
*# Core material definition
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedCoreMaterial )
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *Matprop(0) *DomainNum)
*if(SelectedCoreMaterial==MaterialID)
*if(strcmp(MatProp(Material:),"Concrete01")==0)
*include ..\Materials\Uniaxial\Concrete01.bas
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*include ..\Materials\Uniaxial\Concrete02.bas
*elseif(strcmp(MatProp(Material:),"Concrete04")==0)
*include ..\Materials\Uniaxial\Concrete04.bas
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*include ..\Materials\Uniaxial\Concrete06.bas
*elseif(strcmp(MatProp(Material:),"ConcreteCM")==0)
*include ..\Materials\Uniaxial\ConcreteCM.bas
*elseif(strcmp(MatProp(Material:),"InitStrain")==0)
*include ..\Materials\Uniaxial\InitialStrain.bas
*elseif(strcmp(MatProp(Material:),"InitStress")==0)
*include ..\Materials\Uniaxial\InitialStress.bas
*else
*MessageBox Error: Unsupported Core material for Fiber Section
*endif
*set var dummy=tcl(AddUsedMaterials *SelectedCoreMaterial)
*break
*endif
*end materials
*endif
*# Cover Material DEFINITION
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedCoverMaterial)
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *Matprop(0) *DomainNum)
*if(SelectedCoverMaterial==MaterialID)
*if(strcmp(MatProp(Material:),"Concrete01")==0)
*include ..\Materials\Uniaxial\Concrete01.bas
*elseif(strcmp(MatProp(Material:),"Concrete02")==0)
*include ..\Materials\Uniaxial\Concrete02.bas
*elseif(strcmp(MatProp(Material:),"Concrete04")==0)
*include ..\Materials\Uniaxial\Concrete04.bas
*elseif(strcmp(MatProp(Material:),"Concrete06")==0)
*include ..\Materials\Uniaxial\Concrete06.bas
*elseif(strcmp(MatProp(Material:),"ConcreteCM")==0)
*include ..\Materials\Uniaxial\ConcreteCM.bas
*elseif(strcmp(MatProp(Material:),"InitStrain")==0)
*include ..\Materials\Uniaxial\InitialStrain.bas
*elseif(strcmp(MatProp(Material:),"InitStress")==0)
*include ..\Materials\Uniaxial\InitialStress.bas
*else
*MessageBox Error: Unsupported Cover material for Fiber Section
*endif
*set var dummy=tcl(AddUsedMaterials *SelectedCoverMaterial)
*break
*endif
*end materials
*endif
*# Reinforcing Bar MATERIAL DEFINITION
*set var MaterialExists=tcl(CheckUsedMaterials *SelectedRBMaterial)
*if(MaterialExists==-1)
*loop materials *NotUsed
*set var MaterialID=tcl(FindMaterialNumber *Matprop(0) *DomainNum)
*set var MaterialID=operation(MaterialID+1000)
*if(SelectedRBMaterial==MaterialID)
*if(strcmp(MatProp(Material:),"Steel01")==0)
*include ..\Materials\Uniaxial\Steel01.bas
*elseif(strcmp(MatProp(Material:),"Steel02")==0)
*include ..\Materials\Uniaxial\Steel02.bas
*elseif(strcmp(MatProp(Material:),"ReinforcingSteel")==0)
*include ..\Materials\Uniaxial\ReinforcingSteel.bas
*elseif(strcmp(MatProp(Material:),"RambergOsgoodSteel")==0)
*include ..\Materials\Uniaxial\RambergOsgoodSteel.bas
*elseif(strcmp(MatProp(Material:),"Hysteretic")==0)
*include ..\Materials\Uniaxial\Hysteretic.bas
*else
*MessageBox Error: Unsupported Rebar material for Fiber Section
*endif
*set var dummy=tcl(AddUsedMaterials *SelectedRBMaterial)
*break
*endif
*end materials
*# endif material has been already defined
*endif
*# Thickness
*set var t1=MatProp(Thickness,real)
*set var t2=MatProp(_Thickness,real)
*set var t3=MatProp(__Thickness,real)
*# Width
*set var d1=MatProp(Width,real)
*set var d2=MatProp(_Width,real)
*set var d3=MatProp(__Width,real)
*# cover
*set var c1=MatProp(Cover,real)
*set var c3=MatProp(_Cover,real)
*# Concrete Areas
*set var Area1=operation(t1*d1)
*set var Area2=operation(t2*d2)
*set var Area3=operation(t3*d3)
*# Strips
*set var Strips1=MatProp(Strips,int)
*set var Strips2=MatProp(_Strips,int)
*set var Strips3=MatProp(__Strips,int)
*# Core Areas
*set var CoreArea1=operation((t1-c1)*(d1-c1))
*set var CoreArea3=operation((t3-c3)*(d3-c3))
*# Cover Areas
*set var CoverArea1=operation(Area1-CoreArea1)
*set var CoverArea3=operation(Area3-CoreArea3)
*# Steel Areas
*set var SteelArea1=MatProp(Steel_area,real)
*set var SteelArea2=MatProp(_Steel_area,real)
*set var SteelArea3=MatProp(__Steel_area,real)
*set var HSteelArea=MatProp(___Steel_area,real)
*# horizontal distance per subsection strip
*set var h1=operation(Area1/(Strips1*t1))
*set var h2=operation(Area2/(Strips2*t2))
*set var h3=operation(Area3/(Strips3*t3))

*format "%d%d%g%d%g%d%g"
section FiberInt *FiberIntTag -NStrip *Strips1 *t1 *Strips2 *t2 *Strips3 *t3 {
# First subsection
*for(i=1;i<=Strips1;i=i+1)
# Strip *i
*format "%6g%6g%d"
*#fiber *operation(-Strips2/2*h2-(Strips1-0.5)*h1+(i-1)*h1) 0 *operation(CoreArea1/Strips1) *SelectedCoreMaterial
fiber *operation(-Strips2/2*h2+(0.5-Strips1)*h1+(i-1)*h1) 0 *operation(CoreArea1/Strips1) *SelectedCoreMaterial
*format "%6g%6g%d"
fiber *operation(-Strips2/2*h2+(0.5-Strips1)*h1+(i-1)*h1) 0 *operation(CoverArea1/Strips1) *SelectedCoverMaterial
*format "%6g%6g%d"
fiber *operation(-Strips2/2*h2+(0.5-Strips1)*h1+(i-1)*h1) 0 *operation(SteelArea1/Strips1) *SelectedRBMaterial
*endfor

# Second subsection
*for(i=1;i<=Strips2;i=i+1)
# Strip *i
*format "%6g%6g%d"
fiber *operation(-(Strips2/2-0.5)*h2+(i-1)*h2) 0 *operation(Area2/Strips2) *SelectedCoverMaterial
*format "%6g%6g%d"
fiber *operation(-(Strips2/2-0.5)*h2+(i-1)*h2) 0 *operation(SteelArea2/Strips2) *SelectedRBMaterial
*endfor

# Third subsection
*for(i=1;i<=Strips3;i=i+1)
# Strip *i
*format "%6g%6g%d"
fiber *operation(Strips2/2*h2+0.5*h3+(i-1)*h3) 0 *operation(CoreArea3/Strips3) *SelectedCoreMaterial
*format "%6g%6g%d"
fiber *operation(Strips2/2*h2+0.5*h3+(i-1)*h3) 0 *operation(CoverArea3/Strips3) *SelectedCoverMaterial
*format "%6g%6g%d"
fiber *operation(Strips2/2*h2+0.5*h3+(i-1)*h3) 0 *operation(SteelArea3/Strips3) *SelectedRBMaterial
*endfor

*format "%g%d"
Hfiber 0 0 *HSteelArea *SelectedRBMaterial
}
*endif
