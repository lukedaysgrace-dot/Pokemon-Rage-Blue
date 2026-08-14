#define PROGRAM_NAME "scan_includes"
#define USAGE_OPTS "[-h|--help] [-s|--strict] filename.asm"

#include "common.h"

#include <ctype.h>

void parse_args(int argc, char *argv[], bool *strict) {
	struct option long_options[] = {
		{"strict", no_argument, 0, 's'},
		{"help", no_argument, 0, 'h'},
		{0}
	};
	for (int opt; (opt = getopt_long(argc, argv, "sh", long_options)) != -1;) {
		switch (opt) {
		case 's':
			*strict = true;
			break;
		case 'h':
			usage_exit(0);
			break;
		default:
			usage_exit(1);
		}
	}
}

struct IncludeStack {
	const char *filename;
	const struct IncludeStack *parent;
};

bool is_safe_dependency_path(const char *path) {
	if (!*path) {
		return false;
	}
	for (const unsigned char *ptr = (const unsigned char *)path; *ptr; ptr++) {
		if (!((*ptr >= 'a' && *ptr <= 'z') ||
		      (*ptr >= 'A' && *ptr <= 'Z') ||
		      (*ptr >= '0' && *ptr <= '9') ||
		      strchr("/._-", *ptr))) {
			return false;
		}
	}
	return true;
}

void print_dependency(const char *path, const char *filename) {
	if (!is_safe_dependency_path(path)) {
		error_exit("Unsafe or empty dependency path in \"%s\"\n", filename);
	}
	printf("%s ", path);
}

void scan_file(const char *filename, bool strict, const struct IncludeStack *stack) {
	for (const struct IncludeStack *entry = stack; entry; entry = entry->parent) {
		if (!strcmp(entry->filename, filename)) {
			error_exit("Circular INCLUDE involving \"%s\"\n", filename);
		}
	}
	const struct IncludeStack current = {filename, stack};

	errno = 0;
	FILE *f = fopen(filename, "rb");
	if (!f) {
		if (strict) {
			error_exit("Could not open file \"%s\": %s\n", filename, strerror(errno));
		} else {
			return;
		}
	}

	long size = xfsize(filename, f);
	char *contents = xmalloc(size + 1);
	xfread((uint8_t *)contents, size, filename, f);
	fclose(f);
	contents[size] = '\0';

	for (char *ptr = contents; ptr && ptr < contents + size; ptr++) {
		ptr = strpbrk(ptr, ";\"Ii");
		if (!ptr) {
			break;
		}
		switch (*ptr) {
		case ';': {
			// Skip comments until the end of the line
			char *newline = strpbrk(ptr + 1, "\r\n");
			if (!newline) {
				ptr = contents + size - 1;
			} else {
				ptr = newline;
			}
			break;
		}

		case '"': {
			// Skip string literal until the closing quote
			char *closing_quote = strchr(ptr + 1, '"');
			if (!closing_quote) {
				error_exit("Unterminated string literal in \"%s\"\n", filename);
			}
			ptr = closing_quote;
			break;
		}

		case 'I':
		case 'i':
			/* empty statement between the label and the variable declaration */;
			// Check that an INCLUDE/INCBIN starts as its own token
			char before = ptr > contents ? *(ptr - 1) : '\n';
			if (!isspace((unsigned char)before) && before != ':') {
				break;
			}
			bool is_incbin = !strncmp(ptr, "INCBIN", 6) || !strncmp(ptr, "incbin", 6);
			bool is_include = !strncmp(ptr, "INCLUDE", 7) || !strncmp(ptr, "include", 7);
			if (is_incbin || is_include) {
				// Check that an INCLUDE/INCBIN ends as its own token
				ptr += is_include ? 7 : 6;
				if (!isspace((unsigned char)*ptr) && *ptr != '"') {
					break;
				}
				ptr += strspn(ptr, " \t");
				if (*ptr == '"') {
					// Print the file path and recursively scan INCLUDEs
					ptr++;
					char *include_path = ptr;
					char *closing_quote = strchr(ptr, '"');
					if (!closing_quote) {
						error_exit("Unterminated INC%s path in \"%s\"\n", is_include ? "LUDE" : "BIN", filename);
					}
					*closing_quote = '\0';
					print_dependency(include_path, filename);
					if (is_include) {
						scan_file(include_path, strict, &current);
					}
					ptr = closing_quote;
				} else {
					fprintf(stderr, "%s: no file path after INC%s\n", filename, is_include ? "LUDE" : "BIN");
					// Continue to process a comment
					if (*ptr == ';') {
						ptr--;
					}
				}
			}
			break;
		}
	}

	free(contents);
}

int main(int argc, char *argv[]) {
	bool strict = false;
	parse_args(argc, argv, &strict);

	argc -= optind;
	argv += optind;
	if (argc < 1) {
		usage_exit(1);
	}

	scan_file(argv[0], strict, NULL);
	return 0;
}
