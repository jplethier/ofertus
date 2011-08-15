Feature: Follow a user
  As a user 
  I want to follow another user
  So I can follow his deals

    Background:
      Given one user with an username "user_to_follow" exists
      And I am a user with an username "myself"

    Scenario: Follow a unfollowed user
      Given I am on user_to_follow's page
      When I follow "Follow"
      Then I should see "Started following: 'user_to_follow'"

    Scenario: Follow a user already followed
      Given I am following the user "user_to_follow"
      And I am on user_to_follow's page
      Then I should not see "Follow"

    Scenario: Follow a user already followed - by url
      Given I am following the user "user_to_follow"
      And I go to user_to_follow's follow page
      Then I should see "You already follow: 'user_to_follow'"
