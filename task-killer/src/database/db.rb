require 'sqlite3'

class Database 
  def initialize
    @db = SQLite3::Database.new "task-killer"
    create_table()
  end

  def create_table
    @db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title varchar(255) NOT NULL ,
        content varchar(255) NOT NULL,
        priority INTEGER NOT NULL
      );
    SQL
  end

  def get_current_ID 
    raw_data =  @db.execute("SELECT seq from sqlite_sequence WHERE name='tasks'")
    return 1 if raw_data[0].nil?
    raw_data[0][0]+1
  end

  def insert_task(title, content, priority)
    @db.execute("
      INSERT INTO tasks (title, content, priority)
      VALUES (?,?,?)", [title, content, priority])
  end

  def get_tasks
    @db.execute("SELECT * FROM tasks")
  end

  def update_task(id, field, value)
    @db.execute("UPDATE tasks SET #{field}='#{value}' WHERE id=#{id}")
  end

  def delete_task(id)
    @db.execute("DELETE FROM tasks WHERE id=#{id}")
  end
end

