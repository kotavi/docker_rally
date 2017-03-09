FROM rallyforge/rally:latest
MAINTAINER Tetiana Korchak

COPY /home/openrc .
ADD fix_deployment_config.sh .
