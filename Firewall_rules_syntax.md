# Firewall rule syntax

Use this syntax when creating firewall rules for your Network IPS appliance.

## Firewall rule syntax
A firewall rule consists of several statements (or clauses) that define the traffic for which the rule applies. When you manually create firewall rules for the appliance to use, you can use the following syntax.

|Syntax rule |	Description |	Examples |
|--------|-------|------|
|Adapter clause |	Indicates a specific adapter where the rule is applied. <br> Note: Supported adapter clauses are "any" or the letters A through H. If you do not specify an adapter clause, the rule matches packets on any adapter |- adapter A <br> - adapter B <br> - adapter any |
| Ethernet Clause |	Filters 802.1q VLAN traffic or allows or denies specific types of Ethernet protocols. |- ether vid 2 <br>- ether proto 0x86dd <br>- ether vid 3-199 <br>- proto 0x0800,0x86dd |
| IP clause |	Indicates the version of IP protocol and the conditions in the header that must be satisfied for the statement to match the rule.|- ip IP-source-address-condition IP-destination-address-condition <br>  
|IP datagram clause |	Indicates the protocol and the protocol-specific conditions that must be satisfied for the statement to match.<br> Note: The supported protocols are ICMP, ICMPv6, TCP, and UDP. You can also specify a set of IP protocol numbers.|- icmp ICMP-type-condition ICMP-code-condition <br>- icmpv6 ICMP-type-condition ICMP-code-condition<br>- tcp TCP-source-port-number-condition TCP-destination-port-number-condition<br>- udp UDP-source-port-number-condition UDP-destination-port-number-condition <br>- proto protocol-number-expression|
|Source and target address conditions |	Indicates the set of allowable IPv4 or IPv6 addresses for the source or target for the establishment of a TCP-based connection, UDP packet, ICMP packet, or ICMPv6 packet. |- src addrIP-source-address-expression <br>- dst addrIP-destination-address-expression |
| TCP/UDP source and target port conditions |	Indicate the set of TCP or UDP ports for the source or target of the establishment of a (TCP) connection or a (UDP) packet. |- src portport-number-expression <br>- dst portport-number-expression |
| ICMP type and code conditions |	Indicate the set of ICMP and ICMPv6 types or codes for either side of the packet. |- type ICMP-type-expression <br>- code ICMP-code-expression |
| Using ranges |	Indicates a range of values for IP addresses, port numbers, ICMP message types and codes, and protocol numbers using a dash (-) between the first and last values in the range.|- ip src addrxxx.xxx.x.x - xxx.xxx.x.xx <br>- Note: x is a number in the IP address <br> tcp dst port 20 - 80|
| Using "any"| 	Specifies "any" in all expressions.|- ip dstaddr any <br>- icmp type any |

