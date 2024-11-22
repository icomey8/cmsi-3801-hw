#ifndef STACK_H
#define STACK_H

#include <stdexcept>
#include <memory>
#include <string>
#include <utility>
#include <algorithm> // For std::max

#define MAX_CAPACITY 32768
#define INITIAL_CAPACITY 16

template <typename T>
class Stack {
private:
    std::unique_ptr<T[]> elements; 
    int capacity;                  
    int top;                       

    Stack(const Stack<T>&) = delete;
    Stack<T>& operator=(const Stack<T>&) = delete;

    void reallocate(int new_capacity) {
        if (new_capacity > MAX_CAPACITY) {
            throw std::overflow_error("Exceeded maximum stack capacity");
        }
        std::unique_ptr<T[]> new_elements = std::make_unique<T[]>(new_capacity);
        for (int i = 0; i < top; ++i) {
            new_elements[i] = elements[i];
        }
        elements = std::move(new_elements);
        capacity = new_capacity;
    }

public:
    Stack()
        : elements(std::make_unique<T[]>(INITIAL_CAPACITY)),
          capacity(INITIAL_CAPACITY),
          top(0) {}

    int size() const {
        return top;
    }

    bool is_empty() const {
        return top == 0;
    }

    bool is_full() const {
        return top == capacity;
    }

    void push(T item) {
        if (top == MAX_CAPACITY) {
            throw std::overflow_error("Stack has reached maximum capacity");
        }
        if (is_full()) {
            reallocate(std::min(2 * capacity, MAX_CAPACITY));
        }
        elements[top++] = item;
    }

    T pop() {
        if (is_empty()) {
            throw std::underflow_error("cannot pop from empty stack");
        }
        T popped_value = elements[--top];
        if (top > 0 && top <= capacity / 4 && capacity > INITIAL_CAPACITY) {
            reallocate(std::max(INITIAL_CAPACITY, capacity / 2));
        }
        return popped_value;
    }

    T peek() const {
        if (is_empty()) {
            throw std::underflow_error("Cannot peek on an empty stack");
        }
        return elements[top - 1];
    }
};

#endif 
