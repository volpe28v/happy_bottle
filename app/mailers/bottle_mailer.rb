class BottleMailer < ActionMailer::Base
  default from: "HappyBottle<#{ENV['MAIL_ADDR']}>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.bottle_mailer.one_bottle.subject
  #
  def one_bottle(receiver, bottle)
    @receiver = receiver
    @bottle = bottle

    @bottle.deliver!

    mail to: @receiver.email, subject: "幸せボトルが届きました!"
  end
end
