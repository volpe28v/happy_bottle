class User < ActiveRecord::Base
  attr_accessor :password

  before_save do
    self.hashed_password = self.class.encrypt(self.password) if self.password.present?
  end

  class << self
    def find_by_email_and_password(email, password)
      User.where(email: email, hashed_password: encrypt(password)).first
    end

    def encrypt(password)
      Digest::SHA1.hexdigest(password)
    end
  end
end
