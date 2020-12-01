FROM node:14 AS prod
ARG PORT
ENV PORT=${PORT}
ENV TERM=xterm-256color
ENV NODE_ENV=production
RUN npm install -g @angular/cli
USER node
COPY --chown=node:node ./ /home/node/app
WORKDIR /home/node/app
RUN npm install --only=prod

CMD ["sh", "-c", "ng build"]
EXPOSE $PORT 9229

FROM prod as dev
ENV NODE_ENV=development
RUN npm install --only=dev
