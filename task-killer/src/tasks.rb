require_relative "task.rb"
require_relative "database/db.rb"

class Tasks
  attr_accessor :task_list

  def initialize()
    @database = Database.new
    @task_list = []
    @database.get_tasks.each do |task|
      @task_list.push(Task.new(task[0], task[1], task[2], task[3]))
    end
    @current_id = @database.get_current_ID()
    # p @current_id
    # gets.chomp
    sort_task()
  end

  def get_tasks 
    @task_list
  end

  def update_task(id, field, value)
    @task_list.each do |task|
      if task.id == id
        task[field.to_sym] = value
        @database.update_task(id,field,value)
      end
    end
  end

  def sort_task 
    @task_list.sort_by! {|task| -task.priority}
  end

  def get_tasks_list_length 
    @task_list.length
  end

  def get_task_by_id(id)
    @task_list.each do |task|
      return task if task.id == id 
    end
    return nil
  end

  def add_task(title, content, priority)
    @task_list.push(Task.new(@current_id, title, content, priority))
    @current_id+=1
    @database.insert_task(title, content, priority)
    sort_task
  end

  def delete_task(id)
    @task_list.delete_if { |task | task.id==id }
    @database.delete_task(id)
  end
end