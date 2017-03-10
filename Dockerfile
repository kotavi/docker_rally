FROM rallyforge/rally:latest
MAINTAINER Tetiana Korchak

COPY openrc .
COPY fix_deployment_config.sh .
