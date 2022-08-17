class Order < ApplicationRecord
  include AASM
  belongs_to :user
  # validates :serial, presence: true
  # validates :price, presence: true
  # validates :state, presence: true
  validates :serial, :price, :state, presence: true

  aasm no_direct_assignment: true, column: "state"  do
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
  def create_serial
    # "ORD20220815XXXXXX(0~9a-zA-Z)"
    now = Time.now

    self.serial = "ORD%d%02d%02d%s" % [now.year,
                                       now.month,
                                       now.day,
                                       SecureRandom.alphanumeric(6)]
  end
end
