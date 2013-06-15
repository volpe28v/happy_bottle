class CreateBottles < ActiveRecord::Migration
  def change
    create_table :bottles do |t|
      t.text :message
      t.references :owner, index: true

      t.timestamps
    end
  end
end
