class Job < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 50 }
  validates :company_name, presence: true
  validates :company_website, presence: true
  validates :company_email, presence: true
  
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }
  scope :recent, -> { order(created_at: :desc) }
  
  def publish!
    update(published: true, published_at: Time.current)
  end
  
  def unpublish!
    update(published: false, published_at: nil)
  end
end
