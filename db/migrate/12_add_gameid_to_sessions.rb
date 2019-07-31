class AddGameidToSessions < ActiveRecord::Migration[5.2]
    def change
        add_column :sessions, :game_id, :integer
    end
end