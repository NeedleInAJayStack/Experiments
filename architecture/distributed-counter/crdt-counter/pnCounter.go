package main

import (
	"fmt"

	"github.com/google/uuid"
)

// P-N counter

type PNCounter struct {
	id       string
	positive map[string]int
	negative map[string]int
}

func NewPNCounter() *PNCounter {
	id := uuid.NewString()
	return &PNCounter{
		id:       id,
		positive: map[string]int{id: 0},
		negative: map[string]int{id: 0},
	}
}

func (c *PNCounter) Increment() {
	c.positive[c.id]++
}

func (c *PNCounter) Decrement() {
	c.negative[c.id]++
}

func (c *PNCounter) Count() int {
	sum := 0
	for _, p := range c.positive {
		sum = sum + p
	}
	for _, n := range c.negative {
		sum = sum - n
	}
	return sum
}

func (c *PNCounter) Merge(o *PNCounter) {
	for id, p := range o.positive {
		if _, exists := c.positive[id]; !exists {
			c.positive[id] = p
		}
		// o being greater means it has newer information
		if p > c.positive[id] {
			c.positive[id] = p
		}
	}
	for id, n := range o.negative {
		if _, exists := c.negative[id]; !exists {
			c.negative[id] = n
		}
		if n > c.negative[id] {
			c.negative[id] = n
		}
	}
}

func (c *PNCounter) Description() {
	fmt.Printf("node: %v, p: %v, n: %v\n", c.id, c.positive[c.id], c.negative[c.id])
}
