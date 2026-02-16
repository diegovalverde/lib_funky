# lib_funky

## Browser Playground (local)

From repo root (`funk/` parent directory):

```bash
rustup target add wasm32-unknown-unknown
cargo install wasm-bindgen-cli
```

Then:

```bash
cd web
npm install
npm run dev
```

This starts the browser-only Funk Playground using the Python compiler pipeline (Pyodide) plus Rust/WASM bytecode runner.
