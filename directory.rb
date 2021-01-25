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
    puts "Action completed successfully - choose the next task"
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

def choose_filename
  puts "Enter a filename w extension e.g. students.csv"
  file_selected = STDIN.gets.chomp
  file_selected = "students.csv" if file_selected.empty?
  file_selected
end


def print_input_statements(location = "intro")
  if location == "intro"
    puts "Please enter the names of the students"
    puts "To finish, just hit return twice"
  else
    puts "Now we have #{@students.count} students" 
  end
end  

def input_students
  print_input_statements("intro")
  name = STDIN.gets.chomp
  while !name.empty? do # while name is NOT empty
    add_student("input_student", name, :November)
    # @students << {name: name, cohort: :November}
    print_input_statements("add_user")
    name = STDIN.gets.chomp
  end
end

def load_students(filename = "students.csv")
  file_name = choose_filename
  File.open(file_name, "r") { |file| 
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",") # (Parallel assignment)
    add_student("load_student", name, cohort)
  end}

end

def add_student(use_case, name, cohort)
  cohort = cohort.to_sym if use_case == "load_student"
  @students << {name: name, cohort: cohort}
end  


def save_students
  # open file for viewing
  file_name = choose_filename
  File.open(file_name, "w") { |file| # auto saves file after opening
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end}
end

def try_load_students
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