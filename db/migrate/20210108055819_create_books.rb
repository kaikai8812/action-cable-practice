class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.integer :user_id
      t.text :title
      t.text :opinion

      t.timestamps
    end
  end
end
