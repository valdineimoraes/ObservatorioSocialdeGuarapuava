class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :project, foreign_key: true
      t.references :councilman, foreign_key: true
      t.integer :vote

      t.timestamps
    end
  end
end
