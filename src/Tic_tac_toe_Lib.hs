module Tic_tac_toe_Lib
    ( initGame, nextPlayer,makeTurn,makeTurn',calcIdx,isGameOver,gameLoop ) where

import Data.List
import Control.Monad
import System.IO
import Data.Char

data Player = X|O deriving (Show,Eq)
data Cell = Empty|Mark Player deriving (Eq)
data Field =Field [Cell] deriving (Eq)
data GameState = GameState Player Field deriving (Eq)

instance Show Cell where
    show (Empty) = "_"
    show (Mark X)= "X"
    show (Mark O) = "O"

instance Show Field where
    show (Field f) = show (f!!0) ++ " "++show( (f!!1))++ " "++show(f!!2 )++ "\n"
                     ++ show (f!!3) ++ " "++show( (f!!4))++ " "++show(f!!5 )++ "\n"
                     ++ show (f!!6) ++ " "++show( (f!!7))++ " "++show(f!!8)
  
instance Show GameState where
    show (GameState X f)= "Current turn: "++show (X)++"\n"++show (f) 
    show (GameState O f)= "Current turn: "++show (O)++"\n"++show (f) 


-- **************************************************************************************************

--инициализация игры
initGame:: GameState
initGame = GameState X (Field[Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty])

--какой игрок ходит следующий?
nextPlayer :: Player -> Player
nextPlayer X = O
nextPlayer O = X


--ход
makeTurn:: [Char]->GameState->GameState
makeTurn (xs) (GameState pl (Field f))  | (f !! ((calcIdx xs))) /= Empty = GameState pl (Field f)
                                        | otherwise = GameState (nextPlayer pl) (Field (makeTurn' (splitAt ((calcIdx xs)+1) f) pl))

makeTurn' :: ([Cell], [Cell]) -> Player -> [Cell]
makeTurn' (x,y) pl =  (init x) ++ [Mark pl] ++ y

--функции вычисления индекса(координаты) по инпуту
coordinate:: Char -> Int
coordinate 'A' = 0
coordinate 'B' = 1
coordinate 'C'=2


calcIdx :: [Char] -> Int
calcIdx (x:y) | (digitToInt(head y)<=3 && digitToInt(head y)>=1)  = coordinate(x) * 3+ (digitToInt(head y)-1)
              | otherwise = error "invalid coordinate"


--проверка на окончание игры
isGameOver:: GameState->Bool
--горизонтали
isGameOver (GameState pl (Field [Mark X,Mark X,Mark X,_,_,_,_,_,_])) = True
isGameOver (GameState pl (Field [Mark O,Mark O,Mark O,_,_,_,_,_,_])) = True
isGameOver (GameState pl (Field [_,_,_,Mark X,Mark X,Mark X,_,_,_])) = True
isGameOver (GameState pl (Field [_,_,_,Mark O,Mark O,Mark O,_,_,_])) = True
isGameOver (GameState pl (Field [_,_,_,_,_,_,Mark X,Mark X,Mark X])) = True
isGameOver (GameState pl (Field [_,_,_,_,_,_,Mark O,Mark O,Mark O])) = True
--диагонали
isGameOver (GameState pl (Field [Mark X,_,_,_,Mark X,_,_,_,Mark X])) = True
isGameOver (GameState pl (Field [Mark O,_,_,_,Mark O,_,_,_,Mark O])) = True
isGameOver (GameState pl (Field [_,_,Mark X,_,Mark X,_,Mark X,_,_])) = True
isGameOver (GameState pl (Field [_,_,Mark O,_,Mark O,_,Mark O,_,_])) = True
--вертикали
isGameOver (GameState pl (Field [Mark X,_,_,Mark X,_,_,Mark X,_,_])) = True
isGameOver (GameState pl (Field [Mark O,_,_,Mark O,_,_,Mark O,_,_])) = True
isGameOver (GameState pl (Field [_,Mark X,_,_,Mark X,_,_,Mark X,_])) = True
isGameOver (GameState pl (Field [_,Mark O,_,_,Mark O,_,_,Mark O,_])) = True
isGameOver (GameState pl (Field [_,_,Mark X,_,_,Mark X,_,_,Mark X])) = True
isGameOver (GameState pl (Field [_,_,Mark O,_,_,Mark O,_,_,Mark O])) = True
--если все ячейки заполнены, но никто не выиграл
isGameOver (GameState pl (Field f)) | (f!!0/=Empty) &&(f!!1/=Empty)&&(f!!2/=Empty)&&(f!!3/=Empty)&&(f!!4/=Empty)&&(f!!5/=Empty)&&(f!!6/=Empty)&&(f!!7/=Empty)&&(f!!8/=Empty)  = True
isGameOver _  = False

--геймплей
gameLoop :: GameState->IO()
gameLoop (state) = do
    putStr "enter point: "
    hFlush stdout --сброс буфера, фикс проблем с путстр во время работы не в интерпретаторе
    point <- getLine
    let turn = (makeTurn point state)
    if (state == turn) then do
        putStrLn "\ninvalid input: this cell is filled\n"
        gameLoop turn
        else do
            putStrLn "__________________________________\n"
            print turn
    if (isGameOver turn) then do
        putStrLn "__________________________________\n*****GAMEOVER*****" 
        else do
            (gameLoop turn)
