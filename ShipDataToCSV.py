import csv

full_line = ""
with open('/Users/amiral/seascraper/data.rb', 'r') as in_file:
    for line in in_file :
        if line.startswith('---') :
            full_line += '\n'
        else :
            full_line += line.rstrip().replace(',','|')
            full_line += ','
    print full_line