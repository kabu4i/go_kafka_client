# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#!/bin/sh -Eux

# Start Zookeeper and Kafka
./vagrant/kafka.sh

mkdir -p $GOPATH/src/github.com/stealthly/go_kafka_client
cp -r /go_kafka_client $GOPATH/src/github.com/stealthly
cd $GOPATH/src/github.com/stealthly/go_kafka_client

echo 'Updating dependencies'
gpm install

echo 'Running tests'
go test -v

echo 'Stopping Kafka'
$KAFKA_PATH/bin/kafka-server-stop.sh
echo 'Stopping Zookeeper'
$ZK_HOME/bin/zkServer.sh stop
