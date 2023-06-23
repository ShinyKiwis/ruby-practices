class Person
  attr_accessor :name, :age 
  @@count = 0
  def initialize(name, age)
    @name = name 
    @age = age 
    @@count+=1
  end

  def introduce
    puts "My name is #{@name}. I'm #{age} years old"
  end

  def total_count
    puts "Total number of people is #{@@count}"
  end

  def error 
    raise "JUST AN ERROR"
    rescue StandardError => e
      puts e.message
  end
end

# Task 7 
# Dùng hàm 'times' tạo 1 mảng 'people' 
# gồm 20 person với name là 'Person 1' cho đến 'Person 20', age của mỗi Person random từ 10 -> 90

people = []
20.times do |i|
  people.push(Person.new("Person#{i+1}", rand(10..90)))
end

# Task 8
# Với mảng 'people' lọc ra những Person có tuổi nhỏ hơn 18
puts "People who are younger than 18"
people.filter {|person| person.age < 18}.each do |person|
  person.introduce
end
puts "People who are older than 18"
people.filter {|person| person.age > 18}.each do |person|
  person.introduce
end

# Task 9
# Với mảng 'people' xóa những Person có tuổi nhỏ hơn 18

new_people = people.dup
puts "New people who are older than 18"
new_people.delete_if {|person| person.age <= 18 }.each do |person|
  person.introduce
end

# Task 10
# Sort mảng 'people' theo tuổi tăng dần.
puts "Age increasing"
people.sort_by{|person| person.age}.each do |person| 
  person.introduce
end

# Task 11 
# Sort mảng 'people' theo tuổi giảm dần.
puts "Age decreasing"
people.sort_by{|person| -person.age}.each do |person| 
  person.introduce
end

# Task 12
# Delete 1 phần tử ở vị trí xác định trong mảng 'people'
puts "Remove person at index 2"
p people.length
people.delete_at(2)
p people.length

# Task 13
# Tìm ra Person lớn tuổi nhất, Person nhỏ tuổi nhất.
people.max_by {|person| person.age }.introduce
people.max_by {|person| -person.age }.introduce

# Task 14
# Dùng CÁC vòng lặp trong Ruby và CÁC hàm (khả thi) của Array để tăng tuổi của 
# từng Person trong mảng 'people' lên 1.
p people.map {|person| person.age}

# Use for loop
for person in people do
  person.age +=1
end

# Use Each
people.each do |person|
  person.age += 1
end

# Use map
people.map {|person| person.age += 1}

p people.map {|person| person.age}

# Task 15
# Không dùng vòng lặp (dùng CÁC hàm của Array) lấy ra tất cả 
# các 'age' của các Person trong mảng 'person'
temp = people.map {|person| person.age}
p temp
temp = people.collect {|person| person.age}
p temp

# Task 16
# Tạo 1 mảng 'people_2' tương tự câu 7, nối mảng 'people_2' vào 'people' 
people2 = []
20.times do |i|
  people2.push(Person.new("Person#{i+1}", rand(10..90)))
end

people.concat(people2)
p people.length

# Task 17
# Viết 1 instance method bất kì, raise Exception (với message bất kì) 
# trong method đó, sau đó catch exception và in ra message của Exception đó.
people.each do |person|
  person.error
end
