# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

```markdown
## [Unreleased] - YYYY-MM-DD

### Added
### Changed
### Deprecated
### Fixed
### Security
```

## [Unreleased] - YYYY-MM-DD

### Added
- Created tests for the makefile work directory variables.
### Changed
- Updated the usage of bowerbird::git-dependency to no longer need the pattern
  `$(eval $(call ... ))` and can instead simply use `$(call ...)`.
### Deprecated
### Fixed
- Wrapped the git-dependency command in an `ifdef` to avoid undefined variable warning
  during recursive make.
- Restored the print directory flag to assist with debug.
- Restored verbosity to the git-dependency clone command to to assist with debug.
- Fixed minor typos in the macro descriptions.
- Improved the testing to make sure that expected files are generated from the commands
  and not just old files from previous runs.
### Security


## [0.3.0] - 2024-06-07

### Added
- Updated make flags to include warnings for undefined variables.
- Added documentation strings for the `bowerbird::git-dependency` macro.
### Changed
- The first argument of the `bowerbird::git-dependency` macro changed from an ID to the
  installation path.
- Updated the internal test comparison calls to the new `compare-strings`.
- The clean target now
### Fixed
- Fixed variables references in macros that cause undefined variable errors in repos
  that use bowerbird-test.
- Fixed missing arguments in `bowerbird::deps::define-dependency-constants` tests that
  were causing undefined variable errors.
- Created an additional test for checking whether git history is deleted after a
  successful shallow clone of the dependency repo.
- Created an additional test for checking whether an error is raised when attempting to
  install a dependency into a previously used path.


## [0.2.0] - 2024-06-03

### Changed
- Corrected the usage code snipped to work after direct copy and paste and to generate
  errors if the download fails.
- Added additional checks to the path variables before deleting the `.git` directory
  from the cloned dependency repos.
- Changed the names of the internally used dependency constants.
- Updated the tests to use the bowerbird test runner.
- Added an error message when dependency cannot be cloned.
- Updated the SHA in the readme usage example.


## [0.1.0] - 2024-05-31

### Added
- Created a README with usage example.
- Migrated the bash build recipes to a separate repo.
