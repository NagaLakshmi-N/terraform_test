terraform {
  required_providers {
    http-full = {
      source = "salrashid123/http-full"
    }
  }
}

variable "auth_token" {
  type        = string
  description = "Fresh Service basic auth api token"
}

provider "http-full" { }

# HTTP POST 
data "http" "example" {
  provider = http-full
  url = "https://corestackhelpdesk.freshservice.com/api/v2/tickets"
  method = "POST"
  request_headers = {
    content-type = "application/json",
    Authorization: var.auth_token
  }
  request_body = jsonencode({
    "subject": "Testing CURL Ticket Creation Again (TF) - Demo Wed",
            "group_id": null,
            "department_id": null,
            "category": null,
            "sub_category": null,
            "item_category": null,
            "requester_id": 24000296219,
            "responder_id": null,
            "due_by": "2024-07-01T19:00:00Z",
            "email_config_id": null,
            "cc_emails": [],
            "fr_due_by": "2024-01-21T20:18:49Z",
            "priority": 2,
            "status": 2,
            "source": 2,
            "type": "Incident",
            "description": "If your reading this, it worked - Via Terraform",
            "custom_fields": {
                "major_incident_type": null,
                "business_impact": null,
                "impacted_locations": null,
                "no_of_customers_impacted": null
            },
            "workspace_id": 2
  })
}

output "data" {
  value = jsondecode(data.http.example.response_body)
}
