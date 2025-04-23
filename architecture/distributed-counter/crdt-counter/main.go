package main

import "fmt"

func main() {
	cluster := NewPNCounterCluster(3)

	fmt.Printf("Count: %v\n", cluster.CountFromRandom())
	cluster.PrintCounts()

	// Increment two counters & observe the combined result
	for i := 0; i < 5; i++ {
		cluster.Counters[0].Increment()
		cluster.Counters[1].Increment()
	}
	cluster.Synchronize()

	fmt.Println("---")
	fmt.Printf("Count: %v\n", cluster.CountFromRandom())
	cluster.PrintCounts()

	// Decrement two counters & observe the combined result
	for i := 0; i < 5; i++ {
		cluster.Counters[1].Decrement()
		cluster.Counters[2].Decrement()
	}
	cluster.Synchronize()

	fmt.Println("---")
	fmt.Printf("Count: %v\n", cluster.CountFromRandom())
	cluster.PrintCounts()

	// Increment random counters & observe the combined result
	for i := 0; i < 10; i++ {
		cluster.IncrementRandom()
	}
	cluster.Synchronize()

	fmt.Println("---")
	fmt.Printf("Count: %v\n", cluster.CountFromRandom())
	cluster.PrintCounts()
}
