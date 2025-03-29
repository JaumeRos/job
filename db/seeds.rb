# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create or find the default user for the jobs
user = User.find_or_create_by!(email: 'admin@teachingjobs.co') do |u|
  u.password = 'password123'
  u.password_confirmation = 'password123'
end

# Common locations for job posts
LOCATIONS = [
  'New York, NY',
  'Los Angeles, CA',
  'Chicago, IL',
  'Houston, TX',
  'Phoenix, AZ',
  'Philadelphia, PA',
  'San Antonio, TX',
  'San Diego, CA',
  'Dallas, TX',
  'San Jose, CA',
  'Remote'
].freeze

# Common company names
COMPANIES = [
  'Excellence Academy',
  'Global Education Institute',
  'Future Leaders School',
  'Innovation Learning Center',
  'Bright Minds Academy',
  'Knowledge Hub School',
  'Elite Education Group',
  'Learning Tree Academy',
  'Success Academy',
  'Education First Institute'
].freeze

# Clear existing jobs to avoid duplicates
Job.delete_all

# Generate jobs for each category
Job::CATEGORIES.each do |category|
  # Create 3 jobs for each category
  3.times do |i|
    location = LOCATIONS.sample
    company = COMPANIES.sample
    job_type = ['Full-time', 'Part-time', 'Contract'].sample
    education_level = Job::EDUCATION_LEVELS.sample
    
    # Generate a realistic salary range based on category and education level
    base_salary = case education_level
                 when 'Preschool', 'Elementary School'
                   35000..55000
                 when 'Middle School'
                   40000..65000
                 when 'High School'
                   45000..75000
                 when 'College/University'
                   60000..100000
                 else
                   40000..70000
                 end

    salary_min = base_salary.min
    salary_max = base_salary.max

    # Create the job
    Job.create!(
      title: "#{category} Position",
      description: "We are seeking an experienced #{category.downcase} to join our team at #{company}. 
      
      Key Responsibilities:
      • Develop and implement engaging lesson plans
      • Create a positive learning environment
      • Assess student progress and provide feedback
      • Collaborate with other teachers and staff
      • Participate in professional development
      
      Benefits:
      • Competitive salary
      • Health insurance
      • Professional development opportunities
      • Paid time off
      • Retirement plan",
      
      job_type: job_type,
      company_name: company,
      company_email: "careers@#{company.parameterize}.edu",
      location: location,
      country_code: "US",
      salary_min: salary_min,
      salary_max: salary_max,
      salary_currency: "USD",
      company_website: "https://www.#{company.parameterize}.edu",
      company_logo_url: "https://teachingjobs.co/logos/#{company.parameterize}.png",
      requirements: "• Bachelor's degree in #{category.delete_suffix(' Teaching')} or related field
      • Valid teaching certification
      • Minimum 2 years of teaching experience
      • Strong communication skills
      • Passion for education",
      education_level: education_level,
      category: category,
      user: user,
      published: true,
      published_at: Time.current,
      # Mark the first job in each category as featured
      featured: (i == 0)
    )
  end
end

puts "Created #{Job::CATEGORIES.size * 3} job posts across #{Job::CATEGORIES.size} categories"
