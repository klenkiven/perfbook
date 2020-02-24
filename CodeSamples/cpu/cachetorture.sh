#!/bin/bash
#
# Run cachetorture stats, CPU 0 vs. all other CPUs.  First parameter
# controls the maximum CPU number, defaulting to the largest-numbered CPU.

maxcpu="`grep '^processor' /proc/cpuinfo | tail -1 | awk '{ print $3 }'`"
lastcpu=${1-$maxcpu}

for runtype in checkatomicinc checkbcmpxchg checkcmpxchg checkwrite
do
	for ((cpu=1;cpu<=$lastcpu;cpu++))
	do
		for ((i=1;i<30;i++))
		do
			./cachetorture $runtype 0 $cpu
		done
	done
done
