import docker

def checkDockerContainerStatus( container):
    client = docker.from_env()
    #cli = docker.APIClient()
    if client.containers.list(filters={'name': container}):
        response = client.containers.list(filters={'name': container})
        return str(response[0].id)[:12]
    else:
        return None

running_id = checkDockerContainerStatus('app-container')

if running_id is not None:
    print(f"Found! {running_id}")
else:
    print("Container app-container is not found")