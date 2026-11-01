# DBV

Mac chat viewer for Claude chats you save with
[dumpboth](https://github.com/towelWet/dumpboth).

Sessions on the left, transcript on the right. Search, star, copy, and add notes.
Saved `.jsonl` files are opened read-only.

![DBV showing excerpt of real chat](docs/images/dbv.png)

## Build

```sh
./build.command      # needs Swift 6.2+; builds for Apple silicon, installs to /Applications/DBV.app
swift test           # run tests
```

Build is ad-hoc signed, so it only runs on Mac that built it unless you sign it yourself.

## Where things live

| What | Where |
|---|---|
| Dumps it reads | `~/Old Chats/` |
| Your notes | `~/.claude/skills/dumpboth/db/` |

## See also

[dumpconvert](https://github.com/towelWet/dumpconvert): turn saved chats into a training dataset.

## License

MIT
