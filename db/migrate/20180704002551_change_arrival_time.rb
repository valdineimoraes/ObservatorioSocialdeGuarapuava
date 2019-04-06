

class ChangeArrivalTime < ActiveRecord::Migration[5.2]
  def change
    change_column :session_councilmen, :arrival, :time, default: '00:00:00'
    # Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
