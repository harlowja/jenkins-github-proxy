FROM nginx:latest

COPY startup.sh /tmp/

CMD /tmp/startup.sh
