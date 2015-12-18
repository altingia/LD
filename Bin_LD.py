#!/usr/bin/env python

# Creates average LD (r2) per bin of "n" bp
# Roberto Lozano ... rjl278@cornell.edu

import sys
import numpy as np

LD_file = sys.argv[1]
n = sys.argv[2] #chromosome to test

########     Loading Chromosome size information of the cassava genome  #################

chrm = { 'chr1' : 34959721,
                'chr2' : 32431396,
                'chr3' : 29412403,
                'chr4' : 28749345,
                'chr5' : 28438989,
                'chr6' : 27939960,
                'chr7' : 27069033,
                'chr8' : 34011518,
                'chr9' : 29417918,
                'chr10' : 26335333,
                'chr11' : 27369018,
                'chr12' : 31602189,
                'chr13' : 28119335,
                'chr14' : 24855542,
                'chr15' : 26192760,
                'chr16' : 28979753,
                'chr17' : 27388923,
                'chr18' : 25234269 }

############################################################################################

bsize = 1000000 # size of bin                   
bins = int(chrm['chr'+str(n)])/1000000 + 1  # Number of bins per chromosome

#############################################################################################

r2 = list() # list where the R^2 means will be stored in tuples of the form ("bin_id", mean_r2)
binid = 1 # el bin inicial
lowl = 1
upl  = int(bsize)


 
while binid <= bins:

        tmpr2 = list() #temporary list that carrys the r^2s for each bin
        
        ### Open the huge LD output from vcftools
        
        with open("/home/roberto/Desktop/Scripts/LD/%s" %(LD_file)) as f:
                next(f) # omit header
                for lines in f:
                        a = lines.split("\t")
                        
                        if (int(a[0]) == int(n) and  upl > int(a[1]) > lowl and upl > int(a[2]) > lowl ) :
                                tmpr2.append(float(a[4]))
        
        r2line = binid, np.mean(tmpr2)
        r2.append(r2line)
        
        tmpr2 = list()  
        binid += 1
        lowl += int(bsize) - 1
        upl += int(bsize) -1
        

# Save to file :

f1 = open('LD_chromosome%s' %(n), 'w')
for items in r2:
        a = str(items[0])+"\t"+str(items[1])
        f1.write(a)
        f1.write("\n")
f1.close()
