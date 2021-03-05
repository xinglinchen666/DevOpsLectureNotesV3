# Demo Gremlin
This installation guide will walk you through running Gremlin locally using Docker for Mac. You will also run a shutdown attack against an Nginx container.

## Purpose
Get a feel about using Gremlin for chaos engineering

## Prerequisites
A gremlin account (sign up here)
A Mac

### Step 1.0 - Install Docker For Mac
First you will need to install Docker For Mac if you do not yet have it on your local computer, follow the instructions provided by Docker.

### Step 2.0 - Installing Gremlin
After you have created your Gremlin account (https://www.gremlin.com/) you will need to find your Gremlin Daemon credentials. 

Login to the Gremlin App using your Company name and sign-on credentials. These were emailed to you when you signed up to start using Gremlin.

Tip: you can use your own name as company. 

Navigate to Team Settings and click on your Team. https://app.gremlin.com/settings/teams
![Alt text](../images/team.png?raw=true)


Store your Gremlin client credentials as environment variables, for example:

````
export GREMLIN_TEAM_ID=3f242793-018a-5ad5-9211-fb958f8dc084
export GREMLIN_TEAM_SECRET=eac3a31b-4a6f-6778-1bdb813a6fdc
````

Next run the Gremlin Daemon in a Container.

Use docker run to pull the official Gremlin Docker image and run the Gremlin daemon:

BASH
````
docker run -d --net=host \
--cap-add=NET_ADMIN --cap-add=SYS_BOOT --cap-add=SYS_TIME \
--cap-add=KILL \
-v $PWD/var/lib/gremlin:/var/lib/gremlin \
-v $PWD/var/log/gremlin:/var/log/gremlin \
-v /var/run/docker.sock:/var/run/docker.sock \
-e GREMLIN_TEAM_ID="$GREMLIN_TEAM_ID" \
-e GREMLIN_TEAM_SECRET="$GREMLIN_TEAM_SECRET" \
gremlin/gremlin daemon
````
Note: Please copy the above code from the source in code editor

Use docker ps to see all running Docker containers:

BASH
````
docker ps
CONTAINER ID        IMAGE                COMMAND                  CREATED             STATUS              PORTS                    NAMES
b281e749ac33        gremlin/gremlin      "/entrypoint.sh daem…"   5 seconds ago       Up 4 seconds                                 relaxed_heisenberg
````

### Step 3.0 - Create an NGINX container to attack
First we will create a directory for the html page we will serve using nginx:

BASH
````
mkdir -p ~/docker-nginx/html
cd ~/docker-nginx/html
````

Create a simple HTML page:

BASH

````
vim index.html
````
Paste in this content:
```html
<html>
    <head>
        <title>Docker nginx tutorial</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    </head>
    <body>
        <div class="container">
            <h1>Hello it is your container speaking</h1>
            <p>This nginx page was created by your Docker container.</p>
            <p>Now it's time to create a Gremlin attack.</p>
        </div>
    </body>
</html>
```

type `:wq!` to save the file.

Create a container using the nginx Docker image:

BASH

````
docker run -l service=nginx --name docker-nginx -p 80:80 -d -v ~/docker-nginx/html:/usr/share/nginx/html nginx
````
Make sure the docker-nginx container is running:

BASH

````
docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                NAMES
7167cacb2536        gremlin/gremlin     "/entrypoint.sh daemâ€¦"   40 seconds ago      Up 39 seconds                            practical_benz
fb58b77e5ef8        nginx               "nginx -g 'daemon ofâ€¦"   10 minutes ago      Up 10 minutes       0.0.0.0:80->80/tcp   docker-nginx
````
### Step 4.0 - Run A Gremlin Shutdown Attack
Now use the Gremlin CLI (gremlin) to run a Shutdown attack from within a Gremlin container:

BASH

````
docker run -i     --cap-add=NET_ADMIN     -e GREMLIN_TEAM_ID="${GREMLIN_TEAM_ID}"     -e GREMLIN_TEAM_SECRET="${GREMLIN_TEAM_SECRET}" -v /var/run/docker.sock:/var/run/docker.sock     gremlin/gremlin attack-container docker-nginx shutdown
````
This attack will shutdown your Nginx container.

### Step 5.0 - Open Gremlin UI to play more attach
![Alt text](../images/gremlin-ui.png?raw=true)

Plan an attack for CPU on the container https://app.gremlin.com/attacks/new/containers

![Alt text](../images/container.png?raw=true)
![Alt text](../images/cpu-attach.png?raw=true)
![Alt text](../images/unleash gremlin.png?raw=true)

Use `docker stats` to watch out the effect.

## Reference
https://www.gremlin.com/community/tutorials/how-to-install-and-use-gremlin-locally-with-docker-for-mac/