# OpenSMTPD Docker Container Image

[![Build Status](https://travis-ci.org/wodby/opensmtpd.svg?branch=master)](https://travis-ci.org/wodby/opensmptd)
[![Docker Pulls](https://img.shields.io/docker/pulls/wodby/opensmtpd-alpine.svg)](https://hub.docker.com/r/wodby/opensmtpd-alpine)
[![Docker Stars](https://img.shields.io/docker/stars/wodby/opensmtpd-alpine.svg)](https://hub.docker.com/r/wodby/opensmtpd-alpine)
[![Wodby Slack](http://slack.wodby.com/badge.svg)](http://slack.wodby.com)

## Docker Images

Images are based on [wodby/alpine](https://github.com/wodby/alpine), built via [Travis CI](https://travis-ci.org/wodby/opensmtpd) and published on [Docker Hub](https://hub.docker.com/r/wodby/opensmtpd). 

## Versions

| Image tag (Dockerfile)                                               | OpenSMPTD | Alpine Linux |
| -------------------------------------------------------------------- | --------- | ------------ |
| [6.0.2](https://github.com/wodby/opensmtpd/tree/master/6/Dockerfile) | 6.0.2     | 3.6          |

## Environment Variables

| Variable                   | Default Value | Description |
| -------------------------- | ------------- | ----------- |
| OPENSMTPD_BOUNCE_WARN      | 1h, 6h, 2d    |             |
| OPENSMTPD_EXPIRE           | 4d            |             |
| OPENSMTPD_MAX_MESSAGE_SIZE | 35M           |             |
| RELAY_HOST                 |               |             |
| RELAY_USER                 |               |             |
| RELAY_PASSWORD             |               |             |
| RELAY_PORT                 | 587           |             |

## Actions

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

Deploy OpenSMTPD to your own server via [![Wodby](https://www.google.com/s2/favicons?domain=wodby.com) Wodby](https://wodby.com).
