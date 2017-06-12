FROM jboss-eap-6/eap64-openshift

## Add AJP connector

MAINTAINER Yun In Su <ora01000@time-gate.com>

USER root

## Korean Language Pack enable

RUN localedef -f UTF-8 -i ko_KR ko_KR.UTF-8 && localedef -f EUC-KR -i ko_KR ko_KR.euckr


## copy ojdbc7.jar to image

COPY ojdbc7.jar /usr/share/java
RUN cd /usr/share/java && ln -s ojdbc7.jar ojdbc.jar

USER jboss

RUN mkdir -p /opt/eap/modules/system/layers/openshift/com/oracle/main
COPY module.xml /opt/eap/modules/system/layers/openshift/com/oracle/main
RUN ln -s /usr/share/java/ojdbc7.jar /opt/eap/modules/system/layers/openshift/com/oracle/main/ojdbc.jar
COPY ./configuration/standalone-openshift.xml /opt/eap/standalone/configuration
COPY ./bin/launch/datasource.sh /opt/eap/bin/launch
COPY ./bin/launch/tx-datasource.sh /opt/eap/bin/launch

EXPOSE 8009

USER root

RUN chown jboss:jboss /opt/eap/modules/system/layers/openshift/com/oracle/main/module.xml
RUN chown jboss:jboss /opt/eap/standalone/configuration/standalone-openshift.xml
RUN chown jboss:jboss /opt/eap/bin/launch/datasource.sh
RUN chown jboss:jboss /opt/eap/bin/launch/tx-datasource.sh

# Switch to the user 185 for OpenShift usage
USER 185

# Start the main process
CMD ["/opt/eap/bin/openshift-launch.sh"]
