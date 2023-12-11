# alt-verifier

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/alt-verifier)](https://artifacthub.io/packages/search?repo=alt-verifier)
![Version: 0.1.5](https://img.shields.io/badge/Version-0.1.5-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.7.3](https://img.shields.io/badge/AppVersion-v0.7.3-informational?style=flat-square)

Helm Chart for AltVerifier

**Homepage:** <https://github.com/alt-research/charts>

## How to install

Access a Kubernetes cluster.

Add a chart helm repository with follow commands:

```console
helm repo add alt https://alt-research.github.io/charts/
helm repo update
```

### Install as challenger

For layer1 RPC URL, we suggest you to use alchemy or other RPC provider with more methods avaliable.
Infura cannot be used for verifier cause it lacks support for some required methods.

```console
helm upgrade --install challenger alt/alt-verifier \
    --version 0.1.5	\
    --set mode=challenger \
    --set network=avs-goerli \
    --set secret.privateKey=0x... \
    --set l1.rpc=https://eth-goerli.g.alchemy.com/v2/...
```

### Install as watch tower

```console
helm upgrade --install watchtower alt/alt-verifier \
    --version 0.1.5 \
    --set mode=tower \
    --set network=avs-goerli \
    --set secret.privateKey=0x... \
    --set l1.rpc=https://eth-goerli.g.alchemy.com/v2/...
```

## Commandline Arguments

You can use both camelcased and dashed args without dashes prefix.

For camelcased args, they be auto converted to dashed parameters.

For example:
- `validator: false` and `telemetryUrl: ''` will be omitted
- `validator: "false"` will be `--validator=false`
- `wsExternal: true` will be `--ws-external`
- `rpcCors: all` will be `--rpc-cors=all`

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.repository | string | `"public.ecr.aws/altlayer/alt-verifier"` | Image repository |
| image.pullPolicy | string | `"IfNotPresent"` | Specify a imagePullPolicy Defaults to 'Always' if image tag is 'latest', else set to 'IfNotPresent' ref: http://kubernetes.io/docs/user-guide/images/#pre-pulling-images |
| image.tag | string | `""` | Image tag. Overrides the image tag whose default is the chart appVersion. (default to "master" before first release) If mode is validator, default tag will be appVersion-tracing |
| image.pullSecrets | list | `[]` | Specify docker-registry secret names as an array Optionally specify an array of imagePullSecrets. Secrets must be manually created in the namespace. ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/ Example: pullSecrets:   - myRegistryKeySecretName·  |
| updateStrategy | object | `{"rollingUpdate":{},"type":"RollingUpdate"}` | statefulset strategy type @skip updateStrategy.rollingUpdate ref: https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#update-strategies  |
| podManagementPolicy | string | `""` | podManagementPolicy to manage scaling operation of %%MAIN_CONTAINER_NAME%% pods ref: https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#pod-management-policies  |
| serviceAccount.create | bool | `true` | Enable the creation of a ServiceAccount |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| dnsConfig | object | `{}` | DNS config of Pod |
| podAnnotations | object | `{}` | Annotations of producer Pod |
| securityContext | object | `{}` | Security Context of producer container Example:  securityContext:   capabilities:     drop:     - ALL   readOnlyRootFilesystem: true   runAsNonRoot: true   runAsUser: 1000 |
| service.type | string | `"ClusterIP"` | type of service |
| service.p2p | int | `30333` | P2P port of service |
| service.prometheus | int | `9615` | Prometheus port of service |
| resources | object | `{}` | Resource seetings of producer container We usually recommend not to specify default resources and to leave this as a conscious choice for the user. This also increases chances charts run on environments with little resources, such as Minikube. If you do want to specify resources, uncomment the following lines, adjust them as necessary, and remove the curly braces after 'resources:'. limits:   cpu: 100m   memory: 128Mi requests:   cpu: 100m   memory: 128Mi |
| nodeSelector | object | `{}` | nodeSelector of pod |
| tolerations | list | `[]` | tolerations of pod |
| affinity | object | `{}` | affinity of pod |
| persistence.enabled | bool | `true` | setup volumeClaimTemplate for chaindata persistent volume for producer statefulsets |
| persistence.existingClaim | string | `""` | If set, use existing claim instead of creating a new one |
| persistence.size | string | `"10Gi"` | Size of volume. **NOTICE**: gp3 volume can be live resized when more space needed, no need to provision a large volume at start |
| persistence.storageClassName | string | `""` | storageClassName of PVC |
| persistence.accessModes | list | `["ReadWriteOnce"]` | accessModes of PVC |
| persistence.annotations | object | `{}` | annotations of PVC |
| persistence.chainBaseDir | string | `""` | Dir of volume to store chain data |
| persistence.emptyDir | object | `{}` | EmptyDir settings Will be used when `persistence.enabled=false` Ref: https://kubernetes.io/docs/concepts/storage/volumes#emptydir |
| nameOverride | string | `""` | String to be used in labels |
| fullnameOverride | string | `""` | String to be used as the base of most resource names |
| projectName | string | `""` | String to be used in many resource names |
| secret.create | bool | `true` | create secret instead of using exsisting one |
| secret.name | string | `""` | if `create==false` this is the extra secret's name |
| secret.privateKey | string | `""` | ecdsa private key that will be inserted into the node's keystore |
| chainspec | string | `""` | URL to download chainspec.json |
| instructionWasm | string | `""` | URL to download alt-instruction wasm file |
| ports.p2p | int | `30333` | P2P port of verifier |
| ports.prometheus | int | `9615` | Prometheus port of verifier |
| livenessProbe | object | check [values.yaml](./values.yaml) | Liveness probe |
| readinessProbe | object | check [values.yaml](./values.yaml) | Readiness probe |
| hostPorts.p2p | string | `nil` | P2P port |
| hostPorts.prometheus | string | `nil` | Prometheus port of producer |
| preRunScript | string | `""` | script that run before running verifier |
| mode | string | `"EthRollup"` | verifier mode options: EthRollup, Tower|WatchTower|OnlyChallenger, BeaconRollup, Challenger|TestChallenger |
| l1.chainId | int | `nil` | chainId of layer1 |
| l1.rpc | string | `nil` | RPC URL of layer1 |
| l1.contractAddress | string | `""` | contract address of layer1 diamond proxy |
| l2.rpc | string | `nil` | RPC URL of layer2 |
| l2.contractAddress | string | `""` | contract address of layer2 bridge |
| bootnodes | list | `nil` | bootnodes of verifier |
| args | object | `{}` | command line args of verifier |
| producerArgs | object | `{}` | <PRODUCER_ARGS>... command line args of verifier |
| network | string | `""` | preset network configs. options: avs-goerli |
| serviceMonitor.enabled | bool | `false` | create prometheus-stack's serviceMonitor for producer |
