# DigiPres Toolbox
# ----------------
#
# A Docker image with some DigiPres tools pre-installed
#

# Start from as small an image as possible:
FROM python:3.11-slim-bullseye

# Some (smallish) tools and support for installing more (69MB)
RUN apt-get update && \ 
    apt-get install -y unzip curl xz-utils gzip mediainfo cloc file && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install JRE for Java programs (headless 250MB, headful is 431MB)
RUN apt-get update && apt-get install -y default-jre-headless && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Siegfried (71MB)
ENV SF_VERSION=1.11.1
ENV SF_DEB=siegfried_${SF_VERSION}-1_amd64.deb
RUN curl -s -L -O https://github.com/richardlehane/siegfried/releases/download/v${SF_VERSION}/${SF_DEB} && \
    dpkg -i ${SF_DEB} && \
    rm -f ${SF_DEB} && \
    sf -update

# Install TRiD (9MB)
RUN curl -s -L -O http://mark0.net/download/trid_linux_64.zip && \
    curl -s -L -O http://mark0.net/download/triddefs.zip && \
    unzip trid_linux_64.zip && unzip triddefs.zip && chmod +x ./trid && \
    mv ./trid /usr/local/bin/trid && mv triddefs.trd /usr/local/bin/ && \
    rm -f trid_linux_64.zip triddefs.zip

# Install Fido (10MB)
RUN pip install --no-cache-dir opf-fido

# Install RClone (62MB) as per https://rclone.org/install/#linux-precompiled
RUN curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
    unzip rclone-current-linux-amd64.zip && \
    cp rclone-*-linux-amd64/rclone /usr/bin/ && \
    chown root:root /usr/bin/rclone && \
    chmod 755 /usr/bin/rclone && \
    rm -fr rclone-*-linux-*

#
# Skipping the following to try to keep the image size down...
#

# Install GitHub Linguist (~200MB at least, depending on shared deps)
#RUN apt-get update && \
#    apt-get install -y build-essential cmake pkg-config libicu-dev zlib1g-dev libcurl4-openssl-dev libssl-dev ruby-dev && \ 
#    gem install github-linguist && \
#    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install ffmpeg for a/v formats (484MB!)
# RUN apt-get update && apt-get install -y ffmpeg && \
#    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Apache Tika (needs Java)
#ENV TIKA_VERSION=2.9.2
#RUN curl -s -L -o /usr/share/java/tika-app-${TIKA_VERSION}.jar https://dlcdn.apache.org/tika/${TIKA_VERSION}/tika-app-${TIKA_VERSION}.jar && \
#    ln -s /usr/share/java/tika-app-${TIKA_VERSION}.jar /usr/share/java/tika-app.jar
#COPY tika.sh /usr/local/bin/tika.sh

# Install DROID (needs Java)
#COPY droid /usr/share/java/droid
#RUN ln -s /usr/share/java/droid/droid.sh /usr/local/bin/droid.sh
