FROM ubuntu

RUN apt-get update \
    && apt-get install -y \
        curl

# Install Python and PIP
RUN apt-get install -y \
        python \
    && curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py \
    && python /tmp/get-pip.py

# Install AWS CLI and ECS CLI
RUN pip install awscli \
    && curl -o /usr/local/bin/ecs-cli https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest \
    && chmod +x /usr/local/bin/ecs-cli

WORKDIR /compose-files

COPY ./compose-files /compose-files
COPY ./scripts /usr/local/bin

RUN chmod +x /usr/local/bin/*

ENTRYPOINT ["run-k6-cluster"]
