namespace eval ElasticSection {}

proc ElasticSection::CalcArea {event args} {

	switch $event {

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			set CrossSectionType [DWLocalGetValue $GDN $STRUCT Cross_section]

			if {$CrossSectionType == "Rectangular"} {

				set heightUnit [DWLocalGetValue $GDN $STRUCT Height_h]
				set widthUnit [DWLocalGetValue $GDN $STRUCT Width_b]
				set temp [GidConvertValueUnit $widthUnit]
				set temp [ParserNumberUnit $temp width lengthunit]
				set temp [GidConvertValueUnit $heightUnit]
				set temp [ParserNumberUnit $temp height lengthunit]
				set Areaunit $lengthunit^2

				set AreaSize [expr $height*$width]
				set Area $AreaSize$Areaunit
				set ok [DWLocalSetValue $GDN $STRUCT "ElasticSection_Area" $Area]

			} elseif {$CrossSectionType == "Tee" } {

				set heightUnit [DWLocalGetValue $GDN $STRUCT Height_h]
				set widthUnit [DWLocalGetValue $GDN $STRUCT Width_bf]
				set SlabThickUnit [DWLocalGetValue $GDN $STRUCT Height_hf]
				set WebThickUnit [DWLocalGetValue $GDN $STRUCT Width_bw]

				set temp [GidConvertValueUnit $widthUnit]
				set temp [ParserNumberUnit $temp w Wunit]
				set temp [GidConvertValueUnit $heightUnit]
				set temp [ParserNumberUnit $temp h Hunit]
				set temp [GidConvertValueUnit $SlabThickUnit]
				set temp [ParserNumberUnit $temp ts tsUnit]
				set temp [GidConvertValueUnit $WebThickUnit]
				set temp [ParserNumberUnit $temp tw twUnit]

				set Areaunit $Hunit^2

				set AreaSize [expr $w*$ts+($h-$ts)*$tw]
				set Area $AreaSize$Areaunit
				set ok [DWLocalSetValue $GDN $STRUCT "ElasticSection_Area" $Area]

			} elseif {$CrossSectionType == "Circular"} {

				set diameterunit [DWLocalGetValue $GDN $STRUCT Diameter_d]
				set temp [GidConvertValueUnit $diameterunit]
				set temp [ParserNumberUnit $temp diameter Dunit]
				set diameter [format "%f" $diameter]

				set Areaunit $Dunit^2

				set AreaSize [expr 3.14159265359*$diameter*$diameter/4]
				set Area $AreaSize$Areaunit
				set ok [DWLocalSetValue $GDN $STRUCT "ElasticSection_Area" $Area]

			} elseif {$CrossSectionType == "General" } {

				set Area [DWLocalGetValue $GDN $STRUCT "Area_A"]
				set ok [DWLocalSetValue $GDN $STRUCT "ElasticSection_Area" $Area]
			}
		}
	}
	return ""
}

proc ElasticSection::CalcShearModulus {event args} {

	switch $event {

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]

			set checked [DWLocalGetValue $GDN $STRUCT Calculate_Shear_modulus_(update_to_apply)]

			if {$checked} {

				set Eunit [DWLocalGetValue $GDN $STRUCT Elastic_modulus_E]
				set temp [GidConvertValueUnit $Eunit]
				set temp [ParserNumberUnit $temp E stressunit]
				set nu [DWLocalGetValue $GDN $STRUCT Poisson's_ratio]; # Poisson's ratio

				if {$stressunit == "kPa"} {

					set Gunit "GPa"
					set G [format "%1.8f" [expr $E/(2000000*(1+$nu))]]
					set G $G$Gunit
					set ok [DWLocalSetValue $GDN $STRUCT Shear_modulus_G $G]

				} else {

					set G [format "%1.8f" [expr $E/(2*(1+$nu))]]
					set G $G$stressunit
					set ok [DWLocalSetValue $GDN $STRUCT Shear_modulus_G $G]
				}
			}
		}
	}

	return ""
}