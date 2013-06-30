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

        partner = create(:user, name: 'partner', partnership: partnership)
        partner.save!

        bottle = partner.create_bottle({ message: "オムライス"})
        bottle.deliver!
      end
    end
  end
end
