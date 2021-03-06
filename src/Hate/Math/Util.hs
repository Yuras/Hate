module Hate.Math.Util where

import Hate.Math.Types
import Data.Vect.Float

identityTransform :: Transformation
identityTransform = Transformation 0 0 1

rotateVec :: Rotation -> Vec2 -> Vec2
rotateVec a (Vec2 x y) = Vec2 (x * cos a - y * sin a) (x * sin a + y * cos a)

--type Vec2 = GL.Vertex2 Float
vec2 :: Float -> Float -> Vec2 
vec2 = Vec2

toMatrix :: Transformation -> Mat3
toMatrix (Transformation p r s) = rotationToMatrix r .*. positionToMatrix p .*. scaleToMatrix s

positionToMatrix :: Vec2 -> Mat3
positionToMatrix (Vec2 x y) = Mat3 
    (Vec3 1 0 x)
    (Vec3 0 1 y)
    (Vec3 0 0 1)

rotationToMatrix :: Float -> Mat3
rotationToMatrix r = Mat3
    (Vec3 (cos r) (negate $ sin r) 0)
    (Vec3 (sin r) (         cos r) 0)
    (Vec3 0                      0 1)

scaleToMatrix :: Vec2 -> Mat3
scaleToMatrix (Vec2 x y) = Mat3
    (Vec3 x 0 0)
    (Vec3 0 y 0)
    (Vec3 0 0 1)


toMatrix4 :: Transformation -> Mat4
toMatrix4 (Transformation p r s) =  positionToMatrix4 p .*. rotationToMatrix4 r .*. scaleToMatrix4 s

positionToMatrix4 :: Vec2 -> Mat4
positionToMatrix4 (Vec2 x y) = Mat4
    (Vec4 1 0 0 x)
    (Vec4 0 1 0 y)
    (Vec4 0 0 1 0)
    (Vec4 0 0 0 1)

rotationToMatrix4 :: Float -> Mat4
rotationToMatrix4 r = Mat4
    (Vec4 (cos r) (negate $ sin r) 0 0)
    (Vec4 (sin r) (         cos r) 0 0)
    (Vec4 0                      0 1 0)
    (Vec4 0                      0 0 1)

scaleToMatrix4 :: Vec2 -> Mat4
scaleToMatrix4 (Vec2 x y) = Mat4
    (Vec4 x 0 0 0)
    (Vec4 0 y 0 0)
    (Vec4 0 0 1 0)
    (Vec4 0 0 0 1)

