# Opendistro data migration to Khulnasoft indexer on docker.
This procedure explains how to migrate Opendistro data from Opendistro to Khulnasoft indexer in docker production deployments.
The example is migrating from v4.2 to v4.4.

## Procedure
Assuming that you have a v4.2 production deployment, perform the following steps.

**1. Stop 4.2 environment**
`docker-compose -f production-cluster.yml stop`

**2. List elasticsearch volumes**
`docker volume ls --filter name='khulnasoft-docker_elastic-data'`

**3. Inspect elasticsearch volume**
`docker volume inspect khulnasoft-docker_elastic-data-1`

**4. Spin down the 4.2 environment.**
`docker-compose -f production-cluster.yml down`

**Steps 5 and 6 can be done with the volume-migrator.sh script, specifying Docker compose version and project name as parameters.**

Ex: $ multi-node/volume-migrator.sh 1.25.0 multi-node

**5. Run the volume create command:** create new indexer and Khulnasoft manager volumes using the `com.docker.compose.version` label value from the previous command.

```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=khulnasoft-indexer-data-1 \
           multi-node_khulnasoft-indexer-data-1
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=khulnasoft-indexer-data-2 \
           multi-node_khulnasoft-indexer-data-2
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=khulnasoft-indexer-data-3 \
           multi-node_khulnasoft-indexer-data-3
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=master_khulnasoft_api_configuration \
           multi-node_master_khulnasoft_api_configuration
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=master_khulnasoft_etc \
           multi-node_docker_khulnasoft_etc
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=master-khulnasoft-logs \
           multi-node_master-khulnasoft-logs
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=master-khulnasoft-queue \
           multi-node_master-khulnasoft-queue
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=master-khulnasoft-var-multigroups \
           multi-node_master-khulnasoft-var-multigroups
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=master-khulnasoft-integrations \
           multi-node_master-khulnasoft-integrations
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=master-khulnasoft-active-response \
           multi-node_master-khulnasoft-active-response
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=master-khulnasoft-agentless \
           multi-node_master-khulnasoft-agentless
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=master-khulnasoft-wodles \
           multi-node_master-khulnasoft-wodles
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=master-filebeat-etc \
           multi-node_master-filebeat-etc
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=master-filebeat-var \
           multi-node_master-filebeat-var
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=worker_khulnasoft_api_configuration \
           multi-node_worker_khulnasoft_api_configuration
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=worker_khulnasoft_etc \
           multi-node_worker-khulnasoft-etc
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=worker-khulnasoft-logs \
           multi-node_worker-khulnasoft-logs
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=worker-khulnasoft-queue \
           multi-node_worker-khulnasoft-queue
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=worker-khulnasoft-var-multigroups \
           multi-node_worker-khulnasoft-var-multigroups
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=worker-khulnasoft-integrations \
           multi-node_worker-khulnasoft-integrations
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=worker-khulnasoft-active-response \
           multi-node_worker-khulnasoft-active-response
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=worker-khulnasoft-agentless \
           multi-node_worker-khulnasoft-agentless
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=worker-khulnasoft-wodles \
           multi-node_worker-khulnasoft-wodles
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=worker-filebeat-etc \
           multi-node_worker-filebeat-etc
```
```
docker volume create \
           --label com.docker.compose.project=multi-node \
           --label com.docker.compose.version=1.25.0 \
           --label com.docker.compose.volume=worker-filebeat-var \
           multi-node_worker-filebeat-var
```
**6. Copy the volume content from elasticsearch to Khulnasoft indexer volumes and old Khulnasoft manager content to new volumes.**
```
docker container run --rm -it \
           -v khulnasoft-docker_elastic-data-1:/from \
           -v multi-node_khulnasoft-indexer-data-1:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v khulnasoft-docker_elastic-data-2:/from \
           -v multi-node_khulnasoft-indexer-data-2:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v khulnasoft-docker_elastic-data-3:/from \
           -v multi-node_khulnasoft-indexer-data-3:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v khulnasoft-docker_ossec-api-configuration:/from \
           -v multi-node_master-khulnasoft-api-configuration:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v khulnasoft-docker_ossec-etc:/from \
           -v multi-node_master-khulnasoft-etc:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v khulnasoft-docker_ossec-logs:/from \
           -v multi-node_master-khulnasoft-logs:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v khulnasoft-docker_ossec-queue:/from \
           -v multi-node_master-khulnasoft-queue:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v khulnasoft-docker_ossec-var-multigroups:/from \
           -v multi-node_master-khulnasoft-var-multigroups:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v khulnasoft-docker_ossec-integrations:/from \
           -v multi-node_master-khulnasoft-integrations:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v khulnasoft-docker_ossec-active-response:/from \
           -v multi-node_master-khulnasoft-active-response:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v khulnasoft-docker_ossec-agentless:/from \
           -v multi-node_master-khulnasoft-agentless:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v khulnasoft-docker_ossec-wodles:/from \
           -v multi-node_master-khulnasoft-wodles:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v khulnasoft-docker_filebeat-etc:/from \
           -v multi-node_master-filebeat-etc:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v khulnasoft-docker_filebeat-var:/from \
           -v multi-node_master-filebeat-var:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v khulnasoft-docker_worker-ossec-api-configuration:/from \
           -v multi-node_worker-khulnasoft-api-configuration:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v khulnasoft-docker_worker-ossec-etc:/from \
           -v multi-node_worker-khulnasoft-etc:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v khulnasoft-docker_worker-ossec-logs:/from \
           -v multi-node_worker-khulnasoft-logs:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v khulnasoft-docker_worker-ossec-queue:/from \
           -v multi-node_worker-khulnasoft-queue:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v khulnasoft-docker_worker-ossec-var-multigroups:/from \
           -v multi-node_worker-khulnasoft-var-multigroups:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v khulnasoft-docker_worker-ossec-integrations:/from \
           -v multi-node_worker-khulnasoft-integrations:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v khulnasoft-docker_worker-ossec-active-response:/from \
           -v multi-node_worker-khulnasoft-active-response:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v khulnasoft-docker_worker-ossec-agentless:/from \
           -v multi-node_worker-khulnasoft-agentless:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v khulnasoft-docker_worker-ossec-wodles:/from \
           -v multi-node_worker-khulnasoft-wodles:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v khulnasoft-docker_worker-filebeat-etc:/from \
           -v multi-node_worker-filebeat-etc:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```
```
docker container run --rm -it \
           -v khulnasoft-docker_worker-filebeat-var:/from \
           -v multi-node_worker-filebeat-var:/to \
           alpine ash -c "cd /from ; cp -avp . /to"
```

**7. Start the 4.4 environment.**
```
git checkout 4.4
cd multi-node
docker-compose -f generate-indexer-certs.yml run --rm generator
docker-compose up -d
```

**8. Check the access to Khulnasoft dashboard**: go to the Khulnasoft dashboard using the web browser and check the data.
