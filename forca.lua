local answer
local letter
local cont



function play_game ()
   local secret_word
   secret_word = get_secret_word()
   
   local try = 0
   while try < 5 do
      get_letter()
      print_word()
   end
end
io.write("Write a word:\n ")
io.flush()
word=io.read()
cont = 0




-- get all lines from a file, returns an empty 
-- list/table if the file does not exist
function lines_from(file)
  if not file_exists(file) then return {} end
  lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end


-- get random word from the file
function get_secret_word()

   local name_file = "words.txt" 
	--pegar o file do retorno da funcao
   if not file_exists(name_file) then 
      return {} 
   end
   number_lines = pick_word(file, 1)
   chosen_line = choose_random_line (file, number_lines)
   chosen_word = pick_word(file, chosen_line)
   
   return chosen_word
end


------------------------- get secret word --------------------

-- see if the file exists
function file_exists(file)
  local new_file = io.open(file, "rb")
  if new_file then new_file:close() end
  return new_file ~= nil
end

-- pick word from line
function pick_word(file, line_number)
   local cont=0
   for line in io.lines(file) do
      cont=cont+1
      if cont==line_number then 
         return line
      end
   end
end

-- choose a random line number from the file (not considering the first line)
function choose_random_line (file, number_lines)
   return math.random(2, number_lines)
end
---------------------------------------------------------------

--analyze letter
function analyze_letter()
   local letter
   local guess = false

   repeat
      letter = get_letter()
      guess = analyze_correctness(letter)
      if guess == true then
         guess = analyze_if_letter_repeated (letter, vector_of_situation_letters)
      end
      until guess = true
   
   return letter
end
   
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
      else if letter >= 'a' and letter <= 'z' then
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
   if vector_of_situation_of_letters[letter-65] ~= 0 then 
      io.write("You already chose this letter\n")
      return false
   else
      return true
   end
end

repeat
   io.write("Guess a letter:\n ")
   io.flush()
   letter=io.read()

   if #letter == 1 then
      io.write(letter)
      io.write("\n")
      cont = cont + 1
   else
      io.write("Please guess only one letter at a time\n")
   end
until cont > 5


