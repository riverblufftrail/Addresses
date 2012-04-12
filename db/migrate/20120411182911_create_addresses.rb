class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.references :user

      t.timestamps
    end
    add_index :addresses, :user_id
  end
end
