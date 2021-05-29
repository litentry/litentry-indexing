FROM node:16

WORKDIR /usr/src/app
COPY dotreasury /usr/src/app/dotreasury
RUN cd /usr/src/app/dotreasury && yarn install && yarn upgrade
CMD bash
