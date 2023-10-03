

#!/bin/bash



TOMCAT_CONFIG_FILE=${PATH_TO_TOMCAT_CONFIG_FILE}



# Back up the original config file

cp $TOMCAT_CONFIG_FILE $TOMCAT_CONFIG_FILE.bak



# Increase the PermGen or Metaspace size

sed -i 's/PermGenSize=${OLD_SIZE}/PermGenSize=${NEW_SIZE}/g' $TOMCAT_CONFIG_FILE

sed -i 's/MaxPermSize=${OLD_SIZE}/MaxPermSize=${NEW_SIZE}/g' $TOMCAT_CONFIG_FILE

sed -i 's/MetaspaceSize=${OLD_SIZE}/MetaspaceSize=${NEW_SIZE}/g' $TOMCAT_CONFIG_FILE

sed -i 's/MaxMetaspaceSize=${OLD_SIZE}/MaxMetaspaceSize=${NEW_SIZE}/g' $TOMCAT_CONFIG_FILE



echo "PermGen or Metaspace size increased in the Tomcat configuration file."