local answer
local letter
local cont

io.write("Write a word:\n ")
io.flush()
word=io.read()
cont = 0

-- see if the file exists
function file_exists(file)
  local new_file = io.open(file, "rb")
  if new_file then new_file:close() end
  return new_file ~= nil
end


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
function get_secret_word(file)
  if not file_exists(file) then return {} end
  lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end

-- choose a random line number from the file

-- pick word from line
function pick_word(file, line)
   local n=0
for l in io.lines(file) do
   n=n+1
   if n==line then print(l); break end
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


