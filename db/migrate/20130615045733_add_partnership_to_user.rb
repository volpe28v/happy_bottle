class AddPartnershipToUser < ActiveRecord::Migration
  def change
    add_reference :users, :partnership, index: true
  end
end
