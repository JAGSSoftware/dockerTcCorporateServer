FROM centos:7

LABEL author="José Alberto García Sánchez"
LABEL version="1.0"
LABEL description="Container with the installation of TC Corporate Server \
using a database running un local"

# Environment variables
ENV JAVA_VERSION=8
ENV JAVA_UPDATE=144
ENV JAVA_BUILD=01
ENV SIG=090f390dda5b47b9b721c7dfaa008135

ENV JAVA_HOME=/usr/local/oracle/jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}
ENV JRE_HOME=$JAVA_HOME/jre
ENV TC_ROOT=/usr/Siemens/Teamcenter11
ENV TC_DATA=/usr/Siemens/tcdata

# Additional shells and tools required
RUN yum update && \
  yum install -y csh ksh libaio openssh-server openssh-clients

# Installation directory of Teamcenter Corporate Server
RUN mkdir /usr/Siemens && \
   mkdir /usr/local/oracle

# Installation of JDK
RUN curl --silent --insecure --location --retry 3 \
    --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
    http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}u${JAVA_UPDATE}-b${JAVA_BUILD}/${SIG}/server-jre-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz \
    | tar xz -C /usr/local/oracle

# Copying the installation
COPY ./Teamcenter11/ /usr/Siemens/Teamcenter11/
COPY ./tcdata/ /usr/Siemens/tcdata/
COPY ./volume/ /usr/Siemens/volume/

VOLUME ["/usr/Siemens/tcdata", "/usr/Siemens/volume"]

# Installation of script to run the FSC service
COPY ./Teamcenter11/bin/su_FSC_localhost_root /etc/init.d/rc.ugs.FSC_localhost_root
RUN ["chmod", "755", "/etc/init.d/rc.ugs.FSC_localhost_root"]
WORKDIR /etc/init.d
RUN ["chkconfig", "rc.ugs.FSC_localhost_root", "on"]

EXPOSE 22
WORKDIR /usr/Siemens

CMD source $TC_DATA/tc_profilevars && \
  /etc/init.d/rc.ugs.FSC_localhost_root && \
  /bin/bash
