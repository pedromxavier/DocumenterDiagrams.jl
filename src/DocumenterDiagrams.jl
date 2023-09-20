module DocumenterDiagrams

import Kroki
import MarkdownAST: Node, CodeBlock
import Documenter
import Documenter.DOM
import Documenter.MDFlatten: mdflatten
import Documenter.Selectors: order, matcher, runner
import Documenter.HTMLWriter: DCtx, domify

# Data
"""
    DiagramExpander

Similar to the `RawBlocks` expander, but generates diagrams instead.
"""
abstract type DiagramExpander <: Documenter.Expanders.ExpanderPipeline end

"""
    DiagramBlock
"""
struct DiagramBlock <: Documenter.AbstractDocumenterBlock
    codeblock::CodeBlock
    format::Symbol
    code::String
end

# Parsing
order(::Type{DiagramExpander}) = 10.5

function matcher(::Type{DiagramExpander}, node, page, doc)
    return Documenter.iscode(node, r"^@diagram")
end

function runner(::Type{DiagramExpander}, node, page, doc)
    block = node.element

    m = match(r"@diagram[ ](.+)$", block.info)
    
    if isnothing(m)
        error("invalid '@diagram <format>' syntax: $(block.info)")
    end

    format = Symbol(m[1])

    node.element = DiagramBlock(
        block,      # codeblock
        format,     # format
        block.code, # code
    )

    return nothing
end

# Output
function domify(::DCtx, node::Node, ::DiagramBlock)
    block = node.element

    raw_svg = String(Kroki.render(Kroki.Diagram(block.format, block.code), "svg"))

    return DOM.Tag(Symbol("#RAW#"))(raw_svg)
end

# function mdflatten(io, node::Node, e::DiagramBlock)
#     # mdflatten(io, node, CodeBlock("@diagram $(e.format)", e.code))
#     return nothing
# end

abstract type DiagramBuilder <: Documenter.Builder.DocumentPipeline end

order(::Type{DiagramBuilder}) = 8.1

function runner(::Type{DiagramBuilder}, doc::Documenter.Document)
    return nothing
end

end # module DocumenterDiagrams
