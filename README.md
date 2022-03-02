# Terraform Cloud Sample

This Terraform project generates a full-blown monitoring setup for [Danube webshop](https://danube-webshop.herokuapp.com), including tens of API and Browser checks, alert channels, snippets and more. 

## Usage

After cloning the project, open the terminal and navigate to project root directory.

You will need to export your [Checkly User API key](https://www.checklyhq.com/docs/accounts-and-users/creating-api-key/) and your [Checkly Account ID](https://app.checklyhq.com/settings/account/general) as Terraform environment variables.

```bash
$ export TF_VAR_checkly_api_key=<MY_API_KEY>
$ export TF_VAR_checkly_account_id=<MY_ACCOUNT_ID>
```

Next, initialise the project and apply your terraform config:


```bash
$ terraform init
$ terraform apply
```

## Contributing

If you want to help us improve monitoring for Danube, feel free to submit a PR.

## License

[MIT](https://github.com/checkly/headless-recorder/blob/master/LICENSE)