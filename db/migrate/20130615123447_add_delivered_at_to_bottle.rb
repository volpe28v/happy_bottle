class AddDeliveredAtToBottle < ActiveRecord::Migration
  def change
    add_column :bottles, :delivered_at, :datetime
  end
end
