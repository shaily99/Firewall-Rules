 													/* GENERAL FUNCTIONS */

/* Shaily Bhatt 2017A7PS0040P	and Priyanka Verma 2016B3A70492P */

/* member relation */

member(X,[X|_]).
member(X,[_|Tail]):- member(X,Tail).
member(X,[H|_]):- member(X,H). 

/*Function to check whether elements of one list are present in the other or not*/
allElementsInList([],_).
allElementsInList([X|Tail],L):- member(X,L), allElementsInList(Tail,L).

/* function to check if two lists have atleast one element is common */

match([Head|_], List2):- member(Head,List2).
match([_|Tail],List2):- match(Tail,List2).

/* function to check range */ 

inRange([],_,_).
inRange([H|T], Lo, Hi):- number_codes(X,H), between(Lo,Hi,X), inRange(T,Lo,Hi).



														/*ADAPTER CLAUSE*/
/*Null value is taken as -1 and is accepted. */
/*input format = List of "<string>" */

/* list of accepted and rejected adapters. All other values are dropped by default */

adapter_accepted_list(["a","b","c","d","e", "any"]).
adapter_rejected_list(["f","g","h"]).

/*rules for accepted adapters :- all members of the input list are in accepted list*/

adapter_accept(-1). 
adapter_accept(A):-adapter_accepted_list(L), (member(A,L);allElementsInList(A,L)) .

/* rules for rejected adapters :- any member of the input list is in rejected list */

adapter_reject(A):- adapter_rejected_list(L1), (member(A,L1);match(A,L1)), write('adapter rejected.... ').



												       /* IPv4 ADDRESS CLAUSE */

/*input format = "x.x.x.x" ; Single IP address is accepted as input; IP address cannot be null*/

ipv4_accept(A):- split_string(A,".",".", L), inRange(L,101,255).  

ipv4_reject(A):- split_string(A,".",".", Li), inRange(Li,0,100), write('IPv4 address is in reject range.... '). 



														/* ETHERNET CLAUSE */

/*input format = List of "<string>". Null value is rejected */

list_reject_ethernet(["ipx","pppoe","arp","0","1","2","3","4","5","6","7","8","9"]).
list_accept_ethernet(["xns","sna","rarp","10","11","12","13","14","15","16","17","18","19"]).

/*rules for accepted and rejected ethernet_proto */

ethernet_proto_reject(B) :- list_reject_ethernet(R), (member(B,R);match(B,R)) , write('ethernet proto rejected.... ') . 
ethernet_vid_reject(-1):- write('ethernet proto cannot be null.... ').

ethernet_proto_accept(B) :- list_accept_ethernet(R), (member(B,R);allElementsInList(B,R)). 

/* rules for accepted and rejected ethernet_vid  */

ethernet_vid_reject(C) :- inRange(C,0,50),write('ethernet vid rejected.... '). 
ethernet_vid_reject(-1):- write('ethernet vid cannot be null.... ').

ethernet_vid_accept(C) :- inRange(C,51,399).


												

													/* TCP CLAUSE AND UDP CLAUSES */

/*input format = list of strings ; either one of TCP src and des OR UDP src and des should be entered*/

/* accept and reject ranges of tcp */

tcpsrc_acceptrange(X):-  inRange(X,0,100).
tcpdes_acceptrange(X):- inRange(X,0,100).

tcpsrc_rejectrange(X):- inRange(X,101,200).
tcpdes_rejectrange(X):-  inRange(X,101,200).

tcp_accept(-1,-1).
tcp_accept(A,B):- tcpsrc_acceptrange(A),tcpdes_acceptrange(B).

tcp_reject(A,B):- (tcpsrc_rejectrange(A); tcpdes_rejectrange(B)), write('TCP source or destination address is in reject range.... ').

/* accept and reject ranges of udp */

udpsrc_acceptrange(X):-  inRange(X,0,200).
udpdes_acceptrange(X):-  inRange(X,0,200).

udpsrc_rejectrange(X):- inRange(X,201,500).
udpdes_rejectrange(X):-  inRange(X,201,500).

udp_accept(-1,-1).
udp_accept(A,B):- udpsrc_acceptrange(A),udpdes_acceptrange(B).

udp_reject(A,B):- (udpsrc_rejectrange(A); udpdes_rejectrange(B)), write('UDP source or destination address is in reject range.... ').

/*rule for accepting or rejecting based on tcp and udp */

tcpudp_accept(A,B,C,D):- tcp_accept(A,B),udp_accept(C,D).
tcpudp_reject(A,B,C,D):- (tcp_reject(A,B);udp_reject(C,D)).



													/* ICMP CLAUSES */

/*list of accepted and rejected icmp values*/

icmp_accept_list(["0","1","-1","25","50"]).
icmp_reject_list(["2","11"]).

/*rules for accepting and rejecting icmp*/

icmp_reject(D) :-  icmp_reject_list(K), (match(D,K);member(D,K)) , write('icmp rejected.... ').

icmp_accept(D) :-  icmp_accept_list(K), (member(D,K);allElementsInList(D,K)).




												/* ACCEPT, REJECT AND DROP CONDITIONS FOR PACKET */

/* rules to check accept, reject and drop condtions on packets. if all elements are in accept ranges then packet is accepted, if any one is in reject then packet is rejected, in all other conditions, packet is to be dropped */

accept(A,B,V,P,C,D,E,F,G):- adapter_accept(A), ipv4_accept(B), ethernet_vid_accept(V), ethernet_proto_accept(P), tcpudp_accept(C,D,E,F), icmp_accept(G).
reject(A,B,V,P,C,D,E,F,G):- adapter_reject(A); ipv4_reject(B); tcpudp_reject(C,D,E,F); ethernet_vid_reject(V);ethernet_proto_reject(P); icmp_reject(G).
drop(A,B,V,P,C,D,E,F,G):- ((\+accept(A,B,V,P,C,D,E,F,G)) , (\+reject(A,B,V,P,C,D,E,F,G))).

/* input query and final output */

packet(A,B,V,P,C,D,E,F,G):- accept(A,B,V,P,C,D,E,F,G), write('accept').
packet(A,B,V,P,C,D,E,F,G):- reject(A,B,V,P,C,D,E,F,G), write('reject').
packet(A,B,V,P,C,D,E,F,G):- drop(A,B,V,P,C,D,E,F,G), write('drop').