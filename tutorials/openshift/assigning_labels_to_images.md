Import image

```
[root@openshift-master openshift_scalability]# oc import-image my_test_image --from=docker.io/busybox --confirm
The import completed successfully.

Name:			my_test_image
Namespace:		default
Created:		44 minutes ago
Labels:			<none>
Annotations:		openshift.io/image.dockerRepositoryCheck=2017-04-24T12:36:09Z
Docker Pull Spec:	70.30.60.158:5000/default/my_test_image
Unique Images:		1
Tags:			1

latest
  tagged from docker.io/busybox

  * docker.io/busybox@sha256:32f093055929dbc23dec4d03e09dfe971f5973a9ca5cf059cbfb644c206aa83f
      44 minutes ago

[root@openshift-master openshift_scalability]# oc get images   | grep busy
sha256:32f093055929dbc23dec4d03e09dfe971f5973a9ca5cf059cbfb644c206aa83f   docker.io/busybox@sha256:32f093055929dbc23dec4d03e09dfe971f5973a9ca5cf059cbfb644c206aa83f

```

so "oc get pods --show-labels" is different than labels for images.

`oc get images --show-labels` won't work. because openshift doesn't have a concept of images in registry. rather they're image streams.

[Here's what i mean](https://gist.github.com/arcolife/07ed204419a35f0fe1a255734f211445)

```
[root@openshift-master openshift_scalability]# oc get is  --show-labels
NAME               DOCKER REPO                                  TAGS      UPDATED             LABELS
my_test_image      70.30.60.158:5000/default/my_test_image      latest    About an hour ago   <none>
registry-console   70.30.60.158:5000/default/registry-console   3.4       13 days ago         app=registry-console,createdBy=registry-console-template
 
[root@openshift-master openshift_scalability]# oc edit is my_test_image
imagestream "my_test_image" edited
[root@openshift-master openshift_scalability]# oc get is  --show-labels
NAME               DOCKER REPO                                  TAGS      UPDATED             LABELS
my_test_image      70.30.60.158:5000/default/my_test_image      latest    About an hour ago   foo=bar
registry-console   70.30.60.158:5000/default/registry-console   3.4       13 days ago         app=registry-console,createdBy=registry-console-template
```

- So either we can add LABEL to dockerfile -- [1] and [2]
- or we can add labels to [imagestream object template, like here](https://github.com/openshift/svt/blob/master/openshift_scalability/content/image-stream-template.json#L38) [3]
- or through command line, after importing the image into imagestream, we can edit that and [add this bit](https://gist.github.com/arcolife/f903a5d471cc2f1d69a97a51828c70e6#file-oc-edit-esruc-yaml-L12)

```
[root@openshift-master openshift_scalability]# oc edit is my_test_image
 
....
....
metadata:
  annotations:
    openshift.io/image.dockerRepositoryCheck: 2017-04-24T12:36:09Z
  creationTimestamp: 2017-04-24T12:36:09Z
  generation: 1
  labels:
    foo: bar
  name: my_test_image
  namespace: default
  resourceVersion: "6971847"
  selfLink: /oapi/v1/namespaces/default/imagestreams/my_test_image
  uid: 97cdf0f1-28ea-11e7-bf5a-001a4b16020b
....
....
```

Refs:

1. https://access.redhat.com/documentation/en-us/openshift_enterprise/3.0/html/creating_images/creating-images-metadata#defining-image-metadata
2. https://docs.openshift.com/container-platform/3.5/dev_guide/managing_images.html
3. https://docs.openshift.com/enterprise/3.0/architecture/core_concepts/builds_and_image_streams.html
