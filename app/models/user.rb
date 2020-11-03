class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_create :welcome_send

  
  has_many :attendances
  has_many :attended_events, through: :attendances, source: :event
  has_many :administered_events, through: :attendances, source: :event
  validates :first_name,:last_name,presence:true
  validates :first_name, length: {in: 1..40}
  validates :last_name, length: {in: 1..40}
  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
end
