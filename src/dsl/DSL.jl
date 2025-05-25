"""
    DSL

Julia module for the `Base.show` DSL for 
"""
module DSL

abstract type ShowDSLType end

include("field_showers.jl")

struct ParentShowWrapper{T,HEAD,SHOW}
    x::T
    header::HEAD
    rule::SHOW
end
_rule(p::ParentShowWrapper) = getfield(p, :rule)
_x(p::ParentShowWrapper) = getfield(p, :x)

function Base.getproperty(psw::ParentShowWrapper, p::Symbol)
    x = _x(psw)
    if p === :header
        return Joiner(x, getfield(psw, :header))
    else
        rule = getproperty(_rule(psw), p)
        return Joiner(x, rule)
    end
end

function Base.show(io::IO, m::MIME"text/plain", psw::ParentShowWrapper{T}) where {T}
    fnames = fieldnames(T)
    is_first = true

    header = psw.header
    if !isnothing(header.shower)
        is_first = false
        Base.show(io, m, header)
    end

    for f in fnames
        joiner = getproperty(psw, f)
        if !isnothing(joiner.shower)
            if !is_first
                print(io, '\n')
            end
            Base.show(io, m, joiner)
            is_first = false
        end
    end
end

export ParentShowWrapper

end
