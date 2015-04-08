class CreateCohorts < ActiveRecord::Migration
  def change
    create_table :cohorts do |t|
      t.string :title
      t.string :details

      t.timestamps null: false
    end
  end
end
