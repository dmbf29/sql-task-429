require "pry-byebug"

class Task
  attr_reader :description, :id
  attr_accessor :title
  def initialize(attributes = {})
    @id = attributes[:id]
    @title = attributes[:title]
    @description = attributes[:description]
    @done = attributes[:done] || false
  end

  def self.all
    tasks = DB.execute('SELECT * FROM tasks')
    tasks.map do |task|
      Task.new(task.transform_keys(&:to_sym))
    end
  end

  def self.find(id)
    # find task in database
    task_hash = DB.execute('SELECT * FROM tasks WHERE tasks.id = ?', id).first
    # take id from task
    return task_hash if task_hash.nil?

    Task.new(task_hash.transform_keys(&:to_sym))

    # create task instance
  end

  def save
    id ? update : create
  end

  def destroy
    DB.execute('DELETE FROM tasks WHERE id = ?', id)
    puts "who is the rookie now??!?!?"
  end

  private

  def update
    DB.execute('UPDATE tasks SET title = ?, description = ? WHERE id = ?', title, description, id)
  end

  def create
    DB.execute('INSERT INTO tasks (title, description) VALUES (?, ?)', title, description)
    @id = DB.last_insert_row_id
  end

end
