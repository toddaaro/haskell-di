import           Example.Program as E
import           Protolude

-- this is a trivial main to call the program
main :: IO ()
main = runReaderT E.program "some text"
