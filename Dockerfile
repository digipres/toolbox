# DigiPres Toolbox
# A Docker image with some tools pre-installed
FROM python:3.10-bullseye

# Core Jupyter support:
RUN pip install --no-cache notebook jupyterlab bash_kernel
RUN python -m bash_kernel.install

# Some lightweight tools and support for installing more:
RUN apt-get update && apt-get install -y sudo mediainfo cloc && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Siegfried:
ENV SF_VERSION=1.11.1
ENV SF_DEB=siegfried_${SF_VERSION}-1_amd64.deb
RUN curl -s -L -O https://github.com/richardlehane/siegfried/releases/download/v${SF_VERSION}/${SF_DEB} && \
    dpkg -i ${SF_DEB} && \
    rm -f ${SF_DEB} && \
    sf -update

# Install TRiD:
RUN curl -s -L -O http://mark0.net/download/trid_linux_64.zip && \
curl -s -L -O http://mark0.net/download/triddefs.zip && \
unzip trid_linux_64.zip && unzip triddefs.zip && chmod +x ./trid && \
mv ./trid /usr/local/bin/trid && mv triddefs.trd /usr/local/bin/ && \
rm -f trid_linux_64.zip triddefs.zip

# Install Fido:
RUN pip install --no-cache opf-fido

# Install JRE for Java programs and ffmpeg for a/v formats (c. 0.6GB!):
RUN apt-get update && apt-get install -y default-jre ffmpeg && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install GitHub Linguist and it's build dependencies (c. 0.2GB):
RUN apt-get update && \
    apt-get install -y cmake pkg-config libicu-dev zlib1g-dev libcurl4-openssl-dev libssl-dev ruby-dev && \ 
    apt-get clean && rm -rf /var/lib/apt/lists/*
RUN gem install github-linguist

# Install Apache Tika (needs Java):
ENV TIKA_VERSION=2.9.2
RUN curl -s -L -o /usr/share/java/tika-app-${TIKA_VERSION}.jar https://dlcdn.apache.org/tika/${TIKA_VERSION}/tika-app-${TIKA_VERSION}.jar && \
    ln -s /usr/share/java/tika-app-${TIKA_VERSION}.jar /usr/share/java/tika-app.jar
COPY tika.sh /usr/local/bin/tika.sh

# Install DROID (needs Java)
COPY droid /usr/share/java/droid
RUN ln -s /usr/share/java/droid/droid.sh /usr/local/bin/droid.sh

