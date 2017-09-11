class AddAssigneeRefToRepairs < ActiveRecord::Migration[5.1]
  def change
    add_reference :repairs, :assignee, foreign_key: true
  end
end
