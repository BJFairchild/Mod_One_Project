require_relative '../config/environment'
#TRIVIA_API = "https://opentdb.com/api.php?amount=1&#difficulty=easy&type=multiple"
class CLI

    def self.run
        puts
        puts "Welcome to Trivia!"
        puts "Have you played before (y/n)?"
        played_before= STDIN.gets.chomp
        if played_before ==("y" || "yes")
            puts "Awesome! Face recognition is having technical difficulties today. Please give us your first and last name :)"
            name_input= STDIN.gets.chomp
            $current_user = User.find_by(name: name_input)
        elsif played_before == ("n" || "no")
            puts "Well what's that first and last name then?"
            new_user_input= STDIN.gets.chomp
            $current_user= User.create(name: new_user_input)
        else
            puts
            puts "*Does not compute*"
            self.run
        end

        is_running = true
        while is_running
            self.main_menu
            choice = STDIN.gets.chomp
            # exit
            if choice == "0"
                puts "Maybe next time..."
                is_running = false
            # elsif choice == "1" || choice == "easy"
            #     self.trivia_easy
            # elsif choice == "2" || choice == "medium"
            #     self.trivia_medium
            # elsif choice == "3" || choice == "hard"
            #     self.trivia_hard
            elsif choice == "1" || choice == "Let's play!"  || choice == "play"
                puts "Great choice! Let's test that brain."
                $current_game = Game.create(user_id: $current_user.id, total_score: 0)
                self.trivia_all
            else
                puts "Invalid choice."
            end
        end
    end

    def self.main_menu
        puts "What would you like to do?"
        puts
        puts "0. exit"
        # puts "1. easy"
        # puts "2. medium"
        # puts "3. hard"
        puts "1. Let's play!"
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
        10.times do
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
            puts
            puts final_arr[0]
            puts final_arr[1]
            puts final_arr[2]
            puts final_arr[3]
            chosen= STDIN.gets.chomp.to_i
            if chosen == (correct_index +1)
                Session.create(user_id: $current_user.id, question_id: current_q.id, point_flag: true)
                puts "That's correct! Next question!"
                puts
            else puts "Wow you're dumb. The answer was obviously #{current_q.correct_answer}."
                puts
                Session.create(user_id: $current_user.id, question_id: current_q.id, point_flag: false)
            end
            
        end

        self.end_menu

    
        binding.pry
            
    end

    def self.end_menu
        binding.pry
        $current_game.total_score = Session.where(user_id: $current_user.id, point_flag: true).length
        
        puts "Congratulations! Your score was #{$current_game.total_score} out of 20!" ### Map this to game table

        puts "Your historic ratio is: #{Session.where(user_id: $current_user.id, point_flag: true).length}/#{Session.where(user_id: $current_user.id).length}"
        binding.pry

        sleep(3)
        puts
        puts "1. Play again!"
        puts
        puts "2. Exit"
        end_choice = STDIN.gets.chomp

        binding.pry
    end


    binding.pry


end


