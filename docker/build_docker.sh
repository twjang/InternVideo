#!/bin/bash
set -e
python3 -c "import json; data=json.load(open('/etc/docker/daemon.json')); data.get('default-runtime', 'None') != 'nvidia' and (lambda: (_ for _ in ()).throw(Exception('/etc/docker/daemon.json -> default-runtime should be set to \"nvidia\"')))()"
docker build -t internvideo --build-arg INTERN_COMMIT=$(git log --format="%H" -n 1) .

