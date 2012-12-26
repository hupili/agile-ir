# Search in RFC Paragraphs

## Question

[RFC4862](http://tools.ietf.org/html/rfc4862)
is about IPv6 Stateless Address Autoconfiguration (SLAAC). 
I want to confirm whether DNS information is included in Router Advertisement (RA). 

While one can learn every aspect of the protocol first 
and then answer this question, 
I decide to do some preliminary literal judgement first. 

e.g. 

   * Whether there is a paragraph talking about "router advertisement" and "DNS". 

`grep` is ready for line search but now we want to perform paragraph search. 

## Procedures

Download the document:

```
$wget http://tools.ietf.org/rfc/rfc4862.txt
 ...
2012-12-26 15:13:59 (60.9 KB/s) - `rfc4862.txt' saved [72482/72482]
```

Squeeze the paragraphs for further use: 

```
$cat rfc4862.txt | sed 's/^$/__paragraph__/' | tr -d "\n" | sed 's/__paragraph__/\n/g' > rfc4862.txt.p
$less 
    ...
1.  Introduction
   This document specifies the steps a host takes in deciding how to   autoconfigure its interfaces in IP version 6 (IPv6).  The   autoconfiguration process includes generating a link-local address,   generating global addresses via stateless address autoconfiguration,   and the Duplicate Address Detection procedure to verify the   uniqueness of the addresses on a link.
   The IPv6 stateless autoconfiguration mechanism requires no manual   configuration of hosts, minimal (if any) configuration of routers,   and no additional servers.  The stateless mechanism allows a host to   generate its own addresses using a combination of locally available   information and information advertised by routers.  Routers advertise   prefixes that identify the subnet(s) associated with a link, while   hosts generate an "interface identifier" that uniquely identifies an   interface on a subnet.  An address is formed by combining the two.   In the absence of routers, a host can only generate link-local   addresses.  However, link-local addresses are sufficient for allowing   communication among nodes attached to the same link.
    ...
```

Now every paragraph is one a single line, so we just use 
normal ways to grep what we want:

```
$cat rfc4862.txt.p | grep -i "router advertisement" | wc -l
22
$cat rfc4862.txt.p | grep -i "router advertisement" | grep -i "dns" | wc -l
0
```

We've got a handful lines containing "router advertisement" but no "dns in the same paragraph. 

## Remarks 

This is just for illustration.
Apparently, a better way is to check "dns" first. 
One may find that there is no related terms, e.g. "dns", "domain", "name". 

Nevertheless, one can get more information in this way. 
If you want to find relevant paragraph talking about network prefixes in Routing Advertisement, 
just adapt the above one-liner:

```
$cat rfc4862.txt.p | grep -i "router advertisement" | grep -i "prefix" 
   o  A large site with multiple networks and routers should not require      the presence of a DHCPv6 server for address configuration.  In      order to generate global addresses, hosts must determine the      prefixes that identify the subnets to which they attach.  Routers      generate periodic Router Advertisements that include options      listing the set of active prefixes on a link.
   Router Advertisements also contain zero or more Prefix Information   options that contain information used by stateless address   autoconfiguration to generate global addresses.  It should be noted   that a host may use both stateless address autoconfiguration and   DHCPv6 simultaneously.  One Prefix Information option field, the   "autonomous address-configuration flag", indicates whether or not the   option even applies to stateless autoconfiguration.  If it does,   additional option fields contain a subnet prefix, together with   lifetime values, indicating how long addresses created from the   prefix remain preferred and valid.
   Global addresses are formed by appending an interface identifier to a   prefix of appropriate length.  Prefixes are obtained from Prefix   Information options contained in Router Advertisements.  Creation of   global addresses as described in this section SHOULD be locally   configurable.  However, the processing described below MUST be   enabled by default.
   For each Prefix-Information option in the Router Advertisement:
      It is the responsibility of the system administrator to ensure      that the lengths of prefixes contained in Router Advertisements      are consistent with the length of interface identifiers for that      link type.  It should be noted, however, that this does not mean      the advertised prefix length is meaningless.  In fact, the      advertised length has non-trivial meaning for on-link      determination in [RFC4861] where the sum of the prefix length and      the interface identifier length may not be equal to 128.  Thus, it      should be safe to validate the advertised prefix length here, in      order to detect and avoid a configuration error specifying an      invalid prefix length in the context of address autoconfiguration.
      2.  If RemainingLifetime is less than or equal to 2 hours, ignore          the Prefix Information option with regards to the valid          lifetime, unless the Router Advertisement from which this          option was obtained has been authenticated (e.g., via Secure          Neighbor Discovery [RFC3971]).  If the Router Advertisement          was authenticated, the valid lifetime of the corresponding          address should be set to the Valid Lifetime in the received          option.
   o  Added rules to Section 5.5.3 Router Advertisement processing to      address potential denial-of-service attack when prefixes are      advertised with very short Lifetimes.
   o  Clarified how the length of interface identifiers should be      determined, described the relationship with the prefix length      advertised in Router Advertisements, and avoided using a      particular length hard-coded in this document.
```
