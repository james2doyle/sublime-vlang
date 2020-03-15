// This is a single line comment.

/* This is a multiline comment.
   /* It can be nested. */
*/

module main

import mymodule

fn add(x int, y int) int {
    return x + y
}

fn main() {
    println(add(77, 33))
    println(sub(100, 50))
}

fn sub(x, y int) int {
    name := 'Bob'
    mut age := 20
    println(age)
    age = 21
    println(age)
    large_number := i64(9999999999)
    println(name)
    println(large_number)

    mut nums := [1, 2, 3]
    println(nums) // "[1, 2, 3]"
    println(nums[1]) // "2"

    nums << 4
    println(nums) // "[1, 2, 3, 4]"

    nums << [5, 6, 7]
    println(nums) // "[1, 2, 3, 4, 5, 6, 7]"

    mut names := ['John']
    names << 'Peter'
    names << 'Sam'

    // names << 10  <-- This will not compile. `names` is an array of strings.
    println(names.len) // "3"
    println('Alex' in names) // "false"

    names = [] // The array is now empty

    // We can also preallocate a certain amount of elements.
    ids := [0].repeat(50) // This creates an array with 50 zeros

    nums := [1, 2, 3, 4, 5, 6]
    even := nums.filter(it % 2 == 0)
    println(even) // [2, 4, 6]

    words := ['hello', 'world']
    upper := words.map(it.to_upper())
    println(upper) // ['HELLO', 'WORLD']
    mut m := map[string]int // Only maps with string keys are allowed for now
    m['one'] = 1
    m['two'] = 2
    println(m['one']) // "1"
    println(m['bad_key']) // "0"
    println('bad_key' in m) // Use `in` to detect whether such key exists
    m.delete('two')

    numbers := {
        'one': 1,
        'two': 2,
    }

    a := 10
    b := 20
    if a < b {
        println('$a < $b')
    } else if a > b {
        println('$a > $b')
    } else {
        println('$a == $b')
    }

    num := 777
    s := if num % 2 == 0 {
        'even'
    }
    else {
        'odd'
    }
    println(s) // "odd"

numbers := [1, 2, 3, 4, 5]
for num in numbers {
    println(num)
}
names := ['Sam', 'Peter']
for i, name in names {
    println('$i) $name')  // Output: 0) Sam
}

mut numbers := [1, 2, 3, 4, 5]
for i, num in numbers {
    println(num)
    numbers[i] = 0
}


mut sum := 0
mut i := 0
for i <= 100 {
    sum += i
    i++
}
println(sum) // "5050"

mut num := 0
for {
    num++
    if num >= 10 {
        break
    }
}
println(num) // "10"

for i := 0; i < 10; i++ {
    // Don't print 6
    if i == 6 {
        continue
    }
    println(i)
}

os := 'windows'
print('V is running on ')
match os {
    'darwin' { println('macOS.') }
    'linux'  { println('Linux.') }
    else     { println(os) }
}

s := match number {
    1    { 'one' }
    2    { 'two' }
    else {
        println('this works too')
        'many'
    }
}

enum Color {
    red
    blue
    green
}

fn is_red_or_blue(c Color) bool {
    return match c {
        .red { true }
        .blue { true }
        else { false }
    }
}

// TODO: this will be implemented later
struct Button {
    Widget
    title string
}

button := new_button('Click me')
button.set_pos(x, y)

// Without embedding we'd have to do
button.widget.set_pos(x,y)

struct Foo {
  a int
  b int = 10
}

foo := Foo{}
assert foo.a == 0
assert foo.b == 10

}

struct User {
mut:
    is_registered bool
}

fn (u mut User) register() {
    u.is_registered = true
}

mut user := User{}
println(user.is_registered) // "false"
user.register()
println(user.is_registered) // "true"

fn multiply_by_2(arr mut []int) {
    for i := 0; i < arr.len; i++ {
        arr[i] *= 2
    }
}

