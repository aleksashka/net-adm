# net-adm
.vimrc
```
let tex_file="rs-el"
command L execute "update \| !pdflatex -synctex=1 -interaction=nonstopmode -quiet ".tex_file.".tex && start texworks ".tex_file.".pdf"
command Lh execute "update \| !pdflatex -synctex=1 -interaction=nonstopmode -quiet ".tex_file."-h.tex && pdflatex -synctex=1 -interaction=nonstopmode -quiet ".tex_file."-ho.tex && start texworks ".tex_file."-ho.pdf"
```
