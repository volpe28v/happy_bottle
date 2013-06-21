FactoryGirl.define do
  factory :user do
    sequence(:name)  {|i| "user_#{i}" }
    sequence(:email) {|i| "user_#{i}@happy-bottle.herokuapp.com" }
    password 'p@ssw0rd'

    after :create do |user|
      unless user.partnership
        partnership = Partnership.create!

        user.partnership = partnership
        user.save!

        create(:user, name: 'partner', partnership: partnership)
      end
    end
  end
end
