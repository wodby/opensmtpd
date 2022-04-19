# OpenSMTPD Docker Container Image

[![Build Status](https://github.com/wodby/opensmtpd/workflows/Build%20docker%20image/badge.svg)](https://github.com/wodby/opensmtpd/actions)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/opensmtpd.svg)](https://hub.docker.com/r/wodby/opensmtpd)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/opensmtpd.svg)](https://hub.docker.com/r/wodby/opensmtpd)

## Docker images

❗️For better reliability we release images with stability tags (`wodby/opensmtpd:6-X.X.X`) which correspond to [git tags](https://github.com/wodby/opensmtpd/releases). We strongly recommend using images only with stability tags. 

Overview:

- All images based on Alpine Linux
- Base image: [wodby/alpine](https://github.com/wodby/alpine)
- [GitHub actions builds](https://github.com/wodby/opensmtpd/actions) 
- [Docker Hub](https://hub.docker.com/r/wodby/opensmtpd)

Supported tags and respective `Dockerfile` links:

- `6`, `6.8`, `latest` [_(Dockerfile)_](https://github.com/wodby/opensmtpd/tree/master/Dockerfile)

## Environment variables

| Variable                     | Default Value | Description |
|------------------------------|---------------|-------------|
| `OPENSMTPD_BOUNCE_WARN`      | `1h, 6h, 2d`  |             |
| `OPENSMTPD_EXPIRE`           | `4d`          |             |
| `OPENSMTPD_MAX_MESSAGE_SIZE` | `35M`         |             |
| `RELAY_HOST`                 |               |             |
| `RELAY_USER`                 |               |             |
| `RELAY_PASSWORD`             |               |             |
| `RELAY_PORT`                 | `587`         |             |

## Orchestration actions

Usage:
```
make COMMAND [params ...]

commands:
    check-ready [host max_try wait_seconds delay_seconds]
 
default params values:
    host localhost
    max_try 1
    wait_seconds 1
    delay_seconds 0
```

## Deployment

Deploy OpenSMTPD to your own server via [![Wodby](https://www.google.com/s2/favicons?domain=wodby.com) Wodby](https://wodby.com/stacks/opensmtpd).
