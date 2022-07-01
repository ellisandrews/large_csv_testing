from asyncore import write
import csv
import random


num_columns = 6
num_records = 10000000


assert num_columns >= 3, "num_columns assumed to be >= 3"


with open(f"{num_records}_records.csv", 'w', newline='') as csvfile:
    
    writer = csv.writer(csvfile, delimiter=',')
    writer.writerow([f"column_{x}" for x in range(1, num_columns + 1)])  # header row

    for _ in range(num_records):
        writer.writerow(['Spam', 'Lovely Spam', 'Wonderful Spam'] + [random.uniform(10, 100) for i in range(num_columns - 3)])

