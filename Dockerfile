FROM ubuntu

RUN apt-get update

RUN apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    unzip \
    zip \
    gettext

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y docker-ce docker-ce-cli containerd.io nodejs npm kubectl

RUN mkdir /tmp/aws-files && cd /tmp/aws-files && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o aws.zip && unzip aws.zip && aws/install && cd && rm -fR /tmp/aws-files
