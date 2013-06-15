class Bottle < ActiveRecord::Base
  belongs_to :owner, class_name: "User"

  def deliver!(date = DateTime.now)
    self.delivered_at = date
    save!
  end
end
