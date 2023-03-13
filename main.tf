variable "checkly_api_key" {}
variable "checkly_account_id" {}

terraform {
  required_providers {
    checkly = {
      source  = "checkly/checkly"
      version = "1.6.4"
    }
  }
}

provider "checkly" {
  api_key    = var.checkly_api_key
  account_id = var.checkly_account_id
}

resource "checkly_check_group" "key-shop-flows" {
  name      = "Key Shop Flows"
  activated = true
  muted     = false

  locations = [
    "eu-west-1",
    "eu-central-1"
  ]

  concurrency               = 2
  double_check              = true
  use_global_alert_settings = false

  environment_variable {
    key   = "key1"
    value = "value 1"
  }

  environment_variable {
    key    = "key2"
    value  = "value 2"
    locked = true
  }
}

resource "checkly_check" "browser-check" {
  for_each = fileset("${path.module}/scripts", "*")

  name                      = each.key
  type                      = "BROWSER"
  activated                 = true
  should_fail               = false
  frequency                 = 10
  double_check              = true
  use_global_alert_settings = true
  locations = [
    "us-west-1",
    "eu-central-1"
  ]

  script   = file("${path.module}/scripts/${each.key}")
  group_id = checkly_check_group.key-shop-flows.id

}

resource "checkly_check_group" "e2e-scenarios" {
  name      = "E2E Scenarios"
  activated = true
  muted     = false

  locations = [
    "eu-west-1",
    "eu-central-1"
  ]

  concurrency               = 2
  double_check              = true
  use_global_alert_settings = false

}

resource "checkly_check" "browser-check-demo" {
  for_each = fileset("${path.module}/demo-scripts", "*")

  name                      = each.key
  type                      = "BROWSER"
  activated                 = true
  should_fail               = false
  frequency                 = 30
  double_check              = true
  use_global_alert_settings = true
  locations = [
    "us-west-1",
    "eu-central-1"
  ]

  script   = file("${path.module}/demo-scripts/${each.key}")
  group_id = checkly_check_group.e2e-scenarios.id

}

resource "checkly_check" "get-users" {
  name                      = "GET users"
  type                      = "API"
  activated                 = true
  should_fail               = false
  frequency                 = 1
  double_check              = true
  use_global_alert_settings = true
  degraded_response_time    = 5000
  max_response_time         = 10000

  locations = [
    "eu-central-1",
    "us-west-1"
  ]

  group_id = checkly_check_group.users-api.id

  request {
    url              = "https://danube-webshop.herokuapp.com/api/books"
    follow_redirects = true
    assertion {
      source     = "STATUS_CODE"
      comparison = "EQUALS"
      target     = "200"
    }
    assertion {
      source     = "JSON_BODY"
      property   = "$.length"
      comparison = "EQUALS"
      target     = "30"
    }
  }
}

resource "checkly_check" "post-user" {
  name                      = "POST user"
  type                      = "API"
  activated                 = true
  should_fail               = false
  frequency                 = 10
  double_check              = true
  use_global_alert_settings = true
  degraded_response_time    = 5000
  max_response_time         = 10000

  locations = [
    "eu-central-1",
    "us-west-1"
  ]

  group_id = checkly_check_group.users-api.id

  request {
    url              = "https://danube-webshop.herokuapp.com/api/books"
    follow_redirects = true
    assertion {
      source     = "STATUS_CODE"
      comparison = "EQUALS"
      target     = "200"
    }
    assertion {
      source     = "JSON_BODY"
      property   = "$.length"
      comparison = "EQUALS"
      target     = "30"
    }
  }
}

resource "checkly_check_group" "users-api" {
  name      = "Users API"
  activated = true
  muted     = false

  locations = [
    "eu-west-1",
    "eu-central-1"
  ]

  concurrency               = 2
  double_check              = true
  use_global_alert_settings = false
}

resource "checkly_check" "create-order" {
  name                      = "create order"
  type                      = "API"
  activated                 = true
  should_fail               = false
  frequency                 = 10
  double_check              = true
  use_global_alert_settings = true
  degraded_response_time    = 5000
  max_response_time         = 10000

  locations = [
    "eu-central-1",
    "us-west-1"
  ]

  group_id = checkly_check_group.orders-api.id

  request {
    url              = "https://danube-webshop.herokuapp.com/api/books"
    follow_redirects = true
    assertion {
      source     = "STATUS_CODE"
      comparison = "EQUALS"
      target     = "200"
    }
    assertion {
      source     = "JSON_BODY"
      property   = "$.length"
      comparison = "EQUALS"
      target     = "30"
    }
  }
}

