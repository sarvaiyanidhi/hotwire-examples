class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :task, null: false, foreign_key: true
      t.string :author

      t.timestamps
    end
  end
end
