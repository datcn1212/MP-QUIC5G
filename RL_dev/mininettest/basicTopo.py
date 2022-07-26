from mininet.topo import Topo
from mininet.cli import CLI
from mininet.net import Mininet
from mininet.node import OVSBridge, Host


def setup_environment():
    net = Mininet(topo=DoubleConnTopo(), switch=OVSBridge, controller=None)
    server = net.get("server")
    client = net.get("client")
    client2 = net.get("client2")
    s1 = net.get("s1")

    server.setIP("10.0.0.20", intf="server-eth0")
    client.setIP("10.0.0.1", intf="client-eth0")
    client.setIP("10.0.0.2", intf="client-eth1")

    client2.setIP("10.0.0.3", intf="client2-eth0")
    client2.setIP("10.0.0.4", intf="client2-eth1")

    client.cmd("./scripts/routing.bash")
    client.cmd("./scripts/tc_client.bash")

    client2.cmd("./scripts/routing2.bash")
    client2.cmd("./scripts/tc_client2.bash")

    s1.cmd("./scripts/tc_s1.bash")

    return net


class DoubleConnTopo(Topo):

    def build(self):
        client = self.addHost("client")
        server = self.addHost("server")

        #client2 
        client2 = self.addHost("client2")

        s1 = self.addSwitch('s1')

        self.addLink(s1, client)
        self.addLink(s1, client)
        
        self.addLink(s1, server)

        self.addLink(s1, client2)
        self.addLink(s1, client2)


if __name__ == '__main__':
    NET = setup_environment()
    NET.start()
    CLI(NET)
    NET.stop()
