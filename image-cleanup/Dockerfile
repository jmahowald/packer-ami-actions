FROM cloudcustodian/c7n

USER root

RUN pip install j2cli
RUN apt-get update && apt-get install -y jq

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER custodian
ENTRYPOINT [ "/entrypoint.sh" ]

