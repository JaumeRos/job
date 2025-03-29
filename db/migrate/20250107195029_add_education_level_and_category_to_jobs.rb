class AddEducationLevelAndCategoryToJobs < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :education_level, :string
    add_column :jobs, :category, :string
  end
end 