FROM cloudcustodian/c7n

USER root


RUN pip install j2cli awscli
RUN apt-get update && apt-get install -y jq curl
RUN curl -sfL https://github.com/powerman/dockerize/releases/download/v0.10.0/dockerize-`uname -s`-`uname -m` | install /dev/stdin /usr/local/bin/dockerize

COPY entrypoint.sh /entrypoint.sh
COPY ami-cleanup.tpl.yml /
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

