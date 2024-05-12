FROM ubuntu
WORKDIR /graphene-builder
ARG DEVICE_NAME
ARG VERSION
RUN apt update -y && \
	apt install -y libarchive-tools curl android-sdk-platform-tools-common openssh-client
RUN curl -O https://dl.google.com/android/repository/platform-tools_r35.0.0-linux.zip
RUN echo '62fc977c1b7622ef8dbd6fe1312987d9b139aa8a0b06e88573c1b60129399d49  platform-tools_r35.0.0-linux.zip' | sha256sum -c && \
    bsdtar -xvf platform-tools_r35.0.0-linux.zip
ENV PATH="/graphene-builder/platform-tools:$PATH"
RUN curl -O https://releases.grapheneos.org/allowed_signers
RUN curl -O https://releases.grapheneos.org/allowed_signers.sig
RUN curl -O https://releases.grapheneos.org/${DEVICE_NAME}-factory-${VERSION}.zip \
 && curl -O https://releases.grapheneos.org/${DEVICE_NAME}-factory-${VERSION}.zip.sig
RUN ssh-keygen -Y verify -f allowed_signers -I contact@grapheneos.org -n "factory images" -s ${DEVICE_NAME}-factory-${VERSION}.zip.sig < ${DEVICE_NAME}-factory-${VERSION}.zip
RUN bsdtar xvf ${DEVICE_NAME}-factory-${VERSION}.zip
WORKDIR ${DEVICE_NAME}-factory-${VERSION}

