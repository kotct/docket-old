class CreateConfigurations < ActiveRecord::Migration
  def change
    create_table :configurations do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
