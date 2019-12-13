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

if [[ -f openshift-env ]]; then
  source openshift-env
else
  echo "openshift-env not found!!"
  exit 1
fi


echo "Logging into OpenShift as ${USER}"
echo "*********************************"
oc login --insecure-skip-tls-verify=true -u ${USER}  --server=https://${OPENSHIFT_ENDPOINT}:${PORTNUMBER}
sleep 2s

echo "Creating New Project called  12factor-dev"
echo "*********************************"
oc new-project 12factor-dev
sleep 2s

echo "Starting build of my12factorapp"
echo "*********************************"
oc new-build --binary --name=my12factorapp
sleep 2s

echo "Creating New Project called  ci"
echo "*********************************"
oc new-project ci
sleep 2s

oc get templates -n openshift | grep ${JENKINS_TEMPLATE_NAME} || exit 1
JENKINS_POD=$(oc get templates -n openshift | grep ${JENKINS_TEMPLATE_NAME} | awk '{print $1}')
oc new-app $JENKINS_POD

echo  "Login to Jenkins pod to test"
echo "*********************************"
oc get routes 

echo "Creating pipeline"
echo "*********************************"
oc create -f pipeline.yml -n ci
sleep 2s

echo "Confiuring Jenkins"
echo "*********************************"
#Setup Jenkins credentials
if [[ ${USING_MINISHIFT} != "FALSE" ]]; then
    oc login -u system:admin
    echo "Giving Jenkins SA cluster-admin permission"
    oc adm policy add-cluster-role-to-user cluster-admin system:serviceaccount:ci:jenkins -n ci
    sleep 2s

    echo "Logging into OpenShift as ${USER}"
    echo "*********************************"
    oc login --insecure-skip-tls-verify=true -u ${USER} --server=https://${OPENSHIFT_ENDPOINT}:${PORTNUMBER}
fi

echo "Switch back to"
oc project 12factor-dev
