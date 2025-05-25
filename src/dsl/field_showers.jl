struct Joiner{X,SHOW}
    x::X
    shower::SHOW
end
function Base.show(io::IO, ::MIME"text/plain", j::Joiner)
    return print(io, get_show_string(io, j.shower, j.x))
end
Base.show(::IO, ::MIME"text/plain", ::Joiner{<:Any,Nothing}) = nothing

struct Header{SHOW_TYPES} <: ShowDSLType end
Header(b::Bool=false) = Header{b}()

function get_show_string(io, ::Header{B}, x) where {B}
    type_string = string(typeof(x))
    if B
        return type_string
    else
        return match(r"[^{]+", type_string).match
    end
end

struct FieldName{FIELD} <: ShowDSLType end
FieldName(s::Symbol) = FieldName{s}()
FieldName(s::String) = FieldName(Symbol(s))

function get_show_string(io, ::FieldName{F}, x) where {F}
    fieldval = getfield(x, F)
    return "- $(F)::" * string(typeof(fieldval)) * if !get(io, :compact, false)
        " = " * string(fieldval)
    end
end

export Joiner, Header, FieldName
