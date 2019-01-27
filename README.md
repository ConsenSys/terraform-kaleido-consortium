# terraform-kaleido-consortium
Terraform module which creates consortium resources on Kaleido

## Usage

```hcl
module "consortium" {
  source = "ConsenSys/terraform-kaleido-consortium"

  name = "my-consortium"

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
```