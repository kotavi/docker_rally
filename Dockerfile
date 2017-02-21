FROM rallyforge/rally:latest
MAINTAINER Tetiana Korchak

ADD deployment.json .
ADD openrc .
ADD prepare.sh .
