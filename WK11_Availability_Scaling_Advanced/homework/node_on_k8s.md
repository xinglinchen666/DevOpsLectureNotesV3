
## Deploy a containerized Node.js app to a Kubernetes cluster on AWS

There will be a couple steps we need to focus on, first of all creating a container image and pushing it to a repository. After that, we need to create a Kubernetes cluster and write the configuration files for our containers. The last step will be deploying everything to the cluster and making sure it works.

Ready? Take a breath or two, this will be a handful.

_**Note**: Make sure to have  [Docker](https://www.docker.com/)  installed on your machine in order to be able to run the commands below._

### [](https://dev.to/adnanrahic/containers-vs-serverless-from-a-devops-standpoint-e4n#1-creating-a-container-image)1. Creating a container image

Here's what a simple Node.js/Express application looks like.  

```
// app.js
const express = require('express')
const app = express()
app.get('/', async (req, res, next) => {
  res.status(200).send('Hello World!')
})
app.listen(3000, () => console.log('Server is running on port 3000'))

```

Pretty familiar, right? Creating an image from this is rather simple. First, we need a  **Dockerfile**.  

```
# Dockerfile
FROM node:alpine

# Create app directory
WORKDIR /usr/src/app

# COPY package.json .
# For npm@5 or later, copy package-lock.json as well
COPY package.json package-lock.json ./

# Install app dependencies
RUN npm install

# Bundle app source
COPY . .

EXPOSE 3000

# Start Node server
CMD [ "npm", "start" ]

```

This will configure what our image will look like, the dependencies to install, what port it will expose and which command to run once a container is created.

Time to build the image.  

```
$ docker build . -t <docker_hub_username>/<image_name>

```

This command will take a while if you haven't built the image before. Once it's done, you can push it to the container repository. I'll show you Docker Hub, but you can use whichever you want.  

```
$ docker push <docker_hub_username>/<image_name>

```

_**Note**: Make sure to authenticate yourself before running this command. Run the  `$ docker login`  command._

Once you push the image, your Docker Hub profile will list the image. It'll look something like this.

[![](https://res.cloudinary.com/practicaldev/image/fetch/s--70bj5qGq--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://raw.githubusercontent.com/adnanrahic/cdn/master/containers-vs-serverless/hub-docker.png)](https://res.cloudinary.com/practicaldev/image/fetch/s--70bj5qGq--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://raw.githubusercontent.com/adnanrahic/cdn/master/containers-vs-serverless/hub-docker.png)

With step one wrapped up, you have made the image available for pulling to a Kubernetes cluster of choice. Time to create a cluster.

### [](https://dev.to/adnanrahic/containers-vs-serverless-from-a-devops-standpoint-e4n#2-create-the-kubernetes-cluster)2. Create the Kubernetes cluster

The easiest way to get up and running quickly with Kubernetes on AWS is a tool called  [KOPS](https://github.com/kubernetes/kops). It's a CLI for creating and managing your infrastructure resources.

After installing KOPS you'll have access to the CLI commands for interacting with Kubernetes clusters. Here's a set of commands to get a cluster up-and-running quickly.  

```
$ export ORGANIZATION_NAME=your-org-name

# create state store
$ export BUCKET_NAME=${ORGANIZATION_NAME}-state-store
$ aws s3api create-bucket \
    --bucket ${BUCKET_NAME} \
    --region eu-central-1 \
    --create-bucket-configuration LocationConstraint=eu-central-1
$ aws s3api put-bucket-versioning \
    --bucket ${BUCKET_NAME} \
    --versioning-configuration Status=Enabled

# create cluster
$ export KOPS_CLUSTER_NAME=${ORGANIZATION_NAME}.k8s.local
$ export KOPS_STATE_STORE=s3://${BUCKET_NAME}

# define cluster configuration
$ kops create cluster \
    --master-count=1 --master-size=t2.micro \
    --node-count=1 --node-size=t2.micro \
    --zones=eu-central-1a \
    --name=${KOPS_CLUSTER_NAME}

# if you want to edit config
$ kops edit cluster --name ${KOPS_CLUSTER_NAME}

# apply and create cluster
$ kops update cluster --name ${KOPS_CLUSTER_NAME} --yes

# validate cluster is running
$ kops validate cluster

```

Once the cluster is running you can create configuration files for deploying your container image.

### [](https://dev.to/adnanrahic/containers-vs-serverless-from-a-devops-standpoint-e4n#3-deploy-the-container-image)3. Deploy the container image

Now we're getting to the Kubernetes specific stuff. With the  **kubectl**  command you'll create your Kubernetes resources. You'll need a deployment and a service, to get started quickly. To make it easier let's create two YAML files. One for the deployment and one for the service.  

```
# node-deployment.yml
apiVersion: apps/v1 # for versions before 1.9.0 use apps/v1beta2
kind: Deployment
metadata:
  name: node
spec:
  selector:
    matchLabels:
      app: node
      tier: backend
  replicas: 9
  template:
    metadata:
      labels:
        app: node
        tier: backend
    spec:
      containers:
        - name: node
          image: <docker_hub_username>/<image_name>
          ports:
            - containerPort: 3000
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 1

```

The deployment will create pods, replica-sets and make sure they work as they should, while the service exposes the deployment to external traffic.  

```
# node-service.yml
apiVersion: v1
kind: Service
metadata:
  name: node
  labels:
    app: node
    tier: backend
spec:
  type: LoadBalancer
  ports:
    - port: 80
      targetPort: 3000
  selector:
    app: node
    tier: backend

```

Now you can run the  **kubectl**  command.  

```
$ kubectl apply -f node-deployment.yml
$ kubectl apply -f node-service.yml

```

This will create the pods, replica-sets, deployment, and service. Awesome. You can now see the app running. Ideally, the whole process would be automated in a CI/CD pipeline once you make a push to your code repository. But still, the process is painstakingly long even for someone who has done it before.

Let's see how serverless compares.
