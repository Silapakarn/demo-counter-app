
FROM adoptopenjdk:11.0.11_9-jre-hotspot
USER root
COPY target/Uber.jar /app/
COPY ./startup.sh /startup.sh
RUN chmod 754 /startup.sh
# set the startup command to execute the jar
CMD [ "java", "jar","Uber.jar" ]
ENTRYPOINT ["bash","/startup.sh"]