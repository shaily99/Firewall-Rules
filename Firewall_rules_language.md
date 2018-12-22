
# Firewall rule language

See explanations and examples of parts of a firewall rule, which includes clauses, conditions, and expressions.

A firewall rule consists of several statements (or clauses) that define the traffic for which the rule applies. When you manually create firewall rules, use the syntax in this topic.
Firewall clauses

A firewall rule consists of several clauses chained together to match specific criteria for each packet. The clauses represent specific layers in the protocol stack. Each clause can be broken down into conditions and expressions. The expressions are the variable part of the rule in which you put the address, port, or numeric parameters.
You can use the following firewall clauses:

   #### Adapter clause

    Specifies a set of adapters from A through P that attaches the rule to a specific adapter. The adapter clause indicates a specific adapter where the rule is applied. The supported adapter expressions are any and the letters A through P. If you do not specify an adapter clause, the rule matches packets on any adapter.
        adapter <adapter-id>
        adapter A
        adapter any
        adapter A,C
        adapter A-C
   
   #### Ethernet clause

    Specifies either a network protocol type or virtual LAN (VLAN) identifier to match the 802.1 frame. You can use the Ethernet clause to filter 802.1q VLAN traffic or allow/deny specific types of Ethernet protocols. You can find the list of protocol types at Internet Assigned Number Authority website. Ethernet protocol constants can be specified in decimal, octal, hexadecimal, or alias notation. To make it easier to block specific types of Ethernet traffic, you can specify an alias instead of the well-known number. In some cases, the alias blocks more than one port (for example, IPX and PPPoE).
        ether proto <protocol-id>
        ether proto {arp|aarp|atalk|ipx|mpls|netbui|pppoe|rarp|sna|xns}
        ether vid <vlan-number>
        ether vid <vlan-number> proto <protocol-id>
        ether vid 1 proto 0x0800
        ether vid 2 proto 0x86dd
        ether vid 3-999 proto 0x0800,0x86dd
   
   
   #### IPv4 datagram clause

    Specifies IPv4 addresses and the transport level filtering fields such as TCP/UDP source or destination ports, ICMP type or code, or a specific IP protocol number. The IP datagram clause identifies the protocol and the protocol-specific conditions that must be satisfied in order for the statement to match. Currently, only ICMP, TCP, and UDP conditions are supported, but you can specify filters based on any IP protocol. If you do not specify an IP datagram clause, the statement matches any IP datagram protocol.

    The first and second statements block IP packets that match the IP address expression. The third statement blocks IP packets that match the IP address expression. The fourth statement blocks IP packets that match the protocol type. The fifth statement is a combination of the first and second statements. The sixth statement is a combination of the first, second, and fourth statements.
        ip src addr <ipv4-addr>
        ip dst addr <ipv4-addr>
        ip addr <ipv4-addr>
        ip proto <protocol-type>
        ip src addr <ipv4-addr> dst addr <ipv4-addr>
        ip src addr <ipv4-addr> dst addr <ipv4-addr> proto <protocol-type>
    Examples
        ip addr 192.168.10.1/24
        ip addr 192.168.10.0-192.168.10.255
    

## Firewall conditions

   #### TCP and UDP conditions

    You can specify TCP and UDP port numbers in decimal, octal, or hexadecimal notation. The value range is 0 through 65535.
        tcp src port <tcp-udp-port>
        tcp dst port <tcp-udp-port>
        tcp dst port <tcp-udp-port> src port <tcp-udp-port>
        upd src port <tcp-udp-port>
        upd dst port <tcp-udp-port>
        udp dst port <tcp-udp-port> src port <tcp-udp-port>
   
   
   #### ICMP conditions

    You can specify ICMP conditions in decimal, octal, or hexadecimal notation. You can find the valid number for type and code at the Internet Assigned Numbers Authority (IANA) site.
        icmp type <protocol-type>
        icmp code <message-code>
        icmp type <protocol-type> code <message-code>


## Expressions

An expression describes a list of header values that must match the protocol parser of the clause. Each clause is directly responsible for matching a specific layer in the protocol stack. The syntax and accept range of values is controlled by the clause. The expression can be a single value, a comma-separated list of values, or a range set. Currently, expressions exist to specify the following values:

    Adapter numbers
    IPv4 addresses
    IPv6 addresses
    TCP and UDP port numbers
    ICMP message type and codes
    ICMPv6 message type and codes
    IP datagram protocol numbers

    <value>
    <value>, <value>
    <value> - <value>

Expressions that begin with an exclamation mark (!) are called not-expressions. Not-expressions match all values except those values you specify. Not-expressions that do not match any values generate an error.
IPv4 address expression examples :

The <n> can be either hex or decimal number in a range from 0 to 255. All hex numbers must have a 0x prefix.

####  IPv4 address syntax
 | Example |Description |
 | ------ | ------ | 
 | n.n.n.n | Single address |
 |n.n.n.n, n.n.n.n |Address list|
 |n.n.n.n/<netmask> |Specific address using CIDR format; netmask value must range from 1 to 32|
 |n.n.n.n - n.n.n.n |Address range, where first value is smaller than last|


#### TCP/UDP ports, protocol identifiers, or numbers

The values listed for any constant must be within the fields required range; otherwise the parser refuses the parse clause.

    0xFFFF
    65535
    0, 1, 2
    0 - 2
    !(3 - 65535)


