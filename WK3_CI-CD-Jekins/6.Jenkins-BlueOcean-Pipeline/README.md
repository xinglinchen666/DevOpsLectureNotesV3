# Description

This is to demo how to build Jenkins pipeline using Blue Ocean interface

About Blue Ocean:
Blue Ocean is a new user experience for Jenkins based on a personalizable, modern design that allows users to graphically create, visualize and diagnose Continuous Delivery (CD) Pipelines. For more info please refer to https://www.jenkins.io/projects/blueocean/about/

# Pre-requisite

- Github Account
- Jenkins Server

# Task

## Step #1: In Github, fork a repo with Jenkinsfile under your account
Fork https://github.com/JiangRenDevOps/hello-Jenkinsfile into your account.
![Alt text](images/jenkins-blueocean-pipeline-01.png?raw=true)


## Step #2: Enter Blue Ocean view by clicking the "Open Blue Ocean" button on Jenkins homepage.
![Alt text](images/jenkins-blueocean-pipeline-02.png?raw=true)


## Step #3: Create pipeline from your github repository
![Alt text](images/jenkins-blueocean-pipeline-03.png?raw=true)
1. Click "New Pipeline" on the top right corner.
Choose "Github" as the source.
2. Generate a token by clicking "Create an access token here" and provide the token to Jenkins.
3. Choose your account as the organization this repository belongs to.
4. Choose the repository you just forked into your account.
5. Create pipeline.



## Step #4: View your pipeline deployment process
![Alt text](images/jenkins-blueocean-pipeline-04.png?raw=true)
You should be able to see all Build, Test and Deploy stage output.


## Step #5: Select the credential you have just added
![Alt text](images/integrate-with-github-org-05.png?raw=true)


## Step #6: Input your Github Organisation name to the "Owner" field, review other settings and save.

![Alt text](images/integrate-with-github-org-06.png?raw=true)


## Step #7: You should see this screen after the integration.
![Alt text](images/integrate-with-github-org-07.png?raw=true)


## Step #8: In github organisation, you should see a webhook created automatically.
This webhook will notify Jenkins when there is a push, PR or repository created.
![Alt text](images/integrate-with-github-org-08.png?raw=true)


## Step #9: Fork a repo with Jenkinsfile to your organisation
Fork https://github.com/JiangRenDevOps/hello-Jenkinsfile into your organization.


## Step #10: In Jenkins, run "Scan Organization Now" in the organization view.
You should see a new repository being added into the organization, and a build job is created automatically for the "master" branch of the forked repository.
![Alt text](images/integrate-with-github-org-10.png?raw=true)


## Step #11: Create a new branch
![Alt text](images/integrate-with-github-org-11.png?raw=true)


## Step #12: In Jenkins, you should see a new job is created automatically
![Alt text](images/integrate-with-github-org-12.png?raw=true)


## Step #13: Modify README.md or add a file to the repo.
![Alt text](images/integrate-with-github-org-13.png?raw=true)


## Step #14: In Jenkins, you should see a new build is triggerred
![Alt text](images/integrate-with-github-org-14.png?raw=true)


## Step #15: Create a PR
![Alt text](images/integrate-with-github-org-15.png?raw=true)


## Step #16: In Jenkins, you should see a new build is triggerred
![Alt text](images/integrate-with-github-org-16.png?raw=true)


## Step #17: Merge the PR
![Alt text](images/integrate-with-github-org-17.png?raw=true)


## Step #18: In Jenkins, you should see the PR build is going to be deleted
![Alt text](images/integrate-with-github-org-18.png?raw=true)


## Step #19: In Jenkins, you should see another build in master branch
![Alt text](images/integrate-with-github-org-19.png?raw=true)


## Step #20: Open "Blue Ocean"
![Alt text](images/integrate-with-github-org-20.png?raw=true)


## Step #21: You should see a new UI experience
![Alt text](images/integrate-with-github-org-21.png?raw=true)
