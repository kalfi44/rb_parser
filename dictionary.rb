require './gofin_parser.rb'

# This method is used to return hash holding meaning of section, chapter
# and pragraph code as well as last digit of paragraph code.
# It is based on methods from gofin_parser.  
# @param [String] operator should be either "w" or "d". 
# This distinction is needed because some paragraphs can have same code 
# and yet different name according to income or expense
# @param [String] section_code is code of section that we want to read
# @param [String] chapter_code is code of chapter that we want to read
# @param [String] paragraph_code is code of paragraph that we want to read. It should include last digit also as it will be parsed in this function.
# @return [Hash] It returns has table with following keys(which are symbols):
#  * :section [String] Definition of section code
#  * :chapter [String] Definition of chapter code
#  * :paragraph [String] Definition of paragraph code
#  * :last_digit [String] Definition of last_digit in pargraph code
def init()
	data = scrapper
	sections, chapters = att_2_parse(data[1])
	paragraphs_income, last_digit_income = att_3_4_parse(data[2])
	additional_paragraphs = att_5_6_parse(data[4])
	File.open("definitions/income_sections.txt", "w"){ |f|
		f.write(sections)
	}
	File.open("definitions/income_chapters.txt", "w"){ |f|
		f.write(chapters)
	}
	File.open("definitions/income_paragraphs.txt", "w"){ |f|
		f.write(paragraphs_income)
	}
	File.open("definitions/income_digits.txt", "w"){ |f|
		f.write(last_digit_income)
	}
	File.open("definitions/income_additional.txt", "w"){ |f|
		f.write(additional_paragraphs)
	}
	sections, chapters = att_2_parse(data[1])
	paragraphs_expense, last_digit_expense = att_3_4_parse(data[3])
	additional_paragraphs = att_5_6_parse(data[5])
	File.open("definitions/expenses_sections.txt", "w"){ |f|
		f.write(sections)
	}
	File.open("definitions/expenses_chapters.txt", "w"){ |f|
		f.write(chapters)
	}
	File.open("definitions/expenses_paragraphs.txt", "w"){ |f|
		f.write(paragraphs_expense)
	}
	File.open("definitions/expenses_digits.txt", "w"){ |f|
		f.write(last_digit_expense)
	}
	File.open("definitions/expenses_additional.txt", "w"){ |f|
		f.write(additional_paragraphs)
	}
# in case we need console version 
=begin	if ARGV.length != 4
		raise ArgumentError.new('Wrong number of arguments. Expected 4. Operator, section_code, chapter_code, paragraph_code.')
	elsif ARGV[0] != 'd' and ARGV[0] != 'w'
		raise ArgumentError.new('Wrong operator argument. Expected \'d\'for income or \'w\' for expense.')
	end
	operator = ARGV[0]
	section_code = ARGV[1]
	chapter_code = ARGV[2]
	paragraph_code = ARGV[3].dup
=end
end
=begin to tak one code
def get_code()
	if operator.eql?('d')
		last_digit = paragraph_code.slice!(-1)
		result[:section]=sections[section_code]
		result[:chapter]=chapters[chapter_code]
		result[:last_digit]=last_digit_income[last_digit]
		additional_paragraphs[paragraph_code] == nil ? result[:paragraph]=paragraphs_income[paragraph_code] : result[:paragraph]=additional_paragraphs[paragraph_code]
		return result
	elsif operator.eql?('w')
		last_digit = paragraph_code.slice!(-1)
		result[:section]=sections[section_code]
		result[:chapter]=chapters[chapter_code]
		result[:last_digit]=last_digit_expense[last_digit]
		additional_paragraphs[paragraph_code] == nil ? result[:paragraph]=paragraphs_expense[paragraph_code] : result[:paragraph]=additional_paragraphs[paragraph_code]
		return result
	else
		raise ArgumentError.new('Wrong operator argument. Expected \'d\'for income or \'w\' for expense.')
	end
end
=end