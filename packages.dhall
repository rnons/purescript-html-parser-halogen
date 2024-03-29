let upstream =
      https://github.com/purescript/package-sets/releases/download/psc-0.15.4-20220808/packages.dhall
        sha256:60eee64b04ca0013fae3e02a69fc3b176105c6baa2f31865c67cd5f881a412fd

let extra =
      { jest =
          { dependencies = [ "effect", "aff", "aff-promise" ]
          , repo = "https://github.com/nonbili/purescript-jest.git"
          , version = "v1.0.0"
          }
      }

in  upstream // extra
