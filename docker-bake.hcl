group "linux" {
  targets = [
    "alpine_jdk17",
    "alpine_jdk11",
    "debian_jdk11",
    "debian_jdk17",
  ]
}

group "linux-arm64" {
  targets = [
    "debian_jdk11",
    "debian_jdk17",
  ]
}

group "linux-s390x" {
  targets = [
    "debian_jdk11",
  ]
}

group "linux-ppc64le" {
  targets = [
    "debian_jdk11",
    "debian_jdk17",
  ]
}

variable "REGISTRY" {
  default = "docker.io"
}

variable "JENKINS_REPO" {
  default = "jenkins/ssh-agent"
}

variable "ON_TAG" {
  default = "false"
}

variable "VERSION" {
  default = ""
}

variable "JAVA11_VERSION" {
  default = "11.0.19_7"
}

variable "JAVA17_VERSION" {
  default = "17.0.7_7"
}

target "alpine_jdk17" {
  dockerfile = "alpine/Dockerfile"
  context = "."
  args = {
    JAVA_VERSION = JAVA17_VERSION
  }
  tags = [
    equal(ON_TAG, "true") ? "${REGISTRY}/${JENKINS_REPO}:${VERSION}-alpine-jdk17": "",
    "${REGISTRY}/${JENKINS_REPO}:alpine-jdk17",
    "${REGISTRY}/${JENKINS_REPO}:latest-alpine-jdk17",
  ]
  platforms = ["linux/amd64"]
}

target "alpine_jdk11" {
  dockerfile = "alpine/Dockerfile"
  context = "."
  args = {
    JAVA_VERSION = JAVA11_VERSION
  }
  tags = [
    equal(ON_TAG, "true") ? "${REGISTRY}/${JENKINS_REPO}:${VERSION}-alpine-jdk11": "",
    "${REGISTRY}/${JENKINS_REPO}:alpine",
    "${REGISTRY}/${JENKINS_REPO}:alpine-jdk11",
    "${REGISTRY}/${JENKINS_REPO}:latest-alpine-jdk11",
  ]
  platforms = ["linux/amd64"]
}

target "debian_jdk11" {
  dockerfile = "debian/Dockerfile"
  context = "."
  args = {
    JAVA_VERSION = JAVA11_VERSION
  }
  tags = [
    equal(ON_TAG, "true") ? "${REGISTRY}/${JENKINS_REPO}:${VERSION}": "",
    equal(ON_TAG, "true") ? "${REGISTRY}/${JENKINS_REPO}:${VERSION}-jdk11": "",
    "${REGISTRY}/${JENKINS_REPO}:bullseye-jdk11",
    "${REGISTRY}/${JENKINS_REPO}:debian-jdk11",
    "${REGISTRY}/${JENKINS_REPO}:jdk11",
    "${REGISTRY}/${JENKINS_REPO}:latest",
    "${REGISTRY}/${JENKINS_REPO}:latest-bullseye-jdk11",
    "${REGISTRY}/${JENKINS_REPO}:latest-debian-jdk11",
    "${REGISTRY}/${JENKINS_REPO}:latest-jdk11",
  ]
  platforms = ["linux/amd64", "linux/arm64", "linux/s390x", "linux/ppc64le"]
}

target "debian_jdk17" {
  dockerfile = "debian/Dockerfile"
  context = "."
  args = {
    JAVA_VERSION = JAVA17_VERSION
  }
  tags = [
    equal(ON_TAG, "true") ? "${REGISTRY}/${JENKINS_REPO}:${VERSION}-jdk17": "",
    "${REGISTRY}/${JENKINS_REPO}:bullseye-jdk17",
    "${REGISTRY}/${JENKINS_REPO}:debian-jdk17",
    "${REGISTRY}/${JENKINS_REPO}:jdk17",
    "${REGISTRY}/${JENKINS_REPO}:latest-bullseye-jdk17",
    "${REGISTRY}/${JENKINS_REPO}:latest-debian-jdk17",
    "${REGISTRY}/${JENKINS_REPO}:latest-jdk17",
  ]
  platforms = ["linux/amd64", "linux/arm64", "linux/ppc64le"]
}
