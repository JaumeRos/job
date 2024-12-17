# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://teachingjobs.co"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  add jobs_path, changefreq: 'daily', priority: 1.0
  add pricing_path, changefreq: 'monthly', priority: 0.8
  add contact_path, changefreq: 'monthly', priority: 0.7
  add careers_path, changefreq: 'monthly', priority: 0.7
  add privacy_policy_path, changefreq: 'yearly', priority: 0.5
  add terms_path, changefreq: 'yearly', priority: 0.5
end 