require 'bundler'
Bundler.require

ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.logger.level = 1

ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: 'db/development.db'
)

require_all 'lib'
require_all 'bin'

#https://opentdb.com/api.php?amount=25&difficulty=easy&type=multiple
# API LINK