docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=khulnasoft-indexer-data-1 \
           $2_khulnasoft-indexer-data-1

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=khulnasoft-indexer-data-2 \
           $2_khulnasoft-indexer-data-2

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=khulnasoft-indexer-data-3 \
           $2_khulnasoft-indexer-data-3

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=master_khulnasoft_api_configuration \
           $2_master_khulnasoft_api_configuration

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=master_khulnasoft_etc \
           $2_docker_khulnasoft_etc

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=master-khulnasoft-logs \
           $2_master-khulnasoft-logs

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=master-khulnasoft-queue \
           $2_master-khulnasoft-queue

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=master-khulnasoft-var-multigroups \
           $2_master-khulnasoft-var-multigroups

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=master-khulnasoft-integrations \
           $2_master-khulnasoft-integrations

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=master-khulnasoft-active-response \
           $2_master-khulnasoft-active-response

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=master-khulnasoft-agentless \
           $2_master-khulnasoft-agentless

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=master-khulnasoft-wodles \
           $2_master-khulnasoft-wodles

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=master-filebeat-etc \
           $2_master-filebeat-etc

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=master-filebeat-var \
           $2_master-filebeat-var

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=worker_khulnasoft_api_configuration \
           $2_worker_khulnasoft_api_configuration

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=worker_khulnasoft_etc \
           $2_worker-khulnasoft-etc

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=worker-khulnasoft-logs \
           $2_worker-khulnasoft-logs

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=worker-khulnasoft-queue \
           $2_worker-khulnasoft-queue

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=worker-khulnasoft-var-multigroups \
           $2_worker-khulnasoft-var-multigroups

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=worker-khulnasoft-integrations \
           $2_worker-khulnasoft-integrations

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=worker-khulnasoft-active-response \
           $2_worker-khulnasoft-active-response

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=worker-khulnasoft-agentless \
           $2_worker-khulnasoft-agentless

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=worker-khulnasoft-wodles \
           $2_worker-khulnasoft-wodles

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=worker-filebeat-etc \
           $2_worker-filebeat-etc

docker volume create \
           --label com.docker.compose.project=$2 \
           --label com.docker.compose.version=$1 \
           --label com.docker.compose.volume=worker-filebeat-var \
           $2_worker-filebeat-var

docker container run --rm -it \
           -v khulnasoft-docker_worker-filebeat-var:/from \
           -v $2_worker-filebeat-var:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v khulnasoft-docker_elastic-data-1:/from \
           -v $2_khulnasoft-indexer-data-1:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v khulnasoft-docker_elastic-data-2:/from \
           -v $2_khulnasoft-indexer-data-2:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v khulnasoft-docker_elastic-data-3:/from \
           -v $2_khulnasoft-indexer-data-3:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v khulnasoft-docker_ossec-api-configuration:/from \
           -v $2_master-khulnasoft-api-configuration:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v khulnasoft-docker_ossec-etc:/from \
           -v $2_master-khulnasoft-etc:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v khulnasoft-docker_ossec-logs:/from \
           -v $2_master-khulnasoft-logs:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v khulnasoft-docker_ossec-queue:/from \
           -v $2_master-khulnasoft-queue:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v khulnasoft-docker_ossec-var-multigroups:/from \
           -v $2_master-khulnasoft-var-multigroups:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v khulnasoft-docker_ossec-integrations:/from \
           -v $2_master-khulnasoft-integrations:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v khulnasoft-docker_ossec-active-response:/from \
           -v $2_master-khulnasoft-active-response:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v khulnasoft-docker_ossec-agentless:/from \
           -v $2_master-khulnasoft-agentless:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v khulnasoft-docker_ossec-wodles:/from \
           -v $2_master-khulnasoft-wodles:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v khulnasoft-docker_filebeat-etc:/from \
           -v $2_master-filebeat-etc:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v khulnasoft-docker_filebeat-var:/from \
           -v $2_master-filebeat-var:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v khulnasoft-docker_worker-ossec-api-configuration:/from \
           -v $2_worker-khulnasoft-api-configuration:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v khulnasoft-docker_worker-ossec-etc:/from \
           -v $2_worker-khulnasoft-etc:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v khulnasoft-docker_worker-ossec-logs:/from \
           -v $2_worker-khulnasoft-logs:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v khulnasoft-docker_worker-ossec-queue:/from \
           -v $2_worker-khulnasoft-queue:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v khulnasoft-docker_worker-ossec-var-multigroups:/from \
           -v $2_worker-khulnasoft-var-multigroups:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v khulnasoft-docker_worker-ossec-integrations:/from \
           -v $2_worker-khulnasoft-integrations:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v khulnasoft-docker_worker-ossec-active-response:/from \
           -v $2_worker-khulnasoft-active-response:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v khulnasoft-docker_worker-ossec-agentless:/from \
           -v $2_worker-khulnasoft-agentless:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v khulnasoft-docker_worker-ossec-wodles:/from \
           -v $2_worker-khulnasoft-wodles:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v khulnasoft-docker_worker-filebeat-etc:/from \
           -v $2_worker-filebeat-etc:/to \
           alpine ash -c "cd /from ; cp -avp . /to"

docker container run --rm -it \
           -v khulnasoft-docker_worker-filebeat-var:/from \
           -v $2_worker-filebeat-var:/to \
           alpine ash -c "cd /from ; cp -avp . /to"