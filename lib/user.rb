class User < ActiveRecord::Base
    has_many :sessions
    has_many :games
    has_many :questions, through: :sessions
end