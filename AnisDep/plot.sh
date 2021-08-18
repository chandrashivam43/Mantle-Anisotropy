#!/bin/bash
#rm  *jpg *pdf *eps

#awk '{print $1, $2, $3}' output.dx0.20 | gmt psxy -R-5/410/0.3/1.1 -St0.1 -L -Ey0.02/0.25,lightgreen -JX17 -W0.15,green -Ba20f10/a0.05f0.01 -P -X1.5 -Y1.5 -K >tmp.ps
awk '{print $1, $2, $3}' output.dx0.40 | gmt psxy -R-5/410/0.3/1.1 -St0.1 -L -Ey0.02/0.25,black -JX17 -W0.15,black -Gyellow -Ba20/a0.05 -P -X1.5 -Y1.5 -K >tmp.ps
#awk '{print $1, $2, $3}' output.dx0.05 | gmt psxy -R -Ss0.1 -L -Ey0.02/0.25,red -J -W0.1,red -O -K >>tmp.ps
awk '{print $1, $2}' line.txt | gmt psxy -R -L -J -W1,black -O -K >>tmp.ps
awk '{print $1, $2}' line2.txt | gmt psxy -R -L -J -W1,black -O -K >>tmp.ps
#awk '{print $1, $2}' line3.txt | gmt psxy -R -L -J -W1,black -O -K >>tmp.ps
awk '{print $1, $2, $3, $4}' mark.txt |gmt psxy -R -J -O -K -SV0.5+e  -W0.8,black >>tmp.ps
#awk '{print $1, $2, $3}' output.dx0.25 | gmt psxy -R -Sc0.1 -L -Ey0.02/0.25,gold -J -W0.1,gold -O -K >>tmp.ps
awk '{print $1, $2, $3}' output.dx0.25 | gmt psxy -R -Ss0.1 -L -Ey0.02/0.25,black -J -W0.15,darkblue -Gdarkblue -O -K >>tmp.ps
awk '{print $1, $2, $3}' output.dx0.30 | gmt psxy -R -Sc0.1 -L -Ey0.02/0.25,black -J -W0.15,brown -Gbrown -O -K >>tmp.ps
awk '{print $1, $2, $3}' output.dx0.35 | gmt psxy -R -Ss0.04 -L -Ey0.02/0.5,black -J -W0.1,skyblue -Gskyblue -O -K >>tmp.ps
#awk '{print $1, $2, $3}' output.dx0.40 | gmt psxy -R -Sc0.1 -L -Ey0.02/0.25,black -J -W0.15,gold -O -K >>tmp.ps

gmt pstext -R -J -O -N <<END>>tmp.ps
#90 0.76 15 -65 5 6 dx=0.1@+o@+
#90 0.84 15 -40 5 6 dx=0.4@+o@+
370 0.4 15 0 5 6 All area

#90 0.92 15 -60 5 6 dx=0.4@+o@+
450 0.80  14 90 5 6 Variation factor
200 1.16 14 0 5 6 Assumed depth of anisotropy (km) --->
END



