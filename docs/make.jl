using ShowTime
using Documenter

DocMeta.setdocmeta!(ShowTime, :DocTestSetup, :(using ShowTime); recursive=true)

makedocs(;
    modules=[ShowTime],
    authors="Sam Buercklin <sam.buercklin@gmail.com> and contributors",
    sitename="ShowTime.jl",
    format=Documenter.HTML(;
        canonical="https://sbuercklin.github.io/ShowTime.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)
