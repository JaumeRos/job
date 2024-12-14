class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.string :company_name
      t.string :location
      t.string :salary
      t.string :job_type
      t.date :application_deadline
      t.references :user, null: false, foreign_key: true
      t.string :status
      t.string :slug

      t.timestamps
    end
    add_index :jobs, :slug, unique: true
  end
end
