
class CreateCouncilmen < ActiveRecord::Migration[5.2]
  def change
    create_table :councilmen do |t|
      t.string :name
      t.string :nickname
      t.string :political_party
      t.integer :political_position
      t.references :political_mandate, foreign_key: true

      t.timestamps
    end
  end
end
