#!/bin/bash
# JBoss, Home of Professional Open Source
# Copyright 2016, Red Hat, Inc. and/or its affiliates, and individual
# contributors by the @authors tag. See the copyright.txt in the 
# distribution for a full listing of individual contributors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,  
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
oc exec -it `oc get pods -l app=mysql |grep mysql2| awk '{ print $1 }'` -- bash -c "mysql -u myuser -pmypassword -h 127.0.0.1 mydatabase -te \"CREATE TABLE mytable (name varchar(50)); INSERT INTO mytable VALUES ('Rafael'); INSERT INTO mytable VALUES ('Benevides');\""
echo "Database populated"
