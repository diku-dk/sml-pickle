# sml-pickle [![Build Status](https://travis-ci.org/diku-dk/sml-pickle.svg?branch=master)](https://travis-ci.org/diku-dk/sml-pickle)

Standard ML package for serialising and deserialising data structures.

## Overview of MLB files

- `lib/github.com/diku-dk/sml-random/pickle.mlb`:

  - **signature** [`BITSTREAM`](lib/github.com/diku-dk/sml-pickle/bitstream.sig)
  - **structure** `Bitstream` :> `BITSTREAM`
  - **structure** `Bytestream` :> `BITSTREAM`

  - **signature** [`PICKLE`](lib/github.com/diku-dk/sml-pickle/pickle.sig)
  - **functor** `Pickle` (`S` : `BITSTREAM`)  : `PICKLE`
  - **structure** `Pickle` :> `PICKLE` (uses `Bytestream`)

Use `Bitstream` to generate the most concise pickles and `Bytestream`
for the fastest implementation. The `Pickle` structure is the result
of applying the `Pickle` functor to the `Bytestream` structure.

## Use of the package

This library is set up to work well with the SML package manager
[smlpkg](https://github.com/diku-dk/smlpkg).  To use the package, in
the root of your project directory, execute the command:

```
$ smlpkg add github.com/diku-dk/sml-pickle
```

This command will add a _requirement_ (a line) to the `sml.pkg` file in your
project directory (and create the file, if there is no file `sml.pkg`
already).

To download the library into the directory
`lib/github.com/diku-dk/sml-pickle`, execute the command:

```
$ smlpkg sync
```

You can now reference the `mlb`-file using relative paths from within
your project's `mlb`-files.

Notice that you can choose either to treat the downloaded package as
part of your own project sources (vendoring) or you can add the
`sml.pkg` file to your project sources and make the `smlpkg sync`
command part of your build process.

## Implementation details

The implementation is based on the paper:

- Martin Elsman. __Type-Specialized Serialization with Sharing__. In _Sixth
  Symposium on Trends in Functional Programming (TFP ‘05)_. Tallinn,
  Estonia. September 2005. [pdf](https://elsman.com/pdf/TFP05final_mael.pdf).
