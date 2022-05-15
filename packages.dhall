let upstream =
      https://github.com/purescript/package-sets/releases/download/psc-0.15.0-20220507/packages.dhall
        sha256:cf54330f3bc1b25a093b69bff8489180c954b43668c81288901a2ec29a08cc64

let extra =
      { jest =
        { dependencies = [ "effect", "aff", "aff-promise" ]
        , repo = "https://github.com/nonbili/purescript-jest.git"
        , version = "018543987af27db6a3842048b6b3f5ec47609087"
        }
      }

in  upstream // extra
