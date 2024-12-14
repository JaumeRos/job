class AddRemainingFieldsToJobs < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :company_website, :string
  end
end
