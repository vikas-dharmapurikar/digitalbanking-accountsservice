FROM maven


ENV A8_SERVICE=accountsservices:v1
ENV A8_ENDPOINT_PORT=8090
ENV A8_ENDPOINT_TYPE=http
ENV A8_REGISTRY_URL=http://ADM-a8-registry.mybluemix.net
ENV A8_REGISTRY_POLL=60s
ENV A8_CONTROLLER_URL=http://ADM-a8-controller.mybluemix.net
ENV A8_CONTROLLER_POLL=60s
ENV A8_LOG=enable_log


RUN apt-get install git

RUN git clone https://github.com/caprepo/digitalbanking-accountsservice.git

RUN cd /digitalbanking-accountsservice

RUN mvn -f /digitalbanking-accountsservice/pom.xml clean install -DskipTests

EXPOSE 8090

ENTRYPOINT ["java", "-jar", "-Dspring.profiles.active=docker", "/digitalbanking-accountsservice/target/accountservices-1.0.war"]
