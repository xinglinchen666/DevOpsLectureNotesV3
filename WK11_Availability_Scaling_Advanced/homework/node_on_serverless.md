
## Deploy a serverless Node.js app to AWS

Would you be surprised there are significantly fewer steps in deploying a Node.js app to a serverless environment? I'd sure hope you wouldn't.

With the  [Serverless Framework](https://serverless.com/framework/), you can simplify the development process of serverless applications by miles. You configure all resources in a file called  **serverless.yml**. It'll essentially be converted into a CloudFormation template, get deployed to AWS and create all the resources you specified. The code itself gets packaged into a .zip file and uploaded to S3. From there it'll be deployed to Lambda.

The magic of the Serverless Framework lies in the automated process of creating resources and deploying code all in one step. Let me show you.

_**Note**: I assume you have installed and configured the required framework modules and IAM roles for this to work. If not, check  [this](https://hackernoon.com/a-crash-course-on-serverless-with-node-js-632b37d58b44)  out to get started._  

```
# Framework
$ npm i -g serverless 
# Express.js router proxy module
$ npm i serverless-http

```

### [](https://dev.to/adnanrahic/containers-vs-serverless-from-a-devops-standpoint-e4n#1-configure-the-serverless-resources)1. Configure the serverless resources

Here's what the same Node.js/Express would look like with minor edits to work with AWS Lambda.  

```
// app.js
const express = require('express')
const sls = require('serverless-http')
const app = express()
app.get('/', async (req, res, next) => {
  res.status(200).send('Hello World!')
})
module.exports.server = sls(app)

```

The only difference is that you're passing it to the  **serverless-http**  module. Moving on, I want to give you insight into the actual resources we need, let's check out a sample  **serverless.yml**  file.  

```
# serverless.yml
service: express-sls-app

provider:
  name: aws
  runtime: nodejs8.10
  stage: dev
  region: eu-central-1

functions:
  app:
    handler: app.server
    events:
      - http:
          path: /
          method: ANY
      - http:
          path: /{proxy+}
          method: ANY

```

We'll deploy an  `app`  function with the function handler pointing to the  `server`  method in the  **app.js**  file. The event trigger for this function will be an HTTP request to any path. The actual routing will be handled inside the Express app, so we can just add the  `{proxy+}`  setting.

### [](https://dev.to/adnanrahic/containers-vs-serverless-from-a-devops-standpoint-e4n#2-deploy-the-serverless-resources)2. Deploy the serverless resources

Guess what, deploying it all to AWS takes just one command.  

```
$ serverless deploy

```

Creating a viable CI/CD pipeline for running a single command is significantly more simple than the wild jungle of container commands.
