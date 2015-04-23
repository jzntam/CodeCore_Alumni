class AddColumnsToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :position, :string
    add_column :contacts, :project, :string
    add_column :contacts, :github, :string
    add_column :contacts, :linkedin, :string
  end
end
