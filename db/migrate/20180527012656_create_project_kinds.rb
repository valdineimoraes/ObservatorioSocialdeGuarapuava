
class CreateProjectKinds < ActiveRecord::Migration[5.2]
  def change
    create_table :project_kinds do |t|
      t.string :kind
      t.text :description

      t.timestamps
    end
  end
end
