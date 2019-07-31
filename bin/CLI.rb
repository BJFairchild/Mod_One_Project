require_relative '../config/environment'

TRIVIA_API = "https://opentdb.com/api.php?amount=1&difficulty=easy&type=multiple"

class CLI
    def self.run
        puts "Welcome to Trivia!"
        puts

        is_running = true
        while is_running
            self.main_menu
            choice = STDIN.gets.chomp
            # exit
            if choice == "0"
                is_running = false
            # elsif choice == "1" || choice == "easy"
            #     self.trivia_easy
            # elsif choice == "2" || choice == "medium"
            #     self.trivia_medium
            # elsif choice == "3" || choice == "hard"
            #     self.trivia_hard
            elsif choice == "4" || choice == "surprise me"
                self.trivia_all
            else
                puts "Invalid choice."
            end
        end
    end

    def self.main_menu
        puts "What would you like to do?"
        puts
        # puts "0. exit"
        # puts "1. easy"
        # puts "2. medium"
        # puts "3. hard"
        puts "4. surprise me"
        puts
    end

    # def self.trivia_easy
    #     puts
    #     puts Question.column_names=question_text.sample
    # end

    # def self.trivia_medium
    #     puts
    #     puts Question.column_names=question_text.sample
    # end

    # def self.trivia_hard
    #     puts
    #     puts Question.column_names=question_text.sample
    # end

    def self.trivia_all
        puts
        x = Question.all.sample
        ca = x.correct_answer
        ia1 = x.incorrect_answer
        ia2 = x.incorrect_answer_two
        ia3 = x.incorrect_answer_three
        current_question_array = []
        current_question_array << ca
        current_question_array << ia1
        current_question_array << ia2
        current_question_array << ia3
        answers_list = current_question_array.shuffle
        a1 = answers_list[0]
        a2 = answers_list[1]
        a3 = answers_list[2]
        a4 = answers_list[3]
        puts x.question_text

        puts a1
        puts a2
        puts a3
        puts a4

        user_answer = STDIN.gets.chomp
        binding.pry
    end

    



    # def self.randomize_question
    #     x = Question.all.sample
    #     ca = x.correct_answer
    #     ia1 = x.incorrect_answer
    #     ia2 = x.incorrect_answer_two
    #     ia3 = x.incorrect_answer_three
    #     current_question_array = []
    #     current_question_array << ca
    #     current_question_array << ia1
    #     current_question_array << ia2
    #     current_question_array << ia3
    #     answers_list = current_question_array.shuffle
    #     a1 = answers_list[0]
    #     a2 = answers_list[1]
    #     a3 = answers_list[2]
    #     a4 = answers_list[3]
    # end

end

    

