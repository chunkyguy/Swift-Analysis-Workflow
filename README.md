# Swift-Analysis-Workflow
Make it easier to see what's making your build slow.

You can add flags to the Swift compiler to add new build output to track down slow functions, however browsing this output in Xcode sucks, this script will auto generate the top worst performing functions every time you build.

The output should be generated in the `Logs` directory at your project root directory.
There are 2 logs:

1. *compile-times.log*: You can check this file in your codebase, it truncates any machine local log data.
1. *compile-times-full.log*: This is a machine local log, so can analyze how the code performs on your local machine.

## Prerequisites
You need to have the Swift profiling code turned on for your targets in order to produce the desired output. If you need help doing that, please check out Bryan Irace's fantastic [post](http://irace.me/swift-profiling/) to learn how to turn it on!

# How To Use 
1. Copy the directory somewhere accessible, for example `./script/`
1. Add a Run Script phase after the code has compiled, probably the last thing.
1. Update the script to `"${SRCROOT}/scripts/Swift-Analysis-Workflow/auto-profile.sh" > /dev/null 2>&1 &`

# Thanks
Big thanks to [@irace](https://www.twitter.com/irace) as he and I were talking about this very problem recently and he helped with some of the shell scripts!

If you have any questions about contributing or whatever, please feel free to drop me a line on Twitter I'm just [@brianmichel](https://www.twitter.com/brianmichel).
