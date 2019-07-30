class ModifyQuestionsSchema < ActiveRecord::Migration[5.2]
    def change
        add_column :questions, :difficulty, :string
        remove_column :questions, :catagory_id, :integer
        add_column :questions, :catagory, :string
    end
end
