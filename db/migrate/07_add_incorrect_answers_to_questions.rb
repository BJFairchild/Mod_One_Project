class AddIncorrectAnswersToQuestions < ActiveRecord::Migration[5.2]
    def change
        add_column :questions, :incorrect_answer_two, :string
        add_column :questions, :incorrect_answer_three, :string
    end
end