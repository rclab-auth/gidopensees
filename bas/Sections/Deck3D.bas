proc DeckFiberSection3D { secID GJ conc1ID conc2ID steel1ID steel2ID steel3ID steelbeamID extTendonSteelID intTendonSteelID tendons nsteeltop1 nsteelbot1 nsteeltop2 nsteelbot2 nsteeltop3 nsteelbot3 nbeamsteelfacey nbeamsteelfacez steelArea1 steelArea2 steelArea3 beamSteelArea intTendonArea extTendonArea width1 thick1 width2 thick2 thick3 swwidth swthick beamwidth beamheight cover extWebThick nvoid hv dv zcoordTopIntTendon zcoordBotIntTendon zcoordTopExtTendon zcoordBotExtTendon nfy1 nfz1 nfy2 nfz2 nfyextweb nfzweb nfyintweb nfybeam nfzbeam} {

    if {$nvoid!=0} {
        set nintwebs [expr $nvoid-1]; #number of internal webs
    } else {
        set nintwebs 0.0
        set dv 0.0
        set extWebThick [expr $width2/2]
    }

    if {$nintwebs} {
        set intWebThick [expr ($width2-2**$extWebThick-$nvoid**$dv)/$nintwebs]
    } else {
        set intWebThick 0.0
    }

    if {$nfy1<16} {
        set nfy1 16
    }

    set height [expr $thick1+$thick2+$hv]; # total external height of the main section; not including top slab and sidewalk

    # Concrete Areas
    set Area1 [expr $thick1**$width1]; # Area of the middle slab
    set Area2 [expr $thick2**$width2]; # Area of the bottom slab
    set Area3 [expr $thick3**$width1]; # Area of the top slab
    set swslabArea [expr $swthick**($swwidth-$beamwidth)]
    set beamArea [expr $beamheight**$beamwidth]
    set extWebArea [expr $hv**$extWebThick]; # Area of the external web
    set intWebArea [expr $hv**$intWebThick]; # Area of the internal web
    set totalArea [expr $Area1+$Area2+$Area3+$nintwebs**$intWebArea+2**$extWebArea+2**$swslabArea+2**$beamArea]; # Total Area of the deck Section

    set zcm [expr ($Area1**($height-$thick1/2)+($Area2**$thick2/2)+($Area3**($height+$thick3/2))+2**($swslabArea**($height+$thick3+$swthick/2))+2**($beamArea**($height+$thick3+$swthick-$beamheight/2))+($nintwebs**$intWebArea)**($thick2+$hv/2)+(2**$extWebArea)**($thick2+$hv/2))/$totalArea]

    if {$GJ} {

    section Fiber $secID -GJ $GJ {

        ###################
        # CONCRETE FIBERS #
        ###################

        # create the rectangular concrete fibers for the middle slab
        # patch rect $conc1ID $nfy1 $nfz1 [expr -$width1/2] [expr $height-$zcm-$thick1] [expr +$width1/2] [expr $height-$zcm]
        patch quad $conc2ID $nfy1 $nfz1 [expr -$width1/2] [expr $height-$zcm-$thick1] [expr +$width1/2] [expr $height-$zcm-$thick1] [expr +$width1/2] [expr $height-$zcm] [expr -$width1/2] [expr $height-$zcm]

        # create the rectangular concrete fibers for the bottom slab
        # patch rect $conc2ID $nfy2 $nfz2 [expr -$width2/2] [expr -$zcm] [expr +$width2/2] [expr -$zcm+$thick2]
        patch quad $conc2ID $nfy2 $nfz2 [expr -$width2/2] [expr -$zcm] [expr +$width2/2] [expr -$zcm] [expr +$width2/2] [expr -$zcm+$thick2] [expr -$width2/2] [expr -$zcm+$thick2]

        # create the negative local y dir external web
        # patch rect $conc2ID $nfyextweb $nfzweb [expr -$width2/2] [expr -$zcm+$thick2] [expr -$width2/2+$extWebThick] [expr -$zcm+$thick2+$hv]
        patch quad $conc2ID $nfyextweb $nfzweb [expr -$width2/2] [expr -$zcm+$thick2] [expr -$width2/2+$extWebThick] [expr -$zcm+$thick2] [expr -$width2/2+$extWebThick] [expr -$zcm+$thick2+$hv] [expr -$width2/2] [expr -$zcm+$thick2+$hv]

        # create the positive local y dir external web
        # patch rect $conc2ID $nfyextweb $nfzweb [expr +$width2/2] [expr -$zcm+$thick2] [expr +$width2/2-$extWebThick] [expr -$zcm+$thick2+$hv]
        patch quad $conc2ID $nfyextweb $nfzweb [expr +$width2/2-$extWebThick] [expr -$zcm+$thick2] [expr $width2/2] [expr -$zcm+$thick2] [expr $width2/2] [expr -$zcm+$thick2+$hv] [expr $width2/2-$extWebThick] [expr -$zcm+$thick2+$hv]

        if {$thick3} {
        # create the rectangular concrete fibers for the top slab with different concrete material
        patch quad $conc1ID $nfy1 $nfz1 [expr -$width1/2] [expr $height-$zcm] [expr $width1/2] [expr $height-$zcm] [expr $width1/2] [expr $height-$zcm+$thick3] [expr -$width1/2] [expr $height-$zcm+$thick3]
        }

        if {$swthick && $swwidth} {
        # create the concrete fibers for the sidewalk slab
        # left
        patch quad $conc1ID [expr int($nfy1/3)] $nfz1 [expr -$width1/2] [expr $height-$zcm+$thick3] [expr -$width1/2+$swwidth-$beamwidth] [expr $height-$zcm+$thick3] [expr -$width1/2+$swwidth-$beamwidth]  [expr $height-$zcm+$thick3+$swthick] [expr -$width1/2] [expr $height-$zcm+$thick3+$swthick]
        # right
        patch quad $conc1ID [expr int($nfy1/3)] $nfz1 [expr $width1/2-$swwidth+$beamwidth] [expr $height-$zcm+$thick3] [expr $width1/2] [expr $height-$zcm+$thick3] [expr $width1/2] [expr $height-$zcm+$thick3+$swthick] [expr $width1/2-$swwidth+$beamwidth] [expr $height-$zcm+$thick3+$swthick]
        }

        if {$beamwidth && $beamheight} {
        # create the sidewalk beams
        # left
        patch quad $conc1ID $nfybeam $nfzbeam [expr -$width1/2-$beamwidth] [expr $height-$zcm+$thick3+$swthick-$beamheight] [expr -$width1/2] [expr $height-$zcm+$thick3+$swthick-$beamheight] [expr -$width1/2] [expr $height-$zcm+$thick3+$swthick] [expr -$width1/2-$beamwidth] [expr $height-$zcm+$thick3+$swthick]
        # right
        patch quad $conc1ID $nfybeam $nfzbeam [expr $width1/2] [expr $height-$zcm+$thick3+$swthick-$beamheight] [expr $width1/2+$beamwidth] [expr $height-$zcm+$thick3+$swthick-$beamheight] [expr $width1/2+$beamwidth] [expr $height-$zcm+$thick3+$swthick] [expr $width1/2] [expr $height-$zcm+$thick3+$swthick]
        }

        # create the internal web concrete fibers
        for {set i 1} {$i <= $nintwebs} {incr i 1} {

            set yincr [expr ($i-1)**($dv+$intWebThick)]

            # patch rect $conc2ID $nfyintweb $nfzweb [expr -$width2+$extWebThick+$dv+$yincr] [expr -$zcm+$thick2] [expr -$width2+$extWebThick+$dv+$intWebThick+$yincr] [expr -$zcm+$thick2+$hv]
            patch quad $conc2ID $nfyintweb $nfzweb [expr (-$width2/2)+$extWebThick+$dv+$yincr] [expr -$zcm+$thick2] [expr (-$width2/2)+$extWebThick+$dv+$yincr+$intWebThick] [expr -$zcm+$thick2] [expr (-$width2/2)+$extWebThick+$dv+$yincr+$intWebThick] [expr -$zcm+$thick2+$hv] [expr (-$width2/2)+$extWebThick+$dv+$yincr] [expr -$zcm+$thick2+$hv]
        }

        #################
        # REINFORCEMENT #
        #################

        # top slab - top reinforcement
        layer straight $steel3ID $nsteeltop3 $steelArea3 [expr -$width1/2+$cover] [expr $height-$zcm+$thick3-$cover] [expr +$width1/2-$cover] [expr $height-$zcm+$thick3-$cover]
        # top slab - bottom reinforcement
        layer straight $steel3ID $nsteelbot3 $steelArea3 [expr -$width1/2+$cover] [expr $height-$zcm+$cover] [expr +$width1/2-$cover] [expr $height-$zcm+$cover]

        # middle slab - top reinforcement
        layer straight $steel1ID $nsteeltop1 $steelArea1 [expr -$width1/2+$cover] [expr $height-$zcm-$cover] [expr +$width1/2-$cover] [expr $height-$zcm-$cover]
        # middle slab - bottom reinforcement
        layer straight $steel1ID $nsteelbot1 $steelArea1 [expr -$width1/2+$cover] [expr $height-$zcm-$thick1+$cover] [expr +$width1/2-$cover] [expr $height-$zcm-$thick1+$cover]

        # bottom slab - top reinforcement
        layer straight $steel2ID $nsteeltop2 $steelArea2 [expr -$width2/2+$cover] [expr -$zcm-$cover+$thick2] [expr +$width2/2-$cover] [expr -$zcm-$cover+$thick2]
        # bottom slab - bottom reinforcement
        layer straight $steel2ID $nsteelbot2 $steelArea2 [expr -$width2/2+$cover] [expr -$zcm+$cover] [expr +$width2/2-$cover] [expr -$zcm+$cover]

        # Beam reinforcement

        if {$nbeamsteelfacez>=2} {

            # corner rebars
            layer straight $steelbeamID 2 $beamSteelArea [expr -$width1/2-$beamwidth+$cover] [expr $height-$zcm+$thick3+$swthick-$beamheight+$cover] [expr -$width1/2-$cover] [expr $height-$zcm+$thick3+$swthick-$beamheight+$cover]
            layer straight $steelbeamID 2 $beamSteelArea [expr -$width1/2-$beamwidth+$cover] [expr $height-$zcm+$thick3+$swthick-$cover] [expr -$width1/2-$cover] [expr $height-$zcm+$thick3+$swthick-$cover]

            layer straight $steelbeamID 2 $beamSteelArea [expr $width1/2+$cover] [expr $height-$zcm+$thick3+$swthick-$beamheight+$cover] [expr $width1/2+$beamwidth-$cover] [expr $height-$zcm+$thick3+$swthick-$beamheight+$cover]
            layer straight $steelbeamID 2 $beamSteelArea [expr $width1/2+$cover] [expr $height-$zcm+$thick3+$swthick-$cover] [expr $width1/2+$beamwidth-$cover] [expr $height-$zcm+$thick3+$swthick-$cover]
        }

        if { $nbeamsteelfacez == 3} {

            # middle bars
            fiber [expr -$width1/2-$beamwidth/2] [expr $height-$zcm+$thick3+$swthick-$cover] $beamSteelArea $steelbeamID
            fiber [expr -$width1/2-$beamwidth/2] [expr $height-$zcm+$thick3+$swthick-$beamheight+$cover] $beamSteelArea $steelbeamID

            fiber [expr $width1/2+$beamwidth/2] [expr $height-$zcm+$thick3+$swthick-$cover] $beamSteelArea $steelbeamID
            fiber [expr $width1/2+$beamwidth/2] [expr $height-$zcm+$thick3+$swthick-$beamheight+$cover] $beamSteelArea $steelbeamID

        } elseif { $nbeamsteelfacez > 3 } {

            set ydist [expr ($beamwidth-2**$cover)/($nbeamsteelfacez-1)]
            set yfirstcoord [expr -$width1/2-$beamwidth+$cover+$ydist]
            set ylastcoord [expr -$width1/2-$cover-$ydist]

            layer straight $steelbeamID [expr $nbeamsteelfacez-2] $beamSteelArea $yfirstcoord [expr $height-$zcm+$thick3+$swthick-$cover] $ylastcoord [expr $height-$zcm+$thick3+$swthick-$cover]
            layer straight $steelbeamID [expr $nbeamsteelfacez-2] $beamSteelArea $yfirstcoord [expr $height-$zcm+$thick3+$swthick-$beamheight+$cover] $ylastcoord [expr $height-$zcm+$thick3+$swthick-$beamheight+$cover]

            set yfirstcoord [expr $width1/2+$cover+$ydist]
            set ylastcoord [expr $width1/2+$beamwidth-$cover-$ydist]

            layer straight $steelbeamID [expr $nbeamsteelfacez-2] $beamSteelArea $yfirstcoord [expr $height-$zcm+$thick3+$swthick-$cover] $ylastcoord [expr $height-$zcm+$thick3+$swthick-$cover]
            layer straight $steelbeamID [expr $nbeamsteelfacez-2] $beamSteelArea $yfirstcoord [expr $height-$zcm+$thick3+$swthick-$beamheight+$cover] $ylastcoord [expr $height-$zcm+$thick3+$swthick-$beamheight+$cover]
        }

        if {$nbeamsteelfacey == 3} {

            fiber [expr -$width1/2-$beamwidth+$cover] [expr $height-$zcm+$thick3+$swthick-$beamheight/2] $beamSteelArea $steelbeamID
            fiber [expr -$width1/2-$cover] [expr $height-$zcm+$thick3+$swthick-$beamheight/2] $beamSteelArea $steelbeamID

            fiber [expr $width1/2+$cover] [expr $height-$zcm+$thick3+$swthick-$beamheight/2] $beamSteelArea $steelbeamID
            fiber [expr $width1/2+$beamwidth-$cover] [expr $height-$zcm+$thick3+$swthick-$beamheight/2] $beamSteelArea $steelbeamID

        } elseif {$nbeamsteelfacey > 3} {

            set zdist [expr ($beamheight-2**$cover)/($nbeamsteelfacey-1)]
            set zfirstcoord [expr $height-$zcm+$thick3+$swthick-$beamheight+$cover+$zdist]
            set zlastcoord [expr $height-$zcm+$thick3+$swthick-$cover-$zdist]

            layer straight $steelbeamID [expr $nbeamsteelfacey-2] $beamSteelArea [expr -$width1/2-$beamwidth+$cover] $zfirstcoord [expr -$width1/2-$beamwidth+$cover] $zlastcoord
            layer straight $steelbeamID [expr $nbeamsteelfacey-2] $beamSteelArea [expr -$width1/2-$cover] $zfirstcoord [expr -$width1/2-$cover] $zlastcoord

            layer straight $steelbeamID [expr $nbeamsteelfacey-2] $beamSteelArea [expr $width1/2+$cover] $zfirstcoord [expr $width1/2+$cover] $zlastcoord
            layer straight $steelbeamID [expr $nbeamsteelfacey-2] $beamSteelArea [expr $width1/2+$beamwidth-$cover] $zfirstcoord [expr $width1/2+$beamwidth-$cover] $zlastcoord
        }

        # tendons

        if {$tendons} {

            if {$nvoid!=0} {

                fiber [expr -$width2/2+$extWebThick/2] [expr $zcoordTopExtTendon-$zcm] $extTendonArea $extTendonSteelID
                fiber [expr -$width2/2+$extWebThick/2] [expr $zcoordBotExtTendon-$zcm] $extTendonArea $extTendonSteelID

                fiber [expr $width2/2-$extWebThick/2] [expr $zcoordTopExtTendon-$zcm] $extTendonArea $extTendonSteelID
                fiber [expr $width2/2-$extWebThick/2] [expr $zcoordBotExtTendon-$zcm] $extTendonArea $extTendonSteelID

                for {set i 1} {$i <= $nintwebs} {incr i 1} {

                    set yincr [expr ($i-1)**($dv+$intWebThick)]

                    fiber [expr (-$width2/2)+$extWebThick+$dv+$intWebThick/2+$yincr] [expr $zcoordTopIntTendon-$zcm] $intTendonArea $intTendonSteelID
                    fiber [expr (-$width2/2)+$extWebThick+$dv+$intWebThick/2+$yincr] [expr $zcoordBotIntTendon-$zcm] $intTendonArea $intTendonSteelID

                }
            } else {

                # 3 tendons for solid section
                for {set i 1} {$i<4} {incr i 1} {
                    set ycoord [expr $i**$width2/4]
                    fiber [expr -$width2/2+$ycoord] [expr $zcoordTopExtTendon-$zcm] $extTendonArea $extTendonSteelID
                    fiber [expr -$width2/2+$ycoord] [expr $zcoordBotExtTendon-$zcm] $extTendonArea $extTendonSteelID
                }
            }
        }
    }

    } else {

    section Fiber $secID {

        ###################
        # CONCRETE FIBERS #
        ###################

        # create the rectangular concrete fibers for the middle slab
        # patch rect $conc1ID $nfy1 $nfz1 [expr -$width1/2] [expr $height-$zcm-$thick1] [expr +$width1/2] [expr $height-$zcm]
        patch quad $conc2ID $nfy1 $nfz1 [expr -$width1/2] [expr $height-$zcm-$thick1] [expr +$width1/2] [expr $height-$zcm-$thick1] [expr +$width1/2] [expr $height-$zcm] [expr -$width1/2] [expr $height-$zcm]

        # create the rectangular concrete fibers for the bottom slab
        # patch rect $conc2ID $nfy2 $nfz2 [expr -$width2/2] [expr -$zcm] [expr +$width2/2] [expr -$zcm+$thick2]
        patch quad $conc2ID $nfy2 $nfz2 [expr -$width2/2] [expr -$zcm] [expr +$width2/2] [expr -$zcm] [expr +$width2/2] [expr -$zcm+$thick2] [expr -$width2/2] [expr -$zcm+$thick2]

        # create the negative local y dir external web
        # patch rect $conc2ID $nfyextweb $nfzweb [expr -$width2/2] [expr -$zcm+$thick2] [expr -$width2/2+$extWebThick] [expr -$zcm+$thick2+$hv]
        patch quad $conc2ID $nfyextweb $nfzweb [expr -$width2/2] [expr -$zcm+$thick2] [expr -$width2/2+$extWebThick] [expr -$zcm+$thick2] [expr -$width2/2+$extWebThick] [expr -$zcm+$thick2+$hv] [expr -$width2/2] [expr -$zcm+$thick2+$hv]

        # create the positive local y dir external web
        # patch rect $conc2ID $nfyextweb $nfzweb [expr +$width2/2] [expr -$zcm+$thick2] [expr +$width2/2-$extWebThick] [expr -$zcm+$thick2+$hv]
        patch quad $conc2ID $nfyextweb $nfzweb [expr +$width2/2-$extWebThick] [expr -$zcm+$thick2] [expr $width2/2] [expr -$zcm+$thick2] [expr $width2/2] [expr -$zcm+$thick2+$hv] [expr $width2/2-$extWebThick] [expr -$zcm+$thick2+$hv]

        if {$thick3} {
        # create the rectangular concrete fibers for the top slab with different concrete material
        patch quad $conc1ID $nfy1 $nfz1 [expr -$width1/2] [expr $height-$zcm] [expr $width1/2] [expr $height-$zcm] [expr $width1/2] [expr $height-$zcm+$thick3] [expr -$width1/2] [expr $height-$zcm+$thick3]
        }

        if {$swthick && $swwidth} {
        # create the concrete fibers for the sidewalk slab
        # left
        patch quad $conc1ID [expr int($nfy1/3)] $nfz1 [expr -$width1/2] [expr $height-$zcm+$thick3] [expr -$width1/2+$swwidth-$beamwidth] [expr $height-$zcm+$thick3] [expr -$width1/2+$swwidth-$beamwidth]  [expr $height-$zcm+$thick3+$swthick] [expr -$width1/2] [expr $height-$zcm+$thick3+$swthick]
        # right
        patch quad $conc1ID [expr int($nfy1/3)] $nfz1 [expr $width1/2-$swwidth+$beamwidth] [expr $height-$zcm+$thick3] [expr $width1/2] [expr $height-$zcm+$thick3] [expr $width1/2] [expr $height-$zcm+$thick3+$swthick] [expr $width1/2-$swwidth+$beamwidth] [expr $height-$zcm+$thick3+$swthick]
        }

        if {$beamwidth && $beamheight} {
        # create the sidewalk beams
        # left
        patch quad $conc1ID $nfybeam $nfzbeam [expr -$width1/2-$beamwidth] [expr $height-$zcm+$thick3+$swthick-$beamheight] [expr -$width1/2] [expr $height-$zcm+$thick3+$swthick-$beamheight] [expr -$width1/2] [expr $height-$zcm+$thick3+$swthick] [expr -$width1/2-$beamwidth] [expr $height-$zcm+$thick3+$swthick]
        # right
        patch quad $conc1ID $nfybeam $nfzbeam [expr $width1/2] [expr $height-$zcm+$thick3+$swthick-$beamheight] [expr $width1/2+$beamwidth] [expr $height-$zcm+$thick3+$swthick-$beamheight] [expr $width1/2+$beamwidth] [expr $height-$zcm+$thick3+$swthick] [expr $width1/2] [expr $height-$zcm+$thick3+$swthick]
        }

        # create the internal web concrete fibers
        for {set i 1} {$i <= $nintwebs} {incr i 1} {

            set yincr [expr ($i-1)**($dv+$intWebThick)]

            # patch rect $conc2ID $nfyintweb $nfzweb [expr -$width2+$extWebThick+$dv+$yincr] [expr -$zcm+$thick2] [expr -$width2+$extWebThick+$dv+$intWebThick+$yincr] [expr -$zcm+$thick2+$hv]
            patch quad $conc2ID $nfyintweb $nfzweb [expr (-$width2/2)+$extWebThick+$dv+$yincr] [expr -$zcm+$thick2] [expr (-$width2/2)+$extWebThick+$dv+$yincr+$intWebThick] [expr -$zcm+$thick2] [expr (-$width2/2)+$extWebThick+$dv+$yincr+$intWebThick] [expr -$zcm+$thick2+$hv] [expr (-$width2/2)+$extWebThick+$dv+$yincr] [expr -$zcm+$thick2+$hv]
        }

        #################
        # REINFORCEMENT #
        #################

        # top slab - top reinforcement
        layer straight $steel3ID $nsteeltop3 $steelArea3 [expr -$width1/2+$cover] [expr $height-$zcm+$thick3-$cover] [expr +$width1/2-$cover] [expr $height-$zcm+$thick3-$cover]
        # top slab - bottom reinforcement
        layer straight $steel3ID $nsteelbot3 $steelArea3 [expr -$width1/2+$cover] [expr $height-$zcm+$cover] [expr +$width1/2-$cover] [expr $height-$zcm+$cover]

        # middle slab - top reinforcement
        layer straight $steel1ID $nsteeltop1 $steelArea1 [expr -$width1/2+$cover] [expr $height-$zcm-$cover] [expr +$width1/2-$cover] [expr $height-$zcm-$cover]
        # middle slab - bottom reinforcement
        layer straight $steel1ID $nsteelbot1 $steelArea1 [expr -$width1/2+$cover] [expr $height-$zcm-$thick1+$cover] [expr +$width1/2-$cover] [expr $height-$zcm-$thick1+$cover]

        # bottom slab - top reinforcement
        layer straight $steel2ID $nsteeltop2 $steelArea2 [expr -$width2/2+$cover] [expr -$zcm-$cover+$thick2] [expr +$width2/2-$cover] [expr -$zcm-$cover+$thick2]
        # bottom slab - bottom reinforcement
        layer straight $steel2ID $nsteelbot2 $steelArea2 [expr -$width2/2+$cover] [expr -$zcm+$cover] [expr +$width2/2-$cover] [expr -$zcm+$cover]

        # Beam reinforcement

        if {$nbeamsteelfacez>=2} {

            # corner rebars
            layer straight $steelbeamID 2 $beamSteelArea [expr -$width1/2-$beamwidth+$cover] [expr $height-$zcm+$thick3+$swthick-$beamheight+$cover] [expr -$width1/2-$cover] [expr $height-$zcm+$thick3+$swthick-$beamheight+$cover]
            layer straight $steelbeamID 2 $beamSteelArea [expr -$width1/2-$beamwidth+$cover] [expr $height-$zcm+$thick3+$swthick-$cover] [expr -$width1/2-$cover] [expr $height-$zcm+$thick3+$swthick-$cover]

            layer straight $steelbeamID 2 $beamSteelArea [expr $width1/2+$cover] [expr $height-$zcm+$thick3+$swthick-$beamheight+$cover] [expr $width1/2+$beamwidth-$cover] [expr $height-$zcm+$thick3+$swthick-$beamheight+$cover]
            layer straight $steelbeamID 2 $beamSteelArea [expr $width1/2+$cover] [expr $height-$zcm+$thick3+$swthick-$cover] [expr $width1/2+$beamwidth-$cover] [expr $height-$zcm+$thick3+$swthick-$cover]
        }

        if { $nbeamsteelfacez == 3} {

            # middle bars
            fiber [expr -$width1/2-$beamwidth/2] [expr $height-$zcm+$thick3+$swthick-$cover] $beamSteelArea $steelbeamID
            fiber [expr -$width1/2-$beamwidth/2] [expr $height-$zcm+$thick3+$swthick-$beamheight+$cover] $beamSteelArea $steelbeamID

            fiber [expr $width1/2+$beamwidth/2] [expr $height-$zcm+$thick3+$swthick-$cover] $beamSteelArea $steelbeamID
            fiber [expr $width1/2+$beamwidth/2] [expr $height-$zcm+$thick3+$swthick-$beamheight+$cover] $beamSteelArea $steelbeamID

        } elseif { $nbeamsteelfacez > 3 } {

            set ydist [expr ($beamwidth-2**$cover)/($nbeamsteelfacez-1)]
            set yfirstcoord [expr -$width1/2-$beamwidth+$cover+$ydist]
            set ylastcoord [expr -$width1/2-$cover-$ydist]

            layer straight $steelbeamID [expr $nbeamsteelfacez-2] $beamSteelArea $yfirstcoord [expr $height-$zcm+$thick3+$swthick-$cover] $ylastcoord [expr $height-$zcm+$thick3+$swthick-$cover]
            layer straight $steelbeamID [expr $nbeamsteelfacez-2] $beamSteelArea $yfirstcoord [expr $height-$zcm+$thick3+$swthick-$beamheight+$cover] $ylastcoord [expr $height-$zcm+$thick3+$swthick-$beamheight+$cover]

            set yfirstcoord [expr $width1/2+$cover+$ydist]
            set ylastcoord [expr $width1/2+$beamwidth-$cover-$ydist]

            layer straight $steelbeamID [expr $nbeamsteelfacez-2] $beamSteelArea $yfirstcoord [expr $height-$zcm+$thick3+$swthick-$cover] $ylastcoord [expr $height-$zcm+$thick3+$swthick-$cover]
            layer straight $steelbeamID [expr $nbeamsteelfacez-2] $beamSteelArea $yfirstcoord [expr $height-$zcm+$thick3+$swthick-$beamheight+$cover] $ylastcoord [expr $height-$zcm+$thick3+$swthick-$beamheight+$cover]
        }

        if {$nbeamsteelfacey == 3} {

            fiber [expr -$width1/2-$beamwidth+$cover] [expr $height-$zcm+$thick3+$swthick-$beamheight/2] $beamSteelArea $steelbeamID
            fiber [expr -$width1/2-$cover] [expr $height-$zcm+$thick3+$swthick-$beamheight/2] $beamSteelArea $steelbeamID

            fiber [expr $width1/2+$cover] [expr $height-$zcm+$thick3+$swthick-$beamheight/2] $beamSteelArea $steelbeamID
            fiber [expr $width1/2+$beamwidth-$cover] [expr $height-$zcm+$thick3+$swthick-$beamheight/2] $beamSteelArea $steelbeamID

        } elseif {$nbeamsteelfacey > 3} {

            set zdist [expr ($beamheight-2**$cover)/($nbeamsteelfacey-1)]
            set zfirstcoord [expr $height-$zcm+$thick3+$swthick-$beamheight+$cover+$zdist]
            set zlastcoord [expr $height-$zcm+$thick3+$swthick-$cover-$zdist]

            layer straight $steelbeamID [expr $nbeamsteelfacey-2] $beamSteelArea [expr -$width1/2-$beamwidth+$cover] $zfirstcoord [expr -$width1/2-$beamwidth+$cover] $zlastcoord
            layer straight $steelbeamID [expr $nbeamsteelfacey-2] $beamSteelArea [expr -$width1/2-$cover] $zfirstcoord [expr -$width1/2-$cover] $zlastcoord

            layer straight $steelbeamID [expr $nbeamsteelfacey-2] $beamSteelArea [expr $width1/2+$cover] $zfirstcoord [expr $width1/2+$cover] $zlastcoord
            layer straight $steelbeamID [expr $nbeamsteelfacey-2] $beamSteelArea [expr $width1/2+$beamwidth-$cover] $zfirstcoord [expr $width1/2+$beamwidth-$cover] $zlastcoord
        }

        # tendons

        if {$tendons} {

            if {$nvoid!=0} {

                fiber [expr -$width2/2+$extWebThick/2] [expr $zcoordTopExtTendon-$zcm] $extTendonArea $extTendonSteelID
                fiber [expr -$width2/2+$extWebThick/2] [expr $zcoordBotExtTendon-$zcm] $extTendonArea $extTendonSteelID

                fiber [expr $width2/2-$extWebThick/2] [expr $zcoordTopExtTendon-$zcm] $extTendonArea $extTendonSteelID
                fiber [expr $width2/2-$extWebThick/2] [expr $zcoordBotExtTendon-$zcm] $extTendonArea $extTendonSteelID

                for {set i 1} {$i <= $nintwebs} {incr i 1} {

                    set yincr [expr ($i-1)**($dv+$intWebThick)]

                    fiber [expr (-$width2/2)+$extWebThick+$dv+$intWebThick/2+$yincr] [expr $zcoordTopIntTendon-$zcm] $intTendonArea $intTendonSteelID
                    fiber [expr (-$width2/2)+$extWebThick+$dv+$intWebThick/2+$yincr] [expr $zcoordBotIntTendon-$zcm] $intTendonArea $intTendonSteelID

                }
            } else {

                # 3 tendons for solid section
                for {set i 1} {$i<4} {incr i 1} {
                    set ycoord [expr $i**$width2/4]
                    fiber [expr -$width2/2+$ycoord] [expr $zcoordTopExtTendon-$zcm] $extTendonArea $extTendonSteelID
                    fiber [expr -$width2/2+$ycoord] [expr $zcoordBotExtTendon-$zcm] $extTendonArea $extTendonSteelID
                }
            }
        }
    }
    }
}