resource "checkly_check" "update-order" {
  name                      = "update order"
  type                      = "API"
  activated                 = true
  should_fail               = false
  frequency                 = 10
  double_check              = true
  use_global_alert_settings = true
  degraded_response_time    = 5000
  max_response_time         = 10000

  locations = [
    "eu-central-1",
    "us-west-1"
  ]

  group_id = checkly_check_group.orders-api.id

  request {
    url              = "https://danube-webshop.herokuapp.com/api/books"
    follow_redirects = true
    assertion {
      source     = "STATUS_CODE"
      comparison = "EQUALS"
      target     = "200"
    }
    assertion {
      source     = "JSON_BODY"
      property   = "$.length"
      comparison = "EQUALS"
      target     = "30"
    }
  }
}

resource "checkly_check" "cancel-order" {
  name                      = "cancel order"
  type                      = "API"
  activated                 = true
  should_fail               = false
  frequency                 = 10
  double_check              = true
  use_global_alert_settings = true
  degraded_response_time    = 5000
  max_response_time         = 10000

  locations = [
    "eu-central-1",
    "us-west-1"
  ]

  group_id = checkly_check_group.orders-api.id

  request {
    url              = "https://danube-webshop.herokuapp.com/api/books"
    follow_redirects = true
    assertion {
      source     = "STATUS_CODE"
      comparison = "EQUALS"
      target     = "200"
    }
    assertion {
      source     = "JSON_BODY"
      property   = "$.length"
      comparison = "EQUALS"
      target     = "30"
    }
  }
  alert_settings {
    escalation_type = "RUN_BASED"
    run_based_escalation {
      failed_run_threshold = 1
    }
  }
}

resource "checkly_check" "add-to-wishlist" {
  name                      = "add to wishlist"
  type                      = "API"
  activated                 = true
  should_fail               = false
  frequency                 = 10
  double_check              = true
  use_global_alert_settings = true
  degraded_response_time    = 5000
  max_response_time         = 10000

  locations = [
    "eu-central-1",
    "us-west-1"
  ]

  group_id = checkly_check_group.orders-api.id

  request {
    url              = "https://danube-webshop.herokuapp.com/api/books"
    follow_redirects = true
    assertion {
      source     = "STATUS_CODE"
      comparison = "EQUALS"
      target     = "200"
    }
    assertion {
      source     = "JSON_BODY"
      property   = "$.length"
      comparison = "EQUALS"
      target     = "30"
    }
  }
}

resource "checkly_check_group" "orders-api" {
  name      = "Orders API"
  activated = true
  muted     = false

  locations = [
    "eu-west-1",
    "eu-central-1"
  ]
  concurrency               = 2
  double_check              = true
  use_global_alert_settings = false

  alert_channel_subscription {
    channel_id = checkly_alert_channel.pagerduty_ac.id
    activated  = true
  }

}

resource "checkly_check" "create-inventory-item" {
  name                      = "create inventory item"
  type                      = "API"
  activated                 = true
  should_fail               = false
  frequency                 = 10
  double_check              = true
  use_global_alert_settings = true
  degraded_response_time    = 5000
  max_response_time         = 10000

  locations = [
    "eu-central-1",
    "us-west-1"
  ]

  group_id = checkly_check_group.inventory-api.id

  request {
    url              = "https://danube-webshop.herokuapp.com/api/books"
    follow_redirects = true
    assertion {
      source     = "STATUS_CODE"
      comparison = "EQUALS"
      target     = "200"
    }
    assertion {
      source     = "JSON_BODY"
      property   = "$.length"
      comparison = "EQUALS"
      target     = "30"
    }
  }
}

resource "checkly_check" "update-inventory-item" {
  name                      = "update inventory item"
  type                      = "API"
  activated                 = true
  should_fail               = false
  frequency                 = 10
  double_check              = true
  use_global_alert_settings = true
  degraded_response_time    = 5000
  max_response_time         = 10000

  locations = [
    "eu-central-1",
    "us-west-1"
  ]

  group_id = checkly_check_group.inventory-api.id

  request {
    url              = "https://danube-webshop.herokuapp.com/api/books"
    follow_redirects = true
    assertion {
      source     = "STATUS_CODE"
      comparison = "EQUALS"
      target     = "200"
    }
    assertion {
      source     = "JSON_BODY"
      property   = "$.length"
      comparison = "EQUALS"
      target     = "30"
    }
  }
}

