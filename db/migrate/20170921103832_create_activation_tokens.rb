class CreateActivationTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :activation_tokens do |t|
      t.boolean :redeemed
      t.datetime :redeemed_on
      t.string :token
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
