#all_q = []
# master_questions = JSON.parse(RestClient.get("https://opentdb.com/api.php?amount=50&difficulty=easy&type=multiple"))
    

# 5.times do
#     #master_questions = JSON.parse(RestClient.get("https://opentdb.com/api.php?amount=50&difficulty=easy&type=multiple"))
#     master_questions.each do |q|
#         all_q << q[1]
#     end
#     binding.pry
# end
# binding.pry
# puts "no"

class APICommunicator
    def self.load
        1000.times do
            m_q = JSON.parse(RestClient.get("https://opentdb.com/api.php?amount=1&type=multiple"))

            Question.find_or_create_by(question_text: m_q["results"][0]["question"]) do |ques|
                Question.correct_answer = m_q["results"][0]["correct_answer"],
                Question.incorrect_answer = m_q["results"][0]["incorrect_answers"][0],
                Question.incorrect_answer_two = m_q["results"][0]["incorrect_answers"][1],
                Question.incorrect_answer_three = m_q["results"][0]["incorrect_answers"][2],
                Question.catagory = m_q["results"][0]["category"]
                Question.difficulty = m_q["results"][0]["difficulty"]
            end
        end
    end
end


            
            
        #Question.new(question_text: results[question], "Some location in your questions hash", "Some location in your questions hash", "Some location in your questions hash", "Some location in your questions hash")
        