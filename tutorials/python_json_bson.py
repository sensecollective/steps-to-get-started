from bson import json_util
import json

json.dumps(anObject, default=json_util.default)
json.loads(aJsonString, object_hook=json_util.object_hook)
