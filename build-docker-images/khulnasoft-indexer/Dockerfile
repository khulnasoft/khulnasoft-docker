# Khulnasoft Docker Copyright (C) 2017, Khulnasoft Inc. (License GPLv2)
FROM ubuntu:jammy AS builder

ARG KHULNASOFT_VERSION
ARG KHULNASOFT_TAG_REVISION

RUN apt-get update -y && apt-get install curl openssl xz-utils -y

COPY config/opensearch.yml /

COPY config/config.sh .

COPY config/config.yml /

COPY config/internal_users.yml /

COPY config/roles_mapping.yml /

COPY config/roles.yml /

RUN bash config.sh

################################################################################
# Build stage 1 (the actual Khulnasoft indexer image):
#
# Copy khulnasoft-indexer from stage 0
# Add entrypoint
################################################################################
FROM ubuntu:jammy

ENV USER="khulnasoft-indexer" \
    GROUP="khulnasoft-indexer" \
    NAME="khulnasoft-indexer" \
    INSTALL_DIR="/usr/share/khulnasoft-indexer"

RUN getent group $GROUP || groupadd -r -g 1000 $GROUP

RUN useradd --system \
            --uid 1000 \
            --no-create-home \
            --home-dir $INSTALL_DIR \
            --gid $GROUP \
            --shell /sbin/nologin \
            --comment "$USER user" \
            $USER

WORKDIR $INSTALL_DIR

COPY config/entrypoint.sh /

COPY config/securityadmin.sh /

RUN chmod 700 /entrypoint.sh && chmod 700 /securityadmin.sh

RUN chown 1000:1000 /*.sh

COPY --from=builder --chown=1000:1000 /debian/khulnasoft-indexer/usr/share/khulnasoft-indexer /usr/share/khulnasoft-indexer
COPY --from=builder --chown=0:0 /debian/khulnasoft-indexer/usr/lib/systemd /usr/lib/systemd
COPY --from=builder --chown=0:0 /debian/khulnasoft-indexer/usr/lib/sysctl.d /usr/lib/sysctl.d
COPY --from=builder --chown=0:0 /debian/khulnasoft-indexer/usr/lib/tmpfiles.d /usr/lib/tmpfiles.d

RUN chown -R 1000:1000 /usr/share/khulnasoft-indexer

RUN mkdir -p /var/lib/khulnasoft-indexer && chown 1000:1000 /var/lib/khulnasoft-indexer && \
    mkdir -p /usr/share/khulnasoft-indexer/logs && chown 1000:1000 /usr/share/khulnasoft-indexer/logs && \
    mkdir -p /run/khulnasoft-indexer && chown 1000:1000 /run/khulnasoft-indexer && \
    mkdir -p /var/log/khulnasoft-indexer && chown 1000:1000 /var/log/khulnasoft-indexer && \
    chmod 700 /usr/share/khulnasoft-indexer && \
    chmod 600 /usr/share/khulnasoft-indexer/jvm.options && \
    chmod 600 /usr/share/khulnasoft-indexer/opensearch.yml

USER khulnasoft-indexer

# Services ports
EXPOSE 9200

ENTRYPOINT ["/entrypoint.sh"]
# Dummy overridable parameter parsed by entrypoint
CMD ["opensearchwrapper"]