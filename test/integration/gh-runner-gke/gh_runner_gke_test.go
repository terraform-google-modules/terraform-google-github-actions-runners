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

package gh_runner_gke

import (
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/gruntwork-io/terratest/modules/k8s"
	"github.com/stretchr/testify/assert"
)

func TestGHRunnerGKE(t *testing.T) {
	bpt := tft.NewTFBlueprintTest(t)
	bpt.DefineVerify(func(assert *assert.Assertions) {
		bpt.DefaultVerify(assert)

		// get outputs
		projectId := bpt.GetStringOutput("project_id")
		location := bpt.GetStringOutput("location")
		clusterName := bpt.GetStringOutput("cluster_name")

		// Check cluster is running
		cluster := gcloud.Runf(t, "container clusters describe %s --location %s --project %s", clusterName, location, projectId)
		assert.Contains([]string{"RUNNING"}, cluster.Get("status").String())

		// Get cluster credentials
		gcloud.Runf(t, "container clusters get-credentials %s --location %s --project %s", clusterName, location, projectId)
		k8sOpts := k8s.KubectlOptions{}

		// Check the "runner-k8s-config" secret exists
		secret, err := k8s.RunKubectlAndGetOutputE(t, &k8sOpts, "get", "secret", "runner-k8s-config", "-o", "json")
		if err != nil {
			t.Fatalf("Error getting secret: %s", err)
		}

		assert.NotNil(t, secret, "The secret 'runner-k8s-config' should exist and have data")
	})

	bpt.Test()
}
