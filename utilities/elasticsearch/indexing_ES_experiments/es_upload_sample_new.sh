HOST="$1"
curl -XDELETE "$HOST/test-vos/"
echo
curl -XPUT "$HOST/test-vos/"
echo
curl -XPUT "$HOST/test-vos/sar/_mapping" -d @sar_donottouch.json
echo
# curl -XPOST "$HOST/test-vos/sar/1" -d @doc_donottouch.json
./test.py
# sleep 1
# echo
# # curl -XPOST "http://$HOST:9200/test-vos/sar/1" -d @doc_donottouch.json
# curl -s -XPOST localhost:9200/_bulk?ignore_conflicts=true --data-binary @requests_combined ; echo
# echo
