from __future__ import annotations
from collections.abc import Iterable, Iterator
from typing import Any, List
from dataclasses import dataclass
from enum import Enum
from datetime import date
"""
To create an iterator in Python, there are two abstract classes from the built-
in `collections` module - Iterable,Iterator. We need to implement the
`__iter__()` method in the iterated object (collection), and the `__next__ ()`
method in the iterator.
"""

class CardTypes(Enum):
    VISA = "VI"
    MASTER_CARD = "MC"

@dataclass
class Payment:
    name:str = None
    card_type:CardTypes = None
    date_transaction: date = None
    amount:int = 0

class PaymentIterator(Iterator):
    """
    Concrete Iterators implement various traversal algorithms. These classes
    store the current traversal position at all times.

        `_position` attribute stores the current traversal position. An iterator may
    have a lot of other fields for storing iteration state, especially when it
    is supposed to work with a particular kind of collection.

     This attribute indicates the traversal direction.


    """

    _position: int = None
    _reverse: bool = False

    def __init__(self, collection: PaymentCollection, reverse: bool = False) -> None:
        self._collection = collection
        self._reverse = reverse
        self._position = -1 if reverse else 0

    def __next__(self):
        """
        The __next__() method must return the next item in the sequence. On
        reaching the end, and in subsequent calls, it must raise StopIteration.
        """
        try:
            self._position += -1 if self._reverse else 1
            value = self._collection[self._position]
        except IndexError:
            raise StopIteration()

        return value

    def __getitem__(self,key):
        return getattr(PaymentCollection[self._position],key)

class PaymentCollection(Iterable):
    """
    Concrete Collections provide one or several methods for retrieving fresh
    iterator instances, compatible with the collection class.
    """

    def __init__(self, collection: List[Payment] = []) -> None:
        self._collection = collection

    def __iter__(self) -> PaymentIterator:
        """
        The __iter__() method returns the iterator object itself, by default we
        return the iterator in ascending order.
        """
        return  PaymentIterator(self._collection)


    def get_reverse_iterator(self) -> PaymentIterator:
        return AlphabeticalOrderIterator(self._collection, True)

    def add_item(self, item: Payment):
        if item.card_type is not None:
            self._collection.append(item)
        else:
            raise Exception("card_type must have a value")


if __name__ == "__main__":
    # The client code may or may not know about the Concrete Iterator or
    # Collection classes, depending on the level of indirection you want to keep
    # in your program.

    pago1 = Payment("david",CardTypes.VISA,date.today(),100)
    pago2 = Payment("david",CardTypes.VISA,date.today(),100)
    pago3 = Payment("david",CardTypes.VISA,date.today(),100)

