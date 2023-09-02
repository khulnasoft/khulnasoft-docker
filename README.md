# Khulnasoft containers for Docker

[![Slack](https://img.shields.io/badge/slack-join-blue.svg)](https://khulnasoft.com/community/join-us-on-slack/)
[![Email](https://img.shields.io/badge/email-join-blue.svg)](https://groups.google.com/forum/#!forum/khulnasoft)
[![Documentation](https://img.shields.io/badge/docs-view-green.svg)](https://documentation.khulnasoft.com)
[![Documentation](https://img.shields.io/badge/web-view-green.svg)](https://khulnasoft.com)

In this repository you will find the containers to run:

* Khulnasoft manager: it runs the Khulnasoft manager, Khulnasoft API and Filebeat OSS
* Khulnasoft dashboard: provides a web user interface to browse through alerts data and allows you to visualize agents configuration and status.
* Khulnasoft indexer: Khulnasoft indexer container (working as a single-node cluster or as a multi-node cluster). **Be aware to increase the `vm.max_map_count` setting, as it's detailed in the [Khulnasoft documentation](https://documentation.khulnasoft.com/current/docker/khulnasoft-container.html#increase-max-map-count-on-your-host-linux).**

The folder `build-docker-images` contains a README explaining how to build the Khulnasoft images and the necessary assets.
The folder `indexer-certs-creator` contains a README explaining how to create the certificates creator tool and the necessary assets.
The folder `single-node` contains a README explaining how to run a Khulnasoft environment with one Khulnasoft manager, one Khulnasoft indexer, and one Khulnasoft dashboard.
The folder `multi-node` contains a README explaining how to run a Khulnasoft environment with two Khulnasoft managers, three Khulnasoft indexer, and one Khulnasoft dashboard.

## Documentation

* [Khulnasoft full documentation](http://documentation.khulnasoft.com)
* [Khulnasoft documentation for Docker](https://documentation.khulnasoft.com/current/docker/index.html)
* [Docker hub](https://hub.docker.com/u/khulnasoft)


### Setup SSL certificate

Before starting the environment it is required to provide an SSL certificate (or just generate one self-signed).

Documentation on how to provide these two can be found at [Khulnasoft Docker Documentation](https://documentation.khulnasoft.com/current/docker/khulnasoft-container.html#production-deployment).


## Environment Variables

Default values are included when available.

### Khulnasoft
```
API_USERNAME="khulnasoft-kui"                            # Khulnasoft API username
API_PASSWORD="MyS3cr37P450r.*-"                     # Khulnasoft API password - Must comply with requirements
                                                    # (8+ length, uppercase, lowercase, specials chars)

INDEXER_URL=https://khulnasoft.indexer:9200              # Khulnasoft indexer URL
INDEXER_USERNAME=admin                              # Khulnasoft indexer Username
INDEXER_PASSWORD=SecretPassword                     # Khulnasoft indexer Password
FILEBEAT_SSL_VERIFICATION_MODE=full                 # Filebeat SSL Verification mode (full or none)
SSL_CERTIFICATE_AUTHORITIES=""                      # Path of Filebeat SSL CA
SSL_CERTIFICATE=""                                  # Path of Filebeat SSL Certificate
SSL_KEY=""                                          # Path of Filebeat SSL Key
```

### Dashboard
```
PATTERN="khulnasoft-alerts-*"        # Default index pattern to use

CHECKS_PATTERN=true             # Defines which checks must to be consider by the healthcheck
CHECKS_TEMPLATE=true            # step once the Khulnasoft app starts. Values must to be true or false
CHECKS_API=true
CHECKS_SETUP=true

EXTENSIONS_PCI=true             # Enable PCI Extension
EXTENSIONS_GDPR=true            # Enable GDPR Extension
EXTENSIONS_HIPAA=true           # Enable HIPAA Extension
EXTENSIONS_NIST=true            # Enable NIST Extension
EXTENSIONS_TSC=true             # Enable TSC Extension
EXTENSIONS_AUDIT=true           # Enable Audit Extension
EXTENSIONS_OSCAP=false          # Enable OpenSCAP Extension
EXTENSIONS_CISCAT=false         # Enable CISCAT Extension
EXTENSIONS_AWS=false            # Enable AWS Extension
EXTENSIONS_GCP=false            # Enable GCP Extension
EXTENSIONS_VIRUSTOTAL=false     # Enable Virustotal Extension
EXTENSIONS_OSQUERY=false        # Enable OSQuery Extension
EXTENSIONS_DOCKER=false         # Enable Docker Extension

APP_TIMEOUT=20000               # Defines maximum timeout to be used on the Khulnasoft app requests

API_SELECTOR=true               Defines if the user is allowed to change the selected API directly from the Khulnasoft app top menu
IP_SELECTOR=true                # Defines if the user is allowed to change the selected index pattern directly from the Khulnasoft app top menu
IP_IGNORE="[]"                  # List of index patterns to be ignored

DASHBOARD_USERNAME=kibanaserver     # Custom user saved in the dashboard keystore
DASHBOARD_PASSWORD=kibanaserver     # Custom password saved in the dashboard keystore
KHULNASOFT_MONITORING_ENABLED=true       # Custom settings to enable/disable khulnasoft-monitoring indices
KHULNASOFT_MONITORING_FREQUENCY=900      # Custom setting to set the frequency for khulnasoft-monitoring indices cron task
KHULNASOFT_MONITORING_SHARDS=2           # Configure khulnasoft-monitoring-* indices shards and replicas
KHULNASOFT_MONITORING_REPLICAS=0         ##
```

## Directory structure

    ├── build-docker-images
    │   ├── docker-compose.yml
    │   ├── khulnasoft-dashboard
    │   │   ├── config
    │   │   │   ├── config.sh
    │   │   │   ├── config.yml
    │   │   │   ├── entrypoint.sh
    │   │   │   ├── opensearch_dashboards.yml
    │   │   │   ├── khulnasoft_app_config.sh
    │   │   │   └── khulnasoft.yml
    │   │   └── Dockerfile
    │   ├── khulnasoft-indexer
    │   │   ├── config
    │   │   │   ├── config.sh
    │   │   │   ├── config.yml
    │   │   │   ├── entrypoint.sh
    │   │   │   ├── internal_users.yml
    │   │   │   ├── opensearch.yml
    │   │   │   ├── roles_mapping.yml
    │   │   │   ├── roles.yml
    │   │   │   └── securityadmin.sh
    │   │   └── Dockerfile
    │   └── khulnasoft-manager
    │       ├── config
    │       │   ├── create_user.py
    │       │   ├── etc
    │       │   │   ├── cont-init.d
    │       │   │   │   ├── 0-khulnasoft-init
    │       │   │   │   ├── 1-config-filebeat
    │       │   │   │   └── 2-manager
    │       │   │   └── services.d
    │       │   │       ├── filebeat
    │       │   │       │   ├── finish
    │       │   │       │   └── run
    │       │   │       └── ossec-logs
    │       │   │           └── run
    │       │   ├── filebeat.yml
    │       │   ├── permanent_data.env
    │       │   ├── permanent_data.sh
    │       │   └── khulnasoft.repo
    │       └── Dockerfile
    ├── CHANGELOG.md
    ├── indexer-certs-creator
    │   ├── config
    │   │   └── entrypoint.sh
    │   └── Dockerfile
    ├── LICENSE
    ├── multi-node
    │   ├── config
    │   │   ├── nginx
    │   │   │   └── nginx.conf
    │   │   ├── khulnasoft_cluster
    │   │   │   ├── khulnasoft_manager.conf
    │   │   │   └── khulnasoft_worker.conf
    │   │   ├── khulnasoft_dashboard
    │   │   │   ├── opensearch_dashboards.yml
    │   │   │   └── khulnasoft.yml
    │   │   ├── khulnasoft_indexer
    │   │   │   ├── internal_users.yml
    │   │   │   ├── khulnasoft1.indexer.yml
    │   │   │   ├── khulnasoft2.indexer.yml
    │   │   │   └── khulnasoft3.indexer.yml
    │   │   └── khulnasoft_indexer_ssl_certs
    │   │       └── certs.yml
    │   ├── docker-compose.yml
    │   ├── generate-indexer-certs.yml
    │   ├── Migration-to-Khulnasoft-4.3.md
    │   └── volume-migrator.sh
    ├── README.md
    ├── single-node
    │   ├── config
    │   │   ├── khulnasoft_cluster
    │   │   │   └── khulnasoft_manager.conf
    │   │   ├── khulnasoft_dashboard
    │   │   │   ├── opensearch_dashboards.yml
    │   │   │   └── khulnasoft.yml
    │   │   ├── khulnasoft_indexer
    │   │   │   ├── internal_users.yml
    │   │   │   └── khulnasoft.indexer.yml
    │   │   └── khulnasoft_indexer_ssl_certs
    │   │       ├── admin-key.pem
    │   │       ├── admin.pem
    │   │       ├── certs.yml
    │   │       ├── root-ca.key
    │   │       ├── root-ca.pem
    │   │       ├── khulnasoft.dashboard-key.pem
    │   │       ├── khulnasoft.dashboard.pem
    │   │       ├── khulnasoft.indexer-key.pem
    │   │       ├── khulnasoft.indexer.pem
    │   │       ├── khulnasoft.manager-key.pem
    │   │       └── khulnasoft.manager.pem
    │   ├── docker-compose.yml
    │   ├── generate-indexer-certs.yml
    │   └── README.md
    └── VERSION



## Branches

* `master` branch contains the latest code, be aware of possible bugs on this branch.
* `stable` branch on correspond to the last Khulnasoft stable version.

## Compatibility Matrix

| Khulnasoft version | ODFE    | XPACK  |
|---------------|---------|--------|
| v4.8.0        |         |        |
| v4.7.0        |         |        |
| v4.6.0        |         |        |
| v4.5.2        |         |        |
| v4.5.1        |         |        |
| v4.5.0        |         |        |
| v4.4.5        |         |        |
| v4.4.4        |         |        |
| v4.4.3        |         |        |
| v4.4.2        |         |        |
| v4.4.1        |         |        |
| v4.4.0        |         |        |
| v4.3.11       |         |        |
| v4.3.10       |         |        |
| v4.3.9        |         |        |
| v4.3.8        |         |        |
| v4.3.7        |         |        |
| v4.3.6        |         |        |
| v4.3.5        |         |        |
| v4.3.4        |         |        |
| v4.3.3        |         |        |
| v4.3.2        |         |        |
| v4.3.1        |         |        |
| v4.3.0        |         |        |
| v4.2.7        | 1.13.2  | 7.11.2 |
| v4.2.6        | 1.13.2  | 7.11.2 |
| v4.2.5        | 1.13.2  | 7.11.2 |
| v4.2.4        | 1.13.2  | 7.11.2 |
| v4.2.3        | 1.13.2  | 7.11.2 |
| v4.2.2        | 1.13.2  | 7.11.2 |
| v4.2.1        | 1.13.2  | 7.11.2 |
| v4.2.0        | 1.13.2  | 7.10.2 |
| v4.1.5        | 1.13.2  | 7.10.2 |
| v4.1.4        | 1.12.0  | 7.10.2 |
| v4.1.3        | 1.12.0  | 7.10.2 |
| v4.1.2        | 1.12.0  | 7.10.2 |
| v4.1.1        | 1.12.0  | 7.10.2 |
| v4.1.0        | 1.12.0  | 7.10.2 |
| v4.0.4        | 1.11.0  |        |
| v4.0.3        | 1.11.0  |        |
| v4.0.2        | 1.11.0  |        |
| v4.0.1        | 1.11.0  |        |
| v4.0.0        | 1.10.1  |        |

## Credits and Thank you

These Docker containers are based on:

*  "deviantony" dockerfiles which can be found at [https://github.com/deviantony/docker-elk](https://github.com/deviantony/docker-elk)
*  "xetus-oss" dockerfiles, which can be found at [https://github.com/xetus-oss/docker-ossec-server](https://github.com/xetus-oss/docker-ossec-server)

We thank you them and everyone else who has contributed to this project.

## License and copyright

Khulnasoft Docker Copyright (C) 2017, Khulnasoft Inc. (License GPLv2)

## Web references

[Khulnasoft website](http://khulnasoft.com)
