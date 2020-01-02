class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validate :validate_name_not_include_comma

  belongs_to :user

  def validate_name_not_include_comma
    errors.add(:name, 'カンマは含めることができません') if name&.include?(',')
  end
end

