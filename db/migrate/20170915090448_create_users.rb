class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.string :password_reset_digest
      t.string :email
      t.boolean :is_admin

      t.timestamps
    end
  end
end
