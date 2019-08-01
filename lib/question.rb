class Question < ActiveRecord::Base
    has_many :sessions
    has_many :users, through: :sessions
    #belongs_to :catagory
end