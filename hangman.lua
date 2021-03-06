------------------------------------------------
--	Marina Leão Lucena
--	1011010
------------------------------------------------



function initialize_vector(vector)
--------------------------------------------
--Initialize a vector from index 0 to 26 with
--number 0.
--Parameter:
--   vector : vector to be initialized
--------------------------------------------
   for index = 1, 26 do
      vector[index] = 0
   end
end



function file_exists(file)
----------------------------------------------------
--   Check if the file exists
--   Parameters:
--      file: name of the file
--   Return:
--      new_file : opened file, if it's not nil
-----------------------------------------------------
  local new_file = io.open(file, "rb")
  if new_file then new_file:close() end
  return new_file ~= nil
end



function get_word_from_line(filename, line_number)
----------------------------------------------------
--   Return a word from a pre defined line in a file
--   Parameters:
--      filename: string containing the name of the file.
--      line_number: integer containing the number of the
--                   line to be returned
--   Return:
--      line: variable containing the whole line
--      -1: if the line is not found, return -1
-----------------------------------------------------
   local cont=0
   for line in io.lines(filename) do
      cont=cont+1
      if cont==line_number then 
         return line;
      end
   end
   return -1;
end



function choose_random_line (file, number_lines)
------------------------------------------------------------
--   choose a random line number from the file 
--   (not considering the first line)
-----------------------------------------------------------
   math.randomseed(os.time())
   return math.random(2, number_lines)
end



function analyze_secret_word_correctness (secret_word)
------------------------------------------------
-- Analyze if the chosen secret word is valid, considering the
-- rules of the game.
-- Parameter:
--    secret_word: secret word to be analyzed
-- Return:
--    true if the secret word is valid
--    false if the secret word is not valid
-----------------------------------------------  
   for letter in string.gmatch(secret_word, ".") do
      if not( (letter >= "A" and letter <= "Z") or letter == " ") then
         return false
      end
   end
   return true
end



function get_secret_word()
-----------------------------------------------------------
-- Get random word from the file to be the secret word. If
-- it tries to get more than five times a valid word, exits
-- the program.
-- Return:
--    chosen_word: variable containing the chosen word
--    picked from a line
----------------------------------------------------------
   local filename = "words.txt" 
   file = file_exists(filename)
   if not file then 
      return {} 
   end

   local secret_word_correctness = false
   local number_tries = 0

   repeat
      number_lines = get_word_from_line(filename, 1)
      chosen_line = choose_random_line (file, number_lines)
      secret_word = get_word_from_line(filename, chosen_line)
      secret_word_correctness = analyze_secret_word_correctness (secret_word)
      number_tries = number_tries + 1
      if number_tries > 5 then
         io.write("please analyze your words.txt file. Too many invalid words\n")
         os.exit() 
      end
   until secret_word_correctness == true
   
   return secret_word
end



function get_letter ()
------------------------------------------------
-- Get letter from the user
-- Return:
--    letter: variable containing the data written
--    by the user
-----------------------------------------------
   local letter
   io.write("Guess a letter:\n ")
   letter=io.read()
   return letter
end 



function analyze_letter_correctness (letter)
------------------------------------------------
-- Analyze if the input is a single uppercase letter
-- Parameter:
--   letter: variable containing the user's input
-- Return:
--    true if variable letter contains any uppercase
--         letter from A to Z
--    false if variable letter doesn't respect the
--         above condition
-----------------------------------------------
   if #letter == 1 then
      if letter >= 'A' and letter <= 'Z' then
         return true 
      elseif letter >= 'a' and letter <= 'z' then
         io.write("Please use uppercase letter\n")
      else 
         io.write("Please guess a letter from the alphabet\n")
      end
   else
      io.write("Please guess only one letter at a time\n")
   end
   return false
end



function analyze_if_letter_repeated (letter, vector_of_situation_letters)
------------------------------------------------
-- Analyze if a given valid letter was already guessed
-- Parameter:
--   letter: variable containing a valid letter
--   vector_of_situation_letters: vector containing 26 indexes. 
--      If the index is 0, the letter has not been picked yet. 
-- Return:
--    true if the letter was picked for the first time.
--    false if the letter had already been picked.
-----------------------------------------------
   if vector_of_situation_letters[string.byte(letter)-64] ~= 0 then 
      io.write("You already chose this letter\n")
      return false
   else
      return true
   end
