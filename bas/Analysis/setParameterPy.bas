*set var numBeamContacts=tcl(GetNumberOfBeamContactTags )
*if( numBeamContacts > 0 )
*set var tagindex = 0
*set var idindex = 0
*for(i=1;i<=numBeamContacts;i=i+1)
*set cond Point_Beam_contact_slave_nodes *nodes *CanRepeat
*loop nodes *OnlyInCond
*set var comp=tcl(CompareBeamContactIDs *cond(1) *idindex)
*if(comp)
*set var runTag=tcl(getBeamContactTag *tagindex)
ops.setParameter("-val", 1, "-ele", *runTag, "friction")
*endif
*set var tagindex=operation(tagindex+1)
*end nodes
*set var idindex=operation(idindex+1)
*endfor
*endif