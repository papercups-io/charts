# Papercups Helm Chart

![Version: 0.1.4](https://img.shields.io/badge/Version-0.1.4-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: latest](https://img.shields.io/badge/AppVersion-latest-informational?style=flat-square)

This chart was designed to deploy [papercups](https://papercups.io) to your Kubernetes cluster.

## Deploying Papercups

### Install the Helm repository

```bash
$ helm repo add papercups https://helm.papercups.io/
$ helm install papercups papercups/papercups \
    --set secrets.SECRET_KEY_BASE=dvPPvOjpgX2Wk8Y3ONrqWsgM9ZtU4sSrs4l/5CFD1sLm4H+CjLU+EidjNGuSz7bz \
    --set secrets.DATABASE_URL="ecto://papercups:changeit@papercups-db-postgresql.default.svc.cluster.local/papercups"
```

## Prerequisites

### Backend Database

#### Using the Bitnami PostgreSQL chart

See more at https://github.com/bitnami/charts/tree/master/bitnami/postgresql/#installing-the-chart

```
$ helm repo add bitnami https://charts.bitnami.com/bitnami
$ helm install papercups-db bitnami/postgresql --set postgresqlUsername=papercups,postgresqlPassword=changeit,postgresqlDatabase=papercups
```

## Deploying to AWS

Read more at [https://docs.papercups.io/aws](https://docs.papercups.io/aws).

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Node affinity, is a property of Pods that attracts them to a set of nodes (either as a preference or a hard requirement). |
| autoscaling | object | `{"enabled":false,"maxReplicas":10,"minReplicas":1,"targetCPUUtilizationPercentage":80}` | The Horizontal Pod Autoscaler automatically scales the number of Pods in a replication controller, deployment, replica set or stateful set based on observed CPU utilization |
| configMap | object | `{"BACKEND_URL":"localhost","REQUIRE_DB_SSL":"false"}` | Configures a configmap to provide the papercups configuration |
| fullnameOverride | string | `""` | Override the full qualified app name |
| image.args | list | `["run"]` | Equivalent to Docker's Command |
| image.command | list | `["/entrypoint.sh"]` | Equivalent to Docker's Entrypoint |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"papercups/papercups"` | Override default registry + image.name |
| image.tag | string | `"latest@sha256:9134991ef653cdaceeead862bafdfe332ba9d1e24f49fce386ea092e26bbbd1e"` | Override the image tag |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{"alb.ingress.kubernetes.io/scheme":"internet-facing","alb.ingress.kubernetes.io/target-type":"instance","kubernetes.io/ingress.class":"alb"}` | Specify Ingress controller's annotations. |
| ingress.enabled | bool | `false` | Enable using an Ingress controller. |
| ingress.hosts | list | `[{"host":"*","paths":["/"]}]` | Specify what hosts the listener will listen for. -- If external-dns is enabled, then create DNS records for each host entry |
| ingress.tls | list | `[]` |  |
| initialize_database.enabled | bool | `true` | Create the databases upon install/upgrade. This runs in a distinct job. This is idempotent, but you can disable this if you want. |
| migration.enabled | bool | `true` | Perform a DB migration upon install/upgrade. This runs in a distinct job. |
| nameOverride | string | `""` | Override name of app |
| nodeSelector | object | `{}` | Allow the Deployment to be scheduled on selected nodes |
| podAnnotations | object | `{}` | Annotations to add to the pod(s) |
| podSecurityContext | object | `{}` | PodSecurityContext holds pod-level security attributes and common container settings. |
| replicaCount | int | `1` | Specify the number of papercups instances. |
| resources | object | `{}` | Set resources requests / limits for pods. |
| secrets.DATABASE_URL | string | `"ecto://papercups:changeit@papercups-db-postgresql.default.svc.cluster.local/papercups"` | The connection parameters for ecto to connect to postgresql |
| secrets.SECRET_KEY_BASE | string | `"dvPPvOjpgX2Wk8Y3ONrqWsgM9ZtU4sSrs4l/5CFD1sLm4H+CjLU+EidjNGuSz7bz"` | The secret Phoenix uses to sign and encrypt important information |
| securityContext | object | `{}` | SecurityContext holds security configuration that will be applied to a container. |
| service.port | int | `4000` |  |
| service.type | string | `"NodePort"` |  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` | Tolerations are applied to pods, and allow (but do not require) the pods to schedule onto nodes with matching taints. |
