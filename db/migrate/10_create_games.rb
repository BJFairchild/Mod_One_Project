class CreateGames < ActiveRecord::Migration[5.2]
    def change
        create_table :games do |t|
            t.string :user_id
            t.integer :total_score
        end
    end
end