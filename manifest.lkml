project_name: "block-stitch-shopify"

################ Constants ################

constant:  CONFIG_PROJECT_NAME {
  value: "block-stitch-shopify-config"
  export:  override_required
}

constant: CONNECTION_NAME {
  value: "shopify_data"
  export: override_required
}

constant: SHOPIFY_SCHEMA_NAME {
  value: "shopify"
  export: override_required
}

################ Dependencies ################

local_dependency: {
  project: "@{CONFIG_PROJECT_NAME}"

  override_constant: SHOPIFY_SCHEMA_NAME {
    value: "@{SHOPIFY_SCHEMA_NAME}"
  }

}
