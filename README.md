# k8s-azure-spark
Steps to compile Apache Spark to create a docker image runnable on kubernetes with

* Support for reading and writing from Azure Storage Blob/ Azure Data Lake Storage (ADLS)
* Support for reading and writing avro files with spark-avro package
* Support for connecting to SQL Server and SQL data warehouse via JDBC.

## Steps

Just run 

```
bash <(curl -s https://raw.githubusercontent.com/dharmeshkakadia/k8s-azure-spark/master/spark-image.sh)
```

## Quick Tests

1. image test

```
kubectl run test12 --image dharmeshkakadia/spark:latest -i --tty --command bash
```

2. Interactive submission Pi test:
```
bin/spark-submit \
--deploy-mode cluster \
--class org.apache.spark.examples.SparkPi \
--master k8s://http://127.0.0.1:8001/ \
--conf spark.executor.instances=5 \
--conf spark.app.name=spark-pi-my2 \
--conf spark.kubernetes.container.image=dharmeshkakadia/spark:latest \
--jars local:///opt/spark/examples/jars/spark-examples_2.11-2.4.0-SNAPSHOT.jar \
local:///opt/spark/examples/jars/spark-examples_2.11-2.4.0-SNAPSHOT.jar
```

3. WASB access check with WordCount running against file on WASB:

```
bin/spark-submit \
--deploy-mode cluster \
--class org.apache.spark.examples.JavaWordCount \
--master k8s://http://127.0.0.1:8001/ \
--conf spark.executor.instances=2 \
--conf spark.app.name=spark-wc-wasb \
--conf spark.kubernetes.container.image=dharmeshkakadia/spark:latest \
--conf spark.hadoop.fs.azure.account.key.<YOUR_ACCOUNT_KEY>.blob.core.windows.net=4tZV+I55A== \
--jars local:///opt/spark/examples/jars/spark-examples_2.11-2.4.0-SNAPSHOT.jar \
local:///opt/spark/examples/jars/spark-examples_2.11-2.4.0-SNAPSHOT.jar wasb://<YOUR_STORAGE_CONTAINER_NAME>@<YOUR_STORAGE_ACCOUNT>.blob.core.windows.net/<PATH>
```
