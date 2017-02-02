FROM tomcat:9.0.0-jre8-alpine

ENV GS_VERSION 2.10.1
ENV GEOSERVER_DATA_DIR /opt/geoserver/data_dir

RUN mkdir -p $GEOSERVER_DATA_DIR

WORKDIR /tmp

RUN apk add --no-cache unzip \
        openssl \
        tar && \  
    # get geoserver and jai libraries from the web
    wget -q http://sourceforge.net/projects/geoserver/files/GeoServer/${GS_VERSION}/geoserver-${GS_VERSION}-war.zip -O geoserver.zip && \
    wget -q http://download.java.net/media/jai/builds/release/1_1_3/jai-1_1_3-lib-linux-amd64.tar.gz  && \
    wget -q http://download.java.net/media/jai-imageio/builds/release/1.1/jai_imageio-1_1-lib-linux-amd64.tar.gz

# unpack jai libraries and move to $JAVA_HOME folders
RUN tar -xvzf jai-1_1_3-lib-linux-amd64.tar.gz && \
    tar -xvzf jai_imageio-1_1-lib-linux-amd64.tar.gz && \
    
    mv /tmp/jai-1_1_3/lib/*.jar $JAVA_HOME/lib/ext/ && \ 
    mv /tmp/jai-1_1_3/lib/*.so $JAVA_HOME/lib/amd64/ && \ 
    mv /tmp/jai_imageio-1_1/lib/*.jar $JAVA_HOME/lib/ext/ && \ 
    mv /tmp/jai_imageio-1_1/lib/*.so $JAVA_HOME/lib/amd64/ 

WORKDIR $CATALINA_HOME

# move geoserver files to tomcat webapps folder
RUN unzip /tmp/geoserver.zip -d /tmp && \
    mv /tmp/geoserver.war /usr/local/tomcat/webapps/geoserver.war

#some cleanup of files and apk packages
RUN rm -rf $CATALINA_HOME/webapps/ROOT && \
    rm -rf $CATALINA_HOME/webapps/docs && \
    rm -rf $CATALINA_HOME/webapps/examples && \
    rm -rf $CATALINA_HOME/webapps/host-manager && \
    rm -rf $CATALINA_HOME/webapps/manager && \
    rm -rf /tmp && \
    apk del unzip openssl tar

EXPOSE 8080

CMD ["catalina.sh", "run"]
