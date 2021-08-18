#cp make/1.txt 190.txt

for file90 in `ls *_*seed`
do
	N=`echo $file90 | awk -F"_" '{print $1"_"$2}'`
	mkdir $N
	cd $N

	cp ../$file90 $file90
	cp ../190.txt  1.txt
	cp ../2.sh 2.sh
	cp ../years.txt years.txt
	bash 2.sh
	
	
	for gfile in `ls *.SAC`
	do
		G=`sac<<! |grep GCARC| awk -F" " '{print $3}'
r $gfile
lh GCARC
q
!`
		G=`echo $G | awk '{print $1*1}'`
		G=`echo $G | awk -F"." '{print $1}'`
		if [[ $G -lt 90 ]]
		then
			rm $gfile
		fi
		if [[ $G -gt 140 ]]
		then
			rm $gfile
		fi
		echo $G
	done
	rm *.txt 2.sh years.txt filenames.txt
	rm $file90
	cd ..
	mv $N 13090/$N
	
done

