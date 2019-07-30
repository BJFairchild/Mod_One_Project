require_relative '../config/environment'

TRIVIA_API = "https://opentdb.com/api.php?amount=25&difficulty=easy&type=multiple"

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
            elsif choice == "1" || choice == "play"
                self.trivia
            else
                puts "Invalid choice."
            end
        end
    end

    def self.main_menu
        puts "What would you like to do?"
        puts "0. exit"
        puts "1. play"
    end

    def self.trivia
    end