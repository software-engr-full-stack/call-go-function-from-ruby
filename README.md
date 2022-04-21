# Call a Go function from Ruby

### Write the Go function

```go
// main.go
package main

import (
    "C"
)
// "gofunc" is the function name that will be called by the Ruby code.
// This can be any name. Just be consistent with the function and file names.
// The "main" function can be empty.
// There must not be any space between // and "export".
//export gofunc
func gofunc(inp *C.char) *C.char {
    // Convert the input from C string type to Go string type
    input := C.GoString(inp)

    // Do whatever
    result = process(input)

    // Convert Go type to C type
    return C.CString(string(result))
}
```

### Build the shared object file

`go build -o gofunc.so -buildmode=c-shared *.go`

This will produce the file `gofunc.so`.

### Call the file from Ruby

1. Install the `ffi` gem.

2. Write the Ruby code

```ruby
# main.rb
require 'ffi'

class Main
  extend FFI::Library
  ffi_lib './gofunc.so'

  attach_function :gofunc, [:string], :string

  def initialize
    # Call the Go function
    result = gofunc inp

    p result
  end
end

Main.new
```

## Usage

1. Clone this repo

2. `cd` into the clone directory

3. `make run`
