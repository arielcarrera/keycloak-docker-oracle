# keycloak-oracle

Keycloak Docker image to use with an external Oracle database (Extends the Keycloak docker image).

## Pre-requisites

- Oracle 11 DB installed and running.
- Download and copy the oracle 'ojdbc6.jar' driver and locate it in the root directory beside the dockerfile.
- A local docker registry installed and running on port 5000.

## Usage

### Build the keycloa-oracle image

    docker build -t jboss/keycloak-oracle .

### Tag the image

    docker tag jboss/keycloak-oracle localhost:5000/keycloak-oracle .

### Push the image to the local registry

    docker push localhost:5000/keycloak-oracle

### Start a Keycloak instance

Start a Keycloak instance and connect to the ORACLE instance:

    docker run --name keycloak -e ORACLE_TCP_ADDR=kcdbaddr localhost:5000/keycloak-oracle

### Environment variables

When starting the Keycloak instance you can pass a number of environment variables to configure how it connects to ORACLE. For example:

    docker run --name keycloak --link oracle:oracle -e ORACLE_TCP_ADDR=kcdbaddr -e ORACLE_DATABASE=kcdb -e ORACLE_USER=kcuser -e ORACLE_PASSWORD=kcpassword localhost:5000/keycloak-oracle

#### ORACLE_DATABASE

Specify name of ORACLE database (optional, default is `keycloak`).

#### ORACLE_TCP_ADDR

Specify address for ORACLE database (required).

#### ORACLE_TCP_PORT

Specify port for ORACLE database (optional, default is `1521`).

#### ORACLE_USERNAME

Specify user for ORACLE database (optional, default is `keycloak`).

#### ORACLE_PASSWORD

Specify password for ORACLE database (optional, default is `password`).


