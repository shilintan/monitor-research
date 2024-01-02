#!/bin/bash

apt install -y buildah
buildah login -u shilintan --password-stdin < container_password "https://docker.io"
buildah build --no-cache --format docker -t docker.io/shilintan/custom-apache_skywalking-java-agent:9.0.0-java17 .
#buildah tag     docker.io/shilintan/apache_skywalking-java-agent-custom:9.0.0-java17    docker.io/shilintan/custom-apache_skywalking-java-agent:9.0.0-java17
buildah push    docker.io/shilintan/custom-apache_skywalking-java-agent:9.0.0-java17
buildah rmi     docker.io/shilintan/custom-apache_skywalking-java-agent:9.0.0-java17
buildah rmi     docker.io/apache/skywalking-java-agent:9.0.0-java17