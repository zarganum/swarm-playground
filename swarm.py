import docker
from pprint import pprint

def main():
    client = docker.DockerClient(base_url='unix://var/run/docker.sock')

    pprint(client.info())

    for event in client.events(decode=True):
        pprint(event)


if __name__ == '__main__':
    main()
