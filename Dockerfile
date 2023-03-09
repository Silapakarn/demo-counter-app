FROM adoptopenjdk:11.0.11_9-jre-hotspot
USER root
COPY target/Uber.jar /app/
# @@ -6,4 +6,4 @@ COPY ./startup.sh /startup.sh
COPY ./startup.sh /startup.sh

RUN chmod 754 /startup.sh
RUN mkdir /appdata

EXPOSE 8088

ENTRYPOINT ["bash","/startup.sh"]