resource "checkly_check" "remove-inventory-item" {
  name                      = "remove inventory item"
  type                      = "API"
  activated                 = true
  should_fail               = false
  frequency                 = 10
  double_check              = true
  use_global_alert_settings = true
  degraded_response_time    = 5000
  max_response_time         = 10000

  locations = [
    "eu-central-1",
    "us-west-1"
  ]

  group_id = checkly_check_group.inventory-api.id

  request {
    url              = "https://danube-webshop.herokuapp.com/api/books"
    follow_redirects = true
    assertion {
      source     = "STATUS_CODE"
      comparison = "EQUALS"
      target     = "200"
    }
    assertion {
      source     = "JSON_BODY"
      property   = "$.length"
      comparison = "EQUALS"
      target     = "30"
    }
  }
}

resource "checkly_check" "get-full-inventory" {
  name                      = "get full inventory"
  type                      = "API"
  activated                 = true
  should_fail               = false
  frequency                 = 10
  double_check              = true
  use_global_alert_settings = true
  degraded_response_time    = 5000
  max_response_time         = 10000

  locations = [
    "eu-central-1",
    "us-west-1"
  ]

  group_id = checkly_check_group.inventory-api.id

  request {
    url              = "https://danube-webshop.herokuapp.com/api/books"
    follow_redirects = true
    assertion {
      source     = "STATUS_CODE"
      comparison = "EQUALS"
      target     = "200"
    }
    assertion {
      source     = "JSON_BODY"
      property   = "$.length"
      comparison = "EQUALS"
      target     = "30"
    }
  }
}

resource "checkly_check_group" "inventory-api" {
  name      = "Inventory API"
  activated = true
  muted     = false

  locations = [
    "eu-west-1",
    "eu-central-1"
  ]
  concurrency               = 2
  double_check              = true
  use_global_alert_settings = false

  alert_channel_subscription {
    channel_id = checkly_alert_channel.pagerduty_ac.id
    activated  = true
  }

}

resource "checkly_check" "update-product-details" {
  name                      = "update product details"
  type                      = "API"
  activated                 = true
  should_fail               = false
  frequency                 = 10
  double_check              = true
  use_global_alert_settings = true
  degraded_response_time    = 5000
  max_response_time         = 10000

  locations = [
    "eu-central-1",
    "us-west-1"
  ]

  group_id = checkly_check_group.products-api.id

  request {
    url              = "https://danube-webshop.herokuapp.com/api/books"
    follow_redirects = true
    assertion {
      source     = "STATUS_CODE"
      comparison = "EQUALS"
      target     = "200"
    }
    assertion {
      source     = "JSON_BODY"
      property   = "$.length"
      comparison = "EQUALS"
      target     = "30"
    }
  }
}

resource "checkly_check" "remove-product" {
  name                      = "remove product"
  type                      = "API"
  activated                 = true
  should_fail               = false
  frequency                 = 10
  double_check              = true
  use_global_alert_settings = true
  degraded_response_time    = 5000
  max_response_time         = 10000

  locations = [
    "eu-central-1",
    "us-west-1"
  ]

  group_id = checkly_check_group.products-api.id

  request {
    url              = "https://danube-webshop.herokuapp.com/api/books"
    follow_redirects = true
    assertion {
      source     = "STATUS_CODE"
      comparison = "EQUALS"
      target     = "200"
    }
    assertion {
      source     = "JSON_BODY"
      property   = "$.length"
      comparison = "EQUALS"
      target     = "30"
    }
  }
}

resource "checkly_check" "create-collection" {
  name                      = "create collection"
  type                      = "API"
  activated                 = true
  should_fail               = false
  frequency                 = 10
  double_check              = true
  use_global_alert_settings = true
  degraded_response_time    = 5000
  max_response_time         = 10000

  locations = [
    "eu-central-1",
    "us-west-1"
  ]

  group_id = checkly_check_group.products-api.id

  request {
    url              = "https://danube-webshop.herokuapp.com/api/books"
    follow_redirects = true
    assertion {
      source     = "STATUS_CODE"
      comparison = "EQUALS"
      target     = "200"
    }
    assertion {
      source     = "JSON_BODY"
      property   = "$.length"
      comparison = "EQUALS"
      target     = "30"
    }
  }
}

