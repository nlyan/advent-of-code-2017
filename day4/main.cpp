#include <dukglue/dukglue.h>
#include <iostream>
#include <string>

static std::string
readline () {
    std::string ret;
    std::cout << ">>> ";
    std::getline (std::cin, ret);
    return ret;
}

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
Array.prototype.unique = function (arr) {
    var target = [];
    for (var i = 0, a = this.length; i < a; i++) {
        var obj = this[i];
        if (target.indexOf (obj) == -1) {
            target.push (obj);
        }
    }
    return target;
}

function main() {
    var reader = new LineReader();
    var count = 0;
    while (reader.next()) {
        var line = reader.line ();
        var words = line.split (/\s+/);
        var uwords = words.unique();
        count += (words.length === uwords.length);
    }
    print (count.toString());
}
main()
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
