require 'spec_helper'

feature '瓶の欠片を表示する', :js do
  let!(:user) { create(:user) }

  context 'サインインしている' do
    background do
      sign_in_as user
    end

    scenario '瓶の欠片を表示することができる' do
      within '#peace_of_bottle' do
        save_screenshot '/tmp/hi.png'
        page.should have_content('オム')
      end
    end
  end
end
