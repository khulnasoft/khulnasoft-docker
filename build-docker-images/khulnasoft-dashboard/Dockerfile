# Khulnasoft Docker Copyright (C) 2017, Khulnasoft Inc. (License GPLv2)
FROM ubuntu:jammy AS builder

ARG KHULNASOFT_VERSION
ARG KHULNASOFT_TAG_REVISION
ARG INSTALL_DIR=/usr/share/khulnasoft-dashboard
ARG KHULNASOFT_UI_REVISION=1

# Update and install dependencies
RUN apt-get update && apt install curl libcap2-bin xz-utils -y

# Create Install dir
RUN mkdir -p $INSTALL_DIR

# Download and extract Khulnasoft dashboard base
COPY config/dl_base.sh .
RUN bash dl_base.sh

# Generate certificates
COPY config/config.sh .
COPY config/config.yml /
RUN bash config.sh

COPY config/install_khulnasoft_app.sh /
RUN chmod 775 /install_khulnasoft_app.sh
RUN bash /install_khulnasoft_app.sh

# Copy and set permissions to config files
COPY config/opensearch_dashboards.yml $INSTALL_DIR/config/
COPY config/khulnasoft.yml $INSTALL_DIR/data/khulnasoft/config/
RUN chown 101:101 $INSTALL_DIR/config/opensearch_dashboards.yml && chmod 664 $INSTALL_DIR/config/opensearch_dashboards.yml

# Create and set permissions to data directories
RUN mkdir -p $INSTALL_DIR/data/khulnasoft && chown -R 101:101 $INSTALL_DIR/data/khulnasoft && chmod -R 775 $INSTALL_DIR/data/khulnasoft
RUN mkdir -p $INSTALL_DIR/data/khulnasoft/config && chown -R 101:101 $INSTALL_DIR/data/khulnasoft/config && chmod -R 775 $INSTALL_DIR/data/khulnasoft/config
RUN mkdir -p $INSTALL_DIR/data/khulnasoft/logs && chown -R 101:101 $INSTALL_DIR/data/khulnasoft/logs && chmod -R 775 $INSTALL_DIR/data/khulnasoft/logs

################################################################################
# Build stage 1 (the current Khulnasoft dashboard image):
#
# Copy khulnasoft-dashboard from stage 0
# Add entrypoint
# Add khulnasoft_app_config
################################################################################
FROM ubuntu:jammy

# Set environment variables
ENV USER="khulnasoft-dashboard" \
    GROUP="khulnasoft-dashboard" \
    NAME="khulnasoft-dashboard" \
    INSTALL_DIR="/usr/share/khulnasoft-dashboard"

# Set Khulnasoft app variables
ENV PATTERN="" \
    CHECKS_PATTERN="" \
    CHECKS_TEMPLATE="" \
    CHECKS_API="" \
    CHECKS_SETUP="" \
    EXTENSIONS_PCI="" \
    EXTENSIONS_GDPR="" \
    EXTENSIONS_HIPAA="" \
    EXTENSIONS_NIST="" \
    EXTENSIONS_TSC="" \
    EXTENSIONS_AUDIT="" \
    EXTENSIONS_OSCAP="" \
    EXTENSIONS_CISCAT="" \
    EXTENSIONS_AWS="" \
    EXTENSIONS_GCP="" \
    EXTENSIONS_VIRUSTOTAL="" \
    EXTENSIONS_OSQUERY="" \
    EXTENSIONS_DOCKER="" \
    APP_TIMEOUT="" \
    API_SELECTOR="" \
    IP_SELECTOR="" \
    IP_IGNORE="" \
    KHULNASOFT_MONITORING_ENABLED="" \
    KHULNASOFT_MONITORING_FREQUENCY="" \
    KHULNASOFT_MONITORING_SHARDS="" \
    KHULNASOFT_MONITORING_REPLICAS=""

# Install dependencies
RUN apt update && apt install -y libnss3-dev fonts-liberation libfontconfig1

# Create khulnasoft-dashboard user and group
RUN getent group $GROUP || groupadd -r -g 1000 $GROUP
RUN useradd --system \
            --uid 1000 \
            --no-create-home \
            --home-dir $INSTALL_DIR \
            --gid $GROUP \
            --shell /sbin/nologin \
            --comment "$USER user" \
            $USER

# Copy and set permissions to scripts
COPY config/entrypoint.sh /
COPY config/khulnasoft_app_config.sh /
RUN chmod 700 /entrypoint.sh
RUN chmod 700 /khulnasoft_app_config.sh
RUN chown 1000:1000 /*.sh

# Copy Install dir from builder to current image
COPY --from=builder --chown=1000:1000 $INSTALL_DIR $INSTALL_DIR

# Set workdir and user
WORKDIR $INSTALL_DIR
USER khulnasoft-dashboard

# Services ports
EXPOSE 443

ENTRYPOINT [ "/entrypoint.sh" ]
