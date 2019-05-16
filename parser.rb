load 'dictionary.rb'

class Expense
  attr_accessor :section_code, :chapter_code, :paragraph_code, :last_digit_code, :plan, :involvement, :spending_made, :all_obligations, :past_obligations, :this_year_obligations, :village_funds_expense, :not_expired_expenses
=begin
  def initialize (section_code, chapter_code, paragraph_code, plan, involvement, spending_made, all_obligations, past_obligations, this_year_obligations, village_funds_expense, not_expired_expenses)
    @section_code = section_code
    @chapter_code = chapter_code
    @last_digit_code = paragraph_code.slice!(-1)
    @paragraph_code = paragraph_code
    @plan = plan
    @involvement = involvement
    @spending_made = spending_made
    @all_obligations = all_obligations
    @past_obligations = past_obligations
    @this_year_obligations = this_year_obligations
    @village_funds_expense = village_funds_expense
    @not_expired_expenses = not_expired_expenses
  end
=end
end

line_arr =[]

def correct_line(string)
  string.gsub!(/(?<=\d),(?=\d{2}")/, '.')
  string.gsub!(' ', '_')
  string.gsub!('"', '')
end

def line_to_expense(string)
  line = string.split(',')
  if line[0] != '' 
  	digit = line[2].slice(-1)
  	exp =  Expense.new
  	exp.section_code = line[0]
  	exp.chapter_code = line[1]
  	exp.paragraph_code = line[2]
  	exp.last_digit_code = digit
  	exp.plan = line[3]
  	exp.involvement = line[4]
  	exp.spending_made = line[5]
  	exp.all_obligations = line[6]
  	exp.past_obligations = line[7]
  	exp.this_year_obligations = line[8]
  	exp.village_funds_expense = line[9]
  	exp.not_expired_expenses = line[10]
  	return exp
  end
end

def collect_definitions(filepath)
	file = File.open(filepath) 
	file_data = file.read.gsub!("{", "").gsub!("}","")
	lines = file_data.gsub!("\"", "").split(",")
	hash = {}
	lines.each do |line|
		split_val = line.split("=>")
		split_val[0].gsub!(/()\s(?=\d+)/, '')
		hash[split_val[0]] = split_val[1]
	end
	return hash
end

sections = collect_definitions("definitions/expenses_sections.txt")
chapters = collect_definitions("definitions/expenses_chapters.txt")
paraghraphs = collect_definitions("definitions/expenses_sections.txt")
digits = collect_definitions("definitions/expenses_sections.txt")
additional_paragrphs = collect_definitions("definitions/expenses_sections.txt")


arr_of_arrs = File.open("results/rb-28-s_bochnia_2017_one.csv").read.each_line do |line| 
  line_arr.push(line_to_expense(correct_line(line))) if (/^(((\d{3}),(\d{5}),)|"",,)\d{4,6}(,"\d(\d|\s)*,\d+"){8}/.match(line))
end

line_arr.each do |line| 
  if line!=nil
  	puts "#{line.section_code} #{line.chapter_code} #{line.paragraph_code} #{line.plan}"
  	puts "section: #{sections[line.section_code]}"
  	puts "chapter: #{chapters[line.chapter_code]}"
  end
end
