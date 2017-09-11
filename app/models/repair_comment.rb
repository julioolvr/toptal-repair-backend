class RepairComment < ApplicationRecord
  belongs_to :repair, inverse_of: 'comments'
  belongs_to :user, optional: true
end
