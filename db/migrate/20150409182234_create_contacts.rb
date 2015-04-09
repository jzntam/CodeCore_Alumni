class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :company
      t.string :website
      t.text :other
      t.references :cohort, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :contacts, :cohorts
    add_foreign_key :contacts, :users
  end
end
