proc BookMatName {matName} {
set bookName [GiD_Info materials $matName book]
set bookVar [list "Beam-Column_Elements" "Truss_Elements"]

foreach {i booki} {{Beam-Column_Elements} {3} {Truss_Elements} {2} } {
if {[string compare $bookName $i] == 0} {return $booki} }
}

