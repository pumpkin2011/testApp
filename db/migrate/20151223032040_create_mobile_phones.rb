class CreateMobilePhones < ActiveRecord::Migration
  def change
    create_table :mobile_phones do |t|
      t.references :contact, index: true, foreign_key: true
      t.string :phone_type
      t.string :phone

      t.timestamps null: false
    end
  end
end
