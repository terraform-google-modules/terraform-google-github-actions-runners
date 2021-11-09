# Changelog

All notable changes to this project will be documented in this file.

The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).
This changelog is generated automatically based on [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).

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
