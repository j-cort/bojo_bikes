### Bojo Bikes Project Notes

## Clarify Program Design Using Domain Models

# User Story
As a person,
So that I can use a bike,
I'd like a docking station to release a bike.
 
| Objects | Messages |
| ------- | -------- |
| Person  |          |
| Bike    |          |
| Docking Station | release bike |

Person > "release bike" > Docking Station
Docking Station > "confirm release" > Person

# User Story
As a person,
So that I can use a good bike,
I'd like to see if a bike is working

| Objects | Messages |
| ------- | -------- |
| Person  |          |
| Bike    | working? |

Person > "working?" > Bike
Bike > "T/F" > Person