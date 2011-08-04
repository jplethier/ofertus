Feature: View default deal details
  As a guest
  I want to the default deal details
  so I can see their price, company, etc.

    Scenario: Viewing deal's title
      Given 1 deal with title as "MacBook 99% OFF" was registered today
      And I am on today's deals page
      Then I should see "MacBook 99% OFF" within deal's title

    Scenario: Viewing deal's address
      Given 1 deal with address as "Shopping Mall" was registered today
      And I am on today's deals page
      Then I should see "Shopping Mall" within deal's address