resource "checkly_check" "remove-collection" {
  name                      = "remove collection"
  type                      = "API"
  activated                 = true
  should_fail               = false
  frequency                 = 10
  double_check              = true
  use_global_alert_settings = true
  degraded_response_time    = 5000
  max_response_time         = 10000

  locations = [
    "eu-central-1",
    "us-west-1"
  ]

  group_id = checkly_check_group.products-api.id

  request {
    url              = "https://danube-webshop.herokuapp.com/api/books"
    follow_redirects = true
    assertion {
      source     = "STATUS_CODE"
      comparison = "EQUALS"
      target     = "200"
    }
    assertion {
      source     = "JSON_BODY"
      property   = "$.length"
      comparison = "EQUALS"
      target     = "30"
    }
  }
}

resource "checkly_check" "promote-collection" {
  name                      = "promote collection"
  type                      = "API"
  activated                 = true
  should_fail               = false
  frequency                 = 10
  double_check              = true
  use_global_alert_settings = true
  degraded_response_time    = 5000
  max_response_time         = 10000

  locations = [
    "eu-central-1",
    "us-west-1"
  ]

  group_id = checkly_check_group.products-api.id

  request {
    url              = "https://danube-webshop.herokuapp.com/api/books"
    follow_redirects = true
    assertion {
      source     = "STATUS_CODE"
      comparison = "EQUALS"
      target     = "200"
    }
    assertion {
      source     = "JSON_BODY"
      property   = "$.length"
      comparison = "EQUALS"
      target     = "30"
    }
  }
}

resource "checkly_check_group" "products-api" {
  name      = "Products API"
  activated = true
  muted     = false

  locations = [
    "eu-west-1",
    "eu-central-1"
  ]
  concurrency               = 2
  double_check              = true
  use_global_alert_settings = false

  alert_channel_subscription {
    channel_id = checkly_alert_channel.pagerduty_ac.id
    activated  = true
  }

}

resource "checkly_check" "create-event" {
  name                      = "create event"
  type                      = "API"
  activated                 = true
  should_fail               = false
  frequency                 = 10
  double_check              = true
  use_global_alert_settings = true
  degraded_response_time    = 5000
  max_response_time         = 10000

  locations = [
    "eu-central-1",
    "us-west-1"
  ]

  group_id = checkly_check_group.events-api.id

  request {
    url              = "https://danube-webshop.herokuapp.com/api/books"
    follow_redirects = true
    assertion {
      source     = "STATUS_CODE"
      comparison = "EQUALS"
      target     = "200"
    }
    assertion {
      source     = "JSON_BODY"
      property   = "$.length"
      comparison = "EQUALS"
      target     = "30"
    }
  }
}

resource "checkly_check" "remove-event" {
  name                      = "remove event"
  type                      = "API"
  activated                 = true
  should_fail               = false
  frequency                 = 10
  double_check              = true
  use_global_alert_settings = true
  degraded_response_time    = 5000
  max_response_time         = 10000

  locations = [
    "eu-central-1",
    "us-west-1"
  ]

  group_id = checkly_check_group.events-api.id

  request {
    url              = "https://danube-webshop.herokuapp.com/api/books"
    follow_redirects = true
    assertion {
      source     = "STATUS_CODE"
      comparison = "EQUALS"
      target     = "200"
    }
    assertion {
      source     = "JSON_BODY"
      property   = "$.length"
      comparison = "EQUALS"
      target     = "30"
    }
  }
}

resource "checkly_check_group" "events-api" {
  name      = "Events API"
  activated = true
  muted     = false

  locations = [
    "eu-west-1",
    "eu-central-1"
  ]
  concurrency               = 2
  double_check              = true
  use_global_alert_settings = false

  alert_channel_subscription {
    channel_id = checkly_alert_channel.pagerduty_ac.id
    activated  = true
  }

}

resource "checkly_alert_channel" "email_ac" {
  email {
    address = "giovanni@checklyhq.com"
  }
  send_recovery        = true
  send_failure         = false
  send_degraded        = true
  ssl_expiry           = true
  ssl_expiry_threshold = 22
}

resource "checkly_alert_channel" "email_ac_urgent" {
  email {
    address = "giovanni+alerts@checklyhq.com"
  }
  send_recovery        = true
  send_failure         = false
  send_degraded        = true
  ssl_expiry           = true
  ssl_expiry_threshold = 22
}


resource "checkly_alert_channel" "pagerduty_ac" {
  pagerduty {
    account      = "checkly"
    service_key  = "key1"
    service_name = "pdalert"
  }
}

output "private-location-key" {
  value     = checkly_private_location.location.keys
  sensitive = true
}

# Simple Private Location example
resource "checkly_private_location" "location" {
  name      = "New Private Location"
  slug_name = "new-private-location"
  icon      = "location"
}
