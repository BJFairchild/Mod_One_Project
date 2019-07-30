class AddCatagoryIdToQuestions < ActiveRecord::Migration[5.2]
    def change
        add_column :questions, :catagory_id, :integer
    end
end