class AddUserIdToItem < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :user_id, :bigint, after: :id
  end
end
