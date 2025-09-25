# R Packages Checklist

## Technical requirements

Our goal is for all R packages under EpiForeSITE to have the following features:

- [ ] Lives on GitHub.
- [ ] Has appropriate [`LICENSE`](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/licensing-a-repository) file (see also [licensing](https://r-pkgs.org/license.html) from R Packages (2e)).
- [ ] Documented with [`roxygen2`](https://roxygen2.r-lib.org) ([Rd2roxygen](https://cran.r-project.org/package=Rd2roxygen) converts `.Rd` files to `roxygen2`), including function descriptions, parameters and return values, details, examples, references, and links to other relevant functions.
- [ ] Includes at least one [`rmarkdown`](https://cran.r-project.org/web/packages/rmarkdown/index.html) vignette with an extended example of package usage
- [ ] Has a website using [pkgdown](https://pkgdown.r-lib.org).
- [ ] Has tests using either [`tinytest`](https://cran.r-project.org/web/packages/tinytest/index.html) or [`testthat`](https://cran.r-project.org/web/packages/testthat/index.html).
- [ ] Uses continuous integration (CI) (e.g., [GitHub Actions](./dev-tools/github-actions.md)) to:
    - [ ] Run `R CMD check` on multiple system configurations.
    - [ ] Create the package website.

## Additional requirements

- [ ] Is listed in [EpiForeSITE/software](https://github.com/EpiForeSITE/software) repository.
- [ ] Lists CDC-CFA award number in the `DESCRIPTION` and `README.md` files.
- [ ] Has a badge pointing back to the [EpiForeSITE/software](https://github.com/EpiForeSITE/software).
- [ ] Has a badge indicating the package's readiness level.

## Advanced Package Checklist

Once the above checklist is completed, there are some additional package features that would be nice to have but are not required:

- [ ] Published on CRAN (see [CRAN's submission checklist](https://cran.r-project.org/web/packages/submission_checklist.html)).
- [ ] Uses [`pre-commit`](https://pre-commit.com) both as part of CI and for local development.
- [ ] Has a [`NEWS.md`](https://style.tidyverse.org/news.html#before-release) file.
- [ ] Has a `Containerfile` under [`.devcontainer`](https://docs.github.com/en/codespaces/setting-up-your-project-for-codespaces/adding-a-dev-container-configuration/introduction-to-dev-containers).
- [ ] Uses [GitHub's release system](https://docs.github.com/en/repositories/releasing-projects-on-github/managing-releases-in-a-repository) to keep the latest version current.
- [ ] Has [branch protection rules](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/managing-a-branch-protection-rule) that prevent direct commits to the principal branch (main or master).
- [ ] Uses `codecov` or `coveralls` to release code coverage (via the [covr R package](https://covr.r-lib.org/reference/codecov.html)).

