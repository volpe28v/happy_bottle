class CreatePartnerships < ActiveRecord::Migration
  def change
    create_table :partnerships do |t|

      t.timestamps
    end
  end
end
