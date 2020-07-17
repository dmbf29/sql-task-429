require "sqlite3"
DB = SQLite3::Database.new('tasks.db')
DB.results_as_hash = true
require_relative 'task'


# TODO: CRUD some tasks
task = Task.find(1) # this will return an instance
puts "#{task.title} - #{task.description}"

task = Task.new(title: 'drink beer', description: "it's Friday")
puts "Task before save"
p task.id
task.save
puts "Task after save w/id"
p task.id

task.title = "drink beer updated"
task.save

Task.all

task = Task.find(1)
task.destroy
task = Task.find(1)
puts "This should be nil"
p task




#
