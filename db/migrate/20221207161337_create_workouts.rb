class CreateWorkouts < ActiveRecord::Migration[6.0]
  def change
    create_table :workouts do |t|
      t.string :workout
      t.string :image
      t.integer :owner_id
      t.datetime :time
      t.integer :joins_count

      t.timestamps
    end
  end
end
