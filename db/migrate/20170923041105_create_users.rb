class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :wx_openid
      t.integer :age
      t.text :bio
      t.boolean :is_admin
      t.boolean :is_leader

      t.timestamps
    end
  end
end
