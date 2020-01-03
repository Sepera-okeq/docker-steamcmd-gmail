FROM golang as build
LABEL author="Antoni Baum (Yard1) <antoni.baum@protonmail.com> & Florian Kinder <florian.kinder@fankserver.com>"

WORKDIR /app

ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .

# it will take the flags from the environment
RUN go build

### App
FROM ubuntu:18.04 as app
LABEL author="Antoni Baum (Yard1) <antoni.baum@protonmail.com> & Florian Kinder <florian.kinder@fankserver.com>"

# Install dependencies
RUN apt-get update &&\
	apt-get install --no-install-recommends --no-install-suggests -y curl lib32gcc1 ca-certificates &&\
	rm -rf /var/lib/apt/lists/*

# Download and extract SteamCMD
RUN mkdir -p /opt/steamcmd &&\
	cd /opt/steamcmd &&\
	curl -s http://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar -vxz

# Run it once so it updates, and the update is cached
RUN /opt/steamcmd/steamcmd.sh +quit

COPY --from=build app /
ENTRYPOINT ["/steamcmd_gmail"]
