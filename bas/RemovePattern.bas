*if(IntvData(Remove_load_pattern_at_the_end_of_the_interval_analysis,int)==1)
*if(strcmp(IntvData(Analysis_type),"Static")==0)
*if(strcmp(IntvData(Loading_type),"Constant")==0 || strcmp(IntvData(Loading_type),"Linear")==0)
remove loadPattern *PatternTag
*endif
*elseif(strcmp(IntvData(Analysis_type),"Transient")==0)
*if(strcmp(IntvData(Loading_type),"Function")==0)
remove loadPattern *PatternTag
*elseif(strcmp(IntvData(Loading_type),"Multiple_support_excitation")==0)
remove loadPattern *PatternTag
*elseif(strcmp(IntvData(Loading_type),"Uniform_excitation")==0)
*if(strcmp(IntvData(Excitation_type),"Sine")==0)
remove loadPattern *IDGMLoadPatternTag
*elseif(strcmp(IntvData(Excitation_type),"Record")==0)
remove loadPattern *operation(100*IntvNum+50)
*endif
*endif
*endif
*endif