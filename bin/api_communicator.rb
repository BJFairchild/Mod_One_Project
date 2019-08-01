#require_relative '../config/environment'
require 'pry'
require 'json'
require 'rest-client'
require_relative '../lib/question.rb'

class APICommunicator
    def self.load
        200.times do
            self.generate
        end
    end
    
    def self.generate     
            m_q = JSON.parse(RestClient.get("https://opentdb.com/api.php?amount=1&type=multiple"))

            Question.create(
                question_text: m_q["results"][0]["question"].gsub("&quot;", '"').gsub("&#039;", "'").gsub("&eacute;", "e").gsub("&amp;", "&").gsub("&oacute;", "o").gsub("&aacute;", "a").gsub("&ouml;", "o").gsub("&aring;", "a").gsub("&auml;", "a").gsub("&ntilde;", "n").gsub("&shy;", ""), 
                correct_answer: m_q["results"][0]["correct_answer"].gsub("&quot;", '"').gsub("&#039;", "'").gsub("&eacute;", "e").gsub("&amp;", "&").gsub("&oacute;", "o").gsub("&aacute;", "a").gsub("&ouml;", "o").gsub("&aring;", "a").gsub("&auml;", "a").gsub("&ntilde;", "n").gsub("&shy;", ""), 
                incorrect_answer: m_q["results"][0]["incorrect_answers"][0].gsub("&quot;", '"').gsub("&#039;", "'").gsub("&eacute;", "e").gsub("&amp;", "&").gsub("&oacute;", "o").gsub("&aacute;", "a").gsub("&ouml;", "o").gsub("&aring;", "a").gsub("&auml;", "a").gsub("&ntilde;", "n").gsub("&shy;", ""), 
                incorrect_answer_two: m_q["results"][0]["incorrect_answers"][1].gsub("&quot;", '"').gsub("&#039;", "'").gsub("&eacute;", "e").gsub("&amp;", "&").gsub("&oacute;", "o").gsub("&aacute;", "a").gsub("&ouml;", "o").gsub("&aring;", "a").gsub("&auml;", "a").gsub("&ntilde;", "n").gsub("&shy;", ""), 
                incorrect_answer_three: m_q["results"][0]["incorrect_answers"][2].gsub("&quot;", '"').gsub("&#039;", "'").gsub("&eacute;", "e").gsub("&amp;", "&").gsub("&oacute;", "o").gsub("&aacute;", "a").gsub("&ouml;", "o").gsub("&aring;", "a").gsub("&auml;", "a").gsub("&ntilde;", "n").gsub("&shy;", ""), 
                catagory: m_q["results"][0]["category"],
                difficulty: m_q["results"][0]["difficulty"]
                )
                
    end

            # Question.find_or_create_by(question_text: m_q["results"][0]["question"]) do |ques|
            #     ques.correct_answer = m_q["results"][0]["correct_answer"],
            #     ques.incorrect_answer = m_q["results"][0]["incorrect_answers"][0],
            #     ques.incorrect_answer_two = m_q["results"][0]["incorrect_answers"][1],
            #     ques.incorrect_answer_three = m_q["results"][0]["incorrect_answers"][2],
            #     ques.catagory = m_q["results"][0]["category"],
            #     ques.difficulty = m_q["results"][0]["difficulty"]
            #end
end
binding.pry
0