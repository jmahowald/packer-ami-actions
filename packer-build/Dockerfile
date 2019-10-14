FROM hashicorp/packer:1.3.5

RUN apk add --no-cache jq 

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh



ENTRYPOINT [ "/entrypoint.sh" ]