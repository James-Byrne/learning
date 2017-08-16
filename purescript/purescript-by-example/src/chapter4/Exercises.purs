module Chapter4.Exercises where

import Prelude

import Data.Array (null, filter)
import Data.Array.Partial (tail, head)
import Partial.Unsafe (unsafePartial)

-- | Exercises

-- | 1 - Write a recursive method which checks if a prop is even or odd
isEven :: Int -> Boolean
isEven -1 = false
isEven n | n < -1 = true
isEven n = isEven (n-2)

-- | 2 - Write a recursive function that counts the number of even numbers in an array
numOfEvenNumbers :: Array -> Int
numOfEvenNumbers arr = length <<< filter isEven

length :: forall a. Array a -> Int
length arr =
  if null arr
     then 0
     else 1 + length(unsafePartial tail arr)


-- | Testing things

-- someFunc :: Array -> Int -> Int
-- someFunc [] num = num
-- someFunc arr num = someFunc (unsafePartial tail arr) (num + 1)

-- someFunc arr num | isEven (head arr) = someFunc (unsafePartial tail arr) (num + 1)
