local answer
local letter
local cont

io.write("Write a word:\n ")
io.flush()
word=io.read()
cont = 0

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


