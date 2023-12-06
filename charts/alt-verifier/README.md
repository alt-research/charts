# alt-verifier

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.7.3](https://img.shields.io/badge/AppVersion-v0.7.3-informational?style=flat-square)

Helm Chart for AltVerifier

**Homepage:** <https://github.com/alt-research/charts>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| nodeCount | int | `0` | nodeCount count of producers, not like replicaCounts, it's one producer one statefulset |
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
| service.rpc | int | `9933` | RPC port of service |
| service.ws | int | `9944` | Websocket port of service |
| service.p2p | int | `30333` | P2P port of service |
| service.prometheus | int | `9615` | Prometheus port of service |
| ingress.enabled | bool | `false` | Enable ingress |
| ingress.className | string | `""` | ingressClassName of ingress |
| ingress.annotations | object | `{}` | annotations of ingress |
| ingress.hosts | list | `[]` | hosts of ingress @extra ingress.hosts[*].paths[*].wsPath [string] websocket path Example: hosts: - host: chart-example.local   paths:   - path: /     wsPath: /ws     pathType: ImplementationSpecific |
| ingress.tls | list | `[]` | TLS setting of ingress Example: tls: - secretName: chart-example-tls   hosts:   - chart-example.local |
| wsIngress.enabled | bool | `false` | Enable ingress |
| wsIngress.className | string | `""` | ingressClassName of ingress |
| wsIngress.annotations | object | `{}` | annotations of ingress |
| wsIngress.hosts | list | `[]` | hosts of ingress Example: hosts: - host: chart-example.local   paths:   - path: /     pathType: ImplementationSpecific |
| wsIngress.tls | list | `[]` | TLS setting of ingress Example: tls: - secretName: chart-example-tls   hosts:   - chart-example.local |
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
| secret.mnemonic | string | `""` | creaing a new secret with this mnemonic |
| secret.privateKeys | list | `[]` | ecdsa private key that will be inserted into the node's keystore |
| secret.nodeKeys | list | `[]` | creaing a new secret with thiese keys |
| chainspec.storageUrl | string | `""` | url of the chainspec's dir of storage |
| chainspec.name | string | `""` | built-in chainspec name or filename of chainspec to download |
| ports.p2p | int | `30334` | P2P port of verifier |
| ports.prometheus | int | `9615` | Prometheus port of verifier |
| livenessProbe | object | `{"failureThreshold":3,"httpGet":{"path":"/metrics","port":"prometheus"},"initialDelaySeconds":0,"periodSeconds":10,"successThreshold":1,"timeoutSeconds":1}` | Liveness probe |
| hostPorts.p2p | string | `nil` | P2P port |
| hostPorts.prometheus | string | `nil` | Prometheus port of producer |
| preRunScript | string | `""` | script that run before running verifier |
| args.log | string | `"info"` | Sets a custom logging filter. Syntax is <target>=<level>, e.g. -lsync=debug |
| args.appId | int | `0` | The app id of the layer 2, default is alt_producer 's 0 |
| args.altbeaconUrl | string | `nil` | The altbeacon WebSockets RPC URL |
| serviceMonitor.enabled | bool | `false` | create prometheus-stack's serviceMonitor for producer |
| rollup | object | `{"altInstructionUrl":"","enabled":false,"subCommand":"rollup"}` | eth 1 rollup arguments |
| rollup.enabled | bool | `false` | enable rollup mode |
| rollup.subCommand | string | `"rollup"` | the subcommand of alt-verifier to do rollup and challenge etc. |

## Commandline Arguments

You can use both camelcased and dashed args without dashes prefix.

For camelcased args, they be auto converted to dashed parameters.

For example:
- `validator: false` and `telemetryUrl: ''` will be omitted
- `validator: "false"` will be `--validator=false`
- `wsExternal: true` will be `--ws-external`
- `rpcCors: all` will be `--rpc-cors=all`
