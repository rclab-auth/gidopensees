def DeckFiberSection2D(secID, GJ, conc1ID, conc2ID, steel1ID, steel2ID, steel3ID, steelbeamID, extTendonSteelID, intTendonSteelID, tendons, nsteeltop1, nsteelbot1, nsteeltop2, nsteelbot2, nsteeltop3, nsteelbot3, nbeamsteelfacey, nbeamsteelfacez, steelArea1, steelArea2, steelArea3, beamSteelArea, intTendonArea, extTendonArea, width1, thick1, width2, thick2, thick3, swwidth, swthick, beamwidth, beamheight, cover, extWebThick, nvoid, hv, dv, ycoordTopIntTendon, ycoordBotIntTendon, ycoordTopExtTendon, ycoordBotExtTendon, nfy1, nfz1, nfy2, nfz2, nfzextweb, nfyweb, nfzintweb, nfybeam, nfzbeam):

    if nvoid!=0:
        nintwebs = nvoid - 1 # number of internal webs
    else:
        nintwebs = 0.0
        dv = 0.0
        extWebThick = width2 / 2

    if nintwebs:
        intWebThick = (width2-2**extWebThick-nvoid**dv)/nintwebs
    else:
        intWebThick = 0.0

    if nfz1 < 16:
        nfz1 = 16

    height = thick1 + thick2 + hv # total external height of the man section, not including top slab and sidewalk

    # Concrete Areas
    Area1 = thick1 ** width1 # Area of the middle slab
    Area2 = thick2 ** width2 # Area of the bottom slab
    Area3 = thick3 ** width1 # Area of the top slab
    swslabArea = swthick**(swwidth-beamwidth)
    beamArea = beamheight**beamwidth
    extWebArea = hv**extWebThick # Area of the external web
    intWebArea = hv**intWebThick # Area of the internal web
    totalArea = Area1+Area2+Area3+nintwebs**intWebArea+2**extWebArea+2**swslabArea+2**beamArea # Total Area of the deck Section

    ycm = (Area1**(height-thick1/2)+(Area2**thick2/2)+(Area3**(height+thick3/2))+2**(swslabArea**(height+thick3+swthick/2))+2**(beamArea**(height+thick3+swthick-beamheight/2))+(nintwebs**intWebArea)**(thick2+hv/2)+(2**extWebArea)**(thick2+hv/2))/totalArea

    ops.section("Fiber", secID, "-GJ", GJ)

        ###################
        # CONCRETE FIBERS #
        ###################

    # create the rectangular concrete fibers for the middle slab
    #patch quad  conc2ID  nfy1  nfz1 [expr  height- ycm- thick1] [expr - width1/2] [expr  height- ycm- thick1] [expr + width1/2] [expr  height- ycm] [expr + width1/2] [expr  height- ycm] [expr - width1/2]
    ops.patch("rect", conc2ID, nfy1 ,nfz1 , height-ycm-thick1, -width1/2, height-ycm, +width1/2)
    
    # create the rectangular concrete fibers for the bottom slab
    #patch quad  conc2ID  nfy2  nfz2 [expr - ycm] [expr - width2/2] [expr - ycm] [expr + width2/2] [expr - ycm+ thick2] [expr + width2/2] [expr - ycm+ thick2] [expr - width2/2]
    ops.patch("rect", conc2ID, nfy2, nfz2, -ycm, -width2/2, -ycm+thick2, +width2/2)
    
    # create the negative local z dir external web
    #patch quad  conc2ID  nfzextweb  nfyweb [expr - ycm+ thick2] [expr - width2/2] [expr - ycm+ thick2] [expr - width2/2+ extWebThick] [expr - ycm+ thick2+ hv] [expr - width2/2+ extWebThick] [expr - ycm+ thick2+ hv] [expr - width2/2]
    ops.patch("rect", conc2ID, nfzextweb, nfyweb, -ycm+thick2, -width2/2, -ycm+thick2+hv, -width2/2+extWebThick)
    
    # create the positive local z dir external web
    #patch quad  conc2ID  nfyweb  nfzextweb [expr - ycm+ thick2] [expr + width2/2- extWebThick] [expr - ycm+ thick2] [expr  width2/2] [expr - ycm+ thick2+ hv] [expr  width2/2] [expr - ycm+ thick2+ hv] [expr  width2/2- extWebThick]
    ops.patch("rect", conc2ID, nfyweb, nfzextweb, -ycm+thick2, +width2/2-extWebThick, -ycm+thick2+hv, width2/2)

    if thick3:
        # create the rectangular concrete fibers for the top slab with different concrete material
        ops.patch("rect", conc1ID, nfy1, nfz1, height-ycm, -width1/2, height-ycm+thick3, width1/2)
    

    if swthick and swwidth:
        # create the concrete fibers for the sidewalk slab
        # right
        #patch quad  conc1ID  nfy1 [expr int( nfz1/3)] [expr  height- ycm+ thick3] [expr - width1/2] [expr  height- ycm+ thick3] [expr - width1/2+ swwidth- beamwidth] [expr  height- ycm+ thick3+ swthick] [expr - width1/2+ swwidth- beamwidth] [expr  height- ycm+ thick3+ swthick] [expr - width1/2]
        ops.patch("rect", conc1ID, nfy1, int(nfz1/3), height-ycm+thick3, -width1/2, height-ycm+thick3+swthick, -width1/2+swwidth-beamwidth)
        # left
        #patch quad  conc1ID  nfy1 [expr int( nfz1/3)] [expr  height- ycm+ thick3] [expr  width1/2- swwidth+ beamwidth] [expr  height- ycm+ thick3] [expr  width1/2] [expr  height- ycm+ thick3+ swthick] [expr  width1/2] [expr  height- ycm+ thick3+ swthick] [expr  width1/2- swwidth+ beamwidth]
        ops.patch("rect", conc1ID, nfy1, int(nfz1/3), height-ycm+thick3, width1/2-swwidth+beamwidth, height-ycm+thick3+swthick, width1/2)
    if beamwidth and beamheight:
        # create the sidewalk beams
        # right
        #patch quad  conc1ID  nfybeam  nfzbeam [expr  height- ycm+ thick3+ swthick- beamheight] [expr - width1/2- beamwidth] [expr  height- ycm+ thick3+ swthick- beamheight] [expr - width1/2] [expr  height- ycm+ thick3+ swthick] [expr - width1/2] [expr  height- ycm+ thick3+ swthick] [expr - width1/2- beamwidth]
        ops.patch("rect", conc1ID, nfybeam, nfzbeam, height-ycm+thick3+swthick-beamheight, -width1/2-beamwidth, height-ycm+thick3+swthick, -width1/2)
        # left
        #patch quad  conc1ID  nfybeam  nfzbeam [expr  height- ycm+ thick3+ swthick- beamheight] [expr  width1/2] [expr  height- ycm+ thick3+ swthick- beamheight] [expr  width1/2+ beamwidth] [expr  height- ycm+ thick3+ swthick] [expr  width1/2+ beamwidth] [expr  height- ycm+ thick3+ swthick] [expr  width1/2]
        ops.patch("rect", conc1ID, nfybeam, nfzbeam, height-ycm+thick3+swthick-beamheight, width1/2, height-ycm+thick3+swthick, width1/2+beamwidth)
    # create the internal web concrete fibers
    for i in range(nintwebs):
        zincr = (i-1)**(dv+intWebThick)
        #patch quad  conc2ID  nfyweb  nfzintweb [expr - ycm+ thick2] [expr (- width2/2)+ extWebThick+ dv+ zincr] [expr - ycm+ thick2] [expr (- width2/2)+ extWebThick+ dv+ zincr+ intWebThick] [expr - ycm+ thick2+ hv] [expr (- width2/2)+ extWebThick+ dv+ zincr+ intWebThick] [expr - ycm+ thick2+ hv] [expr (- width2/2)+ extWebThick+ dv+ zincr]
        ops.patch("rect", conc2ID, nfyweb, nfzintweb, -ycm+thick2, (-width2/2)+extWebThick+dv+zincr, -ycm+thick2+hv, (-width2/2)+extWebThick+dv+zincr+intWebThick)


    #################
    # REINFORCEMENT #
    #################

    # top slab - top reinforcement
    ops.layer("straight", steel3ID, nsteeltop3, steelArea3, height- ycm+thick3-cover, -width1/2+cover, height-ycm+thick3-cover, +width1/2-cover)
    # top slab - bottom reinforcement
    ops.layer("straight", steel3ID, nsteelbot3, steelArea3, height-ycm+cover, -width1/2+cover, height-ycm+cover, +width1/2-cover)
    # middle slab - top reinforcement
    ops.layer("straight", steel1ID, nsteeltop1, steelArea1, height-ycm-cover, -width1/2+cover, height-ycm-cover, width1/2-cover)
    # middle slab - bottom reinforcement
    ops.layer("straight", steel1ID, nsteelbot1, steelArea1, height-ycm-thick1+cover, -width1/2+cover, height-ycm-thick1+cover, +width1/2-cover)
    # bottom slab - top reinforcement
    ops.layer("straight", steel2ID, nsteeltop2, steelArea2, -ycm-cover+thick2, -width2/2+cover, -ycm-cover+thick2, +width2/2-cover)
    # bottom slab - bottom reinforcement
    ops.layer("straight", steel2ID, nsteelbot2, steelArea2, -ycm+cover, -width2/2+cover, -ycm+cover, +width2/2-cover)
    # Beam reinforcement

    if nbeamsteelfacey>=2:

        # corner rebars
        ops.layer("straight", steelbeamID, 2, beamSteelArea, height-ycm+thick3+swthick-beamheight+cover, -width1/2-beamwidth+cover, height-ycm+thick3+swthick-beamheight+cover, -width1/2-cover)
        ops.layer("straight", steelbeamID, 2, beamSteelArea, height-ycm+thick3+swthick-cover, -width1/2-beamwidth+cover, height-ycm+thick3+swthick-cover, -width1/2-cover)
        ops.layer("straight", steelbeamID, 2, beamSteelArea, height-ycm+thick3+swthick-beamheight+cover, width1/2+cover, height-ycm+thick3+swthick-beamheight+cover, width1/2+beamwidth-cover)
        ops.layer("straight", steelbeamID, 2, beamSteelArea, height-ycm+thick3+swthick-cover, width1/2+cover, height-ycm+thick3+swthick-cover, width1/2+beamwidth-cover)

    if nbeamsteelfacey == 3:
        # middle bars
        ops.fiber(height-ycm+thick3+swthick-beamheight+cover, -width1/2-beamwidth/2, beamSteelArea, steelbeamID)
        ops.fiber(height-ycm+thick3+swthick-cover, -width1/2-beamwidth/2, beamSteelArea, steelbeamID)
        ops.fiber(height-ycm+thick3+swthick-beamheight+cover, width1/2+beamwidth/2, beamSteelArea, steelbeamID)
        ops.fiber(height-ycm+thick3+swthick-cover, width1/2+beamwidth/2, beamSteelArea, steelbeamID)
        
    elif nbeamsteelfacey > 3:

        zdist = (beamwidth-2**cover)/(nbeamsteelfacey-1)
        zfirstcoord = width1/2+beamwidth-cover-zdist
        zlastcoord = width1/2+cover+zdist
        ops.layer("straight", steelbeamID, nbeamsteelfacey-2, beamSteelArea, height-ycm+thick3+swthick-cover, zfirstcoord, height- ycm+ thick3+ swthick- cover, zlastcoord)
        ops.layer("straight", steelbeamID, nbeamsteelfacey-2, beamSteelArea, height-ycm+thick3+swthick-beamheight+cover, zfirstcoord, height- ycm+ thick3+ swthick- beamheight+ cover, zlastcoord)
        zfirstcoord = -width1/2-cover-zdist
        zlastcoord = -width1/2-beamwidth+cover+zdist
        ops.layer("straight", steelbeamID, nbeamsteelfacey-2, beamSteelArea, height - ycm + thick3 + swthick - cover, zfirstcoord, height- ycm+ thick3+ swthick- cover, zlastcoord)
        ops.layer("straight", steelbeamID, nbeamsteelfacey-2, beamSteelArea, height - ycm + thick3 + swthick - beamheight+ cover, zfirstcoord, height- ycm+ thick3+ swthick- beamheight+ cover, zlastcoord)

    if nbeamsteelfacez == 3:
        ops.fiber(height- ycm+ thick3+ swthick- beamheight/2, - width1/2- beamwidth+ cover, beamSteelArea,  steelbeamID)
        ops.fiber(height- ycm+ thick3+ swthick- beamheight/2, - width1/2- cover, beamSteelArea, steelbeamID)
        ops.fiber(height- ycm+ thick3+ swthick- beamheight/2,  width1/2+ cover, beamSteelArea, steelbeamID)
        ops.fiber(height- ycm+ thick3+ swthick- beamheight/2,  width1/2+ beamwidth- cover, beamSteelArea, steelbeamID)
    elif nbeamsteelfacez > 3:
        ydist = (beamheight-2** cover)/( nbeamsteelfacez-1)
        yfirstcoord = height- ycm+ thick3+ swthick- beamheight+ cover+ ydist
        ylastcoord = height- ycm+ thick3+ swthick- cover- ydist
        ops.layer("straight", steelbeamID, nbeamsteelfacez-2, beamSteelArea, yfirstcoord, - width1/2- beamwidth+ cover, ylastcoord, expr - width1/2- beamwidth+ cover)
        ops.layer("straight", steelbeamID, nbeamsteelfacez-2, beamSteelArea, yfirstcoord, - width1/2- cover, ylastcoord, -width1/2- cover)
        ops.layer("straight", steelbeamID, nbeamsteelfacez-2, beamSteelArea, yfirstcoord,  width1/2+ cover, ylastcoord, width1/2+ cover)
        ops.layer("straight", steelbeamID, nbeamsteelfacez-2, beamSteelArea, yfirstcoord,  width1/2+ beamwidth- cover, ylastcoord, width1/2+ beamwidth- cover)

        # tendons

    if tendons:
        if nvoid!=0:
            ops.fiber(ycoordTopExtTendon- ycm, - width2/2+ extWebThick/2, extTendonArea, extTendonSteelID)
            ops.fiber(ycoordBotExtTendon- ycm, - width2/2+ extWebThick/2, extTendonArea, extTendonSteelID)
            ops.fiber(ycoordTopExtTendon- ycm,  width2/2- extWebThick/2, extTendonArea, extTendonSteelID)
            ops.fiber(ycoordBotExtTendon- ycm,  width2/2- extWebThick/2, extTendonArea, extTendonSteelID)
            for i in range(nintwebs):
                zincr = ( i-1)**( dv+ intWebThick)
                ops.fiber(ycoordTopIntTendon- ycm, (- width2/2)+ extWebThick+ dv+ intWebThick/2+ zincr, intTendonArea, intTendonSteelID)
                ops.fiber(ycoordBotIntTendon- ycm, (- width2/2)+ extWebThick+ dv+ intWebThick/2+ zincr, intTendonArea, intTendonSteelID)
