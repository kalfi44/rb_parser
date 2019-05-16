require 'pdf/reader'

pages = PDF::Reader.new("rb-28-s_bochnia_2017.pdf").page_count
input = ARGV[0]
output_one = "results/#{input}".gsub(".pdf", "_one.csv")
output_rest = "results/#{input}".gsub(".pdf", "_rest.csv")
result = `python3 tab.py #{input} #{output_one} #{output_rest} #{pages}`
File.open(output_one, 'a') { |f| f.write(File.read(output_rest)) }