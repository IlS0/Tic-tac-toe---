module Main where

import Tic_tac_toe_Lib

main :: IO ()
main = do
    putStrLn "__________________________________"
    print initGame
    gameLoop initGame