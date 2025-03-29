class AddPaidAtToJobs < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :paid_at, :datetime
  end
end
