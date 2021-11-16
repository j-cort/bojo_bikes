# Bojo Bikes Project Journal

## Domain Models
Clarify program design by using domain models to break down and represent user stories.

**User Story**
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

**User Story**
As a person,
So that I can use a good bike,
I'd like to see if a bike is working

| Objects | Messages |
| ------- | -------- |
| Person  |          |
| Bike    | working? |

Person > "working?" > Bike
Bike > "T/F" > Person

## Feature Tests
Check that the various aspects of our program are working well together using feature tests.

*Test if a 'docking_station' instance can be produced from the 'DockingStation' class*

```
3.0.0 :005 > docking_station = DockingStation.new
Traceback (most recent call last):
        5: from /Users/james/.rvm/rubies/ruby-3.0.0/bin/irb:23:in `<main>'
        4: from /Users/james/.rvm/rubies/ruby-3.0.0/bin/irb:23:in `load'
        3: from /Users/james/.rvm/rubies/ruby-3.0.0/lib/ruby/gems/3.0.0/gems/irb-1.3.0/exe/irb:11:in `<top (required)>'
        2: from (irb):4:in `<main>'
        1: from (irb):5:in `rescue in <main>'
NameError (uninitialized constant DockingStation)
```

**Error**
---------
- **Type?** NameError
- **Filepath?** from /Users/james/.rvm/rubies/ruby-3.0.0/bin/irb:23:in
- **Line Number?** 23
- **Meaning?** NameError is raised when you reference a constant or a variable which isn't defined in the current context.
- **Solution?** Create the 'DockingStation' class

The feature test fails because the DockingStation class does not exist.

## Unit Tests
Check that a certain unit of code, with a distinct function (related to a particular feature) behaves as expected.

RGR - Red, Green, Refactor
--------------------------
rspec test - DockingStation class exists - **FAIL**
./spec/docking_station_spec.rb
```
describe DockingStation do
end
```

rspec test - DockingStation class exists - **PASS**
./spec/docking_station_spec.rb
```
require 'docking_station'
describe DockingStation do
end
```
./lib/docking_station.rb
```
class DockingStation
end
```

rspec test - Clean Prod Code? - **Refactor Unnecessary**

--------------

The above process of breaking down user stories, feature testing and unit testing (RGR) is repeated through to project completion.