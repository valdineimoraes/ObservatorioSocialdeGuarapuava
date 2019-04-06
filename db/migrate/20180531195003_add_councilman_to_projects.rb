

class AddCouncilmanToProjects < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :councilman, foreign_key: true
  end
end
