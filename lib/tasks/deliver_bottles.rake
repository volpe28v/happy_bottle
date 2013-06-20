require "#{Rails.root}/config/environment"

desc 'Deliver Bottles'
task :deliver_bottles do
  Partnership.all.each do |partnership|
    partnership.users.each do |owner|
      partner = owner.partner
      bottle = owner.bottles.not_delivered_yet.sample
      next unless bottle
      next unless partner.activated?
      next if rand(30) > 10  # とりあえず３日に一通くらいのランダムで回してみる

      begin
        BottleMailer.one_bottle(partner, bottle).deliver
      rescue => e
        Rails.logger.error ["#{e.class} #{e.message}:", *e.backtrace.map {|m| '  '+m }].join("\n")
      end
    end
  end
end
