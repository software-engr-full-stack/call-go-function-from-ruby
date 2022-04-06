package main

import (
    "C"
    "encoding/json"
)

func main() {
}

//export gofunc
func gofunc(inp *C.char) *C.char {
    input := C.GoString(inp)

    var data map[string]interface{}
    err := json.Unmarshal([]byte(input), &data)
    if err != nil {
        result := handleErr(err)
        return C.CString(string(result))
    }

    result, err := json.Marshal(map[string]map[string]interface{}{
        "result": map[string]interface{}{
            "received": data,
        },
    })
    if err != nil {
        result := handleErr(err)
         return C.CString(string(result))
    }

    return C.CString(string(result))
}

func handleErr(err error) []byte {
    result, err := json.Marshal(map[string]error{
        "error": err,
    })
    if err != nil {
        panic(err)
    }
    return result
}
