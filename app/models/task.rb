class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validate :validate_name_not_include_comma

  belongs_to :user

  scope :recent, -> { order(created_at: :desc) }

  def validate_name_not_include_comma
    errors.add(:name, 'カンマは含めることができません') if name&.include?(',')
  end

  # ransackで検索できるカラムを絞る
  def self.ransackable_attributes(auth_object = nil)
    %w[name created_at]
  end

  # 検索条件に含める関連
  def self.ransackable_associations(auth_object = nil)
    []
  end
end

