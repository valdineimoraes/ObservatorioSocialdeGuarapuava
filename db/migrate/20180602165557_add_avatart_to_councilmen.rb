# frozen_string_literal: true

class AddAvatartToCouncilmen < ActiveRecord::Migration[5.2]
  def change
    add_column :councilmen, :avatar, :string
  end
end
