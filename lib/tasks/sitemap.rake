namespace :sitemap do
  desc 'Generate the sitemap'
  task generate: :environment do
    SitemapGenerator::Sitemap.default_host = 'https://teachingjobs.co'
    SitemapGenerator::Sitemap.create do
      add jobs_path, changefreq: 'daily', priority: 1.0
      add pricing_path, changefreq: 'monthly', priority: 0.8
      add contact_path, changefreq: 'monthly', priority: 0.7
      add careers_path, changefreq: 'monthly', priority: 0.7
      add privacy_policy_path, changefreq: 'yearly', priority: 0.5
      add terms_path, changefreq: 'yearly', priority: 0.5
    end
    puts "Sitemap generated successfully!"
  end
end 