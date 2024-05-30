FROM golang:1.21.4-alpine AS build

WORKDIR /app

COPY go.mod ./
COPY go.sum ./

RUN go mod download && go mod verify

COPY main.go ./

RUN go build -o /my-app

WORKDIR /bin/myapp

FROM gcr.io/distroless/base-debian11

COPY --from=build /src/go/myapp .

ENTRYPOINT ["./myapp"]
