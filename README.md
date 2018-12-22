# Firewall-Rules

This repository contains assignment submission to the course 'Logic in Computer Science' at BITS Pilani by me and [Priyanka Verma](https://github.com/PriyankaVerma98).

It is a **prolog** encoding of Firewall rules.
<br>

## Problem Statement 

 Firewall rules are encoded in Prolog as facts and rules: each rule may start with accept (allow the incoming packet),         reject (send reject information to sender), or drop (silently) followed by a clause. [see documentation for syntax]

#### Documentation - 
[Firewall language rules](Firewall_rules_language.md) <br>
[Firewall language syntax](Firewall_rules_syntax.md)

Write a Prolog program to apply encoded rules on any incoming packet. Note that multiple rules may apply.



## The Solution

[Code](Code.pl) contains the prolog encoding <br>
[Instructions](instructions.txt) contains the instructions for passing query to the prolog program <br>
[Database](Database.txt) contains a list of all predicates used in prolog code to encode the rules <br>
[Sample Inputs](inputFile.txt) contains some sample input queries along with the obtained outputs
