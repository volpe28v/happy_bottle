require 'spec_helper'

feature 'パートナーに瓶を流す' do
  let!(:user) { create(:user) }

  context 'サインインしている' do
    background do
      sign_in_as user
    end

    scenario 'パートナーに瓶を流すことができる' do
      fill_in 'bottle_message', with: 'オムライスを作ってもらった'

      click_on '瓶を流す'

      within '.alert' do
        page.should have_content('幸せが詰まった瓶を流しました！')
      end
    end
  end
end
