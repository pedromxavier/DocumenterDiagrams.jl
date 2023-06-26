# DocumenterDiagrams.jl

Diagram features for [Documenter.jl](https://github.com/JuliaDocs/Documenter.jl), powered by [Kroki.jl](https://github.com/bauglir/Kroki.jl)

[![CI](https://github.com/pedromxavier/DocumenterDiagrams.jl/actions/workflows/ci.yml/badge.svg)](https://github.com/pedromxavier/DocumenterDiagrams.jl/actions/workflows/ci.yml)
[![made in BR](https://raw.githubusercontent.com/pedromxavier/flag-badges/main/badges/BR.svg)](https://github.com/pedromxavier/flag-badges)

## Usage

In your `make.jl` file:
```julia
using Documenter
using DocumenterDiagrams
```

In your source `.md`:
````markdown
```@diagram mermaid
graph LR
  D["@diagram block"]
  DJL["Documenter.jl"]
  KJL["Kroki.jl"]
  K["kroki.io"]
  SVG[".svg"]
  
  D --> DJL;
  DJL --> KJL;
  KJL --> K;
  K --> KJL;
  KJL --> DJL;
  DJL ---> SVG;
```
````

will render as:

```mermaid
graph LR
  D["@diagram block"]
  DJL["Documenter.jl"]
  KJL["Kroki.jl"]
  K["kroki.io"]
  SVG[".svg"]
  
  D --> DJL;
  DJL --> KJL;
  KJL --> K;
  K --> KJL;
  KJL --> DJL;
  DJL ---> SVG;
```
