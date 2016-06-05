class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :recipe_id
      t.boolean :recipe_id
      t.timestamps
    end
  end
end
