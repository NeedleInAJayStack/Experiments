package main

import "fmt"

func main() {
	cluster := NewPNCounterCluster(3)

	fmt.Printf("Count: %v\n", cluster.Count())
	cluster.PrintCounts()

	// Increment two counters & observe the combined result
	for i := 0; i < 5; i++ {
		cluster.Counters[0].Increment()
		cluster.Counters[1].Increment()
	}

	fmt.Println("---")
	fmt.Printf("Count: %v\n", cluster.Count())
	cluster.PrintCounts()

	// Decrement two counters & observe the combined result
	for i := 0; i < 5; i++ {
		cluster.Counters[1].Decrement()
		cluster.Counters[2].Decrement()
	}

	fmt.Println("---")
	fmt.Printf("Count: %v\n", cluster.Count())
	cluster.PrintCounts()

	// Increment random counters & observe the combined result
	for i := 0; i < 10; i++ {
		cluster.IncrementRandom()
	}

	fmt.Println("---")
	fmt.Printf("Count: %v\n", cluster.Count())
	cluster.PrintCounts()
}
