const fs = require('fs');
const bytes = fs.readFileSync(__dirname + '/hll_wlrd.wasm');

let hello_world = null; // function will be set later
let start_string_index = 150; // linear memory location of string (the maximu per page is 64KB)
let memory = new WebAssembly.Memory({ initial: 1 }); // number of pages you want to allocate

let importObject = {
    // name inside the WebAsm import declaration
    env: {
        // if there is any function or value from the embedding environment
        // you want to make available to the WebAssembly module, pass them in here
        buffer: memory,
        start_string: start_string_index,
        // function which our WebAsm module will call
        print_string: function (str_len) {
            const bytes = new Uint8Array (memory.buffer, start_string_index, str_len);
            const log_string = new TextDecoder('utf8').decode(bytes);
            console.log(log_string);
        }
    }
};

// We add the IIFE that asynchronously loads our WebAssembly
// module and then calls the helloworld function
(async () => {
    let obj = await WebAssembly.instantiate( new Uint8Array (bytes), importObject);
    ({helloworld: hello_world} = obj.instance.exports);
    hello_world();
})();
