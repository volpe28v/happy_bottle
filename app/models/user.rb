class User < ActiveRecord::Base
  attr_accessor :password
  belongs_to :partnership
  has_many :bottles, foreign_key: "owner_id", dependent: :destroy

  before_save do
    self.hashed_password = self.class.encrypt(self.password) if self.password.present?
  end

  def partner
    # TODO Refactor
    (self.partnership.users - [self]).first
  end

  class << self
    def find_by_email_and_password(email, password)
      User.where(email: email, hashed_password: encrypt(password)).first
    end

    def encrypt(password)
      Digest::SHA1.hexdigest(password)
    end
  end

  def create_bottle(params)
    Bottle.create!(params) do |bottle|
      bottle.owner = self
    end
  end

  def update_invitation_token
    self.invitation_token = OpenSSL::Random.random_bytes(16).unpack("H*").first
  end

  def verify!
    self.invitation_token = nil
    self.save!
  end
end
