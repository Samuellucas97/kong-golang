# KONG - API GATEWAY

## Introduction

This repository contains tests involving the API Gateway Kong. It involves two fake Golang APIs.

To clone this repository, run:

```bash
$ git clone https://
$ cd KONG-PROJECTS
```

### Content

- [Prerequisites](#prerequisites)
- [How to run?](#how-to-run)
- [How to test?](#how-to-test)


## Prerequisites

- Make (version _version 4.3_)
  - How to install? `apt`

- Ansible (version _version 4.3_)
  - How to install? `apt`

- Python (version _3.10.6_)
  - How to install? `apt`

We will use the Ansible to install the Docker and Docker Compose services.

## How to run?

Run the following command to execute the `docker-compose.yaml`:

```bash
$ make
```

If everything was okay, you should see something similar to this:

```bash
$ docker ps
CONTAINER ID   IMAGE                             COMMAND                  CREATED          STATUS                   PORTS     NAMES
```


### How to clean?

Run the following command:

```bash
$ make clean
```

## How to test?
