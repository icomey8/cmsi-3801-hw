package main

import (
	"log"
	"math/rand"
	"sync"
	"sync/atomic"
	"time"
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
	reply chan *Order
}

// generate next order id - similar to java, need atomic
var nextId atomic.Uint64

// a waiter can only hold 3 orders at once
var Waiter = make(chan *Order, 3)


func Cook(name string) {
	log.Println(name, "cook starts")
	for {
		order := <- Waiter
		do(10, name, "cooking order", order.id, "for", order.customer)
		order.preparedBy = name
		order.reply <- order
	}

}

func Customer(name string, wg *sync.WaitGroup) {
	for mealsEaten := 0; mealsEaten < 5; {
		// place order 
		order := &Order{
			id:       nextId.Add(1),
			customer: name,
			reply:    make(chan *Order),
		}
		log.Println(name, "places order", order.id)
		
		// select statement so that if waiter gets order within 7 secs 
			// then you get it from  cook and eat it (mealsEaten ++)
			// if don't get it, leave the restaurant (do(5, name, "is waiting too long, abandoning order", order.id))
		select {
		// case 1 - get order in time 
		// case 2 - too long, abandon order
		}

	}
	log.Println(name, "going home")
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
	wg.Wait()

	log.Println("Restaurant closing")
}