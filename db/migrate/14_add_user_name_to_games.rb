class AddUserNameToGames< ActiveRecord::Migration[5.2]
    def change
        add_column :games, :user_name, :string
    end
end