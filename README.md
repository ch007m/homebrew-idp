# Idp

## How to create a new tap repository

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



## How do I install these formulae?

`brew install ch007m/idp/<formula>`

Or `brew tap ch007m/idp` and then `brew install <formula>`.

Or, in a [`brew bundle`](https://github.com/Homebrew/homebrew-bundle) `Brewfile`:

```ruby
tap "ch007m/idp"
brew "<formula>"
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
