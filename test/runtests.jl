using Test
using Documenter
using DocumenterDiagrams

function main()
    @time include(joinpath(@__DIR__, "docs", "make.jl"))

    @test isdir(joinpath(@__DIR__, "docs", "build"))
    @test isfile(joinpath(@__DIR__, "docs", "build", "index.html"))

    html = read(joinpath(@__DIR__, "docs", "build", "index.html"), String)

    @test !isnothing(match(r"\<svg.*\>.*(DocumenterDiagrams).*\<\/svg\>", html))

    rm(joinpath(@__DIR__, "docs", "build"); recursive=true, force=true)

    return nothing
end

main() # Here we go!
