#!/usr/bin/env python3
import sys

def main(argv):
  if len(argv) != 2:
    raise Exception('Wrong number of arguments, expected: an input and an output file name.')

  with open(argv[0], 'r') as f:
    contents = f.read()
  contents = contents.replace('trusted-', '').replace('TRUSTED-LEMMAS', 'LEMMAS-PROOF')
  with open(argv[1], 'w') as f:
    f.write(contents)

if __name__ == '__main__':
  main(sys.argv[1:])
