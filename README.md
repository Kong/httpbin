# Generic Github Repository Template

Generic github repository template that keeps child repositories sync'd

Use this template as a sensible baseline for new github repositories.

## Instructions

- Create template from repository
- From the new repository settings page enable "Automatically delete head branches" as well as "Allow auto-merge"
- From the new repository branches page create branch protection rule for `main` that requires "pre-commit" to pass as well as "Require a pull request before merging"
- Following the [CODEOWNERS SYNTAX](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners#codeowners-syntax) guidelines, update the new repository CODEOWNERS file
- Following our [Github bot guidline documentation](https://konghq.atlassian.net/wiki/spaces/ENGEN/pages/2720268304/How+To+-+Github+Automation+Guidelines) add a github and dependabot secret for AUTO_MERGE_TOKEN
- Open a pull request on the new repository that seeds the secret baseline file `detect-secrets scan > .secrets.baseline` as well as a sensible README.md
- **Update** the .github/template-sync.yml file in [kong/template-generic](https://github.com/Kong/template-generic) repository with the **cloned repository name** to enable template sync changes
