class AddCompanyEmailAndRenameSalary < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :company_email, :string
    rename_column :jobs, :salary, :salary_range
  end
end
