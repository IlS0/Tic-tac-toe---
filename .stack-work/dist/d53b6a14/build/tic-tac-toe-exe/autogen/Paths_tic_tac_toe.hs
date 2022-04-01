{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -Wno-missing-safe-haskell-mode #-}
module Paths_tic_tac_toe (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "D:\\Haskell\\tic-tac-toe\\.stack-work\\install\\3772f234\\bin"
libdir     = "D:\\Haskell\\tic-tac-toe\\.stack-work\\install\\3772f234\\lib\\x86_64-windows-ghc-9.0.2\\tic-tac-toe-0.1.0.0-KZzvv1sioF53BqlwMbF3wS-tic-tac-toe-exe"
dynlibdir  = "D:\\Haskell\\tic-tac-toe\\.stack-work\\install\\3772f234\\lib\\x86_64-windows-ghc-9.0.2"
datadir    = "D:\\Haskell\\tic-tac-toe\\.stack-work\\install\\3772f234\\share\\x86_64-windows-ghc-9.0.2\\tic-tac-toe-0.1.0.0"
libexecdir = "D:\\Haskell\\tic-tac-toe\\.stack-work\\install\\3772f234\\libexec\\x86_64-windows-ghc-9.0.2\\tic-tac-toe-0.1.0.0"
sysconfdir = "D:\\Haskell\\tic-tac-toe\\.stack-work\\install\\3772f234\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "tic_tac_toe_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "tic_tac_toe_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "tic_tac_toe_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "tic_tac_toe_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "tic_tac_toe_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "tic_tac_toe_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
