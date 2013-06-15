class User < ActiveRecord::Base
  attr_accessor :password

  class << self
    def find_by_email_and_password(email, password)
      User.where(email: email, hashed_password: password).first
    end
  end
end
