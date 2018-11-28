#!/bin/bash
set -eux

wget https://www-us.apache.org/dist/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz
tar spark-2.4.0-bin-hadoop2.7.tgz
cd spark-2.4.0-bin-hadoop2.7/jars
curl -O http://repo1.maven.org/maven2/commons-lang/commons-lang/2.6/commons-lang-2.6.jar && \
curl -O http://repo1.maven.org/maven2/org/mortbay/jetty/jetty-util/6.1.26/jetty-util-6.1.26.jar && \
curl -O http://repo1.maven.org/maven2/com/microsoft/azure/azure-storage/2.0.0/azure-storage-2.0.0.jar && \
curl -O http://repo1.maven.org/maven2/org/apache/hadoop/hadoop-azure/2.7.3/hadoop-azure-2.7.3.jar && \
curl -O http://repo1.maven.org/maven2/com/microsoft/azure/azure-data-lake-store-sdk/2.1.5/azure-data-lake-store-sdk-2.1.5.jar && \
curl -O http://repo1.maven.org/maven2/org/apache/hadoop/hadoop-azure-datalake/3.0.0-alpha3/hadoop-azure-datalake-3.0.0-alpha3.jar && \
curl -O https://raw.githubusercontent.com/dharmeshkakadia/k8s-azure-spark/master/spark-avro_2.11-4.0.0.jar && \
curk -O https://raw.githubusercontent.com/dharmeshkakadia/k8s-azure-spark/master/sqljdbc42.jar
cd ..
wget https://raw.githubusercontent.com/dharmeshkakadia/k8s-azure-spark/master/Dockerfile.ubuntu -O kubernetes/dockerfiles/spark/bindings/python/Dockerfile
./bin/docker-image-tool.sh -t v2.4 -r dharmeshkakadia build
docker tag dharmeshkakadia/spark-py:v2.4 dharmeshkakadia/spark-py-ubuntu:v2.4
docker push dharmeshkakadia/spark-py-ubuntu:v2.4
