class User < ApplicationRecord
  has_many :attendances
  has_many :attended_events, through: :attendances, source: :event
  has_many :administered_events, through: :attendances, source: :event
end
