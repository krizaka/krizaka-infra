# The production document store of Yomizaka (krizaka/yomizaka#524, ADR-005 slice 6): one private, versioned Spaces bucket in
# Toronto (tor1) and one key limited to it. NEW infrastructure: nothing to import, a first `tofu plan` creates three resources.
# The provider is then added in Yomizaka's admin storage screen (endpoint, region and key from the outputs), tested, and set as
# the default of the documents (yomizaka docs/privacy/production-store-canada.md).
module "documents" {
  source = "../../../modules/object-storage"
  name   = "yomizaka-documents-prod"
  region = "tor1"
}

module "documents_digitalocean" {
  source = "../../../providers/digitalocean/object-storage"
  bucket = module.documents.spec
}
