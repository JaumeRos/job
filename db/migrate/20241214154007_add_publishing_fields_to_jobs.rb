class AddPublishingFieldsToJobs < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :published, :boolean
    add_column :jobs, :published_at, :datetime
    add_column :jobs, :paid, :boolean
  end
end
