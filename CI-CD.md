# CI/CD Pipeline Documentation

This repository uses separate CI and CD workflows.

## Workflow Split

- CI workflow: `.github/workflows/ci.yml`
- CD workflow: `.github/workflows/cd.yml`
- Release/changelog workflow: `.github/workflows/release-please.yml`

### CI (Continuous Integration)

Purpose: validate code and build a promotable candidate image.

Triggers:
- Push to `main` and `feature/first-version`
- Pull request to `main`
- Weekly scheduled security run
- Manual dispatch

Stages:
- Lint Dockerfile (Hadolint)
- Validate config files (`devcontainer.json`, `docker-compose.yml`)
- Lint shell scripts (ShellCheck)
- Security scan (Trivy + SARIF upload)
- Build and runtime checks (Node, Python, Docker, GH CLI, Git LFS, Podman)
- Publish candidate image on branch pushes as `ci-<sha>`
- Upload candidate metadata artifact (`candidate-image.json`)

Candidate image:
- `ghcr.io/jasonouellet/devcontainer-base:ci-<sha>`

### CD (Continuous Deployment)

Purpose: publish final image from a previously validated candidate.

Triggers:
- Automatic on tag push `v*`
- Manual dispatch with explicit inputs

Rules:
- `release_tag` is mandatory for final publication
- `latest` is only promoted when `release_tag` is present
- Candidate source must exist as `ci-<sha>`

Promotion behavior:
- Promote `ci-<sha>` to `<release_tag>`
- Promote `ci-<sha>` to `latest`
- Create GitHub release for `<release_tag>`

### Conventional Commits

Conventional Commits remain the recommended commit style.

Purpose:
- Keep commit history machine-readable for release automation.
- Make changelog generation more reliable.

### SemVer Changelog Automation

Workflow: `.github/workflows/release-please.yml`

Purpose:
- Maintain `CHANGELOG.md` automatically from Conventional Commits.
- Manage SemVer releases through a release PR process.

Files used:
- `.release-please-config.json`
- `.release-please-manifest.json`
- `CHANGELOG.md`

## Release Flow

1. Merge code and let CI pass.
2. Ensure candidate exists (`ci-<sha>`).
3. Publish with CD:
   - Automatic: push tag `vX.Y.Z`
   - Manual: run CD workflow and provide `source_sha` and `release_tag`

Example:

```bash
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0
```

## Manual CD Execution

Inputs:
- `source_sha`: commit SHA matching CI candidate tag `ci-<sha>`
- `release_tag`: final published tag (example `v1.2.3`)

## Tags in GHCR

- Candidate: `ci-<sha>`
- Final: `vX.Y.Z`
- Final moving tag: `latest`

## Permissions

Required GitHub Actions permissions:
- `contents: read` for CI, `contents: write` for release creation in CD
- `packages: write` for publishing images
- `security-events: write` for SARIF upload

## Troubleshooting

### CD fails: candidate not found

Confirm CI published the matching candidate tag:

```bash
docker buildx imagetools inspect ghcr.io/jasonouellet/devcontainer-base:ci-<sha>
```

### CD blocked by release tag requirement

This is expected: final publication is intentionally blocked without `release_tag`.

## Further Reading

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [GitHub Container Registry Documentation](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry)
- [Docker Buildx](https://docs.docker.com/build/architecture/)
