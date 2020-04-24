#!/bin/bash

echo "========================================="
echo "Installing SysBench for benchmarking"
sudo apt-get install sysbench
echo "Installation Ended Successfully"
echo "========================================="

echo "============CPU Performance==========="
for ((i=1; i<=100; i=i*10))
do
  echo "========================================="
  echo "Running Testing of CPU with $i thread(s)"
  cpu_time=$(sysbench --num-threads=$i --test=cpu --cpu-max-prime=1000 run|grep "total time taken by event execution:")
  echo "Performance of CPU with $i threads:"
  echo "$cpu_time"
done
echo "========================================="

echo "============Memory Performance==========="
for ((i=1; i<=100; i=i*10))
do
  echo "========================================="
  echo "Running Testing of Memory with $i thread(s)"
  memory_event=$(sysbench --num-threads=$i --test=memory --memory-total-size=10G --memory-oper=write --memory-scope=global run|grep "MB transferred")
  echo "Performance of Memory with $i threads: $memory_event"
done
echo "========================================="

echo "============FileI/O Performance==========="
for ((i=1; i<=100; i=i*10))
do
  echo "========================================="
  echo "Running Testing of File I/O with $i thread(s)"
  file_prepare=$(sysbench --num-threads=$i --test=fileio --file-total-size=1G --file-test-mode=rndrw prepare)
  file_run=$(sysbench --num-threads=$i --test=fileio --file-total-size=1G --file-test-mode=rndrw run|grep "total time taken by event")
  file_cleanup=$(sysbench --num-threads=$i --test=fileio --file-total-size=1G --file-test-mode=rndrw cleanup)
  echo "Performance of File I/O with $i threads:"
  echo "$file_run"
done
echo "========================================="

echo "========================================="
echo "Performance Testing Done Successfully"
