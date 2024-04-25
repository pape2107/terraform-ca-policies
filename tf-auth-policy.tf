resource "azuread_authentication_strength_policy" "privileged_auth_policy" {
    display_name = "Privileged-Authentication-Policy"
    description = "Autentication methods for user with privileged role access"
    allowed_combinations = [ 
        "fido2",
        "password",
     ]
}

resource "azuread_authentication_strength_policy" "user_auth_policy" {
    display_name = "User-Authentication-Policy"
    description = "Autentication methods for normal users"
    allowed_combinations = [ 
        "fido2",
        "password",
     ]
}

resource "azuread_named_location" "home" {
  display_name = "home"
  country {
    countries_and_regions = [ "DE" ]
  }
}