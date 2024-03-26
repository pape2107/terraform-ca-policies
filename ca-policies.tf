resource "azuread_conditional_access_policy" "all_admins_mfa" {
  display_name = "all_admins_mfa"
  state        = "disabled"

  conditions {
    client_app_types    = ["all"]
    sign_in_risk_levels = []
    user_risk_levels    = []

    applications {
      included_applications = ["all"]
      excluded_applications = []
    }

    #devices {
    #   
    #}

    locations {
      included_locations = ["all"]
      excluded_locations = ["AllTrusted"]
    }

    users {
      included_users  = ["All"]
      excluded_groups = ["4a28132d-4707-4136-b5fe-3c8b9b8bad65"]
    }
  }
  grant_controls {
    operator          = "OR"
    built_in_controls = ["mfa"]
  }

  session_controls {
    application_enforced_restrictions_enabled = true
    disable_resilience_defaults               = false
    sign_in_frequency                         = 10
    sign_in_frequency_period                  = "hours"
    cloud_app_security_policy                 = "monitorOnly"
  }
}