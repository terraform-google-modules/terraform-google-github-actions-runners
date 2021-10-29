// Copyright 2021 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package oidc_simple

import (
	"fmt"
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestOIDCSimple(t *testing.T) {
	oidc := tft.NewTFBlueprintTest(t)
	oidc.DefineVerify(func(assert *assert.Assertions) {
		oidc.DefaultVerify(assert)

		pool := gcloud.Run(t, fmt.Sprintf("beta iam workload-identity-pools describe %s", oidc.GetStringOutput("pool_name")))
		assert.Equal("ACTIVE", pool.Get("state").String(), "WI pool is active")

		provider := gcloud.Run(t, fmt.Sprintf("beta iam workload-identity-pools providers describe %s", oidc.GetStringOutput("provider_name")))
		assert.Equal("ACTIVE", provider.Get("state").String(), "WI provider is active")
		assert.Equal("https://token.actions.githubusercontent.com", provider.Get("oidc.issuerUri").String(), "provider has correct issuer ID")
		assert.Equal(1, len(provider.Get("oidc.allowedAudiences").Array()), "WI provider has correct number of audiences")
		assert.Equal("sigstore", provider.Get("oidc.allowedAudiences").Array()[0].String(), "WI provider has correct audience")
		expectedAttribMapping := map[string]string{
			"attribute.actor":      "assertion.actor",
			"attribute.aud":        "assertion.aud",
			"attribute.repository": "assertion.repository",
			"google.subject":       "assertion.sub",
		}
		providerMapping := provider.Get("attributeMapping").Map()
		assert.Equal(len(expectedAttribMapping), len(providerMapping), "WI provider has correct number of attribute mapping")
		for k, v := range expectedAttribMapping {
			assert.Equal(v, providerMapping[k].String(), "has correct mapping")
		}

		saBindings := gcloud.Run(t, fmt.Sprintf("iam service-accounts get-iam-policy %s", oidc.GetStringOutput("sa_email"))).Get("bindings").Array()
		assert.Equal(1, len(saBindings), "SA has one binding")
		assert.Equal(1, len(saBindings[0].Get("members").Array()), "SA binding has one member")
		assert.Equal(fmt.Sprintf("principalSet://iam.googleapis.com/%s/attribute.repository/user/repo", oidc.GetStringOutput("pool_name")), saBindings[0].Get("members").Array()[0].String(), "SA binding has correct member")
		assert.Equal("roles/iam.workloadIdentityUser", saBindings[0].Get("role").String(), "SA binding has correct member")

	})

	oidc.Test()
}
