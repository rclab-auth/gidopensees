proc DeckFiberSection2D { secID GJ conc1ID conc2ID steel1ID steel2ID steel3ID steelbeamID extTendonSteelID intTendonSteelID tendons nsteeltop1 nsteelbot1 nsteeltop2 nsteelbot2 nsteeltop3 nsteelbot3 nbeamsteelfacey nbeamsteelfacez steelArea1 steelArea2 steelArea3 beamSteelArea intTendonArea extTendonArea width1 thick1 width2 thick2 thick3 swwidth swthick beamwidth beamheight cover extWebThick nvoid hv dv ycoordTopIntTendon ycoordBotIntTendon ycoordTopExtTendon ycoordBotExtTendon nfy1 nfz1 nfy2 nfz2 nfzextweb nfyweb nfzintweb nfybeam nfzbeam} {

    if {$nvoid!=0} {
        set nintwebs [expr $nvoid-1]; # number of internal webs
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

    if {$nfz1<16} {
        set nfz1 16
    }

    set height [expr $thick1+$thick2+$hv]; # total external height of the man section, not including top slab and sidewalk

    # Concrete Areas
    set Area1 [expr $thick1**$width1]; # Area of the middle slab
    set Area2 [expr $thick2**$width2]; # Area of the bottom slab
    set Area3 [expr $thick3**$width1]; # Area of the top slab
    set swslabArea [expr $swthick**($swwidth-$beamwidth)]
    set beamArea [expr $beamheight**$beamwidth]
    set extWebArea [expr $hv**$extWebThick]; # Area of the external web
    set intWebArea [expr $hv**$intWebThick]; # Area of the internal web
    set totalArea [expr $Area1+$Area2+$Area3+$nintwebs**$intWebArea+2**$extWebArea+2**$swslabArea+2**$beamArea]; # Total Area of the deck Section

    set ycm [expr ($Area1**($height-$thick1/2)+($Area2**$thick2/2)+($Area3**($height+$thick3/2))+2**($swslabArea**($height+$thick3+$swthick/2))+2**($beamArea**($height+$thick3+$swthick-$beamheight/2))+($nintwebs**$intWebArea)**($thick2+$hv/2)+(2**$extWebArea)**($thick2+$hv/2))/$totalArea]

    section Fiber $secID -GJ $GJ {

        ###################
        # CONCRETE FIBERS #
        ###################

        # create the rectangular concrete fibers for the middle slab
        #patch quad $conc2ID $nfy1 $nfz1 [expr $height-$ycm-$thick1] [expr -$width1/2] [expr $height-$ycm-$thick1] [expr +$width1/2] [expr $height-$ycm] [expr +$width1/2] [expr $height-$ycm] [expr -$width1/2]
        patch rect $conc2ID $nfy1 $nfz1 [expr $height-$ycm-$thick1] [expr -$width1/2] [expr $height-$ycm] [expr +$width1/2]

        # create the rectangular concrete fibers for the bottom slab
        #patch quad $conc2ID $nfy2 $nfz2 [expr -$ycm] [expr -$width2/2] [expr -$ycm] [expr +$width2/2] [expr -$ycm+$thick2] [expr +$width2/2] [expr -$ycm+$thick2] [expr -$width2/2]
        patch rect $conc2ID $nfy2 $nfz2 [expr -$ycm] [expr -$width2/2] [expr -$ycm+$thick2] [expr +$width2/2]

        # create the negative local z dir external web
        #patch quad $conc2ID $nfzextweb $nfyweb [expr -$ycm+$thick2] [expr -$width2/2] [expr -$ycm+$thick2] [expr -$width2/2+$extWebThick] [expr -$ycm+$thick2+$hv] [expr -$width2/2+$extWebThick] [expr -$ycm+$thick2+$hv] [expr -$width2/2]
        patch rect $conc2ID $nfzextweb $nfyweb [expr -$ycm+$thick2] [expr -$width2/2] [expr -$ycm+$thick2+$hv] [expr -$width2/2+$extWebThick]

        # create the positive local z dir external web
        #patch quad $conc2ID $nfyweb $nfzextweb [expr -$ycm+$thick2] [expr +$width2/2-$extWebThick] [expr -$ycm+$thick2] [expr $width2/2] [expr -$ycm+$thick2+$hv] [expr $width2/2] [expr -$ycm+$thick2+$hv] [expr $width2/2-$extWebThick]
        patch rect $conc2ID $nfyweb $nfzextweb [expr -$ycm+$thick2] [expr +$width2/2-$extWebThick] [expr -$ycm+$thick2+$hv] [expr $width2/2]

        if {$thick3} {
        # create the rectangular concrete fibers for the top slab with different concrete material
        patch rect $conc1ID $nfy1 $nfz1 [expr $height-$ycm] [expr -$width1/2] [expr $height-$ycm+$thick3] [expr $width1/2]
        }

        if {$swthick && $swwidth} {
        # create the concrete fibers for the sidewalk slab
        # right
        #patch quad $conc1ID $nfy1 [expr int($nfz1/3)] [expr $height-$ycm+$thick3] [expr -$width1/2] [expr $height-$ycm+$thick3] [expr -$width1/2+$swwidth-$beamwidth] [expr $height-$ycm+$thick3+$swthick] [expr -$width1/2+$swwidth-$beamwidth] [expr $height-$ycm+$thick3+$swthick] [expr -$width1/2]
        patch rect $conc1ID $nfy1 [expr int($nfz1/3)] [expr $height-$ycm+$thick3] [expr -$width1/2] [expr $height-$ycm+$thick3+$swthick] [expr -$width1/2+$swwidth-$beamwidth]
        # left
        #patch quad $conc1ID $nfy1 [expr int($nfz1/3)] [expr $height-$ycm+$thick3] [expr $width1/2-$swwidth+$beamwidth] [expr $height-$ycm+$thick3] [expr $width1/2] [expr $height-$ycm+$thick3+$swthick] [expr $width1/2] [expr $height-$ycm+$thick3+$swthick] [expr $width1/2-$swwidth+$beamwidth]
        patch rect $conc1ID $nfy1 [expr int($nfz1/3)] [expr $height-$ycm+$thick3] [expr $width1/2-$swwidth+$beamwidth] [expr $height-$ycm+$thick3+$swthick] [expr $width1/2]
        }

        if {$beamwidth && $beamheight} {
        # create the sidewalk beams
        # right
        #patch quad $conc1ID $nfybeam $nfzbeam [expr $height-$ycm+$thick3+$swthick-$beamheight] [expr -$width1/2-$beamwidth] [expr $height-$ycm+$thick3+$swthick-$beamheight] [expr -$width1/2] [expr $height-$ycm+$thick3+$swthick] [expr -$width1/2] [expr $height-$ycm+$thick3+$swthick] [expr -$width1/2-$beamwidth]
        patch rect $conc1ID $nfybeam $nfzbeam [expr $height-$ycm+$thick3+$swthick-$beamheight] [expr -$width1/2-$beamwidth] [expr $height-$ycm+$thick3+$swthick] [expr -$width1/2]
        # left
        #patch quad $conc1ID $nfybeam $nfzbeam [expr $height-$ycm+$thick3+$swthick-$beamheight] [expr $width1/2] [expr $height-$ycm+$thick3+$swthick-$beamheight] [expr $width1/2+$beamwidth] [expr $height-$ycm+$thick3+$swthick] [expr $width1/2+$beamwidth] [expr $height-$ycm+$thick3+$swthick] [expr $width1/2]
        patch rect $conc1ID $nfybeam $nfzbeam [expr $height-$ycm+$thick3+$swthick-$beamheight] [expr $width1/2] [expr $height-$ycm+$thick3+$swthick] [expr $width1/2+$beamwidth]
        }

        # create the internal web concrete fibers
        for {set i 1} {$i <= $nintwebs} {incr i 1} {

            set zincr [expr ($i-1)**($dv+$intWebThick)]

            #patch quad $conc2ID $nfyweb $nfzintweb [expr -$ycm+$thick2] [expr (-$width2/2)+$extWebThick+$dv+$zincr] [expr -$ycm+$thick2] [expr (-$width2/2)+$extWebThick+$dv+$zincr+$intWebThick] [expr -$ycm+$thick2+$hv] [expr (-$width2/2)+$extWebThick+$dv+$zincr+$intWebThick] [expr -$ycm+$thick2+$hv] [expr (-$width2/2)+$extWebThick+$dv+$zincr]
            patch rect $conc2ID $nfyweb $nfzintweb [expr -$ycm+$thick2] [expr (-$width2/2)+$extWebThick+$dv+$zincr] [expr -$ycm+$thick2+$hv] [expr (-$width2/2)+$extWebThick+$dv+$zincr+$intWebThick]
        }

        #################
        # REINFORCEMENT #
        #################

        # top slab - top reinforcement
        layer straight $steel3ID $nsteeltop3 $steelArea3 [expr $height-$ycm+$thick3-$cover] [expr -$width1/2+$cover] [expr $height-$ycm+$thick3-$cover] [expr +$width1/2-$cover]
        # top slab - bottom reinforcement
        layer straight $steel3ID $nsteelbot3 $steelArea3 [expr $height-$ycm+$cover] [expr -$width1/2+$cover] [expr $height-$ycm+$cover] [expr +$width1/2-$cover]

        # middle slab - top reinforcement
        layer straight $steel1ID $nsteeltop1 $steelArea1 [expr $height-$ycm-$cover] [expr -$width1/2+$cover] [expr $height-$ycm-$cover] [expr +$width1/2-$cover]
        # middle slab - bottom reinforcement
        layer straight $steel1ID $nsteelbot1 $steelArea1 [expr $height-$ycm-$thick1+$cover] [expr -$width1/2+$cover] [expr $height-$ycm-$thick1+$cover] [expr +$width1/2-$cover]

        # bottom slab - top reinforcement
        layer straight $steel2ID $nsteeltop2 $steelArea2 [expr -$ycm-$cover+$thick2] [expr -$width2/2+$cover] [expr -$ycm-$cover+$thick2] [expr +$width2/2-$cover]
        # bottom slab - bottom reinforcement
        layer straight $steel2ID $nsteelbot2 $steelArea2 [expr -$ycm+$cover] [expr -$width2/2+$cover] [expr -$ycm+$cover] [expr +$width2/2-$cover]

        # Beam reinforcement

        if {$nbeamsteelfacey>=2} {

            # corner rebars
            layer straight $steelbeamID 2 $beamSteelArea [expr $height-$ycm+$thick3+$swthick-$beamheight+$cover] [expr -$width1/2-$beamwidth+$cover] [expr $height-$ycm+$thick3+$swthick-$beamheight+$cover] [expr -$width1/2-$cover]
            layer straight $steelbeamID 2 $beamSteelArea [expr $height-$ycm+$thick3+$swthick-$cover] [expr -$width1/2-$beamwidth+$cover] [expr $height-$ycm+$thick3+$swthick-$cover] [expr -$width1/2-$cover]

            layer straight $steelbeamID 2 $beamSteelArea [expr $height-$ycm+$thick3+$swthick-$beamheight+$cover] [expr $width1/2+$cover] [expr $height-$ycm+$thick3+$swthick-$beamheight+$cover] [expr $width1/2+$beamwidth-$cover]
            layer straight $steelbeamID 2 $beamSteelArea [expr $height-$ycm+$thick3+$swthick-$cover] [expr $width1/2+$cover] [expr $height-$ycm+$thick3+$swthick-$cover] [expr $width1/2+$beamwidth-$cover]
        }

        if {$nbeamsteelfacey == 3 } {

            # middle bars
            fiber [expr $height-$ycm+$thick3+$swthick-$beamheight+$cover] [expr -$width1/2-$beamwidth/2] $beamSteelArea $steelbeamID
            fiber [expr $height-$ycm+$thick3+$swthick-$cover] [expr -$width1/2-$beamwidth/2] $beamSteelArea $steelbeamID

            fiber [expr $height-$ycm+$thick3+$swthick-$beamheight+$cover] [expr $width1/2+$beamwidth/2] $beamSteelArea $steelbeamID
            fiber [expr $height-$ycm+$thick3+$swthick-$cover] [expr $width1/2+$beamwidth/2] $beamSteelArea $steelbeamID

        } elseif { $nbeamsteelfacey > 3} {

            set zdist [expr ($beamwidth-2**$cover)/($nbeamsteelfacey-1)]
            set zfirstcoord [expr $width1/2+$beamwidth-$cover-$zdist]
            set zlastcoord [expr $width1/2+$cover+$zdist]

            layer straight $steelbeamID [expr $nbeamsteelfacey-2] $beamSteelArea [expr $height-$ycm+$thick3+$swthick-$cover] $zfirstcoord [expr $height-$ycm+$thick3+$swthick-$cover] $zlastcoord
            layer straight $steelbeamID [expr $nbeamsteelfacey-2] $beamSteelArea [expr $height-$ycm+$thick3+$swthick-$beamheight+$cover] $zfirstcoord [expr $height-$ycm+$thick3+$swthick-$beamheight+$cover] $zlastcoord

            set zfirstcoord [expr -$width1/2-$cover-$zdist]
            set zlastcoord [expr -$width1/2-$beamwidth+$cover+$zdist]

            layer straight $steelbeamID [expr $nbeamsteelfacey-2] $beamSteelArea [expr $height-$ycm+$thick3+$swthick-$cover] $zfirstcoord [expr $height-$ycm+$thick3+$swthick-$cover] $zlastcoord
            layer straight $steelbeamID [expr $nbeamsteelfacey-2] $beamSteelArea [expr $height-$ycm+$thick3+$swthick-$beamheight+$cover] $zfirstcoord [expr $height-$ycm+$thick3+$swthick-$beamheight+$cover] $zlastcoord
        }

        if {$nbeamsteelfacez == 3} {

            fiber [expr $height-$ycm+$thick3+$swthick-$beamheight/2] [expr -$width1/2-$beamwidth+$cover] $beamSteelArea $steelbeamID
            fiber [expr $height-$ycm+$thick3+$swthick-$beamheight/2] [expr -$width1/2-$cover] $beamSteelArea $steelbeamID

            fiber [expr $height-$ycm+$thick3+$swthick-$beamheight/2] [expr $width1/2+$cover] $beamSteelArea $steelbeamID
            fiber [expr $height-$ycm+$thick3+$swthick-$beamheight/2] [expr $width1/2+$beamwidth-$cover] $beamSteelArea $steelbeamID

        } elseif {$nbeamsteelfacez > 3} {

            set ydist [expr ($beamheight-2**$cover)/($nbeamsteelfacez-1)]
            set yfirstcoord [expr $height-$ycm+$thick3+$swthick-$beamheight+$cover+$ydist]
            set ylastcoord [expr $height-$ycm+$thick3+$swthick-$cover-$ydist]

            layer straight $steelbeamID [expr $nbeamsteelfacez-2] $beamSteelArea $yfirstcoord [expr -$width1/2-$beamwidth+$cover] $ylastcoord [expr -$width1/2-$beamwidth+$cover]
            layer straight $steelbeamID [expr $nbeamsteelfacez-2] $beamSteelArea $yfirstcoord [expr -$width1/2-$cover] $ylastcoord [expr -$width1/2-$cover]

            layer straight $steelbeamID [expr $nbeamsteelfacez-2] $beamSteelArea $yfirstcoord [expr $width1/2+$cover] $ylastcoord [expr $width1/2+$cover]
            layer straight $steelbeamID [expr $nbeamsteelfacez-2] $beamSteelArea $yfirstcoord [expr $width1/2+$beamwidth-$cover] $ylastcoord [expr $width1/2+$beamwidth-$cover]
        }

        # tendons

        if {$tendons} {

            if {$nvoid!=0} {

                fiber [expr $ycoordTopExtTendon-$ycm] [expr -$width2/2+$extWebThick/2] $extTendonArea $extTendonSteelID
                fiber [expr $ycoordBotExtTendon-$ycm] [expr -$width2/2+$extWebThick/2] $extTendonArea $extTendonSteelID

                fiber [expr $ycoordTopExtTendon-$ycm] [expr $width2/2-$extWebThick/2] $extTendonArea $extTendonSteelID
                fiber [expr $ycoordBotExtTendon-$ycm] [expr $width2/2-$extWebThick/2] $extTendonArea $extTendonSteelID

                for {set i 1} {$i <= $nintwebs} {incr i 1} {

                    set zincr [expr ($i-1)**($dv+$intWebThick)]

                    fiber [expr $ycoordTopIntTendon-$ycm] [expr (-$width2/2)+$extWebThick+$dv+$intWebThick/2+$zincr] $intTendonArea $intTendonSteelID
                    fiber [expr $ycoordBotIntTendon-$ycm] [expr (-$width2/2)+$extWebThick+$dv+$intWebThick/2+$zincr] $intTendonArea $intTendonSteelID

                }
            }
        }
    }
}