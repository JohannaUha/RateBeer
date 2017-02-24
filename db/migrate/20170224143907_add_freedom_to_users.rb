class AddFreedomToUsers < ActiveRecord::Migration
  def change
    add_column :users, :freedom, :boolean
  end
end
