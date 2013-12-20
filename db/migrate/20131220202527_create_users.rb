class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :graduation_year
      t.string :password_digest

      t.timestamps
    end
  end
end
