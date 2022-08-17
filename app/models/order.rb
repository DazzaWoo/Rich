class Order < ApplicationRecord
  include AASM
  belongs_to :user
  # validates :serial, presence: true
  # validates :price, presence: true
  # validates :state, presence: true
  validates :serial, :price, :state, presence: true

  aasm column: "state" do
    state :pending, initial: true
    state :paid, :fail, :refunded, :cancelled

    event :pay do
      transitions from: [:pending, :fail], to: :paid

      after do
        puts "發簡訊"
      end
    end

    event :fail do
      transitions from: :pending, to: :fail
    end
    event :cancel do
      transitions from: [:pending, :fail], to: :cancelled
    end
    event :refund do
      transitions from: :paid, to: :refunded
    end
  end

  private
  
end
