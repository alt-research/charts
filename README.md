# Charts

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

Helm Charts of Alt Research

## Working with GHCR

ref: https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry

1. create a PAT with `read:packages` access
2. login in to GHCR with `helm registry login -u=YOUR_USERNAME -p=YOUR_TOKEN ghcr.io`

## Charts

- [alt-verifier](charts/alt-verifier): Helm Chart for AltVerifier

## FAQ

**Q:** Commit hook failing at generate-docs with error "files were modified by this hook"

**A:** It's a conflict between `readme-generator` and `end-of-file-fixer`.
Make sure your README.md always have something after the _Parameters_ section, like a _FAQ_, so the generated readme won't end with 2 empty lines.

---

**Q:** Commit Hook or CI failed with message like `Error: no repository definition for XXX. Please add the missing repos via 'helm repo add'`

**A:** You need to add your chart's dependency's repo to [`ct.yaml`](ct.yaml) and the "Add helm repos that chart depends" step of workflow [release.yml](.github/workflows/release.yml)
