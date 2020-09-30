FROM node

# ENV ELM_DEBUGGER=false
ENV SHELL=bash

WORKDIR /elm

RUN npm i \
    npm i -g elm --unsafe-perm=true --allow-root \
    npm i create-elm-app



# CMD ["/bin/bash", "-c"]
