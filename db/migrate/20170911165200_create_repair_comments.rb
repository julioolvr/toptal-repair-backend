class CreateRepairComments < ActiveRecord::Migration[5.1]
  def change
    create_table :repair_comments do |t|
      t.references :repair, foreign_key: true, null: false
      t.references :user, foreign_key: true
      t.text :comment

      t.timestamps
    end
  end
end
