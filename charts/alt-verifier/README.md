# alt-verifier

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v0.7.3](https://img.shields.io/badge/AppVersion-v0.7.3-informational?style=flat-square)

Helm Chart for AltVerifier

**Homepage:** <https://github.com/alt-research/charts>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| nodeCount | int | `0` | nodeCount count of producers, not like replicaCounts, it's one producer one statefulset |
| image.repository | string | `"public.ecr.aws/altlayer/alt-verifier"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.tag | string | `""` |  |
| image.pullSecrets | list | `[]` |  |
| updateStrategy.type | string | `"RollingUpdate"` |  |
| updateStrategy.rollingUpdate | object | `{}` |  |
| podManagementPolicy | string | `""` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.name | string | `""` |  |
| dnsConfig | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext | object | `{}` |  |
| service.type | string | `"ClusterIP"` |  |
| service.rpc | int | `9933` |  |
| service.ws | int | `9944` |  |
| service.p2p | int | `30333` |  |
| service.prometheus | int | `9615` |  |
| ingress.enabled | bool | `false` |  |
| ingress.className | string | `""` |  |
| ingress.annotations | object | `{}` |  |
| ingress.hosts | list | `[]` |  |
| ingress.tls | list | `[]` |  |
| wsIngress.enabled | bool | `false` |  |
| wsIngress.className | string | `""` |  |
| wsIngress.annotations | object | `{}` |  |
| wsIngress.hosts | list | `[]` |  |
| wsIngress.tls | list | `[]` |  |
| resources | object | `{}` |  |
| nodeSelector | object | `{}` |  |
| tolerations | list | `[]` |  |
| affinity | object | `{}` |  |
| persistence.enabled | bool | `true` |  |
| persistence.existingClaim | string | `""` |  |
| persistence.size | string | `"10Gi"` |  |
| persistence.storageClassName | string | `""` |  |
| persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| persistence.annotations | object | `{}` |  |
| persistence.chainBaseDir | string | `""` |  |
| persistence.emptyDir | object | `{}` |  |
| nameOverride | string | `""` |  |
| fullnameOverride | string | `""` |  |
| projectName | string | `""` |  |
| beaconWsUrl | string | `""` |  |
| secret.create | bool | `true` |  |
| secret.name | string | `""` |  |
| secret.mnemonic | string | `""` |  |
| secret.privateKeys | list | `[]` |  |
| secret.nodeKeys | list | `[]` |  |
| secret.keyInsertScript | string | `"rm /data/*/*/keystore/*\n/usr/local/bin/alt-verifier key insert -d /data --chain=$CHAIN --suri=\"$PRIVATE_KEY\" --key-type acco --scheme ecdsa;\nls /data/*/*/keystore\n"` |  |
| chainspec.storageUrl | string | `""` |  |
| chainspec.name | string | `""` |  |
| rollup.enabled | bool | `false` |  |
| rollup.subCommand | string | `"rollup"` |  |
| rollup.altInstructionUrl | string | `""` |  |
| ports.p2p | int | `30334` |  |
| ports.rpc | int | `9934` |  |
| ports.ws | int | `9945` |  |
| ports.verifierPrometheus | int | `9615` |  |
| ports.prometheus | int | `9616` |  |
| livenessProbe.httpGet.path | string | `"/metrics"` |  |
| livenessProbe.httpGet.port | string | `"verifierprom"` |  |
| livenessProbe.initialDelaySeconds | int | `0` |  |
| livenessProbe.timeoutSeconds | int | `1` |  |
| livenessProbe.periodSeconds | int | `10` |  |
| livenessProbe.successThreshold | int | `1` |  |
| livenessProbe.failureThreshold | int | `3` |  |
| readinessProbe.httpGet.path | string | `"/metrics"` |  |
| readinessProbe.httpGet.port | string | `"verifierprom"` |  |
| readinessProbe.initialDelaySeconds | int | `0` |  |
| readinessProbe.timeoutSeconds | int | `1` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.successThreshold | int | `1` |  |
| readinessProbe.failureThreshold | int | `3` |  |
| hostPorts.p2p | string | `nil` |  |
| hostPorts.rpc | string | `nil` |  |
| hostPorts.ws | string | `nil` |  |
| hostPorts.verifierPrometheus | string | `nil` |  |
| hostPorts.prometheus | string | `nil` |  |
| RUST_LOG | string | `"runtime=debug"` |  |
| preRunScript | string | `""` |  |
| args.log | string | `"info"` |  |
| args.appId | int | `0` |  |
| args.verifierPrometheusExternal | bool | `true` |  |
| args.altbeaconUrl | string | `nil` |  |
| producerArgs.prometheusExternal | bool | `true` |  |
| producerArgs.telemetryUrl | string | `""` |  |
| producerArgs.rpcCors | string | `"all"` |  |
| producerArgs.execution | string | `"native-else-wasm"` |  |
| serviceMonitor.enabled | bool | `false` |  |
