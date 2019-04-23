# Start from golang v1.11 base image
FROM golang:1.11

# Add Maintainer Info
LABEL maintainer="Alessander Viana <alessander.viana@hotmail.com>"

ENV ALLOWED_ORIGIN='http://localhost:3000'
ENV REDIS_ADDR=localhost:6379

# Create the WORKDIR
RUN mkdir /backend

# Set the Current Working Directory inside the container
WORKDIR /backend

# Copy everything from the current directory to WORKDIR
COPY . .

# Download all the dependencies
# https://stackoverflow.com/questions/28031603/what-do-three-dots-mean-in-go-command-line-invocations
# RUN go get -d -v ./...
RUN go get ./...
RUN go build .

# Install the package
# RUN go install -v ./...

# This container exposes port 8080 to the outside world
EXPOSE 8080

# Run the executable
CMD ["backend"]
