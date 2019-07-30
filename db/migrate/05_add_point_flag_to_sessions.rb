class AddPointFlagToSessions < ActiveRecord::Migrate[5.2]
    def change
        add_column :sessions, :point_flag, :boolean
    end
end