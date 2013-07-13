class CreateSearchTable < ActiveRecord::Migration
  def up
     create_table :searches do |t|
      t.string :twitter_handle
      t.integer :frequency
      t.timestamps
     end

  end

  def down
    drop_table :searches
  end
end
