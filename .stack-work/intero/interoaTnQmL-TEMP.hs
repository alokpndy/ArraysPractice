{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TypeOperators   #-}

module Convert () where


import Codec.Picture
import Control.Monad
import Control.Monad.ST
import Data.Array.Repa (Array, DIM1, DIM2, U, D, Z (..), (:.)(..), (!))
import System.Environment (getArgs)
import System.FilePath (replaceExtension)
import qualified Codec.Picture.Types as M
import qualified Data.Array.Repa     as R -- for Repa



main :: IO ()
main = do
  [path, path'] <- getArgs
  eimg <- readImage path
  case eimg of
    Left err -> putStrLn ("Could not read image: " ++ err)
    Right (ImageRGB8 img) -> do
      computed <- (R.computeUnboxedP . rotateImgRepa . fromImage) img
      (savePngImage path' . ImageRGB8 . toImage) computed
    Right (ImageRGBA8 img)-> putStrLn "Unexpected pixel format"
    Right _-> putStrLn "OOOOOO"
rotateImgRepa :: R.Source r e => Array r DIM2 e -> Array D DIM2 e
rotateImgRepa g = R.backpermute e remap g
  where
    e@(Z :. width :. height) = R.extent g
    remap (Z :. x :. y) = Z :. width - x - 1 :. height - y - 1
    {-# INLINE remap #-}





type RGB8 = (Pixel8, Pixel8, Pixel8)

-- | Produce delayed Repa array from image with true color pixels.
fromImage :: Image PixelRGB8 -> Array D DIM2 RGB8
fromImage img@Image {..} =
  R.fromFunction (Z :. imageWidth :. imageHeight)
    (\(Z :. x :. y) ->
       let (PixelRGB8 r g b) = pixelAt img x y
       in (r, g, b))

-- | Get image with true color pixels from manifest Repa array.
toImage :: Array U DIM2 RGB8 -> Image PixelRGB8
toImage a = generateImage gen width height
  where
    Z :. width :. height = R.extent a
    gen x y =
      let (r,g,b) = a ! (Z :. x :. y)
      in PixelRGB8 r g b
