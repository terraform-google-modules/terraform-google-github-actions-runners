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

package gh_runner_mig_container_vm

import (
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/gcloud"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestGHRunnerMIGContainerVM(t *testing.T) {
	bpt := tft.NewTFBlueprintTest(t)
	bpt.DefineVerify(func(assert *assert.Assertions) {
		bpt.DefaultVerify(assert)

		// get outputs
		projectId := bpt.GetStringOutput("project_id")
		migName := bpt.GetStringOutput("mig_name")
		migInstanceTemplateName := bpt.GetStringOutput("mig_instance_template")

		// Check mig exists
		mig := gcloud.Runf(t, "compute instances list --project %s --filter='%s'", projectId, migName)
		assert.NotNil(t, mig)

		// Check IT exists
		it := gcloud.Runf(t, "compute instance-templates list --project %s --filter='%s'", projectId, migInstanceTemplateName)
		assert.NotNil(t, it)
	})

	bpt.Test()
}
