# GitLab Runner

This is the GitLab runner I use because it has both Docker and NodeJS installed in it. So I can build API servers, build their container, then deploy them out to the wild.  

### Building the image:

To build and push up new images:

    $ docker build -t caspian/gitlab-runner:1.0 .
    $ docker push image caspian/gitlab-runner:1.0

Change the version number as needed.

### Running it locally:
    
But to run with Docker, you need specify the docker sock file from your local host. That's the only way I could get _DIND_ to work.

    $ docker run -it \
        -v /var/run/docker.sock:/var/run/docker.sock \
        caspian311/gitlab-runner:1.0 /bin/bash

