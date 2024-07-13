# DNS configuration

This repository hosts the infrastructure-as-code definitions for my DNS zones and their records. It uses Terraform with the [AWS provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs) to interface with [Amazon Route 53](https://aws.amazon.com/route53/).

## Getting started

If you’d simply like to view the records within each of my DNS zones, navigate to the [src/zones/](./src/zones/) directory. Each of the files begins with the DNS zone itself, followed by each of the records in an arbitrary (and, as yet, undocumented) order.

You’re also more than welcome to [contribute](#contributing) if you’d like, but please remember that, in simple terms, these records _are_ my online presence, so I might reject your contributions if I feel they might have a detrimental impact.

## Deployment

Changes are deployed to AWS Route 53 automatically when they’re pushed to the `main` branch using a [GitHub Actions workflow](./.github/workflows/deploy.yml).

As long as you’re [logged in to Terraform Cloud](https://developer.hashicorp.com/terraform/tutorials/cloud-get-started/cloud-login) locally, you can also deploy manually by running the following command:

```shell
terraform -chdir=./src apply
```

## Contributing

I intend to work mostly by myself on this project (they are _my_ DNS zones, after all!).

However, if you’d like to contribute code, please open a pull request against this repository. It would be helpful if you could explain not only what you’ve done, but also why, so that I can understand the underlying reasons for your suggestion.

You can also either [create an issue](https://github.com/connordoner/dns/issues) with details of your suggestion or [email me](mailto:hostmaster@connorgurney.me.uk). In any event, please write a descriptive title or subject line, as this helps me to triage suggestions.

All that said, if you’re reporting a security vulnerability, please email me at [security@connorgurney.me.uk](mailto:security@connorgurney.me.uk) instead. This avoids the vulnerability being in the open whilst I work to fix it.

## License

Everything within this repository is licensed under the [GNU General Public License v3.0](./LICENSE.md).
