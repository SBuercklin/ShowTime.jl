"""
    DSL

Julia module for the `Base.show` DSL for 
"""
module DSL

abstract type ShowDSLType end

struct ParentShowWrapper{T,SHOW}
    x::T
    rule::SHOW
end
_rule(p::ParentShowWrapper) = getfield(p, :rule)
_x(p::ParentShowWrapper) = getfield(p, :x)

function Base.getproperty(psw::ParentShowWrapper, p::Symbol)
    rule = _rule(psw)
    x = _x(psw)
    return Joiner(x, rule) 
end

function Base.show(io::IO, m::MIME"text/plain", psw::ParentShowWrapper{T}) where {T}
    for f in fieldnames(T)
        Base.show(io, m, getproperty(psw,f))
    end
end

struct Joiner{X,SHOW}
    x::X
    shower::SHOW
end
function Base.show(io::IO, m::MIME"text/plain", j::Joiner)
    print(io, j.shower(io, j.x))
end


struct FieldName{FIELD} <: ShowDSLType end
FieldName(s::Symbol) = FieldName{s}()
FieldName(s::String) = FieldName(Symbol(s))

function (f::FieldName)(io, x)
    F = _fieldname(f)
    fieldval = getfield(x, F)
    return "- $(F)::" * string(typeof(fieldval)) * if !get(io, :compact, false)
        " = " * string(fieldval)
    end
end
_fieldname(::FieldName{F}) where {F} = F



end
