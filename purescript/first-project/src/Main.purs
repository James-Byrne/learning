module Main where

import Prelude
import Control.Monad.Eff.Console
import Math (sqrt, pi)

main = logShow(diagonal 3.0 4.0)

diagonal w h = sqrt(w * w + h * h)

circleArea r = pi * r
