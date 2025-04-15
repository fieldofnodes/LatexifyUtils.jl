
# LatexifyUtils.jl

**LatexifyUtils.jl** is a lightweight Julia module to generate LaTeX documents programmatically. It simplifies the creation of sections, lists, tables, figures, and full documents using familiar Julia syntax.

## 📦 Installation

```julia
include("src/LatexifyUtils.jl")
using .LatexifyUtils
```

---

## ✨ Features & Examples

### 📄 Document Setup

```julia
begin_article(title="My Report", author="Jane Doe")
end_document()
```

### 🧱 Sections

```julia
section("Introduction")
subsection("Background")
subsection_star("Unnumbered Section")
```

### ✍️ Text Formatting

```julia
bold("Important")
italic("Emphasis")
underline("Underlined")
smallcaps("Caps")
monospace("Code")
color_text("Warning", "red")
```

### 📋 Lists

```julia
enumerate_N_items(["First", "Second"])
itemize_N_items(["Apple", "Banana"])
```

### 📦 Environments

```julia
center("Centered Text")
quote_block("This is a quote.")
```

### 📊 Tables

```julia
latex_table(["Col1", "Col2"], [["1", "2"], ["3", "4"]])
```

### 🖼️ Figures

```julia
figure("image.png", "A sample image", label="fig:sample")
```

### 🔗 Hyperlinks

```julia
href("https://julialang.org", "Julia")
```

### ✅ Symbols

```julia
checkmark()
crossmark()
```

---

## 🧮 Math Support

Just insert LaTeX math strings:

```julia
"Let $f(x) = x^2$ be a quadratic function."
```

## 📈 Plotting with Plots.jl

```julia
using Plots
plot(sin, -π, π, label="sin(x)")
savefig("sine.png")

figure("sine.png", "Plot of sine function")
```

---

## 🧪 Testing

```julia
using Test
include("test/runtests.jl")
```

---

## 📚 License

MIT License. Created with ❤️ for LaTeX fans in Julia.
