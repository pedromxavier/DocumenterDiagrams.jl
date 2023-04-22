using Documenter
using DocumenterDiagrams

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
    sitename = "DocumenterDiagrams.jl",
    authors  = "Pedro Maciel Xavier",
    pages    = ["Home" => "index.md", "API" => "api.md"],
    workdir  = ".",
)

if "--skip-deploy" ∈ ARGS
    @warn "Skipping deployment"
else
    deploydocs(
        repo = raw"github.com/pedromxavier/DocumenterDiagrams.jl.git",
        push_preview = true,
    )
end