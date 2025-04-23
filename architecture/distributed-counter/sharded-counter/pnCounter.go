package main

import (
	"fmt"

	"github.com/google/uuid"
)

// P-N counter

type PNCounter struct {
	id       string
	positive int
	negative int
}

func NewPNCounter() *PNCounter {
	return &PNCounter{
		id:       uuid.NewString(),
		positive: 0,
		negative: 0,
	}
}

func (c *PNCounter) Increment() {
	c.positive++
}

func (c *PNCounter) Decrement() {
	c.negative++
}

// Disallowed externally because it should be queried at the cluster level.
func (c *PNCounter) count() int {
	return c.positive - c.negative
}

func (c *PNCounter) Description() {
	fmt.Printf("node: %v, p: %v, n: %v\n", c.id, c.positive, c.negative)
}
