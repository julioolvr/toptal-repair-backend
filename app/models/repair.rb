class Repair < ApplicationRecord
  validates :datetime, presence: true
  validate :cannot_overlap_with_other_repair
  belongs_to :assignee, class_name: 'User', optional: true
  has_many :comments, class_name: 'RepairComment', dependent: :destroy, inverse_of: 'repair'

  private

  def cannot_overlap_with_other_repair
    return unless datetime

    overlapping = Repair
                  .where(datetime: (datetime - 1.hour)..datetime)
                  .where.not(id: id)
                  .exists?

    errors.add(:datetime, 'cannot be up to one hour after another repair') if overlapping
  end
end
