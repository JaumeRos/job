class TeachingCategoriesController < ApplicationController
  def show
    @category = params[:category].tr('-', ' ').titleize
    @jobs = Job.published.by_category(@category).recent
    @featured_jobs = @jobs.featured.limit(3)
    @total_jobs = @jobs.count
    
    # SEO metadata
    @page_title = "#{@category} Jobs | Find Your Next Teaching Position"
    @meta_description = "Browse #{@total_jobs}+ #{@category.downcase} jobs. Find your next #{@category.downcase} position at top schools. Apply today! Updated daily."
    
    # Schema.org markup for job listing page
    @schema_markup = {
      "@context": "https://schema.org",
      "@type": "CollectionPage",
      "name": "#{@category} Jobs",
      "description": @meta_description,
      "url": request.url,
      "specialty": @category,
      "about": {
        "@type": "DefinedTerm",
        "name": @category,
        "inDefinedTermSet": "Teaching Categories"
      }
    }
  end

  def index
    @categories = Job::CATEGORIES.sort
    set_meta_tags(
      title: "Teaching Job Categories | Find Education Positions by Subject",
      description: "Browse teaching jobs by category. Find positions in Mathematics, Science, English, and more. Discover opportunities across all teaching subjects and specialties.",
      keywords: "teaching categories, education jobs by subject, teaching specialties, subject teaching jobs, education positions by category",
      og: {
        title: "Teaching Job Categories | Find Education Positions by Subject",
        description: "Browse teaching jobs by category. Find positions in Mathematics, Science, English, and more. Discover opportunities across all teaching subjects and specialties.",
        type: "website",
        url: request.original_url
      }
    )
  end
end 