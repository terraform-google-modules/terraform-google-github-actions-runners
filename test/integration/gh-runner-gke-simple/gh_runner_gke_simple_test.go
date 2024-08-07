// Copyright 2024 Google LLC
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

package gh_runner_gke_simple

import (
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/gruntwork-io/terratest/modules/k8s"
	"github.com/stretchr/testify/assert"
	"github.com/tidwall/gjson"
)

func TestGhRunnerGkeSimple(t *testing.T) {
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

		CheckPodsRunningInNamespace("arc-systems", t, k8sOpts, assert)
		CheckPodsRunningInNamespace("arc-runners", t, k8sOpts, assert)
	})

	bpt.Test()
}

func CheckPodsRunningInNamespace(namespace string, t *testing.T, k8sOpts k8s.KubectlOptions, assert *assert.Assertions) {
	pods, err := k8s.RunKubectlAndGetOutputE(t, &k8sOpts, "get", "pods", "-n", namespace, "-o", "json")

	if err != nil {
		t.Fatalf("Error getting pods: %s", err)
	}

	statuses := gjson.Get(pods, "items.#.status.phase")

	for _, status := range statuses.Array() {
		assert.Equal("Running", status.String())
	}
}
