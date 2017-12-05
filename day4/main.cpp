#include <dukglue/dukglue.h>
#include <iostream>
#include <string>

static void
print (std::string const& str) {
    std::cout << str << "\n";
}

struct LineReader {
    std::string line_;
    bool next() { return (bool) std::getline(std::cin, line_); }
    std::string line() const { return line_; }
};

char const* const program = R"JS(
Array.prototype.unique = function () {
    var target = [];
    for (var i = 0, a = this.length; i < a; i++) {
        var obj = this[i];
        if (target.indexOf (obj) == -1) {
            target.push (obj);
        }
    }
    return target;
}

function part1() {
    var reader = new LineReader();
    var count = 0;
    while (reader.next()) {
        var words = reader.line().split (/\s+/);
        count += (words.length === words.unique().length);
    }
    print (count.toString());
}

function part2() {
    var reader = new LineReader();
    var count = 0;
    while (reader.next()) {
        var words = reader.line().split (/\s+/);
        count += 1
        for (var i = 0, a = words.length; i < a; i++) {
            words[i] = words[i].split('').sort().join('')
        }
        for (var i = 0, a = words.length; i < a; i++) {
            if (words.lastIndexOf(words[i]) != i) {
                count -= 1
                break;
            }
        }
    }
    print (count.toString());
}

// part1()
part2()
)JS";

int main() {
    duk_context* ctx = duk_create_heap_default();
    dukglue_register_function (ctx, &print, "print");
    dukglue_register_constructor<LineReader>(ctx, "LineReader");
    dukglue_register_method (ctx, &LineReader::next, "next");
    dukglue_register_method (ctx, &LineReader::line, "line");
    duk_compile_string (ctx, 0, program);
    duk_call (ctx, 0);
    duk_destroy_heap (ctx);
}
