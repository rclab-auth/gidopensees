proc TK_CheckMaterialForElasticBeamColumn { event args } {
switch $event {
   INIT {
   #...
    return ""
   }
   SYNC {
   
  set GDN [lindex $args 0]
  set STRUCT [lindex $args 1]
  set QUESTION [lindex $args 2]

  # i.e. ChoosedMaterial can be Elastic_Orthotropic (from combo box "Material" in beam column definition)  
  set ChoosedMaterial [DWLocalGetValue $GDN $STRUCT $QUESTION]
   	
	#GiD_AccessValue get materials : Search the value of a field of a material.
	# $ChoosedMaterial is the material name
   # Material: is the question name of the material $ChoosedMaterial
 set MatType [GiD_AccessValue get materials $ChoosedMaterial "Material:"]
 #MatType is the value of the question: Material: of the chosen material from the combo box!
 
  if { $MatType == "ElasticOrthotropic"} {
  WarnWinText "ERROR: Material $ChoosedMaterial which is an $MatType material can not be used for beam-column elements. Use an elastic isotropic material instead."
                      
	 # Change the value of the field "Material:" to Elastic_Isotropic 				  
	 DWLocalSetValue $GDN $STRUCT $QUESTION "Elastic_Isotropic"	
    }	 
     return ""
   }
   DEPEND {
   # ...
    return ""
   }
   CLOSE {
   # ...
    return ""
   }
 }
 return ""
}


proc TK_CheckModelingOptionsForBeamColumnElems { event args } {
switch $event {
   INIT {
   #...
    return ""
   }
   SYNC {
   
  set GDN [lindex $args 0]
  set STRUCT [lindex $args 1]
  set QUESTION [lindex $args 2]

   	
 
   # Dimensions : the question name 
 set ndm [GiD_AccessValue get gendata "Dimensions"]
 set dof [GiD_AccessValue get gendata "DOF"]
 # ndm : number of dimensions of the project
 # dof : degrees of freedom per node
 
  if { $ndm == "2" && $dof== "2" } {
   WarnWinText "WARNING: Beam-Column Elements require a 2D / 3 DOF model or a 3D/6DOF model"
   } elseif {$ndm=="2" && $dof=="6"} {
   WarnWinText "WARNING: Beam-Column Elements require a 2D / 3DOF model or a 3D/6DOF model"
   } elseif {$ndm=="3" && $dof=="3"} {
   WarnWinText "WARNING: Beam-Column Elements require a 2D / 3 DOF model or a 3D/6DOF model"
   }
     return ""
   }
   DEPEND {
   # ...
    return ""
   }
   CLOSE {
   # ...
    return ""
   }
 }
 return ""
}




proc TK_CheckModelingOptionsForQuadElems { event args } {
switch $event {
   INIT {
   #...
    return ""
   }
   SYNC {
   
  set GDN [lindex $args 0]
  set STRUCT [lindex $args 1]
  set QUESTION [lindex $args 2]

   	
 
   # Dimensions : the question name 
 set ndm [GiD_AccessValue get gendata "Dimensions"]
 set dof [GiD_AccessValue get gendata "DOF"]
 # ndm : number of dimensions of the project
 # dof : degrees of freedom per node
 
  if { $ndm != "2" || $dof != "2"} {
  WarnWinText "WARNING: Quad elements require 2D model with 2 DOFs per node !"
                      }
     return ""
   }
   DEPEND {
   # ...
    return ""
   }
   CLOSE {
   # ...
    return ""
   }
 }
 return ""
}

proc TK_CheckModelingOptionsForBrickElems { event args } {
switch $event {
   INIT {
   #...
    return ""
   }
   SYNC {
   
  set GDN [lindex $args 0]
  set STRUCT [lindex $args 1]
  set QUESTION [lindex $args 2]

   	
 
   # Dimensions : the question name 
 set ndm [GiD_AccessValue get gendata "Dimensions"]
 set dof [GiD_AccessValue get gendata "DOF"]
 # ndm : number of dimensions of the project
 # dof : degrees of freedom per node
 
  if { $ndm != "3" || $dof != "3"} {
  WarnWinText "WARNING: Standard Brick elements require 3D model with 3 DOFs per node !"
                      }
     return ""
   }
   DEPEND {
   # ...
    return ""
   }
   CLOSE {
   # ...
    return ""
   }
 }
 return ""
}


proc TK_CheckModelingOptions { event args } {
switch $event {
   INIT {
   #...
    return ""
   }
   SYNC {
   
  set GDN [lindex $args 0]
  set STRUCT [lindex $args 1]
  set QUESTION [lindex $args 2]

   	
 
   # Dimensions : the question name 
 set ndm [GiD_AccessValue get gendata "Dimensions"]
 set dof [GiD_AccessValue get gendata "DOF"]
 # ndm : number of dimensions of the project
 # dof : degrees of freedom per node
 
  if { ($ndm == "3" && $dof == "2") || ($ndm == "2" && $dof== "6") } {
  WarnWinText "WARNING: You CANNOT define $dof DOF in a $ndm Dimensions Model! Please change your options."
                      }
     return ""
   }
   DEPEND {
   # ...
    return ""
   }
   CLOSE {
   # ...
    return ""
   }
 }
 return ""
}