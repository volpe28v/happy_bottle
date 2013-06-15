class BottleMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.bottle_mailer.one_bottle.subject
  #
  def one_bottle(receiver, bottle)
    @receiver = receiver
    @bottle = bottle

    mail to: @receiver.email
  end
end
