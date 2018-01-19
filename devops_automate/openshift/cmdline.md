# output filtering

```
# oc get nodes

# oc describe nodes

# oc get pods -o wide

# oc get pods -n svt-1-1 -o=custom-columns=NAME:.metadata.name,STATE:.status.phase
NAME      STATE
hello0    Running
hello1    Running

--
# oc get pods hello3 -n svt-1-1 -o yaml > pod_info.yaml
# head pod_info.yml -n 4
apiVersion: v1
kind: Pod
metadata:
  annotations:

--
# oc get pods --all-namespaces -o=custom-columns=NAME:.metadata.name,STATE:.status.phase,NM:.metadata.namespace | grep Running -c
3608

--
# oc get pods --all-namespaces -l name=hello-openshift \
    -o=custom-columns=NAME:.metadata.name,STATE:.status.phase,NM:.metadata.namespace \
    | grep Running -c
3600

--
# oc get images --all-namespaces | wc -l
2050

# oc get images --all-namespaces -o=custom-columns=:.metadata.name,:.dockerImageReference | head -n 10

sha256:03b4592d6dba80dcbe053140989a13f43e3922f9b7c3facb8d2b3d51905ba3d2   10.200.197.21:5000/svt-46/cakephp-mysql-example@sha256:03b4592d6dba80dcbe053140989a13f43e3922f9b7c3facb8d2b3d51905ba3d2
sha256:03c0e45fc164c8be465f886a21fb5ccdd7afce2c23d3180f52da8d8ef42ccc89   10.200.197.21:5000/mff/cakephp-mysql-example@sha256:03c0e45fc164c8be465f886a21fb5ccdd7afce2c23d3180f52da8d8ef42ccc89

# oc get images --all-namespaces -o=custom-columns=:.metadata.name,:.dockerImageReference | grep example | head -n 2 | awk '{print $1}'
sha256:03b4592d6dba80dcbe053140989a13f43e3922f9b7c3facb8d2b3d51905ba3d2
sha256:03c0e45fc164c8be465f886a21fb5ccdd7afce2c23d3180f52da8d8ef42ccc89

```
------------
# hawkular/metrics deployment

- https://gist.github.com/arcolife/2d1af4c6be7a29ac75e6099fc4feb5ed
- https://gist.github.com/arcolife/a2fa42ef68951e5dfb8b53de954db8a8

--------------
# router/route/svc

- https://gist.github.com/arcolife/83c4e84d81c53ab592414b2b104bacee
- https://gist.github.com/arcolife/6969491832424acda794599bf9150d71

-------------
# rollout / dc etc..

- https://github.com/kubernetes-incubator/kompose/issues/611#issue-229675910

-------------
# rsh / exec

- https://github.com/arcolife/sarjitsu/issues/6

```
# FIXME: confirm that this works
# oc exec  hello3 bash -n svt-1-1

root@svt-lb: ~ # oc rsh  -n svt-1-1 hello3  
rpc error: code = 13 desc = invalid header field value "oci runtime error: exec failed: container_linux.go:247: starting container process caused \"exec: \\\"/bin/sh\\\": stat /bin/sh: no such file or directory\"\n"

```

-------------
# deletion

refer to `output filtering` section for reference on filtering and listing resource attributes (so you know what you're going to delete)

```
# for i in {220..249}; do oc delete project svt-1-$i; done
project "svt-1-220" deleted
project "svt-1-221" deleted
..
project "svt-1-249" deleted

# oc get pods --all-namespaces -l name=hello-openshift | grep Running -c
3291

# for i in `oc get images --all-namespaces -o=custom-columns=:.metadata.name,:.dockerImageReference | grep example | head -n 2 | awk '{print $1}'`; do oc delete image $i; done

image "sha256:045dd99c5bf008383f58c9976b1acfae09f706ca9894a6d5c4a7aa80d605c6b1" deleted
image "sha256:046bcaf3fb1e2a3d1ed0d0b49bd77b7b3312f0ef4a18a1b814dc9655904a64d0" deleted

```

# delete nodes

```
[root@openshift-master ~]# for i in `oc get nodes | grep '18x1x.\.' | awk '{print $1}'`; do oc delete node $i; done
node "vm172x18x1x2.try1000.com" deleted
node "vm172x18x1x3.try1000.com" deleted
node "vm172x18x1x4.try1000.com" deleted
node "vm172x18x1x5.try1000.com" deleted
node "vm172x18x1x6.try1000.com" deleted

```

oc describe nodes
