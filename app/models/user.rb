class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_create :welcome_send

  has_one_attached :photo
  has_many :attendances
  has_many :attended_events, through: :attendances, source: :event
  has_many :administered_events, foreign_key: 'administrator', class_name: 'Event'
  
  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  def participating?(event)
    return false if self.attended_events.empty?

    self.attended_events.include?(event) ? true : false
    
  end

  def administrator?(event)
    return false if self.administered_events.empty?

    self.administered_events.include?(event) ? true : false
    
  end

  def can_subscribe?(event)
    (participating?(event) || administrator?(event)) ? false : true
  end
end
