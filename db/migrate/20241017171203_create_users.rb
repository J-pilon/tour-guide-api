class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: { unique: true }
      t.string :encrypted_password, null: false
      t.string :authenication_token
      t.date :authentication_token_expiry

      t.timestamps
    end
  end
end
