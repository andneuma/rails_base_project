class AddPasswordResetTimestampToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :password_reset_timestamp, :datetime
  end
end
