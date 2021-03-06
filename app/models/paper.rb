class Paper < ActiveRecord::Base
  has_and_belongs_to_many :authors

  validates :title, presence: true
  validates :venue, presence: true
  validates :year, numericality: { only_integer: true, less_than_or_equal_to: Time.now.year }
end
