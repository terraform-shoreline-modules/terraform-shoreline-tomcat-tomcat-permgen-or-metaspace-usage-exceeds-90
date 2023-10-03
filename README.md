
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Tomcat PermGen or Metaspace Usage exceeds 90%
---

This incident type occurs when the PermGen or Metaspace usage of the Tomcat server exceeds 90%. PermGen and Metaspace are memory pools used for storing class definitions and metadata of the Java virtual machine (JVM). When these memory pools reach their maximum capacity, the server may experience performance issues or even crash. This incident requires immediate attention from the software engineer to investigate the root cause and take appropriate actions to resolve the issue.

### Parameters
```shell
export PID="PLACEHOLDER"

export TOMCAT_CONF_FILE="PLACEHOLDER"

export PERMGEN_METASPACE="PLACEHOLDER"

export PATH_TO_TOMCAT_CONFIG_FILE="PLACEHOLDER"

export OLD_SIZE="PLACEHOLDER"

export NEW_SIZE="PLACEHOLDER"
```

## Debug

### Check the current memory usage of the Tomcat process
```shell
ps -p ${PID} -o rss,vsz
```

### Check the current PermGen usage of the Tomcat process
```shell
jstat -gc ${PID} | awk '{print $8}'
```

### Check the current Metaspace usage of the Tomcat process
```shell
jstat -gc ${PID} | awk '{print $12}'
```

### Check the limits of the PermGen or Metaspace in the Tomcat configuration
```shell
grep -i "${PERMGEN_METASPACE}.*[0-9]\+" ${TOMCAT_CONF_FILE}
```

### Check the available memory on the server
```shell
free -m
```

### Check the size of the PermGen or Metaspace in the Tomcat configuration
```shell
grep -i "${PERMGEN_METASPACE}.*[0-9]\+" ${TOMCAT_CONF_FILE} | awk -F'[><]' '{print $3}'
```

## Repair

### Increase the PermGen or Metaspace size in the Tomcat configuration file to accommodate the application's memory usage.
```shell


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


```