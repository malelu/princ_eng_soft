--local answer
--local letter
--local cont


--initialize vector
function initialize_vector(vector)
   for index = 1, 26 do
      vector[index] = 0
   end
end

-------------------------------------------------------------
------------------------- get secret word --------------------

-- see if the file exists
function file_exists(file)
  local new_file = io.open(file, "rb")
  if new_file then new_file:close() end
  return new_file ~= nil
end

-- pick word from line
function pick_word(filename, line_number)
   local cont=0
   for line in io.lines(filename) do
      cont=cont+1
      if cont==line_number then 
         --print(line)
         return line;
      end
   end
end

-- choose a random line number from the file (not considering the first line)
function choose_random_line (file, number_lines)
   return math.random(2, number_lines)
end
---------------------------------------------------------------
-- get random word from the file
function get_secret_word()
   local filename = "words.txt" 
   file = file_exists(filename)
	--pegar o file do retorno da funcao
   --if not file_exists(name_file) then
   if not file then 
      return {} 
   end
   
   number_lines = pick_word(filename, 1)
   chosen_line = choose_random_line (file, number_lines)
   chosen_word = pick_word(filename, chosen_line)
   
   return chosen_word
end

----------------------------------------------------------------
------------------------- get valid letter --------------------
--get letter and return
function get_letter ()
   local letter
   io.write("Guess a letter:\n ")
   letter=io.read()
   return letter
end 

--analyze if the letter is correct
function analyze_correctness (letter)
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

--vetor contendo todas as letras do alfabeto. se for 0, ainda nao tentou, se for 1, tentou e acertou
--se for -1, tentou e nao acertou
--analyze if the letter is repeated
function analyze_if_letter_repeated (letter, vector_of_situation_letters)
   if vector_of_situation_letters[string.byte(letter)-64] ~= 0 then 
      io.write("You already chose this letter\n")
      return false
   else
      return true
   end
end

---------------------------------------------------------------
--get valid letter
function get_valid_letter()
   local letter
   local guess = false

   repeat
      letter = get_letter()
      guess = analyze_correctness(letter)
      if guess == true then
         guess = analyze_if_letter_repeated (letter, vector_of_situation_letters)
      end
   until guess == true
   
   return letter
end
---------------------------------------------------------------- 
-------check word correctness --------------------------------

-- upload vector_of_situation_letters with a given valid letter
function upload_word (letter, word, vector_of_situation_letters)
   for each_letter in string.gmatch(word, "%a") do
      if each_letter == letter then
         vector_of_situation_letters[string.byte(letter)-64] = 1
         break
      end
   end 
   -- in case the letter is not in the word
   if vector_of_situation_letters[string.byte(letter)-64] == 0 then
      vector_of_situation_letters[string.byte(letter)-64] = -1
   end
end


---------------------------------------------------------------
-- print secret word and check if its complete
function print_secret_word (word, vector_of_situation_letters)
   
   print(word)
   for letter in string.gmatch(word, "%a") do
      if vector_of_situation_letters[string.byte(letter)-64] == 1 then
         io.write(letter)
      else
         io.write("_")
      end 
   end
   io.write("\n")
end

---------------------------------------------------------------
-- check if all letters were guessed right
function check_word_is_done (word, vector_of_situation_letters)
   local correct = true
   for letter in string.gmatch(word, "%a") do
      if vector_of_situation_letters[string.byte(letter)-64] ~= 1 then
         correct = false
         break
      end 
   end
   return correct
end
---------------------------------------------------------------
-- check the situiation of the word being uploaded
function check_word_correctness (letter, word, vector_of_situation_letters)
   upload_word (letter, word, vector_of_situation_letters)
   print_secret_word (word, vector_of_situation_letters)
   return check_word_is_done (word, vector_of_situation_letters)
end
-------------------------------------------------------------------
-------------------------------------------------------------------



--function play_game ()
   local secret_word
   local letter
   vector_of_situation_letters = {}
   local word_correct = false
   local play_game = "y"

   repeat
      initialize_vector(vector_of_situation_letters)

      secret_word = get_secret_word()
   
      local try = 0
      while try < 5 and word_correct == false do
         letter = get_valid_letter()        
         upload_word(letter, secret_word, vector_of_situation_letters)
         word_correct = check_word_correctness (letter, secret_word, vector_of_situation_letters)
         try = try + 1
         print(try)
      end

      if word_correct == true then
         io.write("Congratulations! You guessed the word!")
      else
         io.write("Too bad. You lost :(")
      end
   
      io.write("Do you want to play a again? [y/n]")
      play_game = io.read()
   until play_game == "n"
--end

--io.write("Write a word:\n ")
--io.flush()
--word=io.read()
--cont = 0







--repeat
   --io.write("Guess a letter:\n ")
   --io.flush()
   --letter=io.read()

   --if #letter == 1 then
     -- io.write(letter)
      --io.write("\n")
     -- cont = cont + 1
   --else
    --  io.write("Please guess only one letter at a time\n")
   --end
--until cont > 5


