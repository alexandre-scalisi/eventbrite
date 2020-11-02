class Event < ApplicationRecord
  has_many :attendances
  has_many :attendees, through: :attendances, source: :user
  belongs_to :administrator, class_name: "User"

  # validates :start_date, :duration, :title, :description, :price, :location, presence: true
  validates :start_date,:duration,:description,:price,:location, presence:true
  validate :is_futur?
  validates :duration, numericality: {only_integer: true, greater_than: 0}
  validate :multiple_of_5?
  validates :description, length: {in: 20..1000}
  validates :price, numericality: {only_integer: true},:inclusion => 1..1000

  def is_futur?
     
    if Time.now.to_i > self.start_date.to_i
      errors.add(:start_date, "cannot be before the start time") 
    end 
  end

  def multiple_of_5?
    if self.duration % 5 != 0
      errors.add(:duration, "duration must be a multiple of 5")
    end
  end


end