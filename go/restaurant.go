package main

import (
	"log"
	"math/rand"
	"time"
	"sync"
	"sync/atomic"
)

// A little utility that simulates performing a task for a random duration.
// For example, calling do(10, "Remy", "is cooking") will compute a random
// number of milliseconds between 5000 and 10000, log "Remy is cooking",
// and sleep the current goroutine for that much time.

func do(seconds int, action ...any) {
    log.Println(action...)
    randomMillis := 500 * seconds + rand.Intn(500 * seconds)
    time.Sleep(time.Duration(randomMillis) * time.Millisecond)
}

type Order struct {
	id uint64
	customer string 
	preparedBy string
	// check java version to add more
		// make a replay which is a channel that can take the order (need pointer to the order)
}

// generate next order id - similar to java, need atomic
var nextId atomic.Uint64

// a waiter can only hold 3 orders at once
var Waiter = make(chan *Order, 3 )


func Cook(name string) {
	// log that cooks starts
	// loop forever
	// wait for order from waiter, cook it
	// put name of the cook in the order
	// send it back into the reply channel order.replay <- order

}

func Customer(name string, wg *sync.WaitGroup) {
	for mealsEaten := 0, mealsEaten < 5; {
		// place order 
		// select statement so that if waiter gets order within 7 secs 
			// then you get it from  cook and eat it (mealsEaten ++)
			// if don't get it, leave the restaurant (do(5, name, "is waiting too long, abandoning order", order.id))
	}
}

func main() {
	customers := [10]string{"Ani", "Bai", "Cat", "Dao", "Eve", "Fay", "Gus", "Hua", "Iza", "Jai"}
	// in a loop start each customer as a go routine
	var wg sync.WaitGroup
	for _, customer := range customers {
		wg.Add(1)
		go Customer(customer, &wg)
	}

	// start 3 cooks, Remy, Linguini, and Colette
	go Cook("Remy")
	go Cook("Linguini")
	go Cook("Colette")

	// wait for all customers to finish 

	log.Println("Restaurant closing")
}