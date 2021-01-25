@students = [] # an empty array accessible to all methods

=begin
students = [
  {name: "Dr. Hannibal Lecter", cohort: :November},
  {name: "Darth Vader", cohort: :November},
  {name: "Nurse Ratched", cohort: :November},
  {name: "Michael Corleone", cohort: :November},
  {name: "Alex DeLarge", cohort: :November},
  {name: "The Wicked Witch of the West", cohort: :November},
  {name: "Terminator", cohort: :November},
  {name: "Freddy Krueger", cohort: :November},
  {name: "The Joker", cohort: :November},
  {name: "Joffrey Baratheon", cohort: :November},
  {name: "Norman Bates", cohort: :November}
]
=end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end


def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = gets.chomp
  while !name.empty? do # while name is NOT empty
    @students << {name: name, cohort: :November}
    puts "Now we have #{@students.count} students"
    name = STDIN.gets.chomp
  end
end


def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "I don't know what you meant, please try again"
  end
end

def show_students
  print_header
  print_students_list
  print_footer
end


def print_header
  puts "The students of Villains Academy"
  puts "-------------\n"
end

def print_students_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students.\n"
end  

def load_students(filename = "students.csv")
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",") # assign two vars in one go (Parallel assignment)
    @students << {name: name, cohort: cohort.to_sym}
    end
    file.close
end

def save_students
  # open file for viewing
  file = File.open("students.csv", "w") # use "a" to append instead of (over)write
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def try_load_students
  puts "hi"
  filename = ARGV.first # first arg from command line
  return if filename.nil? # get out the method if no file given
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

try_load_students
interactive_menu

=begin
students = input_students
print_header
print(students)
print_footer(students)
=end