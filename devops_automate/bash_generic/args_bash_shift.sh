[ $# = 0 ] && { echo "usage: ./test.sh <arg1> <arg2> <n1> <n2> <n3>..."; exit -1; }

ARG_1=$1
ARG_2=$2
shift 2
THREADS=$*

echo $ARG_1
echo $ARG_2
for i in $THREADS; do
  echo $i
done
