# GitLab Runner

This is the GitLab runner I use because it has both Docker and NodeJS installed in it. So I can build API servers, build their container, then deploy them out to the wild.  

### Building the image:

To build and push up new images:

    $ docker build -t caspian311/gitlab-runner:1.0 .
    $ docker push image caspian311/gitlab-runner:1.0

Change the version number as needed.

### Running it locally:
    
But to run with Docker, you need specify the docker sock file from your local host. That's the only way I could get _DIND_ to work.

    $ docker run -it \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v <path-to-git-repo>:/root/code \
        caspian311/gitlab-runner:1.0 /bin/bash

### Connect it as a runner to GitLab

You'll need somewhere to run the GitLab runner. I usually just build an EC2 instance somewhere and then register Docker runners there.

Register the runner with the GitLab mother-ship:

    $ ssh ec2-user@<ip-address-of-ec2-instance>
    $ sudo docker run --rm -it -v /srv/gitlab-runner/config:/etc/gitlab-runner \
        gitlab/gitlab-runner register \
        --non-interactive \
        --url "https://gitlab.asynchrony.com/" \
        --registration-token "<TOKEN>" \
        --executor "docker" \
        --docker-image caspian311/gitlab-runner:1.0 \
        --run-untagged="true" \
        --locked="false" \
        --access-level="not_protected"

Don't forget to start the runner:

    $ ssh ec2-user@<ip-address-of-ec2-instance>
    $ sudo docker run -d --name gitlab-runner --restart always \
        -v /srv/gitlab-runner/config:/etc/gitlab-runner \
        -v /var/run/docker.sock:/var/run/docker.sock \
        gitlab/gitlab-runner

#Good Luck!#