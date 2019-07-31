# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 12) do

  create_table "catagories", force: :cascade do |t|
    t.string "title"
  end

  create_table "games", force: :cascade do |t|
    t.integer "total_score"
  end

  create_table "questions", force: :cascade do |t|
    t.string "question_text"
    t.string "correct_answer"
    t.string "incorrect_answer"
    t.string "incorrect_answer_two"
    t.string "incorrect_answer_three"
    t.string "difficulty"
    t.string "catagory"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "question_id"
    t.boolean "point_flag"
    t.integer "game_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
  end

end
