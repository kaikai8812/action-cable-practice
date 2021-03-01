class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.references :users, null: false
      t.integer :partner_id, null: false
      t.string :sentence, null: false
      t.timestamps
    end
  end
end
