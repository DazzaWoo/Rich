class Blog < ApplicationRecord
  acts_as_paranoid

  # relationships
  belongs_to :user

  # validations
  validates :handler, presence: true, uniqueness: true
  validates :title, presence: true
end
