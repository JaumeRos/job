class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :jobs, dependent: :destroy
  has_many :applications
  has_many :applied_jobs, through: :applications, source: :job
end
