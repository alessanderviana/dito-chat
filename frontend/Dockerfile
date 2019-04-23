# Start from alpine base image
FROM node:8.7.0-alpine

# Add Maintainer Info
LABEL maintainer="Alessander Viana <alessander.viana@hotmail.com>"

ENV REACT_APP_BACKEND_WS="ws://localhost:8080"
ENV REACT_APP_BACKEND_URL="http://localhost:8080"

# Create the WORKDIR
RUN mkdir /frontend

# Set the Current Working Directory inside the container
WORKDIR /frontend

# Copy packages to the WORKDIR inside the container
COPY package.json .
COPY package-lock.json .

# Install the needed node modules
RUN npm install

# Copy local code into the container
COPY . /frontend

# Run the app
# CMD ["npm", "run", "dev"]
CMD ["npm", "start"]
