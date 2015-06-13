#!/usr/bin/python

from pylxd import api

lxd = api.API()
# get container images
images = lxd.image_list()
for img in images:
    print "Upload date:", lxd.image_upload_date(img)
print "Driver:", lxd.get_lxd_driver()
print "API compat:", lxd.get_lxd_api_compat()
print "Used filesystem:", lxd.get_lxd_backing_fs()
print "Host info:", lxd.host_info()

containers = lxd.container_list()
for x in containers:
    # Currently, it does not work....
    # lxd.container_run_command(x, "pwd", True)
    print lxd.get_container_log(x)
    # container operations
    # if lxd.container_running(x):
    #     lxd.container_suspend(x, 5000)
