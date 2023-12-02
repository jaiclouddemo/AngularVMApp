# Use an official Node runtime as a parent image
FROM node:18 as builder

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install Angular CLI globally
RUN npm install -g @angular/cli

# Install app dependencies
RUN npm install

# Copy the project files into the docker image
COPY . .

# Build the Angular app
RUN ng build --prod

# Use a smaller base image for the final image
FROM nginx:alpine

# Copy the build output to replace the default nginx contents
COPY --from=builder /app/dist/angular-app /usr/share/nginx/html

# Expose port 80
EXPOSE 80
