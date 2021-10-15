# Papercups Helm Chart for Kubernetes
[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/papercups)](https://artifacthub.io/packages/search?repo=papercups)

Deploy the [Papercups](https://papercups.io) application to Kubernetes

## TL;DR
```
$ helm repo add papercups http://helm.papercups.io/
$ helm repo update
```

## Before you begin
### Prerequisites
- [Kubernetes 1.17.4+](http://kubernetes.io/docs/getting-started-guides/)
- [Helm 3.4+](https://github.com/helm/helm#install)

## Common Settings

```yml
secrets:
  # PUT YOUR OWN SECRET KEYBASE HERE (MUST BE AT LEAST 64 BYTES)
  SECRET_KEY_BASE: "dvPPvOjpgX2Wk8Y3ONrqWsgM9ZtU4sSrs4l/5CFD1sLm4H+CjLU+EidjNGuSz7bz"
  # -- The connection parameters for ecto to connect to EXTERNAL postgresql
  #DATABASE_URL: "ecto://papercups:changeit@papercups-db-postgresql.default.svc.cluster.local/papercups"

## PostgreSQL specific settings (https://hub.helm.sh/charts/bitnami/postgresql/10.3.18)
postgresql:
  # -- Install PostgreSQL using subchart
  install: true

global:
  postgresql:
    enabled: true

    # -- postgresqlUsername which should be used by Rasa to connect to Postgres
    postgresqlUsername: "postgres"

    # -- postgresqlPassword is the password which is used when the postgresqlUsername equals "postgres"
    postgresqlPassword: "password"

    # -- existingSecret which should be used for the password instead of putting it in the values file
    existingSecret: ""

    # -- postgresDatabase which should be used by Papercups
    postgresqlDatabase: "papercups"

    # -- servicePort which is used to expose postgres to the other components
    servicePort: 5432
```
