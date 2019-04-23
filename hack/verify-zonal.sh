#!/usr/bin/env bash

# Copyright 2019 Jetstack Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Make the zonal cluster resource definiton from the regional cluster resource
# definition. This helps to keep the two definitions the same, except for the
# presence of the region or zone property.

set -o errexit
set -o nounset
set -o pipefail

mv gke/zonal.tf gke/zonal.tf.git
./hack/make-zonal.sh
DIFF=$(diff gke/zonal.tf gke/zonal.tf.git)
if [ "$DIFF" != "" ]; then
	echo "zonal.tf is out of sync with regional.tf, run make-zonal.sh to generate it again"
	echo "$DIFF"
	exit 1
fi
mv gke/zonal.tf.git gke/zonal.tf
