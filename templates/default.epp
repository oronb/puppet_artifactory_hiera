<% | String $artifactory
     String $java
     String $destination
     String $file
| %>    

artifactory="4.4.3"
java="8"
#Default values
export ARTIFACTORY_HOME="/$destination/artifactory-oss-$artifactory"
export ARTIFACTORY_USER=artifactory
export JAVA_HOME="/usr/lib/jvm/java-$java-openjdk-amd64"

export TOMCAT_HOME="/$destination/artifactory-oss-$artifactory/tomcat"
export ARTIFACTORY_PID=$ARTIFACTORY_HOME/run/artifactory.pid

export JAVA_OPTIONS="-server -Xms512m -Xmx2g -Xss256k -XX:PermSize=128m -XX:MaxPermSize=128m -XX:+UseG1GC"

