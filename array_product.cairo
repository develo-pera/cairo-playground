%builtins output

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.serialize import serialize_word

// Write a function that computes the product of all the even entries of an array:
// (arr[0] * arr[2] * ...)
func array_product(arr: felt*, size) -> felt {
    if (size == 0) {
        return 1;
    }

    // size is not zero.
    let sum_of_rest = array_product(arr=arr + 2, size=size - 2);
    return arr[0] * sum_of_rest;
}

func main{output_ptr: felt*}() {
    const ARRAY_SIZE = 4;

    let (ptr) = alloc();

    assert [ptr] = 2;
    assert [ptr + 1] = 3;
    assert [ptr + 2] = 4;
    assert [ptr + 3] = 5;

    let sum = array_product(arr=ptr, size=ARRAY_SIZE);

    serialize_word(sum);

    return ();
}
