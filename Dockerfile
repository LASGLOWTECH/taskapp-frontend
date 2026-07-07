#STAGE 1: Build the React app

FROM node:18-alpine AS builder

#Set Working Directory

WORKDIR /app

#Copy package files 

COPY package*.json ./

#Install Deps

RUN npm ci --frozen-lockfile

#Copy source code

COPY . .

#Build App

RUN npm run build

#STAGE 2

FROM nginx:alpine

#Copy built assets from builder stage
COPY --from=builder /app/dist /usr/share/nginx/html

#Expose port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]