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
        $uid=$12;
        $gid=$13;
        $cjid=$1;
        $cjname=-1;
        $cjwait=$3;
        $cjrun=$4;
        $cjstatus=$11;
        $execnum=$14;
        $part_req=$16;
        $nnodes_req=$8;      #only if the traces logs the number of nodes instead of the number of processes (or 1 node = 1 processor)
                             #divide by the number of cores per node otherwise
        $npnode_req=1;
        $ncoresproc_req=-1;
        $ncoresnode_req=-1;  #set this to $8/$nnodes_req if swf specifies total number of cores
        $gpus_req=-1;
        $mem_req=$10;        #SWF is per processor, MWF per node, mutliply by number of processors per node
        $freq_req=-1;
        $ref_pow=-1;
        $constraint="queue:{$15}";
        $licence_req=-1;
        $compmoduleid=0;
        $part_alloc=$16;
        $nnodes_alloc=$5;    #same as nnodes_req
        $npnode_alloc=1;
        $ncoresproc_alloc=-1;
        $ncoresnode_alloc=-1 #same as ncoresnode_req
        $gpus_alloc=-1;
        $mem_alloc=$7;       #same as mem_req
        $avgcputime=$6;
        $freq_alloc=-1;
        $pow=-1;
        $constraint_alloc=-1;
        $licence_alloc=-1;
        $aftercompjid=$17;
        if($17 != -1) {
            $deptype=3;
        }
        else $deptype=-1;
        $compthinktime=$18;
        $event_list=-1;
        print " $mjid $mjncomp $mjname $mjsubmit $mjwait $mjreq $mjncompsubmit $uid $gid $cjid $cjname $cjwait $cjrun $cjstatus $execnum $part_req $nnodes_req $npnode_req $ncoresproc_req $ncoresnode_req $gpus_req 
        $mem_req $freq_req $ref_pow $constraint $licence_req $compmoduleid $part_alloc $nnodes_alloc $npnode_alloc $ncoresproc_alloc $ncoresnode_alloc $gpus_alloc $mem_alloc $avgcputime $freq_alloc $pow 
        $constraint_alloc $licence_alloc $aftercompjid $deptype $compthinktime $event_list\n";
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
