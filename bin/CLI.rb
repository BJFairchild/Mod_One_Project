require_relative '../config/environment'

#TRIVIA_API = "https://opentdb.com/api.php?amount=1&#difficulty=easy&type=multiple"

class CLI
    def self.run
        puts "Welcome to Trivia!"
<<<<<<< HEAD
        puts
=======
        puts "Have you played before (y/n)?"
        played_before= STDIN.gets.chomp
        if played=("y" || "yes")
            puts "Awesome! Face recognition is having technical difficulties today. Please give us your first and last name :)"
            name_input= STDIN.gets.chomp
            User.find_by(name: name_input)
        elsif played = ("n" || "no")
            puts "Well what's that first and last name then?"
            new_user_input= STDIN.gets.chomp
            User.create(name :new_user_input)
        else
            puts "*Does not compute*"
            self.run
        end
>>>>>>> e377a784253d7cd702c2209c2621023f78f7c38f

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
<<<<<<< HEAD
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

=======
        current_q= Question.all.sample
        #binding.pry
        question_arr= [current_q.correct_answer,
            current_q.incorrect_answer,
            current_q.incorrect_answer_two,
            current_q.incorrect_answer_three]
        final_arr= question_arr.shuffle
        correct_index= final_arr.index do |ques|
            ques.include?(current_q.correct_answer)
        end

        puts current_q.question_text
        puts final_arr[0]
        puts final_arr[1]
        puts final_arr[2]
        puts final_arr[3]
        chosen= STDIN.gets.chomp.to_i
        if chosen == (correct_index +1)
            #Session.new(3, current_q.id, true)
            puts "added point flag"
        else puts "did not add flag"
        end
        puts "chosen value"
        puts chosen
        puts "correct index"
        puts correct_index
        
    end

    #binding.pry

    self.trivia_all


>>>>>>> e377a784253d7cd702c2209c2621023f78f7c38f
end

    

