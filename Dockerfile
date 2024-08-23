FROM python:3.7-bullseye

RUN pip install --no-cache notebook bash_kernel opf-fido
RUN python -m bash_kernel.install

RUN apt-get update && apt-get install -y golang mediainfo default-jre ffmpeg cloc && \
    apt-get install -y cmake pkg-config libicu-dev zlib1g-dev libcurl4-openssl-dev libssl-dev ruby-dev && \ 
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN gem install github-linguist

RUN curl -s -L -O https://github.com/richardlehane/siegfried/releases/download/v1.11.1/siegfried_1.11.1-1_amd64.deb && \
    dpkg -i siegfried_1.11.1-1_amd64.deb && \
    sf -update

RUN curl -s -L -o /usr/share/java/tika-app-2.9.2.jar https://dlcdn.apache.org/tika/2.9.2/tika-app-2.9.2.jar && \
    ln -s /usr/share/java/tika-app-2.9.2.jar /usr/share/java/tika-app.jar

COPY droid /usr/share/java/droid
RUN ln -s /usr/share/java/droid/droid.sh /usr/local/bin/droid.sh
COPY tika.sh /usr/local/bin/tika.sh

RUN curl -s -L -O http://mark0.net/download/trid_linux_64.zip && \
    curl -s -L -O http://mark0.net/download/triddefs.zip && \
    unzip trid_linux_64.zip && unzip triddefs.zip && chmod +x ./trid && \
    cp ./trid /usr/local/bin/trid && cp triddefs.trd /usr/local/bin/

