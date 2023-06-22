require_relative "tasks.rb"
require 'terminal-table'

class App
  def initialize
    @task_list = Tasks.new
  end

  def run
    begin
      loop do
        puts "\e[H\e[2J"
        dashboard_message()
        prompt_action()
      end
    rescue Interrupt
      puts "\e[H\e[2J"
      puts "See you later"
    end
  end

  def display_task_list(task_list)
    rows = []
    task_list.each do |task|
      rows.push([task.id, task.title, {:value => task.priority, :alignment => :center}])
    end

    table = Terminal::Table.new(:headings => ["ID", "Title", "Priority"], :rows => rows)
    table.style = {
      :border => :unicode,
    }

    puts table
    
  end
  def prompt_action 
    print "Choose action - Add(A), Delete(D), Edit(E), View(V): "
    loop do
      action = gets.chomp.downcase
      case true
      when action == 'add' || action == 'a'
        add_task()
      when action == 'delete' || action == 'd'
        delete_task()
      when action == 'edit' || action =='e'
        edit_task()
      when action == 'view' || action == 'v'
        view_task()
      else
        puts "Invalid Action!"
        puts "Press Enter to continue"
        gets.chomp
      end
      break
    end
  end

  def green(message)
    message.colorize(:color => :green)
  end

  def blue(message)
    message.colorize(:color => :blue)
  end

  def dashboard_message 
    puts green("Your task list has #{@task_list.get_tasks_list_length} task(s):\n")
    display_task_list(@task_list.get_tasks) if @task_list.get_tasks_list_length != 0
  end

  def add_task 
    print blue("Title: ")
    title = gets.chomp
    print blue("Content: ")
    content = gets.chomp
    print blue("Priority(1-5) - Default is 1: ")
    priority = gets.chomp.to_i 
    @task_list.add_task(title, content, priority)
  end

  def delete_task 
    print blue("ID of task to be deleted: ")
    id = gets.chomp.to_i
    task = @task_list.get_task_by_id(id)
    if !task.nil?
      @task_list.delete_task(id)
    else
      puts "Invalid ID or list is empty!"
    end
    puts "Press Enter to continue"
    gets.chomp
  end

  def edit_task 
    print blue("ID of task to be edited: ")
    id = gets.chomp.to_i
    task = @task_list.get_task_by_id(id)
    if !task.nil?
      loop do
        puts green("1. Title")
        puts green("2. Content")
        puts green("3. Priority")
        puts green("4. Finish")
        print blue("Choose field to edit: ")
        option = gets.chomp.to_i
        case option 
        when 1
          puts "Old title: #{task.title}"
          print blue("New title: ")
          new_title = gets.chomp
          @task_list.update_task(id, "title", new_title)
        when 2
          puts "Old content: #{task.content}"
          print blue("New content: ")
          new_content = gets.chomp
          @task_list.update_task(id, "content", new_content)
        when 3
          puts "Old priority: #{task.priority}"
          print blue("New priority (1-5): ")
          new_priority = gets.chomp
          @task_list.update_task(id, "priority", new_priority)
        else
          break
        end
      end
    else
      puts "Invalid ID or list is empty!"
    end
    puts "Press Enter to continue"
    gets.chomp
  end

  def view_task
    print blue("ID of task to be viewed: ")
    id = gets.chomp.to_i
    task = @task_list.get_task_by_id(id)
    if !task.nil?
      puts "\e[H\e[2J"
      puts blue("[Task information]")
      puts "#{blue("ID")}: #{task.id}"
      puts "#{blue("Title")}: #{task.title}"
      puts "#{blue("Content")}: #{task.content}"
      puts "#{blue("Priority")}: #{task.priority}"
    else
      puts "Invalid ID or list is empty!"
    end
    puts "Press Enter to continue"
    gets.chomp
  end
end 