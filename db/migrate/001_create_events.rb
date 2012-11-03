class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.date :date
      t.string :place
      t.integer :budget
      t.text :context

      t.timestamps
    end
  end
end
