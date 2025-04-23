This implements a CRDT-based sharded counter. Each counter instance (node) is a CRDT that contains its own counter as well as
counts for the rest of the counters in the cluster, allowing both read and writes to occur on individual counter nodes.
The cost of this is cross-node coordination (implemented naiively here with a Cluster.Synchronize method), which could
be achieved asynchronously according to the consistency latency allowed by the system. The cluster in this example only
serves to coordinate the disparate counters, and could be completely removed if a decentralized consensus system like
gossip is used.

This system is eventually consistent because changes from other nodes may not have been synchronized by the time the
count is read from a particular node.

It is fault tolerant, because the count totals will be preserved across of any individual node outage/failure.
