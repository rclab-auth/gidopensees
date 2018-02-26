namespace eval nD {}

proc nD::GenerateValues { event args } {

	switch $event {

		INIT {

			return ""
		}

		SYNC {

			set GDN [lindex $args 0]
			set STRUCT [lindex $args 1]
			set QUESTION [lindex $args 2]
			set unit "MPa"
			set Eunit "GPa"
			set matType [DWLocalGetValue $GDN $STRUCT $QUESTION]
			set mat [DWLocalGetValue $GDN $STRUCT "Material:"]

			switch $matType {
				"Concrete" {
					set Concrete_class [DWLocalGetValue $GDN $STRUCT "Concrete_class"]
					switch $Concrete_class {
						"C12/15" {
							set E 27
							set poisson 0.20
						}
						"C16/20" {
							set E 29
							set poisson 0.20
						}
						"C20/25" {
							set E 30
							set poisson 0.20
						}
						"C25/30" {
							set E 31
							set poisson 0.20
						}
						"C30/37" {
							set E 33
							set poisson 0.20
						}
						"C35/45" {
							set E 34
							set poisson 0.20
						}
						"C40/50" {
							set E 35
							set poisson 0.20
						}
						"C45/55" {
							set E 36
							set poisson 0.20
						}
						"C50/60" {
							set E 37
							set poisson 0.20
						}
						"C55/67" {
							set E 38
							set poisson 0.20
						}
						"C60/75" {
							set E 39
							set poisson 0.20
						}
						"C70/85" {
							set E 41
							set poisson 0.20
						}
						"C80/95" {
							set E 42
							set poisson 0.20
						}
						"C90/105" {
							set E 44
							set poisson 0.20
						}
						default {
							return ""
						}
					}

				}
				"Steel" {
					set E 200
					set poisson 0.30
				}
				default {
					return ""
				}
			}
			switch $mat {
				"ElasticIsotropic" {
					set ok [DWLocalSetValue $GDN $STRUCT "Elastic_modulus_E" $E$Eunit]
					set ok [DWLocalSetValue $GDN $STRUCT "Poisson's_ratio" $poisson]
				}
				default {
					return ""
				}
			}

			return ""
		}

		DEPEND {

			return ""
		}

		CLOSE {

			return ""
		}
	}

	return ""
}