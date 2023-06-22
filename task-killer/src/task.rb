class Task 
  attr_accessor :id, :title, :content, :priority 

  def initialize(id, title, content, priority = 1)
    @id = id
    @title = title
    @content = content 
    @priority = priority
  end

  def []=(key, value)
    instance_variable_set("@#{key}", value)
  end
end