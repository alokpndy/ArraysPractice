{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_arraysV (
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

bindir     = "/Users/alokpandey/Desktop/arraysV/.stack-work/install/x86_64-osx/lts-12.4/8.4.3/bin"
libdir     = "/Users/alokpandey/Desktop/arraysV/.stack-work/install/x86_64-osx/lts-12.4/8.4.3/lib/x86_64-osx-ghc-8.4.3/arraysV-0.1.0.0-HOOeCA6zlvM87nE8mqfTxH-arraysV-exe"
dynlibdir  = "/Users/alokpandey/Desktop/arraysV/.stack-work/install/x86_64-osx/lts-12.4/8.4.3/lib/x86_64-osx-ghc-8.4.3"
datadir    = "/Users/alokpandey/Desktop/arraysV/.stack-work/install/x86_64-osx/lts-12.4/8.4.3/share/x86_64-osx-ghc-8.4.3/arraysV-0.1.0.0"
libexecdir = "/Users/alokpandey/Desktop/arraysV/.stack-work/install/x86_64-osx/lts-12.4/8.4.3/libexec/x86_64-osx-ghc-8.4.3/arraysV-0.1.0.0"
sysconfdir = "/Users/alokpandey/Desktop/arraysV/.stack-work/install/x86_64-osx/lts-12.4/8.4.3/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "arraysV_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "arraysV_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "arraysV_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "arraysV_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "arraysV_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "arraysV_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
