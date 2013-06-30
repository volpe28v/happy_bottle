class InvitationMailer < ActionMailer::Base
  default from: "HappyBottle<#{ENV['MAIL_ADDR']}>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invitation_mailer.invite.subject
  #
  def invite(partner, user)
    @partner = partner
    @user = user

    mail to: partner.email
  end
end
