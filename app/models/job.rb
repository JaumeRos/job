class Job < ApplicationRecord
  belongs_to :user
  has_many :applications
  has_many :applicants, through: :applications, source: :user
  
  # Categories and Types
  CATEGORIES = [
    'Art Teaching',
    'Music Teaching',
    'Physical Education Teaching',
    'Special Education Teaching',
    'ESL Teaching',
    'Math Teaching',
    'Science Teaching',
    'Biology Teaching',
    'Chemistry Teaching',
    'Physics Teaching',
    'English Teaching',
    'History Teaching',
    'Social Studies Teaching',
    'Foreign Language Teaching',
    'Spanish Teaching',
    'French Teaching',
    'Elementary Teaching',
    'Kindergarten Teaching',
    'Preschool Teaching',
    'Middle School Teaching',
    'High School Teaching',
    'Substitute Teaching',
    'Teaching Assistant',
    'School Principal',
    'School Administrator',
    'School Counselor',
    'School Librarian',
    'Drama Teaching',
    'Computer Science Teaching',
    'Technology Teaching',
    'Business Teaching',
    'Economics Teaching',
    'Geography Teaching',
    'Religious Education Teaching',
    'Montessori Teaching',
    'Early Childhood Education',
    'Special Needs Teaching',
    'STEM Teaching',
    'Vocational Teaching',
    'Adult Education Teaching'
  ].freeze

  EDUCATION_LEVELS = [
    'Preschool',
    'Elementary School',
    'Middle School',
    'High School',
    'College/University',
    'Adult Education',
    'Special Education'
  ].freeze

  JOB_TYPES = [
    'Full-time',
    'Part-time',
    'Contract',
    'Temporary',
    'Remote',
    'Hybrid',
    'Summer Program',
    'Substitute'
  ].freeze

  # Validations
  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 50 }
  validates :company_name, presence: true
  validates :company_website, presence: true
  validates :company_email, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :education_level, presence: true, inclusion: { in: EDUCATION_LEVELS }
  validates :job_type, presence: true, inclusion: { in: JOB_TYPES }
  validates :location, presence: true, unless: -> { job_type == 'Remote' }

  # Scopes for filtering
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }
  scope :recent, -> { order(created_at: :desc) }
  scope :by_category, ->(category) { where(category: category) }
  scope :by_education_level, ->(level) { where(education_level: level) }
  scope :by_job_type, ->(type) { where(job_type: type) }
  scope :featured, -> { where(featured: true) }

  def publish!
    update(published: true, published_at: Time.current)
  end
  
  def unpublish!
    update(published: false, published_at: nil)
  end

  def to_param
    [id, title.parameterize].join('-')
  end
end
