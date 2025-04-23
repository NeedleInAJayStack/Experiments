package main

import "math/rand"

type PNCounterCluster struct {
	Counters []*PNCounter
}

func NewPNCounterCluster(numberOfCounters int) *PNCounterCluster {
	// Create counter shards (pretend this is happening across computer nodes)
	counters := []*PNCounter{}
	for i := 0; i < numberOfCounters; i++ {
		counters = append(counters, NewPNCounter())
	}
	return &PNCounterCluster{Counters: counters}
}

// Synchronize the CRDTs
// This could be done in a background process, in a decentralized way, i.e. gossip protocol
// It's execution determines the delay in consistency when reading from a counter
func (c *PNCounterCluster) Synchronize() {
	for _, counterA := range c.Counters {
		for _, counterB := range c.Counters {
			if counterA.id != counterB.id {
				counterA.Merge(counterB)
			}
		}
	}
}

// Get the total system count from a random counter
func (c *PNCounterCluster) CountFromRandom() int {
	counter := c.Counters[rand.Intn(len(c.Counters))]
	return counter.Count()
}

// Increment a random counter
func (c *PNCounterCluster) IncrementRandom() {
	counter := c.Counters[rand.Intn(len(c.Counters))]
	counter.Increment()
}

// Decrement a random counter
func (c *PNCounterCluster) DecrementRandom() {
	counter := c.Counters[rand.Intn(len(c.Counters))]
	counter.Decrement()
}

func (c *PNCounterCluster) PrintCounts() {
	for _, counter := range c.Counters {
		counter.Description()
	}
}
