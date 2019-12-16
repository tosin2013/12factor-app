# Helloworld - WIP

## Requirements on OpenShift cluster
Ensure Jenkins has the approprate permissions to project if you are not cluster-admin
After the Jenkins pod has deployed under the 00_setup.sh
```
oc new-project ci
oc adm policy add-cluster-role-to-user cluster-admin system:serviceaccount:ci:jenkins -n ci
``

The slides of this presentation are available at <http://bit.ly/12factors-app>

To use the scripts, Create and Source the following file.
```
## Sample OpenShift Endpoint
You will need to edit the file called openshift-env. It currently looks like below. Fill in the appropriate information.  Examples of OCP 3.x and 4.x can be found below. 
```
$ cat openshift-env
export OPENSHIFT_ENDPOINT=""
export PORTNUMBER=""
export USER=""
export USING_MINISHIFT=FALSE
export JENKINS_TEMPLATE_NAME="jenkins-ephemeral"
```

## Examples:
**Sample OpenShift 4.x Endpoint**
```
$ cat openshift-env
export OPENSHIFT_ENDPOINT="api.example.com"
export PORTNUMBER="6443"
export USER="developer"
export USING_MINISHIFT=FALSE
export JENKINS_TEMPLATE_NAME="jenkins-ephemeral"
```

**Sample OpenShift 3.11.x Endpoint**
```
$ cat openshift-env
export OPENSHIFT_ENDPOINT="lb.example.com"
export PORTNUMBER="8443"
export USER="developer"
export USING_MINISHIFT=FALSE
export JENKINS_TEMPLATE_NAME="jenkins-ephemeral"
```

**Build and Deploy helloworld-service locally**
------------------------------------------

1. Open a command prompt and navigate to the root directory of this microservice.
2. Type this command to build and execute the service:

        mvn clean compile exec:java

3. The application will be running at the following URL: <http://localhost:8080/api/hello/AnyName>


### The following will show you how to deploy a 12factor-app using OpenShift.
**Codebase** – use version control, one codebase tracked in revision control for many deployments. For this lab we will use the repo below as the codebase.
````
https://github.com/tosin2013/12factor-app.git
````

**Dependencies** – use a package manager and don’t commit dependencies in the codebase repository. OpenShift allows for native language dependency management sytems to be used in this lab we will be using maven. To Build the Java Application.  
Excercises: 01_build.sh  

**Config** – store the config in Environment Variable, if you have to repackage your application, you’re doing it wrong. OpenShift Allows this using features called ConfigMaps.  
Exercises: 04_config.sh  
[Using ConfigMaps](https://github.com/tosin2013/openshift-demos/blob/master/configmaps.md)  

**Backing Services** – a deploy of the twelve-factor app should be able to swap out a local MySQL database with one managed by a third party (such as Amazon RDS ) without any changes to the app’s code. OpenShift allows for external databases to be used with your service.  
Exercises: 05_backing.sh, 06_populatedb.sh  

**Build, Release, Run** – the twelve-factor app uses strict separation between the build, release, and run stages. Every release should always have a unique release ID and releases should allow rollback.  
Exercises: 01_build.sh, 02_release.sh, 03_run.sh  

**Processes** – execute the app as one or more stateless processes, the Twelve-factor processes are stateless and share-nothing.  
Exercises: 03_run.sh

**Port Binding** – export services via port binding, The twelve-factor app is completely self-contained.  
Exercises:  07_port-binding.sh

**Concurrency** – scale out via the process model. Each process should be individually scaled, with Factor 6 (Stateless), it is easy to scale the services.
Exercises: 08_concurrency.sh 

**Disposability** – maximize robustness with fast startup and graceful shutdown, we can achieve this with containers.  
Exercises:  09_disposability.sh

**Dev/Prod Parity** – Keep development, staging, and production as similar as possible, the twelve-factor app is designed for continuous deployment by keeping the gap between development and production small.  
Exercises:  10_deploy-staging.sh

**Logs** – treat logs as event streams, a twelve-factor app never concerns itself with routing or storage of its output stream.  
Exercises:  11_logs.sh

**Admin Processes** – run admin/management tasks as one-off processes.  
Exercises:  12_admin.sh
