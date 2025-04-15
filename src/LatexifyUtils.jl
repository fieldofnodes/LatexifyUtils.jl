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

new_page() = "\\newpage"

section(title) = "\\section{$(title)}"
subsection(title) = "\\subsection{$(title)}"
subsubsection(title) = "\\subsubsection{$(title)}"
paragraph(title) = "\\paragraph{$(title)}"
section_star(title) = "\\section*{$(title)}"
subsection_star(title) = "\\subsection*{$(title)}"
subsubsection_star(title) = "\\subsubsection*{$(title)}"

function enumerate_N_items(items::Vector{String})
    list_items = join(["\t\\item $item\n" for item in items], "")
    return """\\begin{enumerate}
$(list_items)\\end{enumerate}"""
end

function itemize_N_items(items::Vector{String})
    list_items = join(["\t\\item $item\n" for item in items], "")
    return """\\begin{itemize}
$(list_items)\\end{itemize}"""
end

bold(text) = "\\textbf{$(text)}"
italic(text) = "\\textit{$(text)}"
underline(text) = "\\underline{$(text)}"
smallcaps(text) = "\\textsc{$(text)}"
monospace(text) = "\\texttt{$(text)}"
color_text(text, color) = "\\textcolor{$(color)}{$(text)}"

wrap_environment(env::String, content::String) = """\\begin{$(env)}
$(content)
\\end{$(env)}"""

center(content) = wrap_environment("center", content)
quote_block(content) = wrap_environment("quote", content)

function latex_table(headers::Vector{String}, rows::Vector{Vector{String}})
    ncols = length(headers)
    col_format = join(["c" for _ in 1:ncols], " | ")
    header_row = join(headers, " & ") * " \\ \\hline\n"
    body = join([join(row, " & ") * " \\" for row in rows], "\n")
    return """\\begin{tabular}{| $(col_format) |}
\\hline
$(header_row)
$(body)
\\hline
\\end{tabular}"""
end

include_graphics(path::String; width="\\linewidth") =
    "\\includegraphics[width=$(width)]{$(path)}"

function figure(path::String, caption::String; label::String="")
    lbl = isempty(label) ? "" : "\\label{$(label)}"
    return """\\begin{figure}[h]
\\centering
$(include_graphics(path))
\\caption{$(caption)}$(lbl)
\\end{figure}"""
end

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
    return """\\documentclass[$fontsize]{$docclass}
$pkg_lines

$doc_title
$doc_author
$doc_date

\\begin{document}
$(isempty(title) ? "" : "\\maketitle")"""
end

end_document() = "\\end{document}"

end