end



function get_valid_letter()
------------------------------------------------
-- Get letter from user and return when it's valid
-- Return:
--    letter: valid non repeated letter
-----------------------------------------------
   local letter
   local valid_guess = false

   repeat
      letter = get_letter()
      valid_guess = analyze_letter_correctness(letter)
      if valid_guess == true then
         valid_guess = analyze_if_letter_repeated (letter, vector_of_situation_letters)
      end
   until valid_guess == true
   
   return letter
end



function update_vector (letter, secret_word, vector_of_situation_letters)
------------------------------------------------
-- Upload vector_of_situation_letters with a given valid letter.
-- If the letter is part of the secret_word, upload vector_of_situation_letters
-- with 1. If it's not, upload with -1.
-- Parameter:
--    letter: variable containing a valid letter
--    secret_word: secret word to be guessed
--    vector_of_situation_letters: vector containing 26 indexes. 
-- Return:
--    try: variable containing the number of tries of the player.
-----------------------------------------------
   for character in string.gmatch(secret_word, "%a") do
      if character == letter then
         vector_of_situation_letters[string.byte(letter)-64] = 1
         break
      end
   end 
   -- in case the letter is not in the secret_word
   if vector_of_situation_letters[string.byte(letter)-64] == 0 then
      vector_of_situation_letters[string.byte(letter)-64] = -1
      try = try + 1
   end
   return try
end



function print_vector (secret_word, vector_of_situation_letters)
------------------------------------------------
-- Print the word being guessed in the screen. If the letter has not
-- been guessed yet, print _. If it has been guessed, print the
-- actual letter.
-- Parameter:
--    secret_word: secret word to be guessed
--    vector_of_situation_letters: vector containing 26 indexes. 
-----------------------------------------------  
   for letter in string.gmatch(secret_word, ".") do
      if vector_of_situation_letters[string.byte(letter)-64] == 1 then
         io.write(letter)
      elseif letter == " " then
         io.write(" ")
      else
         io.write("_")
      end 
   end
   io.write("\n")
end



function check_word_is_done (secret_word, vector_of_situation_letters)
------------------------------------------------
-- Check if player guessed all the letters of the secret word.
-- Parameter:
--    secret_word: secret word to be guessed
--    vector_of_situation_letters: vector containing 26 indexes.  
-- Return:
--    true if all letters were were guessed
--    false if not 
-----------------------------------------------
   for letter in string.gmatch(secret_word, "%a") do
      if vector_of_situation_letters[string.byte(letter)-64] ~= 1 then
         return false
      end 
   end
   return true
end



function check_vector (letter, secret_word, vector_of_situation_letters)
------------------------------------------------
-- Check the situation of the word being uploaded.
-- Parameter:
--    letter: variable containing a valid letter
--    secret_word: secret word to be guessed
--    vector_of_situation_letters: vector containing 26 indexes. 
-- Return:
--    true if all letters were were guessed
--    false if not 
-----------------------------------------------
   local game_won
   try = update_vector (letter, secret_word, vector_of_situation_letters)
   print_vector (secret_word, vector_of_situation_letters)
   game_won = check_word_is_done (secret_word, vector_of_situation_letters)

   if game_won == true then
      io.write("Congratulations! You guessed the word!\n")
      return true
   elseif try >= 5 then
      io.write("Too bad. You lost :(\n")
      io.write("Correct word: ", secret_word, "\n")
      return true
   else
      return false
   end
end



--function play_game ()
   local secret_word
   local letter
   vector_of_situation_letters = {}  
   local play_game = "Y"

   repeat
      try = 0
      local end_game = false

      initialize_vector(vector_of_situation_letters)
      secret_word = get_secret_word()

      while not end_game do
         letter = get_valid_letter()      
         end_game = check_vector (letter, secret_word, vector_of_situation_letters)
         print("tries:", try)
      end

      repeat
         io.write("Do you want to play a again? [Y/N]")
         play_game = io.read()
      until play_game == "N" or play_game == "Y"

   until play_game == "N"



