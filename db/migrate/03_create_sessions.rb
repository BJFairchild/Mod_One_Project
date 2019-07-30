class CreateSessions < ActiveRecord::Migration[5.2]
    def change
        create_table :sessions do |t|
            t.integer :user_id
            t.integer :question_id
            t.boolean :point_flag
        end
    end
end