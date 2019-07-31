require_relative '../config/environment'

#TRIVIA_API = "https://opentdb.com/api.php?amount=1&#difficulty=easy&type=multiple"

class CLI
    def self.run
        puts "Welcome to Trivia!"
        puts "Have you played before (y/n)?"
        played_before= STDIN.gets.chomp
        if played=("y" || "yes")
            puts "Awesome! Face recognition is having technical difficulties today. Please give us your first and last name :)"
            name_input= STDIN.gets.chomp
            User.find_by(name: name_input)
        elsif played = ("n" || "no")
            puts "Well what's that first and last name then?"
            new_user_input= STDIN.gets.chomp
            User.create(name: new_user_input)
        else
            puts "*Does not compute*"
            self.run
        end

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


end

    

