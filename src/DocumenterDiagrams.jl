module DocumenterDiagrams

import Kroki
import Documenter.Utilities.DOM: DOM, Node
import Documenter.Utilities.Markdown2: CodeBlock
import Documenter.Utilities.MDFlatten: mdflatten
import Documenter.Expanders: ExpanderPipeline, iscode
import Documenter.Selectors: order, matcher, runner
import Documenter.Writers.HTMLWriter: domify
import Documenter.Writers.LaTeXWriter: Context, latex

# Data

"""
Similar to the `RawBlocks` expander, but generates diagrams instead.
"""
abstract type DiagramBlocks <: ExpanderPipeline end

struct DiagramNode
    format::Symbol
    code::String
end

# Parsing

order(::Type{DiagramBlocks}) = 10.5

function matcher(::Type{DiagramBlocks}, node, page, doc)
    iscode(node, r"^@diagram")
end

function runner(::Type{DiagramBlocks}, x, page, doc)
    m = match(r"@diagram[ ](.+)$", x.language)
    m === nothing && error("invalid '@diagram <format>' syntax: $(x.language)")

    page.mapping[x] = DiagramNode(Symbol(m[1]), x.code)
end

# Output

function mdflatten(io, node::Node, e::DiagramNode)
    mdflatten(io, node, CodeBlock("@diagram $(e.format)", e.code))
end

function domify(ctx, navnode, diag::DiagramNode)
    raw_svg = String(Kroki.render(Kroki.Diagram(diag.format, diag.code), "svg"))

    DOM.Tag(Symbol("#RAW#"))(raw_svg)
end

function latex(io::Context, ::Node, diag::DiagramNode)
    # TODO: Not sure about this.
    # IDEA: write figure as png/pdf and _println \includegraphics since svg (default) is not very LaTeX-friendly
    nothing
end

end # module DocumenterDiagrams
