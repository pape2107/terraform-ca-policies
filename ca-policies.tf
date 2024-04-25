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
      included_locations = [azuread_named_location.home.id]
      excluded_locations = ["AllTrusted"]
    }

    users {
      included_users  = ["all"]
      excluded_groups = [azuread_group.ca_exclude.object_id]
    }
  }
  grant_controls {
    operator          = "OR"
    built_in_controls = ["mfa"]
    authentication_strength_policy_id = azuread_authentication_strength_policy.privileged_auth_policy.id
  }

  session_controls {
    application_enforced_restrictions_enabled = true
    disable_resilience_defaults               = false
    sign_in_frequency                         = 10
    sign_in_frequency_period                  = "hours"
    cloud_app_security_policy                 = "monitorOnly"
  }
  depends_on = [azuread_authentication_strength_policy.privileged_auth_policy]
}

resource "azuread_conditional_access_policy" "all_users_mfa" {
  display_name = "all_users_mfa"
  state        = "enabledForReportingButNotEnforced"

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
      included_users  = ["all"]
      excluded_groups = [azuread_group.ca_exclude.object_id]
    }
  }
  grant_controls {
    operator          = "OR"
    built_in_controls = ["mfa"]
    authentication_strength_policy_id = azuread_authentication_strength_policy.user_auth_policy.id
  }

  session_controls {
    application_enforced_restrictions_enabled = true
    disable_resilience_defaults               = false
    sign_in_frequency                         = 10
    sign_in_frequency_period                  = "hours"
    cloud_app_security_policy                 = "monitorOnly"
  }
  depends_on = [ azuread_authentication_strength_policy.user_auth_policy ]
}