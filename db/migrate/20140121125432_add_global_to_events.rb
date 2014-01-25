class AddGlobalToEvents < ActiveRecord::Migration
  def change
    add_column :events, :global, :boolean
  end
end
