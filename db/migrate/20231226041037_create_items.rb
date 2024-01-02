class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :detail
      t.string :image

      t.timestamps
    end
  end
end
