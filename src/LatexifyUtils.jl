module LatexifyUtils

export new_page, section, subsection, subsubsection, paragraph,
    section_star, subsection_star, subsubsection_star,
    enumerate_N_items, itemize_N_items,
    bold, italic, underline, smallcaps, monospace, color_text,
    center, quote_block, wrap_environment,
    latex_table,
    include_graphics, figure,
    href,
    checkmark, crossmark,
    begin_article, end_document


with_newlines(f::Function) = function(args...; kwargs...)
    return "\n" * f(args...; kwargs...) * "\n"
end

_plain_newpage() = "\\newpage"
_plain_section(title) = "\\section{$(title)}"
_plain_subsection(title) = "\\subsection{$(title)}"
_plain_subsubsection(title) = "\\subsubsection{$(title)}"
_plain_paragraph(title) = "\\paragraph{$(title)}"
_plain_section_star(title) = "\\section*{$(title)}"
_plain_subsection_star(title) = "\\subsection*{$(title)}"
_plain_subsubsection_star(title) = "\\subsubsection*{$(title)}"

# Apply wrapper
new_page = with_newlines(_plain_newpage)
section = with_newlines(_plain_section)
subsection = with_newlines(_plain_subsection)
subsubsection = with_newlines(_plain_subsubsection)
paragraph = with_newlines(_plain_paragraph)
section_star = with_newlines(_plain_section_star)
subsection_star = with_newlines(_plain_subsection_star)
subsubsection_star = with_newlines(_plain_subsubsection_star)



_plain_enumerate_N_items(items::Vector{String}) = begin
    list_items = join(["\t\\item $item\n" for item in items], "")
    return """\\begin{enumerate}
$(list_items)\\end{enumerate}"""
end

_plain_itemize_N_items(items::Vector{String}) = begin
    list_items = join(["\t\\item $item\n" for item in items], "")
    return """\\begin{itemize}
$(list_items)\\end{itemize}"""
end


enumerate_N_items = with_newlines(_plain_enumerate_N_items)
itemize_N_items = with_newlines(_plain_itemize_N_items)



bold(text) = "\\textbf{$(text)}"
italic(text) = "\\textit{$(text)}"
underline(text) = "\\underline{$(text)}"
smallcaps(text) = "\\textsc{$(text)}"
monospace(text) = "\\texttt{$(text)}"
color_text(text, color) = "\\textcolor{$(color)}{$(text)}"

function wrap_environment(env::String, content::String)
    """
    \\begin{$(env)}
        $(content)
    \\end{$(env)}
    """
end

center(content) = wrap_environment("center", content)
quote_block(content) = wrap_environment("quote", content)

function _plain_latex_table(headers::Vector{String}, rows::Vector{Vector{String}};
    caption::String="", label::String="")
    ncols = length(headers)
    col_format = join(["c" for _ in 1:ncols], " | ")

    header_row = join(headers, " & ") * " \\\\ \\hline\n"
    body = join([join(row, " & ") * " \\\\" for row in rows], "\n")

    caption_block = isempty(caption) ? "" : "    \\caption{$caption}\n"
    label_block = isempty(label) ? "" : "    \\label{$label}\n"

    return """
    \\begin{table}[]
        \\centering
        \\begin{tabular}{| $(col_format) |}
        \\hline
        $(header_row)
        $(body)
        \\hline
        \\end{tabular}
        $caption_block$label_block
    \\end{table}
    """
end

latex_table = with_newlines(_plain_latex_table)

include_graphics(path::String; width="\\linewidth") =
    "\\includegraphics[width=$(width)]{$(path)}"

function _plain_figure(path::String, caption::String; label::String="", width::String="0.5\\linewidth")
    label_block = isempty(label) ? "" : "    \\label{$(label)}\n"
    return """
    \\begin{figure}
        \\centering
        \\includegraphics[width=$(width)]{$(path)}
        \\caption{$(caption)}
    $label_block\\end{figure}
    """
end

figure = with_newlines(_plain_figure)

href(url::String, text::String) = "\\href{$(url)}{$(text)}"
checkmark() = "\\checkmark"
crossmark() = "\\ding{55}"

function begin_article(; title="", author="", date="\\today", extra_packages=String[], fontsize="12pt", docclass="article")
    default_packages = ["amsmath", "graphicx", "hyperref", "xcolor", "geometry", "pifont"]
    all_packages = union(default_packages, extra_packages)
    pkg_lines = join(["\\usepackage{$pkg}" for pkg in all_packages], "\n")
    doc_title = isempty(title) ? "" : "\\title{$title}"
    doc_author = isempty(author) ? "" : "\\author{$author}"
    doc_date = isempty(date) ? "" : "\\date{$date}"
    return """
    \\documentclass[$fontsize]{$docclass}
    $pkg_lines

    $doc_title
    $doc_author
    $doc_date

    \\begin{document}
    $(isempty(title) ? "" : "\\maketitle")
    """
end

end_document() = "\\end{document}"

end
