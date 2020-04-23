namespace eval FiberInt {}

proc FiberInt::CheckFieldValues { event args } {

	switch $event {

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			# Check if materials are compatible

			set CompatibleConcreteMaterials " \
			Concrete01 \
			Concrete02 \
			Concrete04 \
			Concrete06 \
			ConcreteCM \
			InitStrain \
			InitStress \
			"

			set CompatibleSteelMaterials " \
			Steel01 \
			Steel02 \
			ReinforcingSteel \
			RamberOsgoodSteel \
			Hysteretic \
			"

			set ChosenCoreMaterial [DWLocalGetValue $GDN $STRUCT "Core_material"]
			set ChosenCoverMaterial [DWLocalGetValue $GDN $STRUCT "Cover_material"]
			set ChosenBarMaterial [DWLocalGetValue $GDN $STRUCT "Reinforcing_Bar_material"]

			set CoreMatType [GiD_AccessValue get materials $ChosenCoreMaterial "Material:"]
			set CoverMatType [GiD_AccessValue get materials $ChosenCoverMaterial "Material:"]
			set BarMatType [GiD_AccessValue get materials $ChosenBarMaterial "Material:"]

			if { [lsearch $CompatibleConcreteMaterials $CoreMatType]==-1 } {
				WarnWinText "Non-compatible Core material ($CoreMatType) selected for FiberInt Section"
				DWLocalSetValue $GDN $STRUCT "Core_material" "Concrete04_(Popovics_concrete)"
			}

			if { [lsearch $CompatibleConcreteMaterials $CoverMatType]==-1 } {
				WarnWinText "Non-compatible Cover material ($CoverMatType) selected for FiberInt Section"
				DWLocalSetValue $GDN $STRUCT "Cover_material" "Concrete04_(Popovics_concrete)"
			}

			if { [lsearch $CompatibleSteelMaterials $BarMatType]==-1 } {
				WarnWinText "Non-compatible steel material ($BarMatType) selected for FiberInt Section"
				DWLocalSetValue $GDN $STRUCT "Reinforcing_Bar_material" "Steel01"
			}

			# Check if numbers of strips are integer and positive

			set leftStrips [DWLocalGetValue $GDN $STRUCT Strips]
			set leftStrips [expr abs(int($leftStrips))]
			set middleStrips [DWLocalGetValue $GDN $STRUCT _Strips]
			set middleStrips [expr abs(int($middleStrips))]
			set rightStrips [DWLocalGetValue $GDN $STRUCT __Strips]
			set rightStrips [expr abs(int($rightStrips))]

			set ok [DWLocalSetValue $GDN $STRUCT Strips $leftStrips]
			set ok [DWLocalSetValue $GDN $STRUCT _Strips $middleStrips]
			set ok [DWLocalSetValue $GDN $STRUCT __Strips $rightStrips]

			# ------- Check positive values -------

			set leftThicknessUnit [DWLocalGetValue $GDN $STRUCT Thickness]
			set middleThicknessUnit [DWLocalGetValue $GDN $STRUCT _Thickness]
			set rightThicknessUnit [DWLocalGetValue $GDN $STRUCT __Thickness]
			set leftWidthUnit [DWLocalGetValue $GDN $STRUCT Width]
			set middleWidthUnit [DWLocalGetValue $GDN $STRUCT _Width]
			set rightWidthUnit [DWLocalGetValue $GDN $STRUCT __Width]
			set leftCoverUnit [DWLocalGetValue $GDN $STRUCT Cover]
			set rightCoverUnit [DWLocalGetValue $GDN $STRUCT _Cover]
			set leftSteelAreaUnit [DWLocalGetValue $GDN $STRUCT Steel_area]
			set middleSteelAreaUnit [DWLocalGetValue $GDN $STRUCT _Steel_area]
			set rightSteelAreaUnit [DWLocalGetValue $GDN $STRUCT __Steel_area]
			set horizontalSteelAreaUnit [DWLocalGetValue $GDN $STRUCT ___Steel_area]

			# Seperate values from units

			set temp [GidConvertValueUnit $leftThicknessUnit]
			set temp [ParserNumberUnit $temp leftThickness thicknessUnit]
			set temp [GidConvertValueUnit $middleThicknessUnit]
			set temp [ParserNumberUnit $temp middleThickness dummy]
			set temp [GidConvertValueUnit $rightThicknessUnit]
			set temp [ParserNumberUnit $temp rightThickness dummy]
			set temp [GidConvertValueUnit $leftWidthUnit]
			set temp [ParserNumberUnit $temp leftWidth widthUnit]
			set temp [GidConvertValueUnit $middleWidthUnit]
			set temp [ParserNumberUnit $temp middleWidth dummy]
			set temp [GidConvertValueUnit $rightWidthUnit]
			set temp [ParserNumberUnit $temp rightWidth dummy]
			set temp [GidConvertValueUnit $leftCoverUnit]
			set temp [ParserNumberUnit $temp leftCover CoverUnit]
			set temp [GidConvertValueUnit $rightCoverUnit]
			set temp [ParserNumberUnit $temp rightCover dummy]
			set temp [GidConvertValueUnit $leftSteelAreaUnit]
			set temp [ParserNumberUnit $temp leftSteelArea SteelAreaUnit]
			set temp [GidConvertValueUnit $middleSteelAreaUnit]
			set temp [ParserNumberUnit $temp middleSteelArea dummy]
			set temp [GidConvertValueUnit $rightSteelAreaUnit]
			set temp [ParserNumberUnit $temp rightSteelArea dummy]
			set temp [GidConvertValueUnit $horizontalSteelAreaUnit]
			set temp [ParserNumberUnit $temp horizontalSteelArea dummy]

			# change to absolute values with their units

			set leftThickness [expr abs($leftThickness)]
			set leftThickness $leftThickness$thicknessUnit

			set middleThickness [expr abs($middleThickness)]
			set middleThickness $middleThickness$thicknessUnit

			set rightThickness [expr abs($rightThickness)]
			set rightThickness $rightThickness$thicknessUnit

			set leftWidth [expr abs($leftWidth)]
			set leftWidth $leftWidth$widthUnit

			set middleWidth [expr abs($middleWidth)]
			set middleWidth $middleWidth$widthUnit

			set rightWidth [expr abs($rightWidth)]
			set rightWidth $rightWidth$widthUnit

			set leftCover [expr abs($leftCover)]
			set leftCover $leftCover$CoverUnit

			set rightCover [expr abs($rightCover)]
			set rightCover $rightCover$CoverUnit

			set leftSteelArea [expr abs($leftSteelArea)]
			set leftSteelArea $leftSteelArea$SteelAreaUnit

			set middleSteelArea [expr abs($middleSteelArea)]
			set middleSteelArea $middleSteelArea$SteelAreaUnit

			set rightSteelArea [expr abs($rightSteelArea)]
			set rightSteelArea $rightSteelArea$SteelAreaUnit

			set horizontalSteelArea [expr abs($horizontalSteelArea)]
			set horizontalSteelArea $horizontalSteelArea$SteelAreaUnit

			# Change the field values

			set ok [DWLocalSetValue $GDN $STRUCT Thickness $leftThickness]
			set ok [DWLocalSetValue $GDN $STRUCT _Thickness $middleThickness]
			set ok [DWLocalSetValue $GDN $STRUCT __Thickness $rightThickness]

			set ok [DWLocalSetValue $GDN $STRUCT Width $leftWidth]
			set ok [DWLocalSetValue $GDN $STRUCT _Width $middleWidth]
			set ok [DWLocalSetValue $GDN $STRUCT __Width $rightWidth]

			set ok [DWLocalSetValue $GDN $STRUCT Cover $leftCover]
			set ok [DWLocalSetValue $GDN $STRUCT _Cover $rightCover]

			set ok [DWLocalSetValue $GDN $STRUCT Steel_area $leftSteelArea]
			set ok [DWLocalSetValue $GDN $STRUCT _Steel_area $middleSteelArea]
			set ok [DWLocalSetValue $GDN $STRUCT __Steel_area $rightSteelArea]
			set ok [DWLocalSetValue $GDN $STRUCT ___Steel_area $horizontalSteelArea]
		}
	}

	return ""
}
