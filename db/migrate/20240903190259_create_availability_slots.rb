class CreateAvailabilitySlots < ActiveRecord::Migration[7.1]
  def change
    create_table :availability_slots do |t|
      t.references :teacher, null: false, foreign_key: { to_table: :users }
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
