Given /^no user exists with an email of "(.*)"$/ do |email|
  User.find(:first, :conditions => { :email => email }).should be_nil
end

Given /^one user with an email "([^"]*)" exists$/ do |email|
  Factory.create :confirmed_user, :email => email
end

Given /^I am a user with an email "([^"]*)"$/ do |email|
  user = Factory.create :confirmed_user, :email => email

  And %{I go to the sign in page}
  And %{I fill in "user_email" with "#{user.email}"}
  And %{I fill in "user_password" with "#{user.password}"}
  And %{I press "Sign in"}
end

Given /^I am a user named "([^"]*)" with an email "([^"]*)" and password "([^"]*)"$/ do |name, email, password|
  Factory.create :confirmed_user,
            :name => name,
            :email => email,
            :password => password,
            :password_confirmation => password
end

Given /^I am a user with an email "([^"]*)" and a password "([^"]*)"$/ do |email, password|
  Factory.create :confirmed_user, :email => email, :password => password
end

Then /^I should be already signed in$/ do
  And %{I should see "Logout"}
end

Given /^I am signed up as "(.*)\/(.*)"$/ do |email, password|
  Given %{I am not logged in}
  When %{I go to the sign up page}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I fill in "Password confirmation" with "#{password}"}
  And %{I press "Sign up"}
  Then %{I should see "You have signed up successfully. If enabled, a confirmation was sent to your e-mail."}
  And %{I am logout}
end

Given /^I am logout$/ do
  visit('/users/sign_out')
end

When /^I sign in as "(.*)\/(.*)"$/ do |email, password|
  Given %{I am not logged in}
  When %{I go to the sign in page}
  And %{I fill in "Email" with "#{email}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I press "Sign in"}
end

Then /^I should be signed in$/ do
  Then %{I should see "Fez login com sucesso."}
end

Then /^I sign out$/ do
  visit('/users/sign_out')
end

When /^I return next time$/ do
  And %{I go to the home page}
end

Then /^I should be signed out$/ do
  And %{I should see "Sign up"}
  And %{I should see "Login"}
  And %{I should not see "Logout"}
end

Given /^I am not logged in$/ do
  visit('/users/sign_out') # ensure that at least
end
