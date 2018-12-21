#! /usr/bin/python
from Bio import AlignIO
from optparse import OptionParser

usage_msg = """usage: %prog -i <input fasta file> -I <input type> -o <output stockholm file> -O <output type>
Note: Suport Align format 
      
      - clustal  
      - emboss    
      - fasta 
      - fasta-m10
      - ig
      - nexus 
      - phylip 
      - phylip-sequential 
      - phylip-relaxed 
      - stockholm 
      - mauve 

"""

optParser = OptionParser(usage=usage_msg,add_help_option=True)
optParser.add_option("-i",action="store",type="string",dest="inputfile")
optParser.add_option("-o",action="store",type="string",dest="outputfile")
optParser.add_option("-I",action="store",type="string",dest="intype")
optParser.add_option("-O",action="store",type="string",dest="outtype")

options,args = optParser.parse_args()

count = AlignIO.convert(options.inputfile,
			options.intype,
			options.outputfile, 
			options.outtype)

print "Converted %i alignments Done" % count
