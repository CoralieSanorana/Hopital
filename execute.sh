#!/bin/bash

EXECUTE="execute"
SERVLET_API_JAR="lib/servlet-api.jar"
OJDBC_JAR="lib/ojdbc17.jar"
LIBRAIRY_JAR="$SERVLET_API_JAR:$OJDBC_JAR"

echo "Executer les JAVA "
javac -cp $LIBRAIRY_JAR -d $EXECUTE $(find src/java -name "*.java")