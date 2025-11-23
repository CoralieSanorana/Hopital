#!/bin/bash

# Définition des variables
APP_NAME="Hopital"
SRC_DIR="src/java"
WEB_DIR="src/webapp"
BUILD_DIR="build"
LIB_DIR="lib"
TOMCAT_WEBAPPS="/home/coralie/S3/apache-tomcat-10.0.16/webapps"
SERVLET_API_JAR="$LIB_DIR/servlet-api.jar"
OJDBC_JAR="$LIB_DIR/ojdbc17.jar"
LIBRAIRY_JAR="$SERVLET_API_JAR:$OJDBC_JAR"

# Nettoyage et création du répertoire temporaire
rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR/WEB-INF/classes

# Compilation des fichiers Java avec le JAR des Servlets
find $SRC_DIR -name "*.java" > sources.txt
javac -cp $LIBRAIRY_JAR -d $BUILD_DIR/WEB-INF/classes @sources.txt
rm sources.txt

# Copier le driver JDBC dans WEB-INF/lib
mkdir -p $BUILD_DIR/WEB-INF/lib
cp $OJDBC_JAR $BUILD_DIR/WEB-INF/lib/

# Copier assets (boostrap,css)
cp src/webapp/assets $BUILD_DIR/

# Copier les fichiers web (web.xml, JSP, etc.)
cp -r $WEB_DIR/* $BUILD_DIR/

# Générer le fichier .war dans le dossier build
cd $BUILD_DIR || exit
jar -cvf $APP_NAME.war *
cd ..

# Déploiement dans Tomcat
cp -f $BUILD_DIR/$APP_NAME.war $TOMCAT_WEBAPPS/

echo ""

#echo "Redémarrage de Tomcat..."
#"$TOMCAT_WEBAPPS/../bin/shutdown.sh"
#sleep 3
#"$TOMCAT_WEBAPPS/../bin/startup.sh"

#exit 0
#echo ""
