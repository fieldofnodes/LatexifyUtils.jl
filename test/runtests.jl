
using Test
using LatexifyUtils

@testset "LatexifyUtils" begin
    @test new_page() == "\\newpage"
    @test section("Test") == "\\section{Test}"
    @test subsection_star("Hello") == "\\subsection*{Hello}"
    @test bold("Wow") == "\\textbf{Wow}"
    @test italic("Nice") == "\\textit{Nice}"
    @test underline("Here") == "\\underline{Here}"
    @test smallcaps("title") == "\\textsc{title}"
    @test monospace("code") == "\\texttt{code}"
    @test color_text("red", "red") == "\\textcolor{red}{red}"

    items = ["One", "Two"]
    @test occursin("\\item One", enumerate_N_items(items))
    @test occursin("\\item Two", itemize_N_items(items))

    headers = ["A", "B"]
    rows = [["1", "2"], ["3", "4"]]
    tab = latex_table(headers, rows)
    @test occursin("A & B", tab)
    @test occursin("1 & 2", tab)

    @test include_graphics("pic.png") == "\\includegraphics[width=\\linewidth]{pic.png}"
    @test occursin("\\caption", figure("img.png", "caption"))

    @test href("https://example.com", "click") == "\\href{https://example.com}{click}"
    @test checkmark() == "\\checkmark"
    @test crossmark() == "\\ding{55}"

    doc = begin_article(title="My Doc", author="Me")
    @test occursin("\\title{My Doc}", doc)
    @test end_document() == "\\end{document}"
end
