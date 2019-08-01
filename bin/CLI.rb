require_relative '../config/environment'
require_relative './api_communicator'
#TRIVIA_API = "https://opentdb.com/api.php?amount=1&#difficulty=easy&type=multiple"
class CLI

    def self.run
        puts
        puts "Welcome to Trivia!"
        puts "Have you played before (y/n)?"
        played_before= STDIN.gets.chomp.downcase
        if played_before ==("y" || "yes")
            puts "Awesome! Face recognition is having technical difficulties today. Please give us your first and last name :)"
            name_input= STDIN.gets.chomp.downcase
            if name_input == User.find_by(name: name_input)
                $current_user = User.find_by(name: name_input)
            else
                puts "Writing comprehension 101. Spell your name right."
                self.run
            end
        elsif played_before == ("n" || "no")
            puts "Well what's that first and last name then?"
            new_user_input= STDIN.gets.chomp.downcase
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
            if choice == "2"
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
                $current_game = Game.create(total_score: 0, user_id: $current_user)
                self.trivia_all
            else
                puts "Invalid choice."
            end
        end
    end

    def self.main_menu
        puts "What would you like to do?"
        puts
        puts "1. Let's play!"
        # puts "1. easy"
        # puts "2. medium"
        # puts "3. hard"
        puts "2. Exit."
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
        20.times do
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
            puts "1. #{final_arr[0]}"
            puts "2. #{final_arr[1]}"
            puts "3. #{final_arr[2]}"
            puts "4. #{final_arr[3]}"
            insults= ["Are you trying?", "Bad day?", "Go pull a Gordon Ramsey API.", "I think thou never wast where grace was said.", "I'm guessing you weren't burdened with an overabundance of schooling.", "You're impossible to underestimate.", "You're the Yelp of people.", "Mr. Rogers would be disappointed in the person you are.", "Yelp called and wants its prize employee back.", "Not even an assassin would take you out."]
            chosen= STDIN.gets.chomp.to_i
            if chosen == (correct_index +1)
                Session.create(user_id: $current_user.id, question_id: current_q.id, point_flag: true, game_id: $current_game.id)
                puts "That's correct! Next question!"
                puts
            else puts
                puts "#{insults.sample} The answer was obviously #{current_q.correct_answer}."
                puts
                Session.create(user_id: $current_user.id, question_id: current_q.id, point_flag: false, game_id: $current_game.id)
            end
            
        end

        self.end_menu

    
        #binding.pry
            
    end

    def self.end_menu
        $current_game.update_column(:total_score, Session.where(user_id: $current_user.id, point_flag: true, game_id: $current_game.id).length)
        
        puts "Congratulations! Your score was #{Session.where(user_id: $current_user.id, point_flag: true, game_id: $current_game.id).length} out of 20!"

        puts "Your historic ratio is: #{Session.where(user_id: $current_user.id, point_flag: true).length}/#{Session.where(user_id: $current_user.id).length}"
        #binding.pry

        # puts high_score

        sleep(3)
        puts
        puts "1. Play again!"
        puts "2. Exit"
        end_choice = STDIN.gets.chomp
        if end_choice == "1"
            self.run
        elsif end_choice == "2"
            puts "Thanks for playing!"
            is_running = false
        else
            puts "Press 1 or 2. Reading comprehension 101."
            self.end_menu
        end

    
    end

    def self.high_scores_list
        #ordered_list= 
        top_five= Game.all.order(total_score: :desc).limit(5)
    end

    # def self.high_score
    #     high= Game.where(user_id: $current_user.id).max_by do |max| max.total_score
    #         binding.pry
    #     end
    #     puts "Your highest score is: #{high}"
    # end

    
    def self.high_scores_ids
        i=0
        high_ids= []
        while i < high_scores_list.length
            session_match = Session.all.find do |sessions|
                sessions.game_id == high_scores_list[i]["id"]
            
            end
            high_ids << session_match
            i+=1
        end
        return high_ids
    end
    
    def self.high_scores_names
        i=0
        high_names=[]
        while i < high_scores_ids.length
            user_match = User.all.find do |users|
                users.id == high_scores_ids[i]["user_id"]
            end
            i+=1
            high_names << user_match
        end
        binding.pry
        return high_names
    end


    def self.best_category
    end

end


# high_scores_ids

CLI.high_scores_ids
CLI.high_scores_names
CLI.high_scores_list

