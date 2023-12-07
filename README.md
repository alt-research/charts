# Charts

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

Helm Charts of Alt Research

## Add Repo

```console
helm repo add alt https://alt-research.github.io/charts/
helm repo update
```

## Working with GHCR

ref: https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry

1. create a PAT with `read:packages` access
2. login in to GHCR with `helm registry login -u=YOUR_USERNAME -p=YOUR_TOKEN ghcr.io`

## Charts

-   [alt-verifier](charts/alt-verifier): Helm Chart for AltVerifier

## FAQ

**Q:** Commit Hook or CI failed with message like `Error: no repository definition for XXX. Please add the missing repos via 'helm repo add'`

**A:** You need to add your chart's dependency's repo to [`ct.yaml`](ct.yaml) and the "Add helm repos that chart depends" step of workflow [release.yml](.github/workflows/release.yml)
