class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :status
      t.integer :priority

      t.timestamps
    end
  end
end
