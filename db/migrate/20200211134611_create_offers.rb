class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.string :advertiser_name, null: false, index: {unique: true}
      t.string :url, null: false
      t.text :description, null: false
      t.datetime :starts_at, null: false
      t.datetime :ends_at
      t.boolean :premium, null: false, default: false
      t.boolean :available, null: false, default: false

      t.timestamps
    end
  end
end
