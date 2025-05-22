"""
    ShowTime.jl

`ShowTime.jl` is a package for streamlining custom display logic for your types

The logs are up, the REPL's cued; it's showtime!
"""
module ShowTime

using AutoHashEquals: @auto_hash_equals

include("dsl/DSL.jl")

include("DisplayWrapper.jl")
export DisplayWrapper, NoLimitWrapper

end
