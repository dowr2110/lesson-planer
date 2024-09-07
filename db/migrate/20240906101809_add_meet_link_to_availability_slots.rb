class AddMeetLinkToAvailabilitySlots < ActiveRecord::Migration[7.1]
  def change
    add_column :availability_slots, :meet_link, :string
  end
end
