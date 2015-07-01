class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.integer :account_id
      t.string :name
      t.string :path
      t.timestamps null: false
    end
  end
end
