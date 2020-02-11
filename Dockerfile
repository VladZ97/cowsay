FROM node:13.6.0-alpine3.11
WORKDIR /app
COPY ./src .
RUN npm install
ENTRYPOINT [ "./entry-point.sh" ]
CMD [ "8080" ]