module LoginHelper
  def sign_in_as(user)
    visit root_path

    click_on 'Sign In'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_on 'OK'
  end
end

RSpec.configuration.include LoginHelper, capybara_feature: true
