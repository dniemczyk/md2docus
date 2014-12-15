#!/usr/bin/env ruby

require 'kramdown'

#
# Load a the note text from file
#
text = String.new
while line = gets
  text += line
end

#
# Convert to LaTeX using a provided template for notes
#
latex_note_document = Kramdown::Document.new(
  text,
  template: './template/note.latex.erb'
  ).to_latex

#
# Create a TeX file with the same name as the Markdown file
#-
# TODO: Check if the file ends with md
#-
md_filename = ARGF.filename.dup

tex_filename = md_filename.sub(/md\z/, 'tex')

File.open(tex_filename, 'w+') do |f|
  f.print latex_note_document
  f.close
end

#
# Parse with 'pdflatex' and clean up
#
#-
# TODO: save tex and pdf in seperate folders
#-
2.times { system("pdflatex #{tex_filename}") }
system("rm *.log *.aux *.out")

