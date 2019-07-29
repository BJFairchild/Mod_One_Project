class User < ActiveRecord::Base
    has_many :sessions
    has_many :questions, through: :sessions
end