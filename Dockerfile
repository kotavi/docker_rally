FROM rallyforge/rally:latest
MAINTAINER Tetiana Korchak

#ADD deployment.json .
#ADD openrc .
COPY /root/openrc /home
ADD prepare.sh .
