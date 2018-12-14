FROM node:11.1.0

# Make sure we are running under root user
# this is to fix error with EACCES Errors (user "nobody" does not have rights ...)
# See https://stackoverflow.com/questions/44633419/no-access-permission-error-with-npm-global-install-on-docker-image
USER root
RUN npm -g config set user root

RUN echo node version
RUN node --version

# set working directory
RUN mkdir /usr/src/app
WORKDIR /usr/src/app

# add `/usr/src/app/node_modules/.bin` to $PATH
ENV PATH /usr/src/app/node_modules/.bin:$PATH

# increment this line when you updated the package.json
RUN touch break-cache-1

# install and cache app dependencies
RUN npm install -g webpack
RUN npm install -g zos

ENTRYPOINT [ "zos" ]