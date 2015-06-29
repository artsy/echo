class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.integer :account_id
      t.string :name
      t.boolean :value
      t.timestamps null: false
    end
    add_index :features, :account_id
  end
end
