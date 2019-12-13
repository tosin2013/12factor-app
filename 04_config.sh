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

###
##Change to config map
###
if [[ -f openshift-env ]]; then
  source openshift-env
else
  echo "openshift-env not found!!"
  exit 1
fi

echo "Setting Enviornment using Enviornment variable"
oc set env dc/my12factorapp GREETING="Hi {name}! - My Configuration has changed"
echo "Configuration updated. Please check again http://$(oc get route | grep my12factorapp| awk '{print $2}')/api/hello/developer"
