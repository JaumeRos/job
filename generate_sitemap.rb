#!/usr/bin/env ruby

require 'builder'
require 'date'

HOST = "https://teachingjobs.co"
SITEMAP_PATH = "public/sitemap.xml"

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
]

EDUCATION_LEVELS = [
  'Preschool',
  'Elementary School',
  'Middle School',
  'High School',
  'College/University',
  'Adult Education',
  'Special Education'
]

STATIC_PAGES = [
  { url: '/', priority: 1.0, changefreq: 'daily' },
  { url: '/about', priority: 0.3, changefreq: 'monthly' },
  { url: '/contact', priority: 0.3, changefreq: 'monthly' },
  { url: '/privacy-policy', priority: 0.3, changefreq: 'monthly' },
  { url: '/terms-of-service', priority: 0.3, changefreq: 'monthly' },
  { url: '/careers', priority: 0.3, changefreq: 'monthly' },
  { url: '/dashboard', priority: 0.5, changefreq: 'daily' },
  { url: '/pricing', priority: 0.6, changefreq: 'monthly' },
  { url: '/teaching-categories', priority: 0.9, changefreq: 'daily' }
]

# Create the sitemap XML
puts "Generating sitemap..."
xml = Builder::XmlMarkup.new(indent: 2)
xml.instruct!
xml.urlset(xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9") do
  
  # Add static pages
  STATIC_PAGES.each do |page|
    xml.url do
      xml.loc("#{HOST}#{page[:url]}")
      xml.changefreq(page[:changefreq])
      xml.priority(page[:priority])
      xml.lastmod(Date.today.iso8601)
    end
  end
  
  # Add category pages
  CATEGORIES.each do |category|
    xml.url do
      xml.loc("#{HOST}/teaching-categories/#{category.parameterize}")
      xml.changefreq("daily")
      xml.priority(0.8)
      xml.lastmod(Date.today.iso8601)
    end
  end
  
  # Add education level pages
  EDUCATION_LEVELS.each do |level|
    xml.url do
      xml.loc("#{HOST}/teaching-categories/#{level.parameterize}")
      xml.changefreq("daily")
      xml.priority(0.7)
      xml.lastmod(Date.today.iso8601)
    end
  end
end

# Write the sitemap file
File.open(SITEMAP_PATH, 'w') { |f| f.write(xml.target!) }
puts "Sitemap generated at #{SITEMAP_PATH}" 