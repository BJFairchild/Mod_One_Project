require_relative '../config/environment'
require_relative './api_communicator'
#TRIVIA_API = "https://opentdb.com/api.php?amount=1&#difficulty=easy&type=multiple"
class CLI

    def self.run
        sleep(1)
        puts `clear`
        puts
        puts "Welcome to Trivia!"
        puts "Please enter your name."
        # played_before= STDIN.gets.chomp.downcase
        # if played_before ==("y" || "yes")
        #     puts "Awesome! Face recognition is having technical difficulties today. Please give us your first and last name."
        name_input= STDIN.gets.chomp.downcase
        $current_user = User.find_or_create_by(name: name_input)
            # if name_input == User.find_by(name: name_input).name
            #     $current_user = User.find_by(name: name_input)
            # else
            #     puts "If you can't spell your name correctly, we're going to have problems. Please try again."
            #     self.run
            # end
        # elsif played_before == ("n" || "no")
        #     puts "Well what's that first and last name then?"
        #     new_user_input= STDIN.gets.chomp.downcase
        #     $current_user= User.create(name: new_user_input)
        # else
        #     puts
        #     puts "*Does not compute*"
        #     self.run
        # end

        is_running = true
        while is_running
            self.main_menu
            choice = STDIN.gets.chomp.downcase
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
                sleep(2)
                $current_game = Game.create(total_score: 0, user_id: $current_user.id, user_name: $current_user.name)
                self.trivia_all
            else
                puts "Invalid choice."
                sleep(1)
            end
        end
    end

    def self.main_menu
        puts `clear`
        puts "What would you like to do?"
        puts
        puts "1. Let's play!"
        puts "2. Exit."
        puts
    end

    def self.trivia_all
        20.times do
            current_q= Question.all.sample
            question_arr= [current_q.correct_answer,
                current_q.incorrect_answer,
                current_q.incorrect_answer_two,
                current_q.incorrect_answer_three]
            final_arr= question_arr.shuffle
            correct_index= final_arr.index do |ques|
                ques.include?(current_q.correct_answer)
            end
            puts `clear`

            puts current_q.question_text
            puts
            puts "1. #{final_arr[0]}"
            puts "2. #{final_arr[1]}"
            puts "3. #{final_arr[2]}"
            puts "4. #{final_arr[3]}"
            puts
            puts "The current category is: #{current_q.catagory}"
            puts
            puts "ART PLACEHOLDER"
            puts
            insults= ["Are you trying?", "Bad day?", "I think thou never wast where grace was said.", "I'm guessing you weren't burdened with an overabundance of schooling.", "You're impossible to underestimate.", "You're the Yelp of people.", "Mr. Rogers would be disappointed in you.", "Yelp called and wants its prize employee back.", "Not even an assassin would take you out."]
            chosen= STDIN.gets.chomp.to_i
            while chosen < 1
                puts "requerying"
                chosen= STDIN.gets.chomp.to_i
            end
            if chosen == (correct_index +1)
                Session.create(user_id: $current_user.id, question_id: current_q.id, point_flag: true, game_id: $current_game.id)
                puts "That's correct! Next question!"
                puts
                sleep(1)
            elsif chosen > 4
                puts "That's not even a valid option... WRONG!"
                Session.create(user_id: $current_user.id, question_id: current_q.id, point_flag: false, game_id: $current_game.id)
                sleep(1)
            # elsif chosen.is_a?(Integer) == false
            #     puts "That's not even a number! WRONG!"
            #     Session.create(user_id: $current_user.id, question_id: current_q.id, point_flag: false, game_id: $current_game.id)
            else puts
                puts "#{insults.sample} The correct answer was #{current_q.correct_answer}."
                puts
                Session.create(user_id: $current_user.id, question_id: current_q.id, point_flag: false, game_id: $current_game.id)
                sleep(3)
            end
            
        end

        self.end_menu
            
    end

    def self.end_menu
        sleep(1)
        puts `clear`
        $current_game.update_column(:total_score, Session.where(user_id: $current_user.id, point_flag: true, game_id: $current_game.id).length)
        
        puts "Congratulations! Your score was #{Session.where(user_id: $current_user.id, point_flag: true, game_id: $current_game.id).length} out of 20!"

        puts "Your historic ratio is: #{Session.where(user_id: $current_user.id, point_flag: true).length}/#{Session.where(user_id: $current_user.id).length}"

        puts
        puts
        self.high_score
        puts
        puts
        self.high_scores_list

        sleep(3)
        puts
        puts "1. Play again!"
        puts "2. Exit"
        end_choice = STDIN.gets.chomp.downcase
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
        top_five= Game.all.order(total_score: :desc).limit(5)
        puts "FIRST PLACE!! #{top_five[0].user_name} with #{top_five[0].total_score}"
        puts "SECOND PLACE! #{top_five[1].user_name} with #{top_five[1].total_score}"
        puts "THIRD: #{top_five[2].user_name} with #{top_five[2].total_score}"
        puts "Fourth place: #{top_five[3].user_name} with #{top_five[3].total_score}"
        puts "FifTH PlAcE: #{top_five[4].user_name} with #{top_five[4].total_score}"
    end

    def self.high_score
        high = Game.where(user_id: $current_user.id).max_by do |max| max.total_score
        end
        puts "Your highest score is: #{high.total_score}"
        
    end


    ###########################3 hours of work I feel guilty deleting##########################
    ###########################################################################################
    ###########################################################################################
    ###########################################################################################
    # def self.high_scores_ids
    #     i=0
    #     high_ids= []
    #     while i < high_scores_list.length
    #         session_match = Session.all.find do |sessions|
    #             sessions.game_id == high_scores_list[i]["id"]
            
    #         end
    #         high_ids << session_match
    #         i+=1
    #     end
    #     return high_ids
    # end
    
    # def self.high_scores_names
    #     i=0
    #     high_names=[]
    #     while i < high_scores_ids.length
    #         user_match = User.all.find do |users|
    #             users.id == high_scores_ids[i]["user_id"]
    #         end
    #         i+=1
    #         high_names << user_match
    #     end
    #     binding.pry
    #     return high_names
    # end
    ###########################3 hours of work I feel guilty deleting##########################
    ###########################################################################################
    ###########################################################################################
    ###########################################################################################

  

end
CLI.run


