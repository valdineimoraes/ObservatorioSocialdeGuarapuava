class AddPresentToSessionCouncilmen < ActiveRecord::Migration[5.2]
  def change
    add_column :session_councilmen, :present, :boolean, default: false
  end
end
