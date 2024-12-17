class SitemapsController < ApplicationController
  skip_before_action :authenticate_user!, if: -> { defined?(authenticate_user!) }
  
  def show
    respond_to do |format|
      format.xml do
        sitemap_path = Rails.root.join('public', 'sitemap.xml')
        if File.exist?(sitemap_path)
          render xml: File.read(sitemap_path)
        else
          head :not_found
        end
      end
    end
  end
end 