FROM centos:7

MAINTAINER Aaron Stone <aaronastone@gmail.com>

RUN yum install -y tar \
  wget \
  gzip

# Install Java JDK 7u67
RUN cd /opt && \
  wget --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u67-b01/jdk-7u67-linux-x64.tar.gz" && \
  tar xvf jdk-7u67-linux-x64.tar.gz && \
  chown -R root: jdk1.7.0_67 && \
  rm /opt/jdk-7u67-linux-x64.tar.gz

ENV JAVA_HOME=/opt/jdk1.7.0_67

# Install Tomcat 7.0.55
RUN cd /opt && \
  wget "http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.55/bin/apache-tomcat-7.0.55.tar.gz" && \
  tar xvf apache-tomcat-7.0.55.tar.gz && \
  chown -R root: apache-tomcat-7.0.55 && \
  rm /opt/apache-tomcat-7.0.55.tar.gz

# Open port 8080 for app
EXPOSE 8080

WORKDIR /opt/apache-tomcat-7.0.55

COPY *.war webapps/

# Start Tomcat
CMD ./bin/startup.sh && tail -f logs/catalina.out