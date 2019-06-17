FROM python:3.7-stretch

RUN pip install --no-cache notebook bash_kernel
RUN python -m bash_kernel.install

RUN wget -qO - https://bintray.com/user/downloadSubjectPublicKey?username=bintray | apt-key add -  && \
    echo "deb http://dl.bintray.com/siegfried/debian wheezy main" | tee -a /etc/apt/sources.list  && \
    apt-get update && apt-get install -y siegfried && apt-get install -y default-jre && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN sf -update

RUN curl -s -o /usr/share/java/tika-app-1.21.jar https://www-eu.apache.org/dist/tika/tika-app-1.21.jar && \
    ln -s /usr/share/java/tika-app-1.21.jar /usr/share/java/tika-app.jar

COPY droid /usr/share/java/droid
RUN ln -s /usr/share/java/droid/droid.sh /usr/local/bin/droid.sh
COPY tika.sh /usr/local/bin/tika.sh

RUN curl -s -O http://mark0.net/download/trid_linux_64.zip && \
    curl -s -O http://mark0.net/download/triddefs.zip && \
    unzip trid_linux_64.zip && unzip triddefs.zip && chmod +x ./trid && \
    cp ./trid /usr/local/bin/trid && cp triddefs.trd /usr/local/bin/

