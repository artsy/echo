class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :account_id
      t.string :name
      t.text :content
      t.timestamps null: false
    end
  end
end
