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

func (c *PNCounterCluster) Count() int {
	sum := 0
	for _, counter := range c.Counters {
		sum = sum + counter.count()
	}
	return sum
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
