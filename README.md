# Idp

## How to create a new tap repository

- Create first a new GitHub repository under your ORG
```
brew tap-new ch007m/idp
Initialized empty Git repository in /opt/homebrew/Library/Taps/ch007m/homebrew-idp/.git/
[main (root-commit) 743bd21] Create ch007m/idp tap
 3 files changed, 97 insertions(+)
 create mode 100644 .github/workflows/publish.yml
 create mode 100644 .github/workflows/tests.yml
 create mode 100644 README.md
==> Created ch007m/idp
/opt/homebrew/Library/Taps/ch007m/homebrew-idp

When a pull request making changes to a formula (or formulae) becomes green
(all checks passed), then you can publish the built bottles.
To do so, label your PR as `pr-pull` and the workflow will be triggered.
```
- Add the formula under the folder `Formula`

## How do I install these formulae?

Tap the repository locally
```shell
brew tap ch007m/idp
```
Install the latest released version
`brew install idp`

A specific version:

`brew install idp@0.8.1`
`brew install idp@0.10.0-nightly.20250317`
