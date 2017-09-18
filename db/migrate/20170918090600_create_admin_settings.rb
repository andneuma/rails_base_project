class CreateAdminSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_settings do |t|

      t.string :app_title, default: '', null: false
      t.string :relay_mail_address, default: 'foo@bar.org', null: false
      t.string :captcha_system, default: 'recaptcha', null: false
      t.integer :user_activation_tokens, default: 3, null: false

      t.timestamps
    end
  end
end
