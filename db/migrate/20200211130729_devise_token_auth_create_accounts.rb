class DeviseTokenAuthCreateAccounts < ActiveRecord::Migration[6.0]
  def change
    
    create_table(:accounts) do |t|
      t.string :provider, null: false, default: 'email'
      t.string :uid, null: false, default: ''
      t.string :encrypted_password, null: false, default: ''
      t.string :email

      t.json :tokens

      t.timestamps
    end

    add_index :accounts, :email,                unique: true
    add_index :accounts, [:uid, :provider],     unique: true
  end
end
