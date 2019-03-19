# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.references :meeting, foreign_key: true
      t.string :name
      t.text :description
      t.references :project_kind, foreign_key: true
      t.time :start_project
      t.time :end_project
      t.integer :result

      t.timestamps
    end
  end
end
