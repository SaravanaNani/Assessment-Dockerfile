FROM ubuntu:latest

# Installing Java latest version
RUN apt-get update && \
    apt-get install -y \
    openjdk-17-jdk

# Set environment variables for Java
ENV JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"
ENV PATH=$JAVA_HOME/bin:$PATH


# Download and extract Apache Tomcat
ADD https://dlcdn.apache.org/tomcat/tomcat-11/v11.0.2/bin/apache-tomcat-11.0.2.tar.gz .
RUN tar -zxvf apache-tomcat-11.0.2.tar.gz && \
    rm apache-tomcat-11.0.2.tar.gz

# Configure Tomcat users
RUN sed -i '56 a\<role rolename="manager-gui"/>' apache-tomcat-11.0.2/conf/tomcat-users.xml && \
    sed -i '57 a\<role rolename="manager-script"/>' apache-tomcat-11.0.2/conf/tomcat-users.xml && \
    sed -i '58 a\<user username="tomcat" password="tomcat" roles="manager-gui, manager-script"/>' apache-tomcat-11.0.2/conf/tomcat-users.xml && \
    sed -i '59 a\</tomcat-users>' apache-tomcat-11.0.2/conf/tomcat-users.xml && \
    sed -i '56d' apache-tomcat-11.0.2/conf/tomcat-users.xml && \
    sed -i '21d' apache-tomcat-11.0.2/webapps/manager/META-INF/context.xml && \
    sed -i '22d' apache-tomcat-11.0.2/webapps/manager/META-INF/context.xml

COPY --from=build-stage /maven/target/*.war ./apache-tomcat-11.0.2/webapps

RUN mv ./apache-tomcat-11.0.2 /usr/local/

EXPOSE 8080

# CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
# ENTRYPOINT ["/usr/local/apache-tomcat-11.0.2/bin/catalina.sh", "run"]
CMD ["sh", "-c", "/usr/sbin/apachectl -D FOREGROUND & /usr/local/apache-tomcat-11.0.2/bin/catalina.sh run"]
