# Changelog

All notable changes to this project will be documented in this file.

The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).
This changelog is generated automatically based on [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).

## [3.1.2](https://github.com/terraform-google-modules/terraform-google-github-actions-runners/compare/v3.1.1...v3.1.2) (2023-10-10)


### Bug Fixes

* upgraded versions.tf to include minor bumps from tpg v5 ([#124](https://github.com/terraform-google-modules/terraform-google-github-actions-runners/issues/124)) ([ede4426](https://github.com/terraform-google-modules/terraform-google-github-actions-runners/commit/ede4426a9268ad50524d3b0d23cb1dbf52ab99d3))

## [3.1.1](https://github.com/terraform-google-modules/terraform-google-github-actions-runners/compare/v3.1.0...v3.1.1) (2022-12-29)


### Bug Fixes

* **deps:** update terraform terraform-google-modules/kubernetes-engine/google to v24 ([#85](https://github.com/terraform-google-modules/terraform-google-github-actions-runners/issues/85)) ([980e5d5](https://github.com/terraform-google-modules/terraform-google-github-actions-runners/commit/980e5d50cd89ed0e84f120e0e263bd9700ffa3ca))
* fixes lint issues and generates metadata ([#89](https://github.com/terraform-google-modules/terraform-google-github-actions-runners/issues/89)) ([935368c](https://github.com/terraform-google-modules/terraform-google-github-actions-runners/commit/935368cf54df02eba97596bc21226c63bca2bf4c))

## [3.1.0](https://github.com/terraform-google-modules/terraform-google-github-actions-runners/compare/v3.0.0...v3.1.0) (2022-07-20)


### Features

* Issuer URI has been passed through variable ([#62](https://github.com/terraform-google-modules/terraform-google-github-actions-runners/issues/62)) ([c9da327](https://github.com/terraform-google-modules/terraform-google-github-actions-runners/commit/c9da3279e9af3e195f3ad089efdfb425b8e9032f))

## [3.0.0](https://github.com/terraform-google-modules/terraform-google-github-actions-runners/compare/v2.0.1...v3.0.0) (2022-02-02)


### ⚠ BREAKING CHANGES

* update examples, bump gke module version ([#52](https://github.com/terraform-google-modules/terraform-google-github-actions-runners/issues/52)). `gh-runner-gke` now uses [v19](https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/releases/tag/v19.0.0) of the GKE module. Please refer to the [GKE module upgrade guide](https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/blob/master/docs/upgrading_to_v19.0.md) for more details.

### Features

* Update TPG version constraints to allow 4.0 ([#50](https://github.com/terraform-google-modules/terraform-google-github-actions-runners/issues/50)) ([1aebd31](https://github.com/terraform-google-modules/terraform-google-github-actions-runners/commit/1aebd31f0548374ac061a58cdca7bc98e51eb760))


### Bug Fixes

* update examples, bump gke module version ([#52](https://github.com/terraform-google-modules/terraform-google-github-actions-runners/issues/52)) ([882578e](https://github.com/terraform-google-modules/terraform-google-github-actions-runners/commit/882578e59bf2f5a808abd63ed5dcc74524aa30fa))

### [2.0.1](https://www.github.com/terraform-google-modules/terraform-google-github-actions-runners/compare/v2.0.0...v2.0.1) (2021-11-26)


### Bug Fixes

* bump minimum provider version for gh oidc module ([#45](https://www.github.com/terraform-google-modules/terraform-google-github-actions-runners/issues/45)) ([204a546](https://www.github.com/terraform-google-modules/terraform-google-github-actions-runners/commit/204a5463a48237fbd2bf118459db7dbb7742bb8a))

## [2.0.0](https://www.github.com/terraform-google-modules/terraform-google-github-actions-runners/compare/v1.1.0...v2.0.0) (2021-11-09)


### ⚠ BREAKING CHANGES

* Remove the default allowed audience in `gh-oidc` (#42)
* update issuer_uri for gh provider (#36)
* Support org runners, update images and autoscaling config (#34)

### Features

* Add example for org runner & update shutdown script ([#37](https://www.github.com/terraform-google-modules/terraform-google-github-actions-runners/issues/37)) ([76115f9](https://www.github.com/terraform-google-modules/terraform-google-github-actions-runners/commit/76115f9587a048de26086116d6e3a3eb0ae6aa2c))
* Remove the default allowed audience in `gh-oidc` ([#42](https://www.github.com/terraform-google-modules/terraform-google-github-actions-runners/issues/42)) ([1ec0ec2](https://www.github.com/terraform-google-modules/terraform-google-github-actions-runners/commit/1ec0ec201a6a063d27fea8fd62e6a028fb9fc5e6))
* Support org runners, update images and autoscaling config ([#34](https://www.github.com/terraform-google-modules/terraform-google-github-actions-runners/issues/34)) ([280ca8a](https://www.github.com/terraform-google-modules/terraform-google-github-actions-runners/commit/280ca8a79266d00d6ec8fe84413de0d23cbdc791))
* update issuer_uri for gh provider ([#36](https://www.github.com/terraform-google-modules/terraform-google-github-actions-runners/issues/36)) ([2ca3e6c](https://www.github.com/terraform-google-modules/terraform-google-github-actions-runners/commit/2ca3e6c4ea2a9987f8c5ac6191bbe925df4dd12b))

## [1.1.0](https://www.github.com/terraform-google-modules/terraform-google-github-actions-runners/compare/v1.0.1...v1.1.0) (2021-09-20)


### Features

* add gh oidc module ([#32](https://www.github.com/terraform-google-modules/terraform-google-github-actions-runners/issues/32)) ([1f10847](https://www.github.com/terraform-google-modules/terraform-google-github-actions-runners/commit/1f10847dc69246166bd68a3149d2fefb5a43bf3b))

### [1.0.1](https://www.github.com/terraform-google-modules/terraform-google-github-actions-runners/compare/v1.0.0...v1.0.1) (2021-08-17)


### Bug Fixes

* Switched to use google_project_iam_member, which is non-authoritative ([#27](https://www.github.com/terraform-google-modules/terraform-google-github-actions-runners/issues/27)) ([281a737](https://www.github.com/terraform-google-modules/terraform-google-github-actions-runners/commit/281a737a59046735577178052f584c3c9749239b))
* use machine_type in mig-runner ([#30](https://www.github.com/terraform-google-modules/terraform-google-github-actions-runners/issues/30)) ([4f940f6](https://www.github.com/terraform-google-modules/terraform-google-github-actions-runners/commit/4f940f69a4bad949213250ba3b42ae905da5d2ca))

## [1.0.0](https://www.github.com/terraform-google-modules/terraform-google-github-actions-runners/compare/v0.1.0...v1.0.0) (2021-04-24)


### ⚠ BREAKING CHANGES

* add Terraform 0.13 constraint and module attribution (#22)

### Features

* add Terraform 0.13 constraint and module attribution ([#22](https://www.github.com/terraform-google-modules/terraform-google-github-actions-runners/issues/22)) ([11d7179](https://www.github.com/terraform-google-modules/terraform-google-github-actions-runners/commit/11d7179773abf41e1f4a101dd729edaf1773929a))

## 0.1.0 (2020-11-24)


### Features

* add network project for svpc, expose cooldown period, default scripts ([#15](https://www.github.com/terraform-google-modules/terraform-google-github-actions-runners/issues/15)) ([048156a](https://www.github.com/terraform-google-modules/terraform-google-github-actions-runners/commit/048156ae1708ccef39d36be55270048153fc8081))
* remove api enablement and update docs ([#13](https://www.github.com/terraform-google-modules/terraform-google-github-actions-runners/issues/13)) ([5c01d64](https://www.github.com/terraform-google-modules/terraform-google-github-actions-runners/commit/5c01d64fdb47e84aa8bbe082f2af80669a0fcc32))

## [0.1.0](https://github.com/terraform-google-modules/terraform-google-terraform-google-github-actions-runners/releases/tag/v0.1.0) - 20XX-YY-ZZ

### Features

- Initial release

[0.1.0]: https://github.com/terraform-google-modules/terraform-google-terraform-google-github-actions-runners/releases/tag/v0.1.0