mut nums := [1, 2, 3]
multiply_by_2(mut nums)
println(nums) // "[2, 4, 6]"

fn sqr(n int) int {
    return n * n
}

fn run(value int, op fn(int) int) int {
    return op(value)
}

fn main()  {
    println(run(5, sqr)) // "25"
}

struct Dog {}
struct Cat {}

fn (d Dog) speak() string {
    return 'woof'
}

fn (c Cat) speak() string {
    return 'meow'
}

interface Speaker {
    speak() string
}

fn perform(s Speaker) {
    println(s.speak())
}

dog := Dog{}
cat := Cat{}
perform(dog) // "woof"
perform(cat) // "meow"

enum Color {
    red green blue
}

fn main() {
    mut color := Color.red
    // V knows that `color` is a `Color`. No need to use `color = Color.green` here.
    color = .green
    println(color) // "1"  TODO: print "green"?
    if color == .green {
        println("it's green")
    }
}

struct User {
    id int
    name string
}

struct Repo {
    users []User
}

fn new_repo() Repo {
    return Repo {
        users: [User{1, 'Andrew'}, User {2, 'Bob'}, User {10, 'Charles'}]
    }
}

fn (r Repo) find_user_by_id(id int) ?User {
    for user in r.users {
        if user.id == id {
            // V automatically wraps this into an option type
            return user
        }
    }
    return error('User $id not found')
}

fn main() {
    repo := new_repo()
    user := repo.find_user_by_id(10) or { // Option types must be handled by `or` blocks
        return  // `or` block must end with `return`, `break`, or `continue`
    }
    println(user.id) // "10"
    println(user.name) // "Charles"
}

struct Repo<T> {
    db DB
}

fn new_repo<T>(db DB) Repo<T> {
    return Repo<T>{db: db}
}

// This is a generic function. V will generate it for every type it's used with.
fn (r Repo<T>) find_by_id(id int) ?T {
    table_name := T.name // in this example getting the name of the type gives us the table name
    return r.db.query_one<T>('select * from $table_name where id = ?', id)
}

db := new_db()
users_repo := new_repo<User>(db)
posts_repo := new_repo<Post>(db)
user := users_repo.find_by_id(1)?
post := posts_repo.find_by_id(1)?


import json

struct User {
    name string
    age  int

    // Use the `skip` attribute to skip certain fields
    foo Foo [skip]

    // If the field name is different in JSON, it can be specified
    last_name string [json:lastName]
}

data := '{ "name": "Frodo", "lastName": "Baggins", "age": 25 }'
user := json.decode(User, data) or {
    eprintln('Failed to decode json')
    return
}
println(user.name)
println(user.last_name)
println(user.age)

$if windows {
    println('Windows')
}

$if linux {
    println('Linux')
}

$if mac {
    println('macOS')
}

$if debug {
    println('debugging')
}

// TODO: not implemented yet
fn decode<T>(data string) T {
    mut result := T{}
    for field in T.fields {
        if field.typ == 'string' {
            result.$field = get_string(data, field.name)
        } else if field.typ == 'int' {
            result.$field = get_int(data, field.name)
        }
    }
    return result
}

// generates to:
fn decode_User(data string) User {
    mut result := User{}
    result.name = get_string(data, 'name')
    result.age = get_int(data, 'age')
    return result
}

struct Vec {
    x int
    y int
}

fn (a Vec) str() string {
    return '{$a.x, $a.y}'
}

fn (a Vec) + (b Vec) Vec {
    return Vec {
        a.x + b.x,
        a.y + b.y
    }
}

fn (a Vec) - (b Vec) Vec {
    return Vec {
        a.x - b.x,
        a.y - b.y
    }
}

fn main() {
    a := Vec{2, 3}
    b := Vec{4, 5}
    println(a + b) // "{6, 8}"
    println(a - b) // "{-2, -2}"
}
