class AddDefaultsToJobsPublishingFields < ActiveRecord::Migration[7.0]
  def change
    change_column_default :jobs, :published, from: nil, to: false
    change_column_default :jobs, :paid, from: nil, to: false
  end
end
