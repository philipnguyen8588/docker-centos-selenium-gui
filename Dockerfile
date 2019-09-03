## https://hub.docker.com/r/consol/centos-xfce-vnc/
FROM consol/centos-xfce-vnc:1.3.0
ENV REFRESHED_AT 2018-03-18

# Switch to root user to install additional software
USER 0

COPY ./app/chromedriver_linux64.zip selenium/chromedriver_linux64.zip
COPY ./app/google-chrome-stable_current_x86_64.rpm selenium/google-chrome-stable_current_x86_64.rpm
COPY ./app/selenium-server-standalone-3.141.59.jar selenium/selenium-server-standalone-3.141.59.jar
COPY ./sh/start.sh selenium/start.sh

# Install Java 8, unzip, google chrome
RUN yum -y install java-1.8.0-openjdk unzip && \
    #wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm && \
    yum -y localinstall selenium/google-chrome-stable_current_x86_64.rpm && \
    rm -f selenium/google-chrome-stable_current_x86_64.rpm && \
    chmod a+x selenium/start.sh && \
    #wget https://chromedriver.storage.googleapis.com/76.0.3809.126/chromedriver_linux64.zip && \
    unzip selenium/chromedriver_linux64.zip -d selenium/
    #rm -f chromedriver_linux64.zip && \
    #wget https://selenium-release.storage.googleapis.com/3.141/selenium-server-standalone-3.141.59.jar

#ENTRYPOINT ["/headless/selenium/start.sh"]
CMD ["/headless/selenium/start.sh"]

## switch back to default user
USER 1000