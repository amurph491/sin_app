class CreateTemperatureData < ActiveRecord::Migration
  def up
  	create_table :temp_recordings do |t|
  		t.string :temp
  	end
  	add_index :temp_recordings, :temp
  end

  def down
  	drop_table :temp_recordings
  end
end
