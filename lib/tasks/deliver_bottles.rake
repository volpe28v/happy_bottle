require "#{Rails.root}/config/environment"

desc 'Deliver Bottles'
task :deliver_bottles do
  #Partnership を取得
  Partnership.all.each do |partnership|
    partnership.users.each do |owner|
      partner = (partnership.users - [owner]).first
      bottle = owner.bottles.sample
      next unless bottle

      BottleMailer.one_bottle(partner, bottle).deliver
    end
  end
end
