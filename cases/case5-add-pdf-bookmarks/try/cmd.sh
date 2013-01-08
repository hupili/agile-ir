
exit 0

# The following line works!
# It can add bookmarks
# Ref: http://stackoverflow.com/a/3108884/1772926
# Ref (long): http://stackoverflow.com/questions/2969479/merge-pdfs-with-pdftk-with-bookmarks/3108884#3108884
gs -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -sOutputFile=merged.pdf merged.pdf -c [/Page 1 /View [/XYZ null null null] /Title (File 1) /OUT pdfmark -c [/Page 2 /View [/XYZ null null null] /Title (File 2sfsdfsdfsdfs) /OUT pdfmark -f 1.pdf 2.pdf
