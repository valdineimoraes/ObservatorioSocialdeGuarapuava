

class CreateSessionCouncilmen < ActiveRecord::Migration[5.2]
  def change
    create_table :session_councilmen do |t|
      t.references :meeting, foreign_key: true
      t.references :councilman, foreign_key: true
      t.time :arrival
      t.time :leaving
      t.text :note

      t.timestamps
    end
  end
end
