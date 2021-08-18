rm 2.txt filenames.txt
countmax=5
l=`cat 1.txt |  wc -l | awk '{print $1}'`


for comp in HHZ                       ######## change this if needed
do

for i in `seq 1 1 $l`
do
date=`cat 1.txt | awk -v j=$i -F"," 'NR==j {print $3}' | awk -F"-" '{print $1"\t"$2"\t"$3}'`
year=`echo $date | awk '{print $1}'`
month=`echo $date | awk '{print $2}'`
day=`echo $date | awk '{print $3}'`
n=`echo $year | awk '{if($1%400 == 0) print 1 ; else if($1%100 == 0) print 0 ; else if($1%4 == 0) print 1 ; else print 0 }'`
if [[ $n -eq 0 ]]
then

	jd=`cat years.txt | awk -v k=$month -v d=$day 'BEGIN{
	}

	NR<=k  {
	l[NR]=$2
	sum+=l[NR]
	}

	END {
	s=sum+d
	print s
	
	}'`
elif [[ $n -eq 1 ]]
then

	jd=`cat years.txt | awk -v k=$month -v d=$day 'BEGIN{
	}

	NR<=k  {
	l[NR]=$3
	sum+=l[NR]
	}

	END {
	s=sum+d
	print s
	
	}'`

	
fi
jdd=`echo $jd | awk '{if($1<=9) print "00"$1 ; else if ($1>=10 && $1 <= 99) print "0"$1 ; else print $1}'`
f=`cat 1.txt | awk -F"," -v j=$i 'NR==j{print $3}' | awk -F"-" '{print $1}'`
p=`cat 1.txt | awk -F"," -v j=$i 'NR==j{print $4}' | awk -F"." '{print $1}' | awk -F":" '{print $1"."$2"."$3}'`
a=`cat 1.txt | awk -F"," -v j=$i 'NR==j{print $4}' | awk -F"." '{print $2}' | awk '{if($1=="") print "00" ; else print $1}'`
mag=`cat 1.txt | awk -F"," -v j=$i 'NR==j{print $11}'`
s=`cat 1.txt | awk -F"," -v j=$i -v b=$f -v q=$jdd -v z=$p -v c=$a 'NR==j {print b"."q"."z"\t"c"\t"$5"\t"$6"\t"$7 }'` 
echo $s"	"$mag >> 2.txt
done

tar -xvf *tar*
x=`ls -d */`
rdseed -d -o l -f -p $x*.mseed -g $x*.dataless
rm -r -d */
#mseed2sac *.mseed
#rdseed -d -o 1 -p -f *.seed

for name in *$comp*.SAC
do
name2=`echo $name | awk -F"." '{print $1"."$2"."$3"."$4"."$5}'`
#echo $name
count=0
length=`cat 2.txt | wc -l`
for xn in `seq 1 1 $length`
do
x=`cat 2.txt | head -n$xn | tail -n1`
count=`echo $count+1 | bc`
if [[ $count -gt $countmax ]]
then
	echo count=$count
	break
fi
x1=`echo $x |awk -F" " '{print $1}'`
#echo name2=$name2 x1=$x1
if [[ "$name2" = "$x1" ]]
then
	echo DONE
	no=`cat 2.txt | awk '{print $1}' | grep  -n "$x1" | awk -F":" '{print $1}'`  
	lat=`cat 2.txt | awk -v n=$no 'NR==n {print $3}'`
	lon=`cat 2.txt | awk -v n=$no 'NR==n {print $4}'`
	dep=`cat 2.txt | awk -v n=$no 'NR==n {print $5*1000}'`
	magn=`cat 2.txt | awk -v n=$no 'NR==n {print $6}'`
	ori=`cat 2.txt | awk -v n=$no 'NR==n {print $1"\t"$2}' | awk -F"." '{print $1"\t"$2"\t"$3"\t"$4"\t"$5 }'`
	ori1=`echo $ori | awk '{print $1}'`
	ori2=`echo $ori | awk '{print $2}'`
	ori3=`echo $ori | awk '{print $3}'`
	ori4=`echo $ori | awk '{print $4}'`
	ori5=`echo $ori | awk '{print $5}'`
	ori6=`echo $ori | awk '{print $6}'`
	sac<<!
r *$x1*
ch EVLA $lat
ch EVLO $lon
ch EVDP $dep
ch o gmt $ori1 $ori2 $ori3 $ori4 $ori5 $ori6
ch MAG $magn
w over
q
!
	sed '/'$x1'/d' 2.txt > 2_1.txt
	cp 2_1.txt 2.txt
	break
fi
jdname=`echo $name2 |awk -F"." '{print 1*$2}'`
jdx1=`echo $x1 |awk -F"." '{print 1*$2}'`
yname=`echo $name2 |awk -F"." '{print 1*$1}'`
yx1=`echo $x1 |awk -F"." '{print 1*$1}'`
if [[ $yname -gt $yx1 ]]
then
	sed '/'$x1'/d' 2.txt > 2_1.txt
	cp 2_1.txt 2.txt
	continue
elif [[ $jdname -gt $jdx1 ]]
then
	sed '/'$x1'/d' 2.txt > 2_1.txt
	cp 2_1.txt 2.txt
	continue
fi
done
done
done
