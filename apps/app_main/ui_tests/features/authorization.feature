Feature: Authorization

  @authorization
  Scenario: Login with email and password
    Given User sees authorization screen
    When User enters email
    And User enters password
    And User taps Authorize
    Then User see Home screen

  @authorization
  Scenario: Logout from home screen
    Given User see Home screen
    When User opens side menu
    And User taps Logout
    Then User sees authorization screen