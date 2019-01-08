<!-- This file was automatically generated by the `build-harness`. Make all changes to `README.yaml` and run `make readme` to rebuild this file. -->
[![README Header][readme_header_img]][readme_header_link]

[![Cloud Posse][logo]](https://cpco.io/homepage)

# Helmfiles [![Codefresh Build Status](https://g.codefresh.io/api/badges/build?repoOwner=cloudposse&repoName=helmfiles&branch=master&pipelineName=helmfiles&accountName=cloudposse&type=cf-1)](https://g.codefresh.io/pipelines/helmfiles/builds) [![Latest Release](https://img.shields.io/github/release/cloudposse/helmfiles.svg)](https://github.com/cloudposse/helmfiles/releases/latest) [![Slack Community](https://slack.cloudposse.com/badge.svg)](https://slack.cloudposse.com)


Helmfiles is a comprehensive distribution of declarative [`helm`](https://helm.sh/) chart invocations. It makes it really easy to get up and running with a full stack of fully integrated apps for Kubernetes using [`helmfile`](https://github.com/roboll/helmfile). It's also compatible with `releases`. 

Pull Requests are welcome!


---

This project is part of our comprehensive ["SweetOps"](https://cpco.io/sweetops) approach towards DevOps. 
[<img align="right" title="Share via Email" src="https://docs.cloudposse.com/images/ionicons/ios-email-outline-2.0.1-16x16-999999.svg"/>][share_email]
[<img align="right" title="Share on Google+" src="https://docs.cloudposse.com/images/ionicons/social-googleplus-outline-2.0.1-16x16-999999.svg" />][share_googleplus]
[<img align="right" title="Share on Facebook" src="https://docs.cloudposse.com/images/ionicons/social-facebook-outline-2.0.1-16x16-999999.svg" />][share_facebook]
[<img align="right" title="Share on Reddit" src="https://docs.cloudposse.com/images/ionicons/social-reddit-outline-2.0.1-16x16-999999.svg" />][share_reddit]
[<img align="right" title="Share on LinkedIn" src="https://docs.cloudposse.com/images/ionicons/social-linkedin-outline-2.0.1-16x16-999999.svg" />][share_linkedin]
[<img align="right" title="Share on Twitter" src="https://docs.cloudposse.com/images/ionicons/social-twitter-outline-2.0.1-16x16-999999.svg" />][share_twitter]




It's 100% Open Source and licensed under the [APACHE2](LICENSE).













## Usage


Install the latest release of `helmfile` from the [helmfile releases](https://github.com/roboll/helmfile/releases) page.

Alternatively, we also distribute `helmfile` as an [alpine package](https://github.com/cloudposse/packages).

Add the cloudposse alpine repository.

```
# Install the cloudposse alpine repository
ADD https://apk.cloudposse.com/ops@cloudposse.com.rsa.pub /etc/apk/keys/
RUN echo "@cloudposse https://apk.cloudposse.com/3.8/vendor" >> /etc/apk/repositories
```

Install `helmfile` from the repository.

```
RUN apk add helmfile
```


### Docker

We distribute a docker image with all helmfiles. Use a multi-stage build to include them.

```
FROM cloudposse/helmfiles:latest as helmfiles

COPY --from helmfiles /releases/ /conf/releases/
```

**IMPORTANT:** we recommend pinning `cloudposse/helmfiles` to a specific release rather than using `latest`

### Git

```
git clone git@github.com:cloudposse/helmfiles.git
```

### Configuration

Define a `helmfile.yaml` which includes the releases you wish to support. Specify all releases in the order in which they should get installed.

Here's an example of a [`helmfile.yaml`](helmfile.yaml):

```
# Ordered list of releases. 
helmfiles:
  - "releases/prometheus-operator.yaml"
  - "releases/cluster-autoscaler.yaml"
  - "releases/kiam.yaml"
  - "releases/external-dns.yaml"
  - "releases/kube-lego.yaml"
  - "releases/nginx-ingress.yaml"
  - "releases/kube-prometheus.yaml"
  - "releases/grafana.yaml"
  - "releases/heapster.yaml"
  - "releases/dashboard.yaml"
  - "releases/portal.yaml"
```








## Share the Love 

Like this project? Please give it a ★ on [our GitHub](https://github.com/cloudposse/helmfiles)! (it helps us **a lot**) 

Are you using this project or any of our other projects? Consider [leaving a testimonial][testimonial]. =)


## Related Projects

Check out these related projects.

- [Geodesic](https://github.com/cloudposse/geodesic) - Geodesic is the fastest way to get up and running with a rock solid, production grade cloud platform built on strictly Open Source tools.
- [Packages](https://github.com/cloudposse/packages) - Cloud Posse installer and distribution of native apps
- [Terraform Root Modules](https://github.com/cloudposse/terraform-root-modules) - Collection of Terraform root module invocations for provisioning reference architectures
- [Build Harness](https://github.com/cloudposse/build-harness) - Collection of Makefiles to facilitate building Golang projects, Dockerfiles, Helm charts, and more
- [Chamber](https://docs.cloudposse.com/tools/chamber/) - a CRUD tool for managing secrets stored in AWS Systems Manager Parameter Store and exposing those secrets as Environment Variables to processes.




## References

For additional context, refer to some of these links. 

- [helmfile](https://github.com/roboll/helmfile) - Helmfile is a declarative configuration for deploying distributions of helm charts
- [helm](https://helm.sh/) - The package manager for Kubernetes
- [docs](https://docs.cloudposse.com/tools/helmfile/) - Documentation for how we use helmfile


## Help

**Got a question?**

File a GitHub [issue](https://github.com/cloudposse/helmfiles/issues), send us an [email][email] or join our [Slack Community][slack].

[![README Commercial Support][readme_commercial_support_img]][readme_commercial_support_link]

## Commercial Support

Work directly with our team of DevOps experts via email, slack, and video conferencing. 

We provide [*commercial support*][commercial_support] for all of our [Open Source][github] projects. As a *Dedicated Support* customer, you have access to our team of subject matter experts at a fraction of the cost of a full-time engineer. 

[![E-Mail](https://img.shields.io/badge/email-hello@cloudposse.com-blue.svg)][email]

- **Questions.** We'll use a Shared Slack channel between your team and ours.
- **Troubleshooting.** We'll help you triage why things aren't working.
- **Code Reviews.** We'll review your Pull Requests and provide constructive feedback.
- **Bug Fixes.** We'll rapidly work to fix any bugs in our projects.
- **Build New Terraform Modules.** We'll [develop original modules][module_development] to provision infrastructure.
- **Cloud Architecture.** We'll assist with your cloud strategy and design.
- **Implementation.** We'll provide hands-on support to implement our reference architectures. 




## Slack Community

Join our [Open Source Community][slack] on Slack. It's **FREE** for everyone! Our "SweetOps" community is where you get to talk with others who share a similar vision for how to rollout and manage infrastructure. This is the best place to talk shop, ask questions, solicit feedback, and work together as a community to build totally *sweet* infrastructure.

## Newsletter

Signup for [our newsletter][newsletter] that covers everything on our technology radar.  Receive updates on what we're up to on GitHub as well as awesome new projects we discover. 

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/cloudposse/helmfiles/issues) to report any bugs or file feature requests.

### Developing

If you are interested in being a contributor and want to get involved in developing this project or [help out](https://cpco.io/help-out) with our other projects, we would love to hear from you! Shoot us an [email][email].

In general, PRs are welcome. We follow the typical "fork-and-pull" Git workflow.

 1. **Fork** the repo on GitHub
 2. **Clone** the project to your own machine
 3. **Commit** changes to your own branch
 4. **Push** your work back up to your fork
 5. Submit a **Pull Request** so that we can review your changes

**NOTE:** Be sure to merge the latest changes from "upstream" before making a pull request!


## Copyright

Copyright © 2017-2019 [Cloud Posse, LLC](https://cpco.io/copyright)



## License 

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) 

See [LICENSE](LICENSE) for full details.

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.









## Trademarks

All other trademarks referenced herein are the property of their respective owners.

## About

This project is maintained and funded by [Cloud Posse, LLC][website]. Like it? Please let us know by [leaving a testimonial][testimonial]!

[![Cloud Posse][logo]][website]

We're a [DevOps Professional Services][hire] company based in Los Angeles, CA. We ❤️  [Open Source Software][we_love_open_source].

We offer [paid support][commercial_support] on all of our projects.  

Check out [our other projects][github], [follow us on twitter][twitter], [apply for a job][jobs], or [hire us][hire] to help with your cloud strategy and implementation.



### Contributors

|  [![Erik Osterman][osterman_avatar]][osterman_homepage]<br/>[Erik Osterman][osterman_homepage] | [![Igor Rodionov][goruha_avatar]][goruha_homepage]<br/>[Igor Rodionov][goruha_homepage] | [![Andriy Knysh][aknysh_avatar]][aknysh_homepage]<br/>[Andriy Knysh][aknysh_homepage] |
|---|---|---|


  [osterman_homepage]: https://github.com/osterman
  [osterman_avatar]: http://s.gravatar.com/avatar/88c480d4f73b813904e00a5695a454cb?s=144


  [goruha_homepage]: https://github.com/goruha/
  [goruha_avatar]: http://s.gravatar.com/avatar/bc70834d32ed4517568a1feb0b9be7e2?s=144


  [aknysh_homepage]: https://github.com/aknysh/
  [aknysh_avatar]: https://avatars0.githubusercontent.com/u/7356997?v=4&u=ed9ce1c9151d552d985bdf5546772e14ef7ab617&s=144




[![README Footer][readme_footer_img]][readme_footer_link]
[![Beacon][beacon]][website]

  [logo]: https://cloudposse.com/logo-300x69.svg
  [docs]: https://cpco.io/docs
  [website]: https://cpco.io/homepage
  [github]: https://cpco.io/github
  [jobs]: https://cpco.io/jobs
  [hire]: https://cpco.io/hire
  [slack]: https://cpco.io/slack
  [linkedin]: https://cpco.io/linkedin
  [twitter]: https://cpco.io/twitter
  [testimonial]: https://cpco.io/leave-testimonial
  [newsletter]: https://cpco.io/newsletter
  [email]: https://cpco.io/email
  [commercial_support]: https://cpco.io/commercial-support
  [we_love_open_source]: https://cpco.io/we-love-open-source
  [module_development]: https://cpco.io/module-development
  [terraform_modules]: https://cpco.io/terraform-modules
  [readme_header_img]: https://cloudposse.com/readme/header/img?repo=cloudposse/helmfiles
  [readme_header_link]: https://cloudposse.com/readme/header/link?repo=cloudposse/helmfiles
  [readme_footer_img]: https://cloudposse.com/readme/footer/img?repo=cloudposse/helmfiles
  [readme_footer_link]: https://cloudposse.com/readme/footer/link?repo=cloudposse/helmfiles
  [readme_commercial_support_img]: https://cloudposse.com/readme/commercial-support/img?repo=cloudposse/helmfiles
  [readme_commercial_support_link]: https://cloudposse.com/readme/commercial-support/link?repo=cloudposse/helmfiles
  [share_twitter]: https://twitter.com/intent/tweet/?text=Helmfiles&url=https://github.com/cloudposse/helmfiles
  [share_linkedin]: https://www.linkedin.com/shareArticle?mini=true&title=Helmfiles&url=https://github.com/cloudposse/helmfiles
  [share_reddit]: https://reddit.com/submit/?url=https://github.com/cloudposse/helmfiles
  [share_facebook]: https://facebook.com/sharer/sharer.php?u=https://github.com/cloudposse/helmfiles
  [share_googleplus]: https://plus.google.com/share?url=https://github.com/cloudposse/helmfiles
  [share_email]: mailto:?subject=Helmfiles&body=https://github.com/cloudposse/helmfiles
  [beacon]: https://ga-beacon.cloudposse.com/UA-76589703-4/cloudposse/helmfiles?pixel&cs=github&cm=readme&an=helmfiles
