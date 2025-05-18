module ShowTime

using AutoHashEquals: @auto_hash_equals

include("DisplayWrapper.jl")
export DisplayWrapper, NoLimitWrapper

end
