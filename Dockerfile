FROM node:alpine AS builder
WORKDIR '/app'
COPY package.json . 
RUN npm install 
COPY . .
RUN npm run build

FROM nginx AS prod 
# This isn't used when running manually, but it's used by elastic beanstalk.
EXPOSE 80
COPY --from=builder  /app/build /usr/share/nginx/html
