using Test
using LatexifyUtils

@testset "LatexifyUtils" begin
    @test new_page() == "\n\\newpage\n"
    @test section("Test") == "\n\\section{Test}\n"
    @test subsection_star("Hello") == "\n\\subsection*{Hello}\n"
    @test bold("Wow") == "\\textbf{Wow}"
    @test italic("Nice") == "\\textit{Nice}"
    @test underline("Here") == "\\underline{Here}"
    @test smallcaps("title") == "\\textsc{title}"
    @test monospace("code") == "\\texttt{code}"
    @test color_text("red", "red") == "\\textcolor{red}{red}"

    items = ["One", "Two"]
    enum = enumerate_N_items(items)
    item = itemize_N_items(items)
    @test occursin("\\item One", enum)
    @test occursin("\\item Two", item)
    @test startswith(enum, "\n")
    @test endswith(enum, "\n")
    @test startswith(item, "\n")
    @test endswith(item, "\n")

    headers = ["A", "B"]
    rows = [["1", "2"], ["3", "4"]]
    tab = latex_table(headers, rows; caption="My Caption", label="tab:example")
    @test occursin("A & B", tab)
    @test occursin("1 & 2", tab)
    @test occursin("\\caption{My Caption}", tab)
    @test occursin("\\label{tab:example}", tab)
    @test startswith(tab, "\n")
    @test endswith(tab, "\n")

    fig = figure("img.png", "Sample Image", label="fig:img")
    @test occursin("\\includegraphics[width=0.5\\linewidth]{img.png}", fig)
    @test occursin("\\caption{Sample Image}", fig)
    @test occursin("\\label{fig:img}", fig)
    @test startswith(fig, "\n")
    @test endswith(fig, "\n")

    @test href("https://example.com", "click here") == "\\href{https://example.com}{click here}"
    @test checkmark() == "\\checkmark"
    @test crossmark() == "\\ding{55}"

    doc = begin_article(title="My Title", author="Jane Doe")
    @test occursin("\\title{My Title}", doc)
    @test occursin("\\author{Jane Doe}", doc)
    @test occursin("\\begin{document}", doc)
    @test end_document() == "\\end{document}"
end
