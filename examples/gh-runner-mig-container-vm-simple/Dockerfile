# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# Download and verify the integrity of the download first

FROM ubuntu:18.04

RUN apt-get update && \
    apt-get -y install curl \
    iputils-ping \
    tar \
    jq

ARG GH_RUNNER_VERSION="2.169.0"
WORKDIR /runner
RUN curl -o actions.tar.gz --location "https://github.com/actions/runner/releases/download/v${GH_RUNNER_VERSION}/actions-runner-linux-x64-${GH_RUNNER_VERSION}.tar.gz" && \
    tar -zxf actions.tar.gz && \
    rm -f actions.tar.gz && \
    ./bin/installdependencies.sh

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

RUN useradd ghrunner && chown -R ghrunner: /runner
USER ghrunner
ENTRYPOINT ["/runner/entrypoint.sh"]
