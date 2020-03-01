file = File.open("5desk.txt", "r")
@save_file = File.open("savefile.txt", "w")
contents = file.read
line_total = File.foreach(file).count
@word = ""

while @word.length >= 12 || @word.length <= 5
  @word = IO.readlines("5desk.txt")[rand(line_total)].chomp.downcase()  #Gets random word with length between 5 and 12. 
end                                                                     #Downcase word to make it case insensitive

turn_count = 0
@correct_letters = "_" * @word.length
@incorrect_letters = []
@display = @correct_letters.split(//)

def win?
  if !@correct_letters.include?("_")
    puts "Player wins"
    @save_file.puts "Player wins"
    true
  end
  false
end
  
def correct_display(guess)
  word_array = @word.split(//)
  
  unless word_array.include?(guess)      #when guessed letter is not in target word
    print @display
    puts
    @save_file.print @display
    @save_file.puts 
    @incorrect_letters << guess
    puts "Incorrect guess"
    @save_file.puts "Incorrect guess"
    return
  end
  
  puts "Correct guess"
  @save_file.puts "Correct guess"
  word_array.each_with_index do |letter, i| 
    @display[i] = guess if letter == guess
  end

  print @display
  puts @save_file.print @display
  puts
  @save_file.puts
end

puts @word
@save_file.puts @word
while turn_count != 6                    #add in feature to guess whole word
  puts "This is turn #{turn_count+1}"
  puts "Guess a letter"
  @save_file.puts "This is turn #{turn_count+1}"
  @save_file.puts "Guess a letter"
  guess = gets.chomp.downcase
  correct_display(guess)
  puts @incorrect_letters.join(" ")
  puts
  @save_file.puts @incorrect_letters.join(" ")
  @save_file.puts

  turn_count += 1
  return if win?
end

@save_file.close

#write to "save file" works (prob not the most effecient but whatever)
#need way to load into save file