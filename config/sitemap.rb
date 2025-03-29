# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://teachingjobs.co"

# The directory to write sitemaps to locally
SitemapGenerator::Sitemap.public_path = 'public/'

# If using Cloudflare or similar CDN, you might want to specify the sitemaps host
# SitemapGenerator::Sitemap.sitemaps_host = "https://#{ENV['ASSET_HOST']}" if ENV['ASSET_HOST'].present?

# Store on S3 if using AWS
# SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(
#   fog_provider: 'AWS',
#   aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
#   aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
#   fog_directory: ENV['S3_BUCKET_NAME'],
#   fog_region: ENV['AWS_REGION']
# )

SitemapGenerator::Sitemap.create do
  # Add static pages
  add '/', changefreq: 'daily', priority: 1.0
  add '/about', changefreq: 'monthly', priority: 0.3
  add '/contact', changefreq: 'monthly', priority: 0.3
  add '/privacy-policy', changefreq: 'monthly', priority: 0.3
  add '/terms-of-service', changefreq: 'monthly', priority: 0.3
  add '/careers', changefreq: 'monthly', priority: 0.3
  add '/dashboard', changefreq: 'daily', priority: 0.5
  add '/pricing', changefreq: 'monthly', priority: 0.6

  # Add teaching categories index
  add '/teaching-categories', changefreq: 'daily', priority: 0.9

  # Add each teaching category (manually listing for compatibility)
  [
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
  ].each do |category|
    add "/teaching-categories/#{category.parameterize}", 
        changefreq: 'daily', 
        priority: 0.8
  end

  # Add education levels (manually listing for compatibility)
  [
    'Preschool',
    'Elementary School',
    'Middle School',
    'High School',
    'College/University',
    'Adult Education',
    'Special Education'
  ].each do |level|
    add "/teaching-categories/#{level.parameterize}", 
        changefreq: 'daily', 
        priority: 0.7
  end
end 