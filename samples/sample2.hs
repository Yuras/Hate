import qualified Graphics.Rendering.OpenGL as GL (Vertex2(..), GLfloat)
import Glisha.G3D
import Glisha
import Control.Lens
import qualified Graphics.UI.GLFW as GLFW (Key(..)) 

type SampleState = [Instance]

sampleLoad :: LoadFn SampleState
sampleLoad = do
    pipeline <- createPipeline "shader.vert" "shader.frag"
    let vertexData = [
            -1, -1,
            1, -1,
            1, 1
            ]
    mesh <- fromVertArray vertexData

    let inst = [createInst (-0.5, -0.5),
                createInst (-0.5,  0.5),
                createInst (0.5,  -0.5),
                createInst (0.5,   0.5)]
            where createInst (x,y) = Instance mesh pipeline (GL.Vertex2 x y :: GL.Vertex2 GL.GLfloat)
   
    return inst

sampleDraw :: DrawFn SampleState
sampleDraw = do
    objects <- get
    mapM_ draw objects

    let change x = if x < 1.0 then x + 0.01
                              else x - 2.0
        x = element 0

    go <- getKey GLFW.Key'Space
    when go $ do
        traversed.position.x %= change

main = runApp sampleLoad sampleDraw

