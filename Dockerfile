FROM python:3.7-stretch

RUN pip install --no-cache notebook bash_kernel
RUN python -m bash_kernel.install

RUN wget -qO - https://bintray.com/user/downloadSubjectPublicKey?username=bintray | apt-key add -  && \
    echo "deb http://dl.bintray.com/siegfried/debian wheezy main" | tee -a /etc/apt/sources.list  && \
    apt-get update && apt-get install -y siegfried && apt-get install -y default-jre

RUN sf -update

RUN curl -s -o /usr/share/java/tika-app-1.21.jar https://www-eu.apache.org/dist/tika/tika-app-1.21.jar

COPY droid /usr/share/java/droid


