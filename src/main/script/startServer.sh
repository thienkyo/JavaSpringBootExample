#!/bin/sh

#export JAVA_HOME=/usr/local/java
#PATH=/usr/local/java/bin:${PATH}

#cd /home/ala/DevDaily/Musubi

#---------------------------------#
# dynamically build the classpath #
#---------------------------------#
#THE_CLASSPATH=
#for i in `ls ./lib/*.jar`
#do
#  THE_CLASSPATH=${THE_CLASSPATH}:${i}
#done

#---------------------------#
# run the anti-spam program #
#---------------------------#
#java -cp ".:${THE_CLASSPATH}"  \
#   EmailAgentController        \
#   lib/mail.properties         \
#   lib/userMail.properties     \
#   message.uid.cache           \
#   | tee -a SPAM.mbox


CLASSPATH=
for file in `ls ../lib/*.jar`
do
	CLASSPATH=${CLASSPATH}:${file}
done

for f  in `ls ../classes/*.jar`
do
	CLASSPATH=${CLASSPATH}:${f}
done
echo $CLASSPATH

java -cp ":${CLASSPATH}" \
	com.canh.App --spring.config.location=../properties/application.properties > ../logs/server.log & echo "$!" > ../pid/myjavaprogram.pid

i=0
while [ $i -lt 5 ]	
do
	
	if grep -q "Started App" ../logs/server.log;
		then
			echo "Started app"
			echo "process id:$!"
			break
  		else
    			echo "waiting..."
 	fi
	sleep 5

done
























