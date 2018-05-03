class CreateVisits < ActiveRecord::Migration[5.1]
  def change
    create_table :visits do |t|
      t.string :user_id
      t.string :short_url, null: false
      t.timestamps
    end
    add_index :visits, :short_url, unique: true 
  end
end
