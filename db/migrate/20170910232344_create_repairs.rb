class CreateRepairs < ActiveRecord::Migration[5.1]
  def change
    create_table :repairs do |t|
      t.string :title
      t.text :description
      t.datetime :datetime
      t.boolean :is_complete, default: false
      t.boolean :is_approved, default: false

      t.timestamps
    end
  end
end
