import tabula 
import sys

def tabula_one(input,output_one):
	tabula.convert_into(input, output_one, pages=1, output_format="csv", multiple_tables=True, lattice=True, stream=False, area=[261.54625 ,33.99995999999997, 397.31875, 804.4299599999999])
	

def tablua_rest(input,output_rest,end):
	tabula.convert_into(input, output_rest, pages='2-' + str(end), output_format="csv", multiple_tables=True, lattice=True, stream=False)
	
def main():
	input = sys.argv[1]
	output_one = sys.argv[2]
	output_rest = sys.argv[3]
	pages = sys.argv[4]
	tabula_one(input, output_one)
	tablua_rest(input, output_rest, pages)
	

if __name__ == "__main__":
    main()