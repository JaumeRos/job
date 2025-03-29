class AddSchemaFieldsToJobs < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :country_code, :string unless column_exists?(:jobs, :country_code)
    add_column :jobs, :salary_currency, :string, default: 'USD' unless column_exists?(:jobs, :salary_currency)
    add_column :jobs, :salary_min, :integer unless column_exists?(:jobs, :salary_min)
    add_column :jobs, :salary_max, :integer unless column_exists?(:jobs, :salary_max)
    add_column :jobs, :requirements, :text unless column_exists?(:jobs, :requirements)
    add_column :jobs, :company_logo_url, :string unless column_exists?(:jobs, :company_logo_url)
  end
end 