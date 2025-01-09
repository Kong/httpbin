target "docker-metadata-action" {}

target "build" {
  inherits = ["docker-metadata-action"]
  context = "./"
  dockerfile = "Dockerfile"
  platforms = ["linux/amd64", "linux/arm64"]
  attest = [
    "type=sbom,generator=docker/scout-sbom-indexer:latest",
    "type=provenance"
  ]
}
