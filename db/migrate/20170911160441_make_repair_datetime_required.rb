class MakeRepairDatetimeRequired < ActiveRecord::Migration[5.1]
  def change
    change_column_null :repairs, :datetime, false
  end
end
