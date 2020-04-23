#!/bin/bash
for i in 1 2 3
do
  echo "========================================="
  echo "Running Testing of CPU with $i thread(s)"
  cpu_event=$(sysbench cpu --threads=$i --cpu-max-prime=10000 run|grep "events per second")
  echo "Performance of CPU with $i threads: $cpu_event"
done

for i in 1 2 3
do
  echo "========================================="
  echo "Running Testing of Memory with $i thread(s)"
  memory_event=$(sysbench memory --threads=$i --memory-total-size=10G --memory-oper=write --memory-scope=global run|grep "MiB transferred")
  echo "Performance of Memory with $i threads: $memory_event"
done

for i in 1 2 3
do
  echo "========================================="
  echo "Running Testing of File I/O with $i thread(s)"
  file_prepare=$(sysbench fileio --threads=$i --file-total-size=3G --file-test-mode=rndrw prepare)
  file_run=$(sysbench fileio --threads=$i --file-total-size=3G --file-test-mode=rndrw run|grep "total number of events:")
  file_cleanup=$(sysbench fileio --threads=$i --file-total-size=3G --file-test-mode=rndrw cleanup)
  echo "Performance of File I/O with $i threads:"
  echo "$file_run"
done
