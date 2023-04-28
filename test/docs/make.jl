# Set up to run docstrings with jldoctest
DocMeta.setdocmeta!(
    DocumenterDiagrams,
    :DocTestSetup,
    :(using DocumenterDiagrams);
    recursive = true,
)

makedocs(;
    modules  = [DocumenterDiagrams],
    doctest  = true,
    clean    = true,
    format   = Documenter.HTML(),
    sitename = "DocumenterDiagrams.jl (TEST)",
    authors  = "Pedro Maciel Xavier",
    pages    = ["Test" => "index.md"],
    workdir  = @__DIR__,
)
