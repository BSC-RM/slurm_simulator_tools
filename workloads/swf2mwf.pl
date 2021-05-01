#!/usr/bin/perl

while(<>){
    if(/.*\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+).*/){
        #print "$1 $2 $3 $4 $5 $6 $7 $8 $9 $10 $11 $12 $13 $14 $15 $16 $17 $18\n";
        $mjid=$1;
        $mjncomp=1;
        $mjname=-1;
        $mjsubmit=$2;
        $mjwait=$3;
        $mjreq=$9;
        $mjncompsubmit=1;
        $cjid=$1;
        $cjname=-1;
        $cjwait=$3;
        $cjrun=$4;
        $cjstatus=$11;
        $execnum=$14;
        $part_req=$16;
        $nnodes_req=$8; #only if the traces logs the number of nodes instead of the number of processes (or 1 node = 1 processor)
        $npnode_req=1;
        $nthrpproc_req=48;
        $mem_req=$10;
        $freq_req=-1;
        $nam_req=-1;
        $localstrg_req=-1;
        $network_req=-1;
        $constraint=-1;
        $hint=-1;
        $licence_req=-1;
        $compmoduleid=0;
        $part_alloc=$16;
        $nnodes_alloc=$5;
        $npnode_alloc=1;
        $nthrpproc_alloc=48;
        $mem_alloc=$7;
        $freq_alloc=-1;
        $nam_alloc=-1;
        $localstrg_alloc=-1;
        $network_alloc=-1;
        $licence_alloc=-1;
        $aftercompjid=$17;
        if($17) {
            $deptype=3;
        }
        else $deptype=-1;
        $compthinktime=$18;
        print " $mjid $mjncomp $mjname $mjsubmit $mjwait $mjreq $mjncompsubmit $cjid $cjname $cjwait $cjrun $cjstatus $execnum $part_req $nnodes_req $npnode_req $nthrpproc_req $mem_req $freq_req $nam_req $localstrg_req $network_req $constraint $hint $licence_req $compmoduleid $part_alloc $nnodes_alloc $npnode_alloc $nthrpproc_alloc $mem_alloc $freq_alloc $nam_alloc $localstrg_alloc $network_alloc $licence_alloc $aftercompjid $deptype $compthinktime\n";
    }
    elsif(/.*; EndTime:.*/){
        print "$_";
        print "; NumberOfModules: 1\n";
        print "; ModuleID: 0\n";
    }
    elsif(/.*;.*:.*/){
        print "$_"; #TODO: Check how the header is defined in MWF proposal and do the conversion accordingly instead of only copying SWF header.
   }

}





# SWF example
#    1        0      0    222   80     -1    -1   80  14400 1200000  1   1   1  -1  1 -1 -1 -1
#    2     1136      0 244682  128     -1    -1  128 259200 1024000  1   2   2  -1  1 -1 -1 -1

#MWF example

#    1	1	-1	0	0	1440	1	1	-1	0	222	1	-1	-1	80	1	48	1200000	-1	-1	-1	-1	-1	-1	-1	0	-1	80	1	48	-1	-1	-1	-1	-1	-1	-1	AFTEROK/AFTERNOTOK	-
