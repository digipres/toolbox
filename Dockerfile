FROM python:3.7-stretch

RUN pip install --no-cache notebook bash_kernel opf-fido
RUN python -m bash_kernel.install

RUN curl -sL "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x20F802FE798E6857" | gpg --dearmor | sudo tee /usr/share/keyrings/siegfried-archive-keyring.gpg && \
echo "deb [signed-by=/usr/share/keyrings/siegfried-archive-keyring.gpg] https://www.itforarchivists.com/ buster main" | sudo tee -a /etc/apt/sources.list.d/siegfried.list

RUN apt-get update && apt-get install -y siegfried mediainfo default-jre ffmpeg cloc && \
    apt-get install -y cmake pkg-config libicu-dev zlib1g-dev libcurl4-openssl-dev libssl-dev ruby-dev && \ 
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN sf -update && gem install github-linguist --no-ri --no-rdoc

RUN curl -s -o /usr/share/java/tika-app-1.21.jar https://www-eu.apache.org/dist/tika/tika-app-1.21.jar && \
    ln -s /usr/share/java/tika-app-1.21.jar /usr/share/java/tika-app.jar

COPY droid /usr/share/java/droid
RUN ln -s /usr/share/java/droid/droid.sh /usr/local/bin/droid.sh
COPY tika.sh /usr/local/bin/tika.sh

RUN curl -s -O http://mark0.net/download/trid_linux_64.zip && \
    curl -s -O http://mark0.net/download/triddefs.zip && \
    unzip trid_linux_64.zip && unzip triddefs.zip && chmod +x ./trid && \
    cp ./trid /usr/local/bin/trid && cp triddefs.trd /usr/local/bin/

