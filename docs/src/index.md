# DocumenterDiagrams.jl

## `@diagram <format>` block
Uses the [Kroki.jl](https://github.com/bauglir/Kroki.jl/) binding for [kroki](https://kroki.io)
to generate diagrams in multiple formats.

````markdown
```@diagram ditaa
+----------------+ 1  +---------------+  +------+
| @diagram block |--->| Documenter.jl |->| .svg |
+----------------+    +---------------+  +------+
                     2 |        ^      6
                       v      5 |  3
                      +----------+   +----------+
                      | Kroki.jl |-->| kroki.io |
                      +----------+   +----------+
                                ^     |
                                |  4  |
                                +-----+
```
````

It will render and inline the resulting image:

```@diagram ditaa
+----------------+ 1  +---------------+  +------+
| @diagram block |--->| Documenter.jl |->| .svg |
+----------------+    +---------------+  +------+
                     2 |        ^      6
                       v      5 |  3
                      +----------+   +----------+
                      | Kroki.jl |-->| kroki.io |
                      +----------+   +----------+
                                ^     |
                                |  4  |
                                +-----+
```