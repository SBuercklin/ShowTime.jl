"""
    DisplayWrapper

A wrapper for structs which allows passing properties when `Base.show` is invoked for 
a generic `IOContext`.

Currently only implements `Base.show` methods for the `MIME"text/plain"` MIME-type
"""
@auto_hash_equals struct DisplayWrapper{X,T<:Tuple}
    x::X
    overrides::T
end

DisplayWrapper(x::X, KV::Pair...) where {X} = DisplayWrapper(x, KV)

function Base.show(io::IO, m::MIME"text/plain", dw::DisplayWrapper)
    new_io = IOContext(io, dw.overrides...)
    return Base.show(new_io, m, dw.x)
end

function DisplayWrapper(x::DisplayWrapper, KV::Pair...)
    current_overrides = NamedTuple(x.overrides)
    new_overrides = merge(current_overrides, NamedTuple(KV))

    return DisplayWrapper(x.x, pairs(new_overrides)...)
end

"""
    NoLimitWrapper(x)

Shorthand for DisplayWrapper(x, :limit => false) to prevent limiting output written to IO
"""
function NoLimitWrapper(x)
    return DisplayWrapper(x, :limit => false)
end
