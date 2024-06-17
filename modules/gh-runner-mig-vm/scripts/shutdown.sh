#!/bin/bash
# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

generate_gha_jwt () {
  ####################
  # Generate JWT token
  # Doc: https://docs.github.com/en/apps/creating-github-apps/authenticating-with-a-github-app/generating-a-json-web-token-jwt-for-a-github-app
  ####################
  
  client_id="$GHA_CLIENT_ID" # Client ID as first argument
  
  pem=$(echo -n "$GHA_PRIVATE_KEY" | base64 --decode) # file path of the private key as second argument
  
  now=$(date +%s)
  iat=$((now - 60)) # Issues 60 seconds in the past
  exp=$((now + 600)) # Expires 10 minutes in the future
  
  #b64enc() { tr -d '\n' | tr -d '\r' | base64 | tr '+/' '-_' | tr -d '='; }
  b64enc() { openssl base64 | tr -d '=' | tr '/+' '_-' | tr -d '\n'; }
  
  header_json='{
      "typ":"JWT",
      "alg":"RS256"
  }'
  # Header encode
  header=$( echo -n "${header_json}" | b64enc )
  
  payload_json='{
      "iat":'"${iat}"',
      "exp":'"${exp}"',
      "iss":"'"${client_id}"'"
  }'
  # Payload encode
  payload=$( echo -n "${payload_json}" | b64enc )
  
  # Signature
  header_payload="${header}"."${payload}"
  signature=$(
      openssl dgst -sha256 -sign <(echo -n "${pem}") \
      <(echo -n "${header_payload}") | b64enc
  )
  
  # Create JWT
  JWT="${header_payload}"."${signature}"
  
  #printf "%s\n" "$JWT"
}


secretUri=$(curl -sS "http://metadata.google.internal/computeMetadata/v1/instance/attributes/secret-id" -H "Metadata-Flavor: Google")
#secrets URI is of the form projects/$PROJECT_NUMBER/secrets/$SECRET_NAME/versions/$SECRET_VERSION
#split into array based on `/` delimeter
IFS="/" read -r -a secretsConfig <<<"$secretUri"
#get SECRET_NAME and SECRET_VERSION
SECRET_NAME=${secretsConfig[3]}
SECRET_VERSION=${secretsConfig[5]}
#access secret from secretsmanager
secrets=$(gcloud secrets versions access "$SECRET_VERSION" --secret="$SECRET_NAME")
#set secrets as env vars
# shellcheck disable=SC2046
# we want to use wordsplitting
export $(echo "$secrets" | jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]")
#stop and uninstall the runner service
cd /runner || exit
./svc.sh stop
./svc.sh uninstall
if [[ -z $REPO_NAME ]]; then
    # Remove action runner from the organisation
    POST_URL="https://api.github.com/orgs/${REPO_OWNER}/actions/runners/remove-token"
else
    # Remove action runner from the repo
    POST_URL="https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/actions/runners/remove-token"
fi

#only execute when client_id and private_key are not empty
#use as check to see if we want to use github app for authentication
#because we are overwriting the GITHUB_TOKEN variable
if [[ -n $GHA_CLIENT_ID ]] && [[ -n $GHA_PRIVATE_KEY ]]; then
    generate_gha_jwt

    #Get access token
    #Docs: https://docs.github.com/en/apps/creating-github-apps/authenticating-with-a-github-app/generating-an-installation-access-token-for-a-github-app
    GITHUB_TOKEN=$(curl --request POST \
    --url "https://api.github.com/app/installations/${GHA_INSTALLATION_ID}/access_tokens" \
    --header "Accept: application/vnd.github+json" \
    --header "Authorization: Bearer ${JWT}" \
    --header "X-GitHub-Api-Version: 2022-11-28" | jq -r .token)
fi

#remove the runner configuration
RUNNER_ALLOW_RUNASROOT=1 /runner/config.sh remove --unattended --token "$(curl -sS --request POST --url "$POST_URL" --header "authorization: Bearer ${GITHUB_TOKEN}" --header "content-type: application/json" | jq -r .token)"
