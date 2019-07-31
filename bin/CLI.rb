require_relative '../config/environment'

TRIVIA_API = "https://opentdb.com/api.php?amount=1&difficulty=easy&type=multiple"

class CLI
    def self.run
        puts "Welcome to Trivia!"

        is_running = true
        while is_running
            self.main_menu
            choice = STDIN.gets.chomp
            # exit
            if choice == "0"
                is_running = false
            elsif choice == "1" || choice == "easy"
                self.trivia_easy
            elsif choice == "2" || choice == "medium"
                self.trivia_medium
            elsif choice == "3" || choice == "hard"
                self.trivia_hard
            elsif choice == "4" || choice == "surprise me"
                self.trivia_all
            else
                puts "Invalid choice."
            end
        end
    end

    def self.main_menu
        puts "What would you like to do?"
        puts "0. exit"
        puts "1. easy"
        puts "2. medium"
        puts "3. hard"
        puts "4. surprise me"
    end

    def self.trivia_easy
        puts Question.column_names=question_text.sample
    end

    def self.trivia_medium
        puts Question.column_names=question_text.sample
    end

    def self.trivia_hard
        puts Question.column_names=question_text.sample
    end

    def self.trivia_all
        puts Question.all.sample.question_text
    end
end
