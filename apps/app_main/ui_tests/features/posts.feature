Feature: Posts

  @posts
  Scenario: Test Posts
    Given User sees "Posts" button
    When User taps "Posts" button
    And User taps "Remote first" button
    Then User sees data is loaded