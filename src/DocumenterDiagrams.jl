module DocumenterDiagrams

import Kroki
import Documenter: AbstractDocumenterBlock
import Documenter.MarkdownAST: Node, CodeBlock
import Documenter.Expanders: NestedExpanderPipeline, iscode
import Documenter.Selectors: order, matcher, runner
import Documenter.MDFlatten: mdflatten
import Documenter.HTMLWriter: DOM, DCtx, domify
import Documenter.LaTeXWriter: Context, latex

# Data

"""
Similar to the `RawBlocks` expander, but generates diagrams instead.
"""
abstract type DiagramBlocks <: NestedExpanderPipeline end

struct DiagramNode <: AbstractDocumenterBlock
    format::Symbol
    code::String
end

# Parsing

order(::Type{DiagramBlocks}) = 10.5

function matcher(::Type{DiagramBlocks}, node, page, doc)
    iscode(node, r"^@diagram")
end

function runner(::Type{DiagramBlocks}, node, page, doc)
    @assert node.element isa CodeBlock
    x = node.element

    m = match(r"@diagram[ ](.+)$", x.info)
    m === nothing && error("invalid '@diagram <format>' syntax: $(x.info)")

    node.element = DiagramNode(Symbol(m[1]), x.code)

    nothing
end

# Output

function mdflatten(io, node::Node, e::DiagramNode)
    mdflatten(io, node, CodeBlock("@diagram $(e.format)", e.code))
end

function domify(::DCtx, ::Node, diag::DiagramNode)
    raw_svg = Kroki.render(Kroki.Diagram(diag.format, diag.code), "svg")

    DOM.Tag(Symbol("#RAW#"))(String(raw_svg))
end

function latex(io::Context, ::Node, diag::DiagramNode)
    # TODO: Not sure about this.
    # IDEA: write figure as png/pdf and _println \includegraphics since svg (default) is not very LaTeX-friendly
    nothing
end

end # module DocumenterDiagrams
