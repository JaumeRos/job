class Application < ApplicationRecord
  belongs_to :job
  belongs_to :user
  
  validates :cover_letter, presence: true
  validates :status, presence: true, inclusion: { in: %w[pending accepted rejected] }
  
  before_validation :set_default_status
  
  private
  
  def set_default_status
    self.status ||= 'pending'
  end
end
