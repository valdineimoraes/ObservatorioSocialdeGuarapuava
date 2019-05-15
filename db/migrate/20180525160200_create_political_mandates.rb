class CreatePoliticalMandates < ActiveRecord::Migration[5.2]
  def change
    create_table :political_mandates do |t|
      t.date :first_period
      t.date :final_period
      t.string :description

      t.timestamps
    end
  end
end
