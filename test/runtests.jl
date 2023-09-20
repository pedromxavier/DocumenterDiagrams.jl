using Test
using Documenter
using DocumenterDiagrams

const DOCS_PATH = joinpath(@__DIR__, "docs")

function main()
    include(joinpath(DOCS_PATH, "make.jl"))

    @testset "* DocumenterDiagrams.jl Test Suite *" begin
        @test isdir(joinpath(DOCS_PATH, "build"))
        @test isfile(joinpath(DOCS_PATH, "build", "index.html"))

        html = read(joinpath(DOCS_PATH, "build", "index.html"), String)

        @test !isnothing(match(r"\<svg.*\>.*(DocumenterDiagrams).*\<\/svg\>", html))

        rm(joinpath(DOCS_PATH, "build"); recursive=true, force=true)
    end

    return nothing
end

main() # Here we go!
