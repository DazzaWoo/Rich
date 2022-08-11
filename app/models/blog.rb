class Blog < ApplicationRecord
  acts_as_paranoid

  # relationships
  belongs_to :user
  has_many :blog_visitors
  has_many :visitors, through: :blog_visitiors, source: :user

  # validations
  validates :handler, presence: true, uniqueness: true
  validates :title, presence: true
end
