# Khulnasoft Docker Copyright (C) 2017, Khulnasoft Inc. (License GPLv2)
sleep 30
bash /usr/share/khulnasoft-indexer/plugins/opensearch-security/tools/securityadmin.sh -cd /usr/share/khulnasoft-indexer/opensearch-security/ -nhnv -cacert  $CACERT -cert $CERT -key $KEY -p 9200 -icl