import System.IO

main :: IO ()
main = do
 
-- open file and get contents 
  fd <- openFile "input.txt" ReadMode
  ns <- hGetContents fd
 
-- convert lines of file to integers 
  let list = map (read::String->Int) (lines ns) 
  
-- list comprehensions to filter numbers we want 
  let p1 = [[x,y] | x <- list, y <- list, x + y == 2020]
  let p2 = [[x,y,z] | x <- list, y <- list, z <- list, x + y + z == 2020]

-- extracting the first list from the answers we got
  let a1 = p1 !! 0
  let a2 = p2 !! 0

  putStrLn "Answer for part 1: "
  print (product a1)
  putStrLn "Answer for part 2: "
  print (product a2)
  
  hClose fd
