This implements a sharded counter. A cluster contains a collection of P-N Counters, each of which contains separate
state. Writes to the counters may enter into any P-N Counter directly, whereas reads must be performed from the cluster
leader.

Consider each counter as a node in a distributed system, ignoring details related to networking, protocols, and cluster
membership.

This system is eventually consistent because changes may enter each counter while the reads are still being aggregated.

It is not fault tolerant, because the loss of any individual node will irreparably damage the count totals.
