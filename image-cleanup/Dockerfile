FROM cloudcustodian/c7n

USER root


RUN pip install j2cli awscli
RUN apt-get update && apt-get install -y jq curl
RUN curl -sfL $(curl -s https://api.github.com/repos/powerman/dockerize/releases/latest | grep -i /dockerize-$(uname -s)-$(uname -m)\" | cut -d\" -f4) | install /dev/stdin /usr/local/bin/dockerize

COPY entrypoint.sh /entrypoint.sh
COPY ami-cleanup.tpl.yml ./
RUN chmod +x /entrypoint.sh


USER custodian
ENTRYPOINT [ "/entrypoint.sh" ]

