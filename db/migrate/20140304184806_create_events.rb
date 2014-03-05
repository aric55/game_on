class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.date :dateheld

      t.timestamps
    end
    add_index :events, :dateheld
  end
end
