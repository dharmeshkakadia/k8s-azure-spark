FROM kubespark/spark-driver-py:v2.2.0-kubernetes-0.5.0

ADD *.jar /opt/spark/jars/

RUN apk --update add snappy snappy-dev java-snappy-native libc6-compat
