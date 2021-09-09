# Terraform Cloud Sample

This Terraform project generates a full-blown monitoring setup for [Danube webshop](https://danube-webshop.herokuapp.com), including tens of API and Browser checks, alert channels, snippets and more. 

## Usage

After cloning the project, open the terminal and navigate to project root directory.

```bash
$ export TF_VAR_checkly_api_key=<MY_API_KEY>

$ terraform init

$ terraform apply
```

## Contributing

If you want to help us improve monitoring for Danube, feel free to submit a PR.

## License

[MIT](https://github.com/checkly/headless-recorder/blob/master/LICENSE